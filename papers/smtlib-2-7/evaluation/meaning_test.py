#!/usr/bin/env python3
"""Does the matcher read what the Lean means, or only what it is called?

Twelve declarations each get one small change of meaning (a character range, a version
gate, an empty list allowed). They are split into sets X and Y. Session 1 sees X changed and
Y as written; session 2 sees Y changed and X as written. So every declaration is judged once
changed and once as the authors wrote it, and no session sees both. Both sessions also see,
as written, declarations where the authors chose a reading that departs from the letter of
a grammar rule (their Readings L2 to L6 and G1), paired with the passage they depart from.

For each item the matcher sees the declaration (in the session's copy of the Lean, which
carries the change) and the passages it is supposed to state, and answers whether the Lean
states exactly that rule. The answer key never enters a session folder.

    python3 meaning_test.py build PREPARED_DIR OUT_DIR
    python3 meaning_test.py key        (prints the key)
"""
from __future__ import annotations

import json
import random
import re
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent

# (id, file under lean/Spec, declaration, exact text, replacement, what changed, passages by (version, rule or heading))
MUTATIONS = {
    "X": [
        ("digit", "Lexicon.lean", "Spec.Lexicon.digit", "def digit : Regex := range 48 57", "def digit : Regex := range 48 56",
         "excludes the digit 9", [("2.7", "rule", "digit"), ("2.7", "heading", "Digits")]),
        ("numeral", "Lexicon.lean", "Spec.Lexicon.numeral",
         'def numeral : Regex := alt (lit "0") (minus (plus digit) (startsWith (lit "0")))', "def numeral : Regex := plus digit",
         "allows leading zeros", [("2.7", "rule", "numeral"), ("2.7", "heading", "Numerals")]),
        ("hexadecimal", "Lexicon.lean", "Spec.Lexicon.hexadecimal", "range 65 70, range 97 102", "range 65 71, range 97 103",
         "allows the letters G and g", [("2.7", "rule", "hexadecimal"), ("2.7", "heading", "Hexadecimals")]),
        ("application", "Grammar/Syntax.lean", "Spec.Grammar.Tree.Term.Valid",
         "    arguments ≠ [] ∧ function.Valid version ∧ Term.ValidAll version arguments",
         "    function.Valid version ∧ Term.ValidAll version arguments",
         "allows an application with no arguments", [("2.7", "rule", "term")]),
        ("declare-const", "Grammar/Syntax.lean", "Spec.Grammar.Tree.Command.Valid",
         "  | .declareConst _ sort => versionAtLeast version .v2_5 ∧ sort.Valid version",
         "  | .declareConst _ sort => versionAtLeast version .v2_6 ∧ sort.Valid version",
         "admits declare-const only from 2.6", [("2.0", "rule", "command"), ("2.5", "rule", "command")]),
        ("white-space", "Lexicon.lean", "Spec.Lexicon.whiteSpaceChar",
         "def whiteSpaceChar : Regex := altAll [code 9, code 10, code 13, code 32]",
         "def whiteSpaceChar : Regex := altAll [code 10, code 13, code 32]",
         "drops tab from white space", [("2.7", "rule", "white_space_char"), ("2.7", "heading", "White Space Characters")]),
    ],
    "Y": [
        ("binary", "Lexicon.lean", "Spec.Lexicon.binary", 'plus (oneOf "01")', 'plus (oneOf "012")',
         "allows the digit 2", [("2.7", "rule", "binary"), ("2.7", "heading", "Binaries")]),
        ("decimal", "Lexicon.lean", "Spec.Lexicon.decimal", 'seq (star (lit "0")) numeral', 'seq (plus (lit "0")) numeral',
         "requires a zero after the point", [("2.7", "rule", "decimal"), ("2.7", "heading", "Decimals")]),
        ("let", "Grammar/Syntax.lean", "Spec.Grammar.Tree.Term.Valid",
         "    bindings ≠ [] ∧ Term.ValidBindings version bindings ∧ body.Valid version",
         "    Term.ValidBindings version bindings ∧ body.Valid version",
         "allows a let with no bindings", [("2.7", "rule", "term")]),
        ("echo", "Grammar/Syntax.lean", "Spec.Grammar.Tree.Command.Valid",
         "  | .echo _ => versionAtLeast version .v2_5", "  | .echo _ => versionAtLeast version .v2_6",
         "admits echo only from 2.6", [("2.0", "rule", "command"), ("2.5", "rule", "command")]),
        ("string", "Lexicon.lean", "Spec.Lexicon.string", '(lit "\\"\\"")', '(lit "\\\\\\"")',
         "escapes a quote with a backslash instead of doubling it", [("2.7", "rule", "string"), ("2.7", "heading", "String literals")]),
        ("quoted-symbol", "Lexicon.lean", "Spec.Lexicon.quotedSymbol", '(oneOf "|\\\\")', '(oneOf "|")',
         "allows a backslash inside a quoted symbol", [("2.7", "rule", "symbol"), ("2.7", "heading", "Symbols")]),
    ],
}

# The authors' Readings, shown as written, against the passage whose letter they depart from.
READINGS = [
    ("L5", "Spec.Lexicon.keyword", [("2.7", "rule", "keyword"), ("2.7", "heading", "Keywords")]),
    ("L4", "Spec.Lexicon.simpleSymbol", [("2.5", "rule", "simple_symbol"), ("2.7", "heading", "Symbols")]),
    ("L3", "Spec.Lexicon.letter", [("2.5", "rule", "letter")]),
    ("L6", "Spec.Lexicon.addedCommandNames", [("2.7", "heading", "Reserved words"), ("2.7", "B-heading", "Tokens")]),
    ("L2", "Spec.Lexicon.commentAtEnd", [("2.7", "id", "2.7-p023-02"), ("2.7", "id", "2.7-p024-01")]),
    ("G1", "Spec.Grammar.Tree.SExpr.Valid", [("2.5", "rule", "s_expr"), ("2.5", "section", "3.2")]),
]


def passage_ids(passages: list[dict], refs) -> list[str]:
    ids = []
    for version, kind, value in refs:
        for p in passages:
            if p["version"] != version or p["kind"] in ("example", "footnote"):
                continue
            if (kind == "rule" and p["production"] == value and p["part"] == "B") or \
               (kind == "heading" and p["part"] == "3" and (p["heading"] or "").lower() == value.lower()) or \
               (kind == "B-heading" and p["part"] == "B" and (p["heading"] or "").lower().startswith(value.lower())) or \
               (kind == "section" and p["part"] == "3" and p["section"] == value) or \
               (kind == "id" and p["id"] == value):
                ids.append(p["id"])
    if not ids:
        raise SystemExit(f"no passage for {refs}")
    return ids


def build(prepared: Path, out: Path) -> dict:
    passages = json.loads((HERE / "inventory" / "passages.json").read_text(encoding="utf-8"))
    key = {"sessions": {}}
    for session, changed in (("1", "X"), ("2", "Y")):
        unchanged = "Y" if changed == "X" else "X"
        folder = out / f"session_{session}"
        if folder.exists():
            shutil.rmtree(folder)
        shutil.copytree(prepared / "code_only" / "lean", folder / "lean")
        shutil.copy(prepared / "code_only" / "passages.jsonl", folder / "passages.jsonl")
        items = []
        for slug, file, decl, old, new, what, refs in MUTATIONS[changed]:
            path = folder / "lean" / "Spec" / file
            text = path.read_text(encoding="utf-8")
            if text.count(old) != 1:
                raise SystemExit(f"{slug}: expected text found {text.count(old)} times in {file}")
            path.write_text(text.replace(old, new), encoding="utf-8")
            items.append({"slug": slug, "declaration": decl, "passages": passage_ids(passages, refs),
                          "truth": "changed", "change": what})
        changed_decls = {m[2] for m in MUTATIONS[changed]}
        for slug, file, decl, old, new, what, refs in MUTATIONS[unchanged]:
            if decl in changed_decls:
                continue  # the same declaration carries this session's change, so it is not as written
            items.append({"slug": slug, "declaration": decl, "passages": passage_ids(passages, refs),
                          "truth": "as_written"})
        for reading, decl, refs in READINGS:
            items.append({"slug": f"reading-{reading}", "declaration": decl, "passages": passage_ids(passages, refs),
                          "truth": "authors_reading", "reading": reading})
        random.Random(int(session)).shuffle(items)
        for n, item in enumerate(items, 1):
            item["item"] = f"item-{n:02d}"
        (folder / "items.json").write_text(json.dumps(
            [{"item": i["item"], "declaration": i["declaration"], "passages": i["passages"]} for i in items],
            indent=1) + "\n", encoding="utf-8")
        shutil.copy(HERE / "tasks" / "meaning_check.md", folder / "TASK.md")
        (folder / "out").mkdir()
        key["sessions"][session] = items
    (HERE / "meaning" ).mkdir(exist_ok=True)
    (HERE / "meaning" / "key.json").write_text(json.dumps(key, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    return {s: len(v) for s, v in key["sessions"].items()}


if __name__ == "__main__":
    if sys.argv[1] == "build":
        print(build(Path(sys.argv[2]), Path(sys.argv[3])))
