#!/usr/bin/env python3
"""Apply the round-four rewrites to papers/euler/links.json.

    python3 papers/euler/tools/apply_rewrites.py RETURN_A RETURN_B

Round four rewrote the page's sentences of ours for a reader who knows incompressible Euler and
the blow-up literature but has never read Lean: the comparison note on each phrase-to-Lean link,
the title, summary and note of each declaration the paper links to, and the comparison of each
numbered result with its formal statement. RETURN_A and RETURN_B are the reviewed return folders
(comparisons.json, declarations.json, results.json), kept privately. The links, the passages and
their quotes are not changed. A changed verdict is taken only with the reason the return gives.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent


def main() -> int:
    path = HERE / "links.json"
    links = json.loads(path.read_text(encoding="utf-8"))
    passages = {p["id"]: p for p in links["passages"]}
    counts = {"comparisons": 0, "verdicts": 0, "titles": 0, "notes": 0, "results": 0}
    for folder in map(Path, sys.argv[1:3]):
        comps = json.loads((folder / "comparisons.json").read_text(encoding="utf-8"))
        for pid, rows in comps.items():
            held = passages[pid].get("comparisons", [])
            if [r["lean"] for r in rows] != [c["lean"] for c in held]:
                raise SystemExit(f"{pid}: the return's links differ from links.json")
            for new, old in zip(rows, held):
                if new["fidelity"] != old["fidelity"]:
                    if not str(new.get("fidelity_changed_because", "")).strip():
                        raise SystemExit(f"{pid} {new['lean']}: changed verdict without a reason")
                    counts["verdicts"] += 1
                note = str(new.get("note", "")).strip()
                if note != old.get("note", "") or new["fidelity"] != old["fidelity"]:
                    counts["comparisons"] += 1
                old.update({"fidelity": new["fidelity"], "note": note})
        decls = json.loads((folder / "declarations.json").read_text(encoding="utf-8"))
        for name, d in decls.items():
            title = d["title"].strip().rstrip(".")
            summary = d["summary"].strip().rstrip(".")
            if links["plain"].get(name) != title:
                counts["titles"] += 1
            links["plain"][name] = title
            note = links["notes"].setdefault(name, {"on": "lean", "because": []})
            note.update({"text": d["note"].strip(), "summary": summary})
            counts["notes"] += 1
        results = json.loads((folder / "results.json").read_text(encoding="utf-8"))
        for name, r in results.items():
            entry = links["fidelity"][name]
            if r["verdict"] != entry["verdict"] and not str(r.get("verdict_changed_because", "")).strip():
                raise SystemExit(f"{name}: changed verdict without a reason")
            entry.update({"verdict": r["verdict"], "text": r["text"].strip()})
            counts["results"] += 1
    path.write_text(json.dumps(links, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    print(f"applied: {counts['comparisons']} comparisons changed ({counts['verdicts']} verdicts), "
          f"{counts['titles']} titles changed, {counts['notes']} notes rewritten, {counts['results']} result comparisons")
    return 0


if __name__ == "__main__":
    sys.exit(main())
