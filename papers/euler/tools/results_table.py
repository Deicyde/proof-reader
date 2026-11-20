#!/usr/bin/env python3
"""Write the result-by-result link table of the Euler companion from the authors' own map.

Reads a checkout of mcoiculescu/EulerBlowupPublic at the pinned commit: the rows of
formalization/paper-coverage-latest.md, the TeX of the arXiv version in manuscript/source/,
and the Lean of the Paper layer. Every link points at the authors' files on GitHub at that
commit; nothing of theirs is copied. Prints Markdown.

    python3 papers/euler/tools/results_table.py /path/to/EulerBlowupPublic
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

COMMIT = "fd3a1588967810b9abe42a1dcf46ee662d6434e2"
BLOB = f"https://github.com/mcoiculescu/EulerBlowupPublic/blob/{COMMIT}"


def declaration_range(lines: list[str], start: int) -> tuple[int, int]:
    """1-based lines of the declaration starting at index `start`, up to its last non-blank line."""
    end = start
    for k in range(start + 1, len(lines)):
        if lines[k].strip() == "" or re.match(r"^(/--|theorem |def |lemma |end |namespace |section )", lines[k]):
            break
        end = k
    return start + 1, end + 1


DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|noncomputable)\s+)*(?:theorem|lemma|def|abbrev)\s+([^\s:({\[]+)")


def declarations(lean: Path, files: list[Path]) -> dict[str, tuple[str, int, int]]:
    """Fully qualified name -> (repository path, first line, last line), tracking `namespace`."""
    found: dict[str, tuple[str, int, int]] = {}
    for path in files:
        lines = path.read_text(encoding="utf-8").splitlines()
        stack: list[str] = []
        for i, line in enumerate(lines):
            if m := re.match(r"^namespace\s+(\S+)", line):
                stack.append(m.group(1))
            elif re.match(r"^end\s+(\S+)", line) and stack:
                stack.pop()
            elif m := DECL.match(line):
                name = m.group(1)
                full = name[len("_root_."):] if name.startswith("_root_.") else ".".join([*stack, name])
                first, last = declaration_range(lines, i)
                found.setdefault(full, (path.relative_to(lean.parent.parent).as_posix(), first, last))
    return found


def kind_of(result: str) -> str:
    if result.startswith("Text "):
        return "Display"
    n = result.split()[0]
    return n


def main(repo: Path) -> None:
    head = subprocess.run(["git", "-C", str(repo), "rev-parse", "HEAD"], capture_output=True, text=True).stdout.strip()
    if head != COMMIT:
        sys.exit(f"{repo} is at {head}, expected {COMMIT}")
    lean = repo / "formalization" / "lean"
    paper = lean / "TorusEuler" / "Paper"
    statement_files = sorted(paper.glob("*/Statements.lean")) + sorted(paper.glob("*/TextStatements.lean"))
    spine = [paper / "Spine.lean"]
    tex_root = repo / "manuscript" / "source"
    decls = declarations(lean, statement_files + spine)
    rows = []
    for line in (repo / "formalization" / "paper-coverage-latest.md").read_text(encoding="utf-8").splitlines():
        # Later cells can hold a literal "|" (an absolute value), so split off the first four only.
        cells = [c.strip() for c in line.split("|", 5)]
        if not line.startswith("| ") or len(cells) < 6 or cells[1] in ("Result", "---") or not cells[3].startswith("`"):
            continue
        result, tex, name, cites = cells[1], cells[2], cells[3].strip("`"), cells[4]
        label = re.match(r"`([^`]+)`", tex).group(1)
        where = re.search(r"(sections/[\w.]+\.tex)(?::(\d+))?", tex)
        tex_file, tex_line = where.group(1), where.group(2)
        if not tex_line:
            text = (tex_root / tex_file).read_text(encoding="utf-8").splitlines()
            tex_line = next(str(i + 1) for i, l in enumerate(text) if f"\\label{{{label}}}" in l)
        stmt = decls.get(f"TorusEuler.Paper.Statement.{name}")
        node = decls.get(f"TorusEuler.Paper.{name}")
        if not node:
            sys.exit(f"no spine theorem for {name}")
        if not stmt:
            sys.exit(f"no statement definition for {name}")
        rows.append((result, label, tex_file, tex_line, name, stmt, node, cites))

    print("| Result | In the paper | Lean statement | Lean theorem | Its proof cites |")
    print("| --- | --- | --- | --- | --- |")
    for result, label, tex_file, tex_line, name, stmt, node, cites in rows:
        title = result.replace("Text ", "Display ").replace("_", " ")
        paper_link = f"[`{label}`]({BLOB}/manuscript/source/{tex_file}#L{tex_line})"
        s_link = f"[`Statement.{name}`]({BLOB}/{stmt[0]}#L{stmt[1]}-L{stmt[2]})"
        n_link = f"[`Paper.{name}`]({BLOB}/{node[0]}#L{node[1]}-L{node[2]})"
        cites = cites.replace("Text ", "display ").replace("_", " ").replace("*library*", "library")
        print(f"| {title} | {paper_link} | {s_link} | {n_link} | {cites} |")
    print(f"\n{len(rows)} rows, from `formalization/paper-coverage-latest.md` at `{COMMIT[:7]}`.")


if __name__ == "__main__":
    main(Path(sys.argv[1]))
