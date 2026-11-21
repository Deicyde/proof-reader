#!/usr/bin/env python3
"""Apply the round-six expert review to papers/euler/links.json, keeping only verified corrections.

    python3 papers/euler/tools/apply_review.py VERDICTS_DIR RETURN_A RETURN_B

Round six was an independent, hostile review: each return lists findings and corrected cards
(ties, declarations, results), a glossary of the formalization's conventions, an improved guide,
a paragraph for each section and a few showcase cards. Every finding that changes meaning (all
but "not-standalone") was then checked against the Lean and the paper; VERDICTS_DIR holds those
decisions (verdicts_*.json: confirmed, confirmed-with-edit or rejected).

A card is corrected only if none of its findings was rejected; a confirmed-with-edit verdict
replaces the named field with its fixed text. Findings that only make a card readable on its own
are taken as returned. The glossary, section aids and showcase go to notes/.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
from apply_audit import blocks_of  # noqa: E402
from build_links import section_of  # noqa: E402


def main() -> int:
    verdict_dir, returns = Path(sys.argv[1]), [Path(a) for a in sys.argv[2:4]]
    verdicts = {}
    for path in sorted(verdict_dir.glob("verdicts_*.json")):
        for v in json.loads(path.read_text()):
            verdicts[v["ref"]] = v
    links = json.loads((HERE / "links.json").read_text(encoding="utf-8"))
    md = (HERE / "paper.md").read_text(encoding="utf-8")
    offsets = [0]
    for line in md.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    blocks = [{**b, "start": offsets[b["line"] - 1], "stop": offsets[b["end_line"]]} for b in blocks_of(HERE / "paper.md")]
    by_id = {p["id"]: p for p in links["passages"]}
    counts = {"ties": 0, "declarations": 0, "results": 0, "held_back": 0, "edited": 0}
    held, record = set(), {"rejected": [], "edited": []}
    glossary, aids, showcase = [], {}, []
    for letter, folder in zip("AB", returns):
        findings = json.loads((folder / "findings.json").read_text())
        edits: dict[str, list[dict]] = {}
        for i, f in enumerate(findings):
            v = verdicts.get(f"{letter}{i}")
            if f["severity"] == "not-standalone" or v is None:
                continue
            if v["decision"] == "rejected":
                held.add(f["card"])
                record["rejected"].append({"card": f["card"], "finding": f["finding"], "why": v["reason"]})
            elif v["decision"] == "confirmed-with-edit":
                edits.setdefault(f["card"], []).append(v)
        for t in json.loads((folder / "ties.json").read_text()):
            card = f"tie:{t['id']}"
            if card in held:
                counts["held_back"] += 1
                continue
            for v in edits.get(card, []):
                for c in t["comparisons"]:
                    if c["lean"] == v.get("fixed_lean") or (not v.get("fixed_lean") and len(t["comparisons"]) == 1):
                        c[v.get("fixed_field") or "note"] = v["fixed_text"]
                counts["edited"] += 1
                record["edited"].append({"card": card, "why": v["reason"]})
            if t["status"] == "removed":
                by_id.pop(t["id"], None)
                continue
            q = t["quote"]
            at = md.index(q)
            block = next(b for b in blocks if b["start"] <= at and at + len(q) <= b["stop"])
            old = by_id.get(t["id"], {})
            entry = {"id": t["id"], "section": section_of(block["heading"]), "role": t["role"], "quote": q, "lean": t["lean"],
                     "anchor": {"heading": block["heading"], "block": block["block"]}, "topic": t["topic"],
                     "comparisons": [{"lean": c["lean"], "fidelity": c["fidelity"], "note": str(c.get("note", "")).strip()} for c in t["comparisons"]],
                     "audit": {"status": t["status"], "reason": str(t.get("reason", "")).strip(), "round": 6}}
            if t.get("lines"):
                entry["lines"] = t["lines"]
            for key in ("checks", "title"):
                if key in old:
                    entry[key] = old[key]
            by_id[t["id"]] = entry
            counts["ties"] += 1
        for name, d in json.loads((folder / "declarations.json").read_text()).items():
            card = f"declaration:{name}"
            if card in held:
                counts["held_back"] += 1
                continue
            for v in edits.get(card, []):
                d[v.get("fixed_field") or "note"] = v["fixed_text"]
                counts["edited"] += 1
                record["edited"].append({"card": card, "why": v["reason"]})
            links["plain"][name] = d["title"].strip().rstrip(".")
            note = links["notes"].setdefault(name, {"on": "lean", "because": []})
            note.update({"text": d["note"].strip(), "summary": d["summary"].strip().rstrip(".")})
            counts["declarations"] += 1
        for name, r in json.loads((folder / "results.json").read_text()).items():
            card = f"result:{name}"
            if card in held:
                counts["held_back"] += 1
                continue
            for v in edits.get(card, []):
                r[v.get("fixed_field") or "text"] = v["fixed_text"]
                counts["edited"] += 1
            links["fidelity"][name].update({"verdict": r["verdict"], "text": r["text"].strip()})
            counts["results"] += 1
        glossary += json.loads((folder / "glossary.json").read_text())
        aids.update(json.loads((folder / "section_aids.json").read_text()))
        showcase += json.loads((folder / "showcase.json").read_text())
    passages = sorted(by_id.values(), key=lambda p: md.index(p["quote"]))
    linked: dict[str, list[str]] = {}
    for p in passages:
        for n in p["lean"]:
            linked.setdefault(n, []).append(p["id"])
    for name, note in links["notes"].items():
        note["because"] = linked.get(name, [])
    links["passages"] = passages
    links["show_also"] = sorted(n for n in links["notes"] if not linked.get(n))
    (HERE / "links.json").write_text(json.dumps(links, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    notes = HERE / "notes"
    (notes / "glossary.json").write_text(json.dumps(glossary, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    (notes / "section-aids.json").write_text(json.dumps(aids, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    (notes / "showcase.json").write_text(json.dumps(showcase, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    (verdict_dir / "applied-record.json").write_text(json.dumps({"counts": counts, **record}, ensure_ascii=False, indent=1) + "\n")
    print(f"applied: {counts}; {len(record['rejected'])} findings rejected; glossary {len(glossary)}, "
          f"section aids {len(aids)}, showcase {len(showcase)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
