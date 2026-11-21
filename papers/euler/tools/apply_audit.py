#!/usr/bin/env python3
"""Apply the round-five link audit and notes to papers/euler/links.json.

    python3 papers/euler/tools/apply_audit.py RETURN_A RETURN_B RETURN_C

Round five audited every phrase-to-Lean link for readers who know the incompressible Euler
equations and have never read Lean, and rewrote each linked declaration's note to explain the
formal statement as mathematics. Each return folder holds ties.json, untied.json,
declarations.json and results.json (packet A also GUIDE.md); they are kept privately.

- A phrase marked kept, corrected or replaced takes the returned quote, declarations, lines,
  role, topic and comparisons; one marked removed is dropped; new phrases are added. Phrase ids
  are kept. Each quote is placed in paper.md again: it must occur exactly once, inside one block.
- Declaration titles, summaries and notes, and the result comparisons, are replaced.
- The reasons given for paragraphs left without a link go to notes/paragraph-dispositions.json,
  and packet A's guide to notes/lean-guide.md.
"""
from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
from build_links import section_of  # noqa: E402


def blocks_of(md_path: Path) -> list[dict]:
    done = subprocess.run(["node", str(ROOT / "web/tools/render-paper.mjs"), str(md_path), "euler", "lean", "--markdown-source"],
                          input=json.dumps({"passages": []}), capture_output=True, text=True, cwd=ROOT / "web")
    if done.returncode:
        raise SystemExit(done.stderr[-1500:])
    return json.loads(done.stdout)["source_blocks"]


def main() -> int:
    links = json.loads((HERE / "links.json").read_text(encoding="utf-8"))
    md = (HERE / "paper.md").read_text(encoding="utf-8")
    offsets = [0]
    for line in md.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    blocks = [{**b, "start": offsets[b["line"] - 1], "stop": offsets[b["end_line"]]} for b in blocks_of(HERE / "paper.md")]
    by_id = {p["id"]: p for p in links["passages"]}
    counts = {"kept": 0, "corrected": 0, "replaced": 0, "removed": 0, "new": 0, "notes": 0, "results": 0}
    dispositions, guide = {}, None
    for folder in map(Path, sys.argv[1:4]):
        for t in json.loads((folder / "ties.json").read_text(encoding="utf-8")):
            status = t["status"]
            counts[status] += 1
            if status == "removed":
                by_id.pop(t["id"], None)
                continue
            q = t["quote"]
            if md.count(q) != 1:
                raise SystemExit(f"{t['id']}: quote occurs {md.count(q)} times")
            at = md.index(q)
            block = next((b for b in blocks if b["start"] <= at and at + len(q) <= b["stop"]), None)
            if block is None:
                raise SystemExit(f"{t['id']}: quote crosses blocks")
            entry = {"id": t["id"], "section": section_of(block["heading"]), "role": t["role"], "quote": q,
                     "lean": t["lean"], "anchor": {"heading": block["heading"], "block": block["block"]}, "topic": t["topic"]}
            if t.get("lines"):
                entry["lines"] = t["lines"]
            old = by_id.get(t["id"], {})
            for key in ("checks", "title"):
                if key in old:
                    entry[key] = old[key]
            entry["comparisons"] = [{"lean": c["lean"], "fidelity": c["fidelity"], "note": str(c.get("note", "")).strip()}
                                    for c in t.get("comparisons", [])]
            if status != "kept" or "reason" in t:
                entry["audit"] = {"status": status, "reason": str(t.get("reason", "")).strip()}
            by_id[t["id"]] = entry
        for name, d in json.loads((folder / "declarations.json").read_text(encoding="utf-8")).items():
            links["plain"][name] = d["title"].strip().rstrip(".")
            note = links["notes"].setdefault(name, {"on": "lean", "because": []})
            note.update({"text": d["note"].strip(), "summary": d["summary"].strip().rstrip(".")})
            counts["notes"] += 1
        for name, r in json.loads((folder / "results.json").read_text(encoding="utf-8")).items():
            links["fidelity"][name].update({"verdict": r["verdict"], "text": r["text"].strip()})
            counts["results"] += 1
        dispositions.update(json.loads((folder / "untied.json").read_text(encoding="utf-8")))
        if (folder / "GUIDE.md").exists():
            guide = (folder / "GUIDE.md").read_text(encoding="utf-8")
    passages = sorted(by_id.values(), key=lambda p: md.index(p["quote"]))
    linked = {n: [] for n in links["notes"]}
    for p in passages:
        for n in p["lean"]:
            linked.setdefault(n, []).append(p["id"])
    for name, note in links["notes"].items():
        note["because"] = linked.get(name, [])
    links["passages"] = passages
    links["show_also"] = sorted(n for n in links["notes"] if not linked.get(n))
    for claim in links["claims"]:
        if claim["passage"] not in by_id:
            raise SystemExit(f"claim {claim['id']}: its passage {claim['passage']} was removed")
    for name, f in links["fidelity"].items():
        f["because"] = [b for b in f["because"] if b in by_id] or f["because"]
    (HERE / "links.json").write_text(json.dumps(links, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    (HERE / "notes").mkdir(exist_ok=True)
    (HERE / "notes/paragraph-dispositions.json").write_text(json.dumps(dispositions, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    if guide:
        (HERE / "notes/lean-guide.md").write_text(guide, encoding="utf-8")
    print(f"applied: {counts}; {len(passages)} passages, {sum(len(p['comparisons']) for p in passages)} comparisons, "
          f"{len(dispositions)} paragraph dispositions, guide {'written' if guide else 'absent'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
