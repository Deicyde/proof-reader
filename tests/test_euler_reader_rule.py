"""The Euler page's prose is written for readers who have never read Lean.

Every note, summary, comparison and result text in papers/euler, and every string in its
notes/ files except the cards' identifier fields, must be free of backticks, Lean identifiers
(snake_case, camelCase, dotted names) and remarks about review packets outside $…$ formulas.
The declaration names themselves are the cards' identifiers and are not checked.
"""
from __future__ import annotations

import json
import re
import unittest
from pathlib import Path

EULER = Path(__file__).resolve().parent.parent / "papers" / "euler"
IDENT = re.compile(r"\b[A-Za-z]+_[A-Za-z0-9_]+\b|\b[a-z]+[A-Z][A-Za-z0-9]*\b|\b[A-Z][a-z0-9]+[A-Z][A-Za-z0-9]*\b"
                   r"|\b[A-Za-z]{2,}\.[A-Za-z]{2,}[A-Za-z0-9_.]*\b")
BANNED = re.compile(r"`|\bTorusEuler\b|\bpacket\b", re.I)
ALLOWED = {"e.g", "i.e", "et.al", "McKean", "DeLellis", "LittlewoodPaley", "TeX", "OpenAI"}
SKIP_KEYS = {"card", "cards", "lean", "name", "id", "term", "url", "ref"}
RECORDS = {"paragraph-dispositions.json", "frozen-statement-comparison.md"}  # working records, not reader prose


def problems(text: str) -> list[str]:
    prose = re.sub(r"\$\$.*?\$\$|\$[^$]*\$", " ", text, flags=re.S)
    found = [m.group(0) for m in BANNED.finditer(prose)]
    found += [m.group(0) for m in IDENT.finditer(prose)
              if m.group(0) not in ALLOWED and not re.fullmatch(r"[A-Za-z]\.[0-9]+", m.group(0))]
    return found


def strings(value, key=""):
    if isinstance(value, str):
        if key not in SKIP_KEYS:
            yield key, value
    elif isinstance(value, dict):
        for k, v in value.items():
            yield from strings(v, k)
    elif isinstance(value, list):
        for v in value:
            yield from strings(v, key)


class ReaderRule(unittest.TestCase):
    def test_links_prose(self):
        links = json.loads((EULER / "links.json").read_text(encoding="utf-8"))
        bad = []
        for name, note in links["notes"].items():
            for field in ("text", "summary"):
                if problems(note.get(field, "")):
                    bad.append(f"note {name} {field}: {problems(note[field])[:3]}")
        for p in links["passages"]:
            ex = p.get("explanation") or {}
            for where, text in [("explanation", ex.get("text", "")), ("open", ex.get("open", ""))] + [
                    (f"citation {i}", f"{c.get('where', '')} {c.get('supports', '')}") for i, c in enumerate(ex.get("citations", []))]:
                if problems(text):
                    bad.append(f"{where} {p['id']}: {problems(text)[:3]}")
            for c in p.get("comparisons", []):
                if problems(c.get("note", "")):
                    bad.append(f"comparison {p['id']} / {c['lean']}: {problems(c['note'])[:3]}")
                if problems((c.get("matters") or {}).get("line", "")):
                    bad.append(f"matters {p['id']} / {c['lean']}: {problems(c['matters']['line'])[:3]}")
        for name, f in links.get("fidelity", {}).items():
            if problems((f.get("matters") or {}).get("line", "")):
                bad.append(f"result matters {name}: {problems(f['matters']['line'])[:3]}")
        for name, title in links.get("plain", {}).items():
            if problems(title):
                bad.append(f"title {name}: {problems(title)[:3]}")
        for name, f in links.get("fidelity", {}).items():
            if problems(f.get("text", "")):
                bad.append(f"result {name}: {problems(f['text'])[:3]}")
        self.assertEqual(bad, [], f"{len(bad)} prose fields name Lean:\n" + "\n".join(bad[:40]))

    def test_notes_files(self):
        bad = []
        for path in sorted((EULER / "notes").glob("*.json")):
            if path.name in RECORDS:
                continue
            for key, text in strings(json.loads(path.read_text(encoding="utf-8"))):
                if problems(text):
                    bad.append(f"{path.name} {key}: {problems(text)[:3]}")
        for page in sorted((EULER / "notes").glob("*.md")):
            if page.name in RECORDS:
                continue
            text = re.sub(r"(?m)^#+ .*$", "", page.read_text(encoding="utf-8"))
            if problems(text):
                bad.append(f"{page.name}: {problems(text)[:3]}")
        self.assertEqual(bad, [], "\n".join(bad[:40]))


if __name__ == "__main__":
    unittest.main()
