#!/usr/bin/env python3
"""A matcher that reads nothing but names, to show how much of the task names alone solve.

Each declaration is linked to the 2.7 grammar rule whose name matches its own
(`simpleSymbol` to ⟨simple_symbol⟩, `SExpr.Valid` to ⟨s_expr⟩) and to the 2.7 chapter 3
paragraphs whose run-in heading names the same thing (`keyword` to "Keywords").

    python3 name_baseline.py OUT.json
"""
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
GENERIC = {"Valid", "tokens", "token", "mk", "ofToken", "asTerm", "Exactly", "From", "Delimited"}


def snake(name: str) -> str:
    name = name.replace("SExpr", "SExpr_").replace("_", "")
    return re.sub(r"(?<=[a-z0-9])(?=[A-Z])", "_", name).lower().replace("s_expr", "s_expr")


def main() -> int:
    passages = [p for p in json.loads((HERE / "inventory" / "passages.json").read_text(encoding="utf-8")) if p["version"] == "2.7"]
    rules = {}
    for p in passages:
        if p["production"]:
            rules.setdefault(p["production"], []).append(p["id"])
    decls = json.loads((HERE / "reference" / "declarations.json").read_text())
    out = []
    for d in decls:
        parts = d["id"].split(".")[1:]
        while len(parts) > 1 and parts[-1] in GENERIC:
            parts.pop()
        word = snake(parts[-1]) if parts else ""
        matches = [{"passage": q, "relation": "defines"} for q in rules.get(word, [])]
        stem = word.replace("_", " ").rstrip("s")
        if len(stem) > 3:
            for p in passages:
                head = (p["heading"] or "").lower()
                if p["part"] == "3" and p["kind"] == "prose" and stem in head and len(head) < 30:
                    matches.append({"passage": p["id"], "relation": "defines"})
        out.append({"id": d["id"], "matches": matches})
    Path(sys.argv[1]).write_text(json.dumps(out, indent=1) + "\n", encoding="utf-8")
    print(sum(1 for r in out if r["matches"]), "of", len(out), "declarations linked by name")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
