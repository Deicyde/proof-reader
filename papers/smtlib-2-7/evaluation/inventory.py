#!/usr/bin/env python3
"""Split the SMT-LIB standards into numbered passages, each anchored on its PDF page.

The inventory is frozen before any matcher runs. Every passage keeps the standard's own
words, the release it comes from, the PDF page it is printed on, the section and run-in
heading it sits under, and the grammar rule it states, if any. The boxes come from the
same word extraction the reader uses, so a passage that anchors here highlights on the page.

    python3 papers/smtlib-2-7/evaluation/inventory.py

writes evaluation/inventory/passages.json and evaluation/inventory/summary.json.
"""
from __future__ import annotations

import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
PAPER = HERE.parent
ROOT = PAPER.parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import paper as reader  # noqa: E402

# PDF page ranges (1-based, inclusive), read off each release's own contents and headers.
RELEASES = {
    "2.7": {"release": "2026-09-09", "pdf": PAPER / "paper.pdf",
            "ranges": {"3": (23, 57), "4": (58, 77), "B": (104, 113)}},
    "2.6": {"release": "2024-09-20", "pdf": PAPER / "standards" / "smtlib-2.6.pdf",
            "ranges": {"3": (22, 52), "B": (96, 102)}},
    "2.5": {"release": "2015-06-28", "pdf": PAPER / "standards" / "smtlib-2.5.pdf",
            "ranges": {"3": (21, 48), "B": (86, 91)}},
    "2.0": {"release": "2012-09-09", "pdf": PAPER / "standards" / "smtlib-2.0.pdf",
            "ranges": {"3": (19, 40), "B": (71, 76)}},
}

SECTION = re.compile(r"^\s*(\d+(?:\.\d+){0,2})\.?\s{2,}([A-Z][^.]{2,60})$")
RUN_IN = re.compile(r"^\s*([A-Z][A-Za-z][A-Za-z ,'-]{1,40})\.\s+\S")
PRODUCTION = re.compile(r"^\s*(?:⟨\s*([a-z][a-z_0-9-]*)\s*⟩|h([a-z][a-z_0-9 -]*?)\s?i)\s*::=")


def production_name(line: str) -> str:
    """The rule a line states. Older PDFs extract ⟨ ⟩ as the letters h and i and lose the
    underscore, so `hspec constanti` is ⟨spec_constant⟩."""
    m = PRODUCTION.match(line)
    return (m.group(1) or m.group(2).strip().replace(" ", "_"))
FOOTNOTE = re.compile(r"^\s{0,4}\(?\s?\d{1,2}\s?\)?\s+[A-Z(]")
APPENDIX_HEAD = re.compile(r"^\s*([A-Z][A-Za-z -]{3,50})\s*$")


def layout_pages(pdf: Path) -> list[list[str]]:
    out = subprocess.run(["pdftotext", "-layout", str(pdf), "-"], check=True, capture_output=True, text=True).stdout
    return [page.splitlines() for page in out.split("\f")]


def running_head(line: str) -> bool:
    text = line.strip()
    return bool(re.match(r"^\d+\s{2,}\S", text) or re.search(r"\S\s{2,}\d+$", text)
                or re.fullmatch(r"APPENDIX\s+[A-Z]", text) or text.isupper() and len(text) < 60)


def blocks(lines: list[str]) -> list[list[str]]:
    """Paragraph blocks, with the running head removed and each grammar rule its own block."""
    body = list(lines)
    while body and not body[0].strip():
        body.pop(0)
    for _ in range(2):
        if body and running_head(body[0]):
            body.pop(0)
            while body and not body[0].strip():
                body.pop(0)
    out: list[list[str]] = []
    current: list[str] = []
    for line in body:
        if not line.strip():
            if current:
                out.append(current)
            current = []
            continue
        if SECTION.match(line):
            if current:
                out.append(current)
            out.append([line])
            current = []
            continue
        if current and re.match(r"^\s{1,4}\(?\s?\d{1,2}\s?\)?\s+[A-Z(]", line) and not PRODUCTION.match(line):
            out.append(current)
            current = []
        elif PRODUCTION.match(line) and current:
            out.append(current)
            current = []
        elif current and PRODUCTION.match(current[0]) and not line.strip().startswith(("|", "·")) \
                and len(line) - len(line.lstrip()) < len(current[0]) - len(current[0].lstrip()) + 2 \
                and not re.match(r"^\s{6,}", line):
            out.append(current)
            current = []
        current.append(line)
    if current:
        out.append(current)
    return out


def kind_of(block: list[str], in_footer: bool) -> str:
    first = block[0]
    if PRODUCTION.match(first):
        return "production"
    if in_footer and FOOTNOTE.match(first):
        return "footnote"
    if len(block) == 1 and (SECTION.match(first) or (APPENDIX_HEAD.match(first) and len(first.strip()) < 45)):
        return "heading"
    indents = [len(l) - len(l.lstrip()) for l in block]
    if min(indents) >= 8 and not any(l.rstrip().endswith(".") for l in block):
        return "example"
    return "prose"


def build() -> dict:
    passages = []
    summary = {}
    for version, spec in RELEASES.items():
        pdf = spec["pdf"]
        sha = hashlib.sha256(pdf.read_bytes()).hexdigest()
        pages = layout_pages(pdf)
        words, sizes = reader.pdf_words(pdf)
        by_page: dict[int, list[dict]] = {}
        for w in words:
            by_page.setdefault(w["page"], []).append(w)
        counts = {"passages": 0, "anchored": 0, "first_line_only": 0, "start_only": 0, "unanchored": 0}
        for part, (first_page, last_page) in spec["ranges"].items():
            section, heading = (part if part == "B" else part), None
            for page in range(first_page, last_page + 1):
                page_blocks = blocks(pages[page - 1])
                footer_from = len(page_blocks)
                for i in range(len(page_blocks) - 1, -1, -1):
                    if FOOTNOTE.match(page_blocks[i][0]) and not PRODUCTION.match(page_blocks[i][0]):
                        footer_from = i
                    else:
                        break
                ordinal = 0
                for i, block in enumerate(page_blocks):
                    if len(block) == 1 and re.fullmatch(r"\s*\d{1,3}\s*", block[0]):
                        continue  # a page number printed at the top or bottom
                    kind = kind_of(block, i >= footer_from)
                    first = block[0]
                    if kind == "heading":
                        m = SECTION.match(first)
                        if m and part != "B":
                            section, heading = m.group(1), m.group(2).strip()
                        elif part == "B":
                            heading = first.strip()
                        continue
                    if kind == "prose":
                        r = RUN_IN.match(first)
                        if r and not first.strip().startswith(("The ", "This ", "In ", "A ", "An ", "For ", "If ", "Note")):
                            heading = r.group(1).strip()
                    ordinal += 1
                    text = " ".join(" ".join(l.split()) for l in block)
                    production = production_name(first) if kind == "production" else None
                    pid = f"{version}-p{page:03d}-{ordinal:02d}"
                    anchor = {"status": "unanchored"}
                    page_words = by_page.get(page, [])
                    head = (re.match(r"^(.*?::=)", text).group(1) if kind == "production"
                            else " ".join(text.split()[:8]))
                    for label, quote in (("whole", text), ("first_line", " ".join(first.split())), ("start", head)):
                        hits = reader.find_quote(quote, page_words)
                        if len(hits) == 1:
                            got_page, rects, last = reader.span_rects(quote, hits[0], page_words)
                            anchor = {"status": label, "quote": quote, "rects": rects}
                            break
                    counts["passages"] += 1
                    counts[{"whole": "anchored", "first_line": "first_line_only", "start": "start_only"}.get(anchor["status"], "unanchored")] += 1
                    passages.append({
                        "id": pid, "version": version, "release": spec["release"], "pdf_sha256": sha,
                        "pdf_file": str(pdf.relative_to(PAPER)), "page": page, "part": part,
                        "section": section, "heading": heading, "kind": kind,
                        "production": production, "text": text, "anchor": anchor,
                    })
        summary[version] = counts
    return {"passages": passages, "summary": summary}


def main() -> int:
    result = build()
    out = HERE / "inventory"
    out.mkdir(exist_ok=True)
    (out / "passages.json").write_text(json.dumps(result["passages"], ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    (out / "summary.json").write_text(json.dumps(result["summary"], indent=1) + "\n", encoding="utf-8")
    print(json.dumps(result["summary"], indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
