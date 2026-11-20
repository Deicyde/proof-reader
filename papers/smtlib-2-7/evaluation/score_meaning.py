#!/usr/bin/env python3
"""Score the meaning test, counting a change wherever Lean's dependencies carry it.

An item meant to be as written can still behave differently if a definition it uses was
changed in the same session (`decimal` uses `digit`). Lean's own dependency report decides
which items reach a changed definition. Each item then has one truth:

  changed        its own declaration was changed: the right verdict is `differs`
  carried        it uses a changed definition: the right verdict is `differs`
  as_written     nothing it uses was changed: the right verdict is `exact`
  reading        the authors' Reading, as written: the right verdict is `differs`, and the
                 explanation is graded by hand against the authors' words (grades file)

    python3 score_meaning.py SESSION_1_ANSWERS SESSION_2_ANSWERS [GRADES.json]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent.parent.parent / "tools"))
import paper as reader  # noqa: E402


def real(name: str) -> str:
    return name.replace("Spec.", "BSmtLibSpec.", 1) if name.startswith("Spec.") else name


def main() -> int:
    key = json.loads((HERE / "meaning" / "key.json").read_text(encoding="utf-8"))
    folder, config = reader.load_paper("smtlib-2-7")
    info, _ = reader.shards(folder, config)
    uses = info["uses"]
    answers = {"1": json.loads(Path(sys.argv[1]).read_text()), "2": json.loads(Path(sys.argv[2]).read_text())}
    grades = json.loads(Path(sys.argv[3]).read_text()) if len(sys.argv) > 3 else {}
    rows, tally = [], {}
    for session, items in key["sessions"].items():
        changed = {real(i["declaration"]) for i in items if i["truth"] == "changed"}
        given = {a["item"]: a for a in answers[session]}
        for item in items:
            decl = real(item["declaration"])
            reach = reader.reachable([decl], uses) - {decl}
            carried = sorted(reach & changed)
            truth = item["truth"]
            if truth == "as_written" and carried:
                truth = "carried"
            if truth == "authors_reading":
                truth = "reading"
            verdict = given.get(item["item"], {}).get("verdict", "missing")
            expected = "exact" if truth == "as_written" else "differs"
            row = {"session": session, "item": item["item"], "slug": item["slug"], "truth": truth,
                   "carried_from": carried, "verdict": verdict, "right_verdict": verdict == expected,
                   "difference": given.get(item["item"], {}).get("difference", "")}
            if truth == "reading":
                row["grade"] = grades.get(f"{session}/{item['slug']}")
            rows.append(row)
            t = tally.setdefault(truth, {"right": 0, "of": 0, "unsure": 0})
            t["of"] += 1
            t["right"] += row["right_verdict"]
            t["unsure"] += verdict == "unsure"
    out = {"tally": tally, "rows": rows}
    (HERE / "meaning" / "score.json").write_text(json.dumps(out, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    for truth, t in tally.items():
        print(f"{truth:11} right verdict {t['right']} of {t['of']} (unsure {t['unsure']})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
