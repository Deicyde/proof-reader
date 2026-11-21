#!/usr/bin/env python3
"""Set papers/euler/paper.md from the authors' TeX, and carry each phrase tie into it.

    python3 papers/euler/tools/reading_copy.py UPSTREAM TIES_JSON

UPSTREAM is a checkout of mcoiculescu/EulerBlowupPublic at fd3a158. TIES_JSON holds the
phrase ties, each placed in the flattened TeX by its `after`, `from` and `to` quotes (the
format of the review returns). The script:

1. flattens `manuscript/source/main.tex` and the auxiliary note exactly as the review
   packets did, so every tie lands where its reviewers put it;
2. compiles both with Tectonic and reads the authors' own numbers for every label;
3. numbers sections, theorems and equations itself and stops unless every label agrees;
4. puts a marker around each tie, sets the TeX in Markdown with Pandoc, and reads each tie
   back as an exact quotation of the Markdown;
5. converts the figures to SVG.

It writes paper.md, figures/*.svg and generated/reading-ties.json (each tie's quotation).
The authors' wording is not changed. Their numbers, cross-references and citations are
written out as the PDF prints them, because a reading copy cannot compute them.
"""
from __future__ import annotations

import hashlib
import json
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
COMMIT = "fd3a1588967810b9abe42a1dcf46ee662d6434e2"
INPUT = re.compile(r"^\\input\{([^}]+)\}\s*$")
THEOREMS = {"theorem": "Theorem", "proposition": "Proposition", "lemma": "Lemma",
            "corollary": "Corollary", "remark": "Remark"}
NUMBERED_MATH = ("equation", "align")
SEPARATOR = "% ======== The auxiliary note follows, unchanged, as its own document ========\n"


class ReadingCopyError(RuntimeError):
    pass


# ------------------------------------------------------------------ the flattened TeX

def flatten(root: Path, rel: str, out: list[str]) -> None:
    path = root / (rel if rel.endswith(".tex") else rel + ".tex")
    name = path.relative_to(root).as_posix()
    out.append(f"% >>> begin {name}\n")
    for line in path.read_text(encoding="utf-8").splitlines():
        m = INPUT.match(line)
        if m:
            flatten(root, m.group(1), out)
            continue
        out.append(line + "\n")
    out.append(f"% <<< end {name}\n")


def flat_tex(upstream: Path) -> str:
    root = upstream / "manuscript/source"
    out: list[str] = []
    flatten(root, "main.tex", out)
    out += ["\n", SEPARATOR, "\n"]
    flatten(root, "anc/auxiliary/terminal_smoothness.tex", out)
    return "".join(out)


# ------------------------------------------------------------------ the authors' numbers

def compile_labels(upstream: Path) -> dict[str, dict[str, str]]:
    """Every \\label's printed number, from Tectonic's .aux files for both documents."""
    if not shutil.which("tectonic"):
        raise ReadingCopyError("tectonic is needed to read the authors' numbers")
    found: dict[str, dict[str, str]] = {}
    with tempfile.TemporaryDirectory(prefix="euler-tex-") as scratch:
        work = Path(scratch) / "source"
        shutil.copytree(upstream / "manuscript/source", work)
        for doc, rel in (("main", "main.tex"), ("auxiliary", "anc/auxiliary/terminal_smoothness.tex")):
            path = work / rel
            # Tectonic is XeTeX; the pdfTeX switch makes hyperref load the wrong driver.
            path.write_text(path.read_text(encoding="utf-8").replace("\\pdfoutput=1", ""), encoding="utf-8")
            run = subprocess.run(["tectonic", "--keep-intermediates", path.name], cwd=path.parent,
                                 capture_output=True, text=True)
            if run.returncode:
                raise ReadingCopyError(f"tectonic failed on {rel}:\n{run.stderr[-1500:]}")
            aux = path.with_suffix(".aux").read_text(encoding="utf-8")
            labels = {m[1]: m[2] for m in re.finditer(r"\\newlabel\{([^}]+)\}\{\{([^}]*)\}", aux)}
            cites = {m[1]: m[2] for m in re.finditer(r"\\bibcite\{([^}]+)\}\{([^}]*)\}", aux)}
            found[doc] = {"labels": labels, "cites": cites}
    return found


# ------------------------------------------------------------------ small TeX readers

def group(text: str, pos: int, opening: str = "{", closing: str = "}") -> int:
    """The index just past the group that opens at text[pos]."""
    if text[pos] != opening:
        raise ReadingCopyError(f"expected {opening!r} at {pos}: {text[pos:pos + 40]!r}")
    depth, i = 0, pos
    while i < len(text):
        c = text[i]
        if c == "\\":
            i += 2
            continue
        if c == opening:
            depth += 1
        elif c == closing:
            depth -= 1
            if depth == 0:
                return i + 1
        i += 1
    raise ReadingCopyError(f"unclosed group at {pos}")


def strip_comments(text: str) -> str:
    out = []
    for line in text.splitlines(keepends=True):
        # A % inside an \href URL is part of the URL, as hyperref reads it.
        urls = [(m.start(), group(line, m.end() - 1)) for m in re.finditer(r"\\href\{", line) if _closes(line, m.end() - 1)]
        cut = next((m.start() for m in re.finditer(r"(?<!\\)%", line)
                    if not any(a < m.start() < b for a, b in urls)), None)
        out.append(line[:cut] + ("\n" if line.endswith("\n") else "") if cut is not None else line)
    return "".join(out)


def _closes(line: str, pos: int) -> bool:
    try:
        group(line, pos)
        return True
    except ReadingCopyError:
        return False


# ------------------------------------------------------------------ tie markers

def tie_spans(flat: str, ties: list[dict]) -> list[tuple[int, int, str]]:
    spans = []
    for tie in ties:
        start = flat.find(tie["after"]) + len(tie["after"]) if tie.get("after") else 0
        if tie.get("after") and flat.find(tie["after"]) < 0:
            raise ReadingCopyError(f"tie {tie['id']}: after-quote not found")
        f = flat.find(tie["from"], start)
        e = flat.find(tie["to"], f) if f >= 0 else -1
        if f < 0 or e < 0:
            raise ReadingCopyError(f"tie {tie['id']}: quote not found in the flattened TeX")
        spans.append((f, e + len(tie["to"]), tie["id"]))
    spans.sort()
    for (a, b, x), (c, d, y) in zip(spans, spans[1:]):
        if c < b:
            raise ReadingCopyError(f"ties {x} and {y} overlap")
    return spans


SKIP_FORWARD = re.compile(r"\s+|\\item\b\s*|\\noindent\b\s*|\\label\{[^}]*\}|"
                          r"\\begin\{(?:theorem|proposition|lemma|corollary|remark|proof|enumerate)\}(?:\[[^\]]*\])?")
SKIP_BACK = re.compile(r"(?:\s+|\\label\{[^}]*\}|\\end\{(?:theorem|proposition|lemma|corollary|remark|proof|enumerate)\})$")


def place_markers(flat: str, spans: list[tuple[int, int, str]]) -> tuple[str, dict[str, str]]:
    """Insert ZQnnnnA before and ZQnnnnB after each tie. A marker never sits between a
    structural command and its text, so the quotation stays inside one paragraph."""
    inserts = []
    names = {}
    for k, (a, b, tid) in enumerate(spans):
        while (m := SKIP_FORWARD.match(flat, a)) and m.end() <= b:
            a = m.end()
            if not m.group(0):
                break
        while (m := SKIP_BACK.search(flat[a:b])):
            if not m.group(0):
                break
            b -= len(m.group(0))
        token = f"{k:04d}"
        names[token] = tid
        glue = "{}" if re.search(r"\\[A-Za-z]+$", flat[:b]) else ""
        inserts.append((a, f"ZQ{token}A"))
        inserts.append((b, f"{glue}ZQ{token}B"))
    out = flat
    for pos, text in sorted(inserts, key=lambda x: x[0], reverse=True):
        out = out[:pos] + text + out[pos:]
    return out, names


# ------------------------------------------------------------------ numbering

class Numbers:
    def __init__(self) -> None:
        self.section = 0
        self.appendix = False
        self.theorem = 0
        self.equation = 0
        self.figure = 0
        self.subs: dict = {}

    def section_label(self) -> str:
        return chr(ord("A") + self.section - 1) if self.appendix else str(self.section)


def number_document(body: str, aux: dict, other: dict | None) -> tuple[str, dict[str, str]]:
    """Rewrite one document's body for Pandoc: numbered headings, theorems, equation tags,
    figures, written-out references and linked citations. Every number is compared with
    the one the authors' compiled TeX gives its label."""
    labels, cites = aux["labels"], aux["cites"]
    ours: dict[str, str] = {}
    n = Numbers()
    out: list[str] = []
    i = 0
    figures: list[dict] = []
    pattern = re.compile(r"\\(section|subsection|subsubsection)\*?\s*\{|\\appendix\b|"
                         r"\\begin\{(\w+\*?)\}|\\end\{(\w+\*?)\}")
    while True:
        m = pattern.search(body, i)
        if not m:
            out.append(body[i:])
            break
        out.append(body[i:m.start()])
        if m.group(1):
            level = m.group(1)
            close = group(body, m.end() - 1)
            title = body[m.end():close - 1]
            starred = "*" in body[m.start():m.end()]
            label = re.match(r"\s*\\label\{([^}]+)\}", body[close:])
            end = close + (label.end() if label else 0)
            title = re.sub(r"\\texorpdfstring\{((?:[^{}]|\{[^{}]*\})*)\}\{[^{}]*\}", r"\1", title)
            if level == "section" and not starred:
                n.section += 1
                n.theorem = n.equation = 0
                num = n.section_label()
                heading = f"\n\n## {num} {title}\n\n" if not n.appendix else f"\n\n## Appendix {num}. {title}\n\n"
            elif level == "section":
                num, heading = None, f"\n\n## {title}\n\n"
            else:
                num = None
                hashes = "###" if level == "subsection" else "####"
                heading = f"\n\n{hashes} {title}\n\n"
                if not starred:
                    num = sub_number(n, level)
                    heading = f"\n\n{hashes} {num} {title}\n\n"
            if label and num:
                ours[label.group(1)] = num
            out.append("ZHEAD" + heading.strip("\n").replace("\n", " ") + "ZEND\n\n")
            i = end
            continue
        if m.group(0).startswith("\\appendix"):
            n.appendix, n.section = True, 0
            i = m.end()
            continue
        env = m.group(2) or m.group(3)
        opening = bool(m.group(2))
        if env in THEOREMS and opening:
            n.theorem += 1
            num = f"{n.section_label()}.{n.theorem}"
            j = m.end()
            title = ""
            if j < len(body) and body[j] == "[":
                k = group(body, j, "[", "]")
                title = f" ({body[j + 1:k - 1]})"
                j = k
            label = re.match(r"\s*\\label\{([^}]+)\}", body[j:])
            if label:
                ours[label.group(1)] = num
                j += label.end()
            out.append(f"\n\n\\textbf{{{THEOREMS[env]} {num}{title}.}} ")
            i = j
            continue
        if env in THEOREMS:
            out.append("\n\n")
            i = m.end()
            continue
        if env == "proof":
            if opening:
                j = m.end()
                head = "Proof"
                if j < len(body) and body[j] == "[":
                    k = group(body, j, "[", "]")
                    head = body[j + 1:k - 1]
                    j = k
                out.append(f"\n\n\\textit{{{head}.}} ")
                i = j
            else:
                out.append(" $\\square$\n\n")
                i = m.end()
            continue
        if env in NUMBERED_MATH and opening:
            close = body.index(f"\\end{{{env}}}", m.end())
            inner = body[m.end():close]
            rows = split_rows(inner) if env == "align" else [inner]
            new_rows = []
            pending: list[str] = []
            for row in rows:
                skip = re.search(r"\\(?:nonumber|notag)\b", row)
                row = re.sub(r"\\(?:nonumber|notag)\b", "", row)
                found = pending + re.findall(r"\\label\{([^}]+)\}", row)
                row = re.sub(r"\\label\{[^}]+\}", "", row)
                if skip:
                    # amsmath gives a label on an unnumbered row the next row's number.
                    pending = found
                    new_rows.append(row)
                    continue
                pending = []
                n.equation += 1
                num = f"{n.section_label()}.{n.equation}"
                for lab in found:
                    ours[lab] = num
                new_rows.append(row.rstrip() + f" \\tag{{{num}}}" + ("\n" if row.endswith("\n") else ""))
            out.append(f"\\begin{{{env}}}" + "\\\\".join(new_rows) + f"\\end{{{env}}}")
            i = close + len(f"\\end{{{env}}}")
            continue
        if env == "figure" and opening:
            close = body.index("\\end{figure}", m.end())
            inner = body[m.end():close]
            n.figure += 1
            cap_at = inner.index("\\caption")
            cap_end = group(inner, inner.index("{", cap_at))
            caption = inner[inner.index("{", cap_at) + 1:cap_end - 1]
            label = re.search(r"\\label\{([^}]+)\}", inner)
            if label:
                ours[label.group(1)] = str(n.figure)
            graphic = re.search(r"\\includegraphics(?:\[[^\]]*\])?\{([^}]+)\}", inner)
            source = graphic.group(1) if graphic else None
            tikz = None
            if not graphic:
                t0 = inner.index("\\begin{tikzpicture}")
                t1 = inner.index("\\end{tikzpicture}") + len("\\end{tikzpicture}")
                tikz = inner[t0:t1]
            name = f"figures/figure-{n.figure}.svg"
            figures.append({"number": n.figure, "file": name, "source": source, "tikz": tikz})
            out.append(f"\n\nZFIG{n.figure}Z\n\n\\textbf{{Figure {n.figure}.}} {caption}\n\n")
            i = close + len("\\end{figure}")
            continue
        out.append(m.group(0))
        i = m.end()
    text = "".join(out)

    mismatched = [f"{k}: ours {v}, theirs {labels.get(k)}" for k, v in ours.items() if labels.get(k) != v]
    missing = [k for k in labels if k not in ours and not k.startswith("cc:fig") and k in body]
    if mismatched:
        raise ReadingCopyError("numbers differ from the compiled TeX:\n" + "\n".join(mismatched[:20]))

    def reference(match: re.Match) -> str:
        kind, key = match.group(1), match.group(2)
        if key.startswith("M-") and other is not None:
            value = other["labels"].get(key[2:])
        else:
            value = labels.get(key)
        if value is None:
            raise ReadingCopyError(f"no number for \\{kind}{{{key}}}")
        return f"({value})" if kind == "eqref" else value

    text = re.sub(r"\\(eqref|ref)\{([^}]+)\}", reference, text)
    # A drawn figure is compiled on its own, without the paper's labels, so its references
    # are written out here as the paper prints them.
    for fig in figures:
        if fig["tikz"]:
            fig["tikz"] = re.sub(r"\\(eqref|ref)\{([^}]+)\}", reference, fig["tikz"])

    def citation(match: re.Match) -> str:
        note = match.group(1)
        keys = [k.strip() for k in match.group(2).split(",")]
        parts = []
        for key in keys:
            if key not in cites:
                raise ReadingCopyError(f"no bibliography entry for {key}")
            parts.append(f"\\href{{\\#cite-{key}}}{{{cites[key]}}}")
        inner = ", ".join(parts) + (f", {note}" if note else "")
        return f"[{inner}]"

    text = re.sub(r"\\cite(?:\[([^\]]*)\])?\{([^}]+)\}", citation, text)
    text = re.sub(r"\\bibitem\{([^}]+)\}", lambda m: f"\n\nZBIB{m.group(1)}ZZBIB ", text)
    text = re.sub(r"\\begin\{thebibliography\}\{[^}]*\}", "\n\nZHEAD## ReferencesZEND\n\n", text)
    text = text.replace("\\end{thebibliography}", "\n\n")
    return text, {"figures": figures, "missing": missing, "cites": cites, "numbers": ours}


def sub_number(n: Numbers, level: str) -> str:
    key = (n.appendix, n.section)
    state = n.subs.setdefault(key, [0, 0])
    if level == "subsection":
        state[0] += 1
        state[1] = 0
        return f"{n.section_label()}.{state[0]}"
    state[1] += 1
    return f"{n.section_label()}.{state[0]}.{state[1]}"


def split_rows(inner: str) -> list[str]:
    """The rows of an align: split at \\\\ outside braces."""
    rows, depth, cur, i = [], 0, [], 0
    while i < len(inner):
        c = inner[i]
        if c == "\\" and inner.startswith("\\\\", i) and depth == 0:
            rows.append("".join(cur))
            cur = []
            i += 2
            continue
        if c == "\\":
            cur.append(inner[i:i + 2])
            i += 2
            continue
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
        cur.append(c)
        i += 1
    rows.append("".join(cur))
    return rows


# ------------------------------------------------------------------ Pandoc

def pandoc(tex: str) -> str:
    run = subprocess.run(
        ["pandoc", "-f", "latex", "-t",
         "markdown-raw_tex-raw_attribute-header_attributes-fenced_divs-native_divs-native_spans"
         "-bracketed_spans-link_attributes-citations-smart-implicit_figures-simple_tables-multiline_tables-grid_tables",
         "--wrap=none"],
        input=tex, capture_output=True, text=True)
    if run.returncode:
        dump = Path(tempfile.gettempdir()) / "euler-pandoc-input.tex"
        dump.write_text(tex, encoding="utf-8")
        raise ReadingCopyError(f"pandoc failed (input kept in {dump}):\n{run.stderr[-2000:]}")
    return run.stdout


def document_parts(doc: str) -> tuple[str, str, str]:
    """Macro definitions, front matter (title, authors, abstract) and body of one document."""
    macros = "\n".join(line for line in doc.splitlines() if re.match(r"\s*\\(?:newcommand|providecommand|renewcommand)", line)
                       and "MainAuxPath" not in line)
    begin = doc.index("\\begin{document}") + len("\\begin{document}")
    end = doc.index("\\end{document}")
    inner = doc[begin:end]
    abs0 = inner.find("\\begin{abstract}")
    abs1 = inner.find("\\end{abstract}")
    abstract = inner[abs0 + len("\\begin{abstract}"):abs1] if abs0 >= 0 else ""
    after = inner[abs1 + len("\\end{abstract}"):] if abs0 >= 0 else inner
    after = re.sub(r"\\(?:maketitle|tableofcontents|raggedbottom|centering|qedhere|needspace\{[^}]*\})", "", after)
    after = re.sub(r"\\setcounter\{[^}]*\}\{[^}]*\}", "", after)
    return macros, abstract, after


def front(title: str, authors: list[str], abstract_md: str) -> str:
    people = "\n".join(f"<li>{a}</li>" for a in authors)
    block = f'<header class="front">\n\n# {title}\n\n'
    if authors:
        block += f'<ul class="authors">\n{people}\n</ul>\n\n'
    block += "</header>\n\n"
    if abstract_md.strip():
        block += f'<section class="abstract">\n\n{abstract_md.strip()}\n\n</section>\n\n'
    return block


def post(md: str, cites: dict, figures: list[dict]) -> str:
    md = re.sub(r"ZHEAD(.*?)ZEND", lambda m: m.group(1).replace("\\#", "#"), md)
    md = re.sub(r"^\\(#+ )", r"\1", md, flags=re.M)
    md = re.sub(r"ZBIB(.+?)ZZBIB ?", lambda m: f'<a id="cite-{m.group(1)}"></a>\\[{cites[m.group(1)]}\\] ', md)
    for fig in figures:
        md = md.replace(f"ZFIG{fig['number']}Z", f"![Figure {fig['number']}]({fig['file']})")
    return md


# ------------------------------------------------------------------ figures

def figure_svgs(upstream: Path, figures: list[dict], preamble: str, out: Path) -> None:
    out.mkdir(parents=True, exist_ok=True)
    src = upstream / "manuscript/source"
    with tempfile.TemporaryDirectory(prefix="euler-fig-") as scratch:
        for fig in figures:
            target = out / Path(fig["file"]).name
            if fig["source"]:
                pdf = src / fig["source"]
            else:
                tex = Path(scratch) / f"fig{fig['number']}.tex"
                packages = "\n".join(line for line in preamble.splitlines()
                                     if re.match(r"\\(?:usepackage|usetikzlibrary|newcommand)", line)
                                     and "geometry" not in line and "hyperref" not in line)
                tex.write_text("\\documentclass[11pt,border=4pt]{standalone}\n" + packages +
                               "\n\\begin{document}\n" + fig["tikz"] + "\n\\end{document}\n", encoding="utf-8")
                run = subprocess.run(["tectonic", tex.name], cwd=scratch, capture_output=True, text=True)
                if run.returncode:
                    raise ReadingCopyError(f"tectonic failed on figure {fig['number']}:\n{run.stderr[-1500:]}")
                pdf = tex.with_suffix(".pdf")
            run = subprocess.run(["pdftocairo", "-svg", str(pdf), str(target)], capture_output=True, text=True)
            if run.returncode:
                raise ReadingCopyError(f"pdftocairo failed on figure {fig['number']}: {run.stderr}")


# ------------------------------------------------------------------ quotations

def read_ties(md: str, names: dict[str, str]) -> tuple[str, dict[str, dict]]:
    """Remove the markers and return each tie's exact quotation of the Markdown."""
    found = {}
    clean, shift = [], 0
    pieces = re.split(r"(ZQ\d{4}[AB])", md)
    pos = 0
    opened: dict[str, int] = {}
    for piece in pieces:
        m = re.fullmatch(r"ZQ(\d{4})([AB])", piece)
        if m:
            if m.group(2) == "A":
                opened[m.group(1)] = pos
            else:
                if m.group(1) not in opened:
                    raise ReadingCopyError(f"tie {names[m.group(1)]}: closing marker before opening")
                found[names[m.group(1)]] = (opened.pop(m.group(1)), pos)
            continue
        clean.append(piece)
        pos += len(piece)
    text = "".join(clean)
    missing = [names[t] for t in names if names[t] not in found]
    if missing or opened:
        raise ReadingCopyError(f"markers lost by Pandoc for ties: {missing[:20]} {list(opened)[:20]}")
    ties = {}
    for tid, (a, b) in found.items():
        a, b = balance(text, a, b)
        ties[tid] = {"start": a, "stop": b, "quote": text[a:b]}
    return text, ties


def balance(text: str, a: int, b: int) -> tuple[int, int]:
    """Widen a span over surrounding spaces, emphasis and link brackets it cuts."""
    while a < b and text[a].isspace():
        a += 1
    while b > a and text[b - 1].isspace():
        b -= 1
    def outside_math(q: str) -> str:
        return re.sub(r"\$\$.*?\$\$|(?<!\\)\$[^$]*\$", "", q, flags=re.S)

    for _ in range(4):
        q = outside_math(text[a:b])
        if q.count("**") % 2:
            if text[a - 2:a] == "**":
                a -= 2
            elif text[b:b + 2] == "**":
                b += 2
        q = outside_math(text[a:b])
        single = len(re.findall(r"(?<!\*)\*(?!\*)", q))
        if single % 2:
            if a and text[a - 1] == "*" and text[a - 2:a] != "**":
                a -= 1
            elif text[b:b + 1] == "*":
                b += 1
        q = text[a:b]
        bare = outside_math(text[a:b]).replace("\\[", "").replace("\\]", "")
        # A Markdown link the span opens but does not close, or enters in the middle.
        if re.search(r"\[[^\]]*$", bare) or re.search(r"\]\([^)]*$", bare):
            close = text.find(")", b)
            if close > 0 and "\n" not in text[b:close]:
                b = close + 1
        if re.match(r"^[^\[]*\]\(", bare):
            opening = text.rfind("[", 0, a)
            if opening >= 0 and "\n" not in text[opening:a]:
                a = opening
    return a, b


def main() -> int:
    upstream, ties_path = Path(sys.argv[1]), Path(sys.argv[2])
    flat = flat_tex(upstream)
    ties = json.loads(ties_path.read_text(encoding="utf-8"))["ties"]
    spans = tie_spans(flat, ties)
    marked, names = place_markers(flat, spans)
    main_doc, aux_doc = marked.split(SEPARATOR)
    numbers = compile_labels(upstream)

    parts = []
    figures_all = []
    record = {}
    for doc, key, other in ((main_doc, "main", None), (aux_doc, "auxiliary", numbers["main"])):
        doc = strip_comments(doc)
        macros, abstract, body = document_parts(doc)
        body, info = number_document(body, numbers[key], other)
        record[key] = {"numbers": len(info["numbers"]), "labels": len(numbers[key]["labels"])}
        figures_all += info["figures"]
        md = post(pandoc(macros + "\n\\begin{document}\n" + body + "\n\\end{document}\n"), info["cites"], info["figures"])
        abstract_md = post(pandoc(macros + "\n\\begin{document}\n" + abstract + "\n\\end{document}\n"), info["cites"], [])
        if key == "main":
            head = front("Finite-Time Singularity Formation for the Three-Dimensional Euler Equations",
                         ["Levent Alpöge", "Tristan Buckmaster", "Matei P. Coiculescu"], abstract_md)
        else:
            head = ("## Auxiliary note. Smooth terminal regularity away from the origin\n\n"
                    "<section class=\"abstract\">\n\n" + abstract_md.strip() + "\n\n</section>\n\n")
            md = re.sub(r"^## (\d+|References)\b", lambda m: "### Note " + m.group(1) if m.group(1) != "References" else "### References of the note", md, flags=re.M)
        parts.append(head + md.strip() + "\n")
        if key == "main":
            figure_svgs(upstream, info["figures"], doc[:doc.index("\\begin{document}")], HERE / "figures")
    combined = "\n".join(parts)
    text, quotes = read_ties(combined, names)
    if "ZQ" in text or "ZFIG" in text or "ZBIB" in text or "ZHEAD" in text:
        raise ReadingCopyError("a marker survived")
    (HERE / "paper.md").write_text(text, encoding="utf-8")
    out = HERE / "generated" / "reading-ties.json"
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps({"commit": COMMIT, "source_sha256": hashlib.sha256(flat.encode()).hexdigest(),
                               "paper_md_sha256": hashlib.sha256(text.encode()).hexdigest(),
                               "numbers": record, "ties": quotes}, indent=1, ensure_ascii=False) + "\n",
                   encoding="utf-8")
    print(f"paper.md: {len(text)} characters, {len(quotes)} ties carried, {len(figures_all)} figures; numbers {record}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
