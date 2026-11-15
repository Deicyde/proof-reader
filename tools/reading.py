"""Render an author's Markdown directly, or compare a reading copy with PDF text.

The comparison uses PDF text after margin and figure filtering. It normalizes
some characters and allows moved text, which can also hide changes in word or
character order. It helps detect transcription errors but does not certify an
exact copy. The comparison also assigns page marks to the reading text.

Passages and Lean names are found in the rendered text, then marked in place.
"""
from __future__ import annotations

import html
import json
import re
import subprocess
import unicodedata
from bisect import bisect_left
from collections import Counter
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path
from urllib.parse import quote as urlquote, unquote, urljoin

ROOT = Path(__file__).resolve().parent.parent
RENDER = ROOT / "web" / "tools" / "render-paper.mjs"

# Formulas first, so each one is a single piece of the page.
PART = re.compile(r'<span class="m" data-m="(\d+)">(.*?)</span>|<[^>]+>|[^<]+', re.S)
BLOCK = re.compile(r"</?(?:p|div|li|ul|ol|pre|figure|figcaption|h[1-6]|aside|header|section|blockquote|table|thead|tbody|tr|th|td)\b|<span class=\"cl\"")
# The blocks a reader sees as a paragraph: a code line inside a listing is not one.
PARAGRAPH = re.compile(r"</?(?:p|div|li|ul|ol|pre|figure|figcaption|h[1-6]|aside|header|section|blockquote|table|thead|tbody|tr|th|td)\b")
TAG_NAME = re.compile(r"</?([a-zA-Z0-9]+)")
BULLETS = {"•", "∙", "◦"}
ALLOWED_TAGS = {
    "a", "aside", "blockquote", "br", "code", "div", "em", "figcaption", "figure", "h1", "h2", "h3", "h4", "header", "hr",
    "img", "li", "ol", "p", "pre", "section", "span", "strong", "sub", "sup", "ul", "h5", "h6",
    "table", "thead", "tbody", "tr", "th", "td",
}


class ReadingError(Exception):
    pass


@dataclass
class Part:
    kind: str  # tag, text or math
    raw: str = ""
    text: str = ""
    start: int = 0
    code: bool = False
    link: bool = False
    # A space added here so that a block ends a word. It is not the paper's.
    added: bool = False


@dataclass
class Page:
    parts: list[Part] = field(default_factory=list)
    visible: str = ""


def render(markdown: Path, slug: str, *, guide: bool = False, passages: list[dict] | None = None,
           language: str = "haskell") -> dict:
    args = ["node", str(RENDER), str(markdown), slug]
    if guide:
        args += [language, "--markdown-source"]
    done = subprocess.run(args, input=json.dumps({"passages": passages or []}) if guide else None,
                          capture_output=True, text=True, cwd=ROOT / "web")
    if done.returncode != 0:
        raise ReadingError(f"could not set {markdown.name}:\n{done.stderr[-1500:]}")
    return json.loads(done.stdout)


def resolve_markdown(markdown: Path, slug: str, passages: list[dict], language: str = "lean") -> tuple[dict, list[dict]]:
    """Resolve exact raw quotes before rendering. An anchor never excuses a duplicate."""
    source = markdown.read_bytes().decode("utf-8")
    done = render(markdown, slug, guide=True, passages=passages, language=language)
    lines = source.splitlines(keepends=True)
    offsets = [0]
    for line in lines:
        offsets.append(offsets[-1] + len(line))
    resolved, errors = [], []
    for item in passages:
        pid, quote = item["id"], item["quote"]
        if item.get("nth") is not None or item.get("page") is not None:
            errors.append(f"passage {pid}: Markdown uses anchor, not nth or page")
        hits = spot(source, quote) if quote else []
        if len(hits) != 1:
            errors.append(f"passage {pid}: exact quote found {len(hits)} times in {markdown.name}, needs exactly one")
            continue
        anchor = item.get("anchor", {})
        if not isinstance(anchor, dict) or not isinstance(anchor.get("heading"), str) or type(anchor.get("block")) is not int or anchor["block"] < 1:
            errors.append(f"passage {pid}: anchor needs exact heading and positive integer block")
            continue
        blocks = [b for b in done["source_blocks"] if b["heading"] == anchor["heading"] and b["block"] == anchor["block"]]
        if len(blocks) != 1:
            errors.append(f"passage {pid}: heading/block resolves to {len(blocks)} source blocks, needs exactly one")
            continue
        block = blocks[0]
        start, stop = hits[0], hits[0] + len(quote)
        if not offsets[block["line"] - 1] <= start < stop <= offsets[block["end_line"]]:
            errors.append(f"passage {pid}: quote is outside its heading/block anchor")
            continue
        resolved.append({**item, "page": None, "last_page": None, "rects": [], "order": start,
                         "source_quote": quote, "source_block": block["id"],
                         "source_lines": [source.count("\n", 0, start) + 1, source.count("\n", 0, stop - 1) + 1]})
    if errors:
        raise ReadingError("\n".join(errors))
    return done, resolved


def locate_markdown(page: Page, done: dict, passages: list[dict]) -> tuple[dict, dict]:
    """Locate each rendered quote inside its already checked source block."""
    bounds, position = {}, 0
    for part in page.parts:
        if part.kind == "tag":
            marker = re.search(r'data-source-(start|end)="([^"]+)"', part.raw)
            if marker:
                bounds.setdefault(marker[2], {})[marker[1]] = position
        else:
            position = part.start + len(part.text)
    spans, visible_quotes, errors = {}, {}, []
    for passage in passages:
        pid = passage["id"]
        bound = bounds.get(passage["source_block"], {})
        if set(bound) != {"start", "end"}:
            errors.append(f"passage {pid}: rendered source block markers are missing")
            continue
        quote = parse(done["quote_html"][pid]).visible
        target, _ = squeeze(quote)
        squeezed, back = squeeze(page.visible[bound["start"]:bound["end"]])
        hits = spot(squeezed, target) if target else []
        if len(hits) != 1:
            errors.append(f"passage {pid}: rendered quote found {len(hits)} times in its source block, needs exactly one")
            continue
        spans[pid] = (bound["start"] + back[hits[0]], bound["start"] + back[hits[0] + len(target) - 1] + 1)
        visible_quotes[pid] = quote
    if errors:
        raise ReadingError("\n".join(errors))
    return spans, visible_quotes


def numbered_ranges(ranges: list[tuple[str, int]], outline: list[dict]) -> list[tuple[str, int]]:
    """An unnumbered subheading belongs to the numbered section above it, so that
    `name_sections` can name section 3 and cover its subheadings too."""
    owner, stack = {}, []
    for entry in outline:
        while stack and stack[-1]["level"] >= entry["level"]:
            stack.pop()
        owner[entry["id"]] = entry["id"] if entry["number"] else next((s["id"] for s in reversed(stack) if s["number"]), entry["id"])
        stack.append(entry)
    return [(owner.get(name, name), start) for name, start in ranges]


def build_markdown(done: dict, slug: str, passages: list[dict], names: list[str], source_url: str,
                   name_sections: list[str] | None = None, companions: dict[str, str] | None = None) -> dict:
    """Render the author's Markdown directly, with source lines instead of PDF pages."""
    route = f"./#/{slug}"

    def link(match):
        url = html.unescape(match[1])
        aliases = done["heading_aliases"]
        reader_url = url.removeprefix("./")
        path, _, fragment = url.partition("#")
        if companions and path in companions:
            reader_url = f"#/{urlquote(companions[path], safe='')}"
            if fragment:
                reader_url += f"#{fragment}"
        companion = re.fullmatch(r"#/([^/#]+)#([^#]+)", reader_url)
        if companion:
            paper, heading = companion.groups()
            heading = unquote(heading)
            if unquote(paper) == slug:
                heading = aliases.get(heading, heading)
            reader_url = f"#/{paper}/@{urlquote(heading, safe='')}"
        if reader_url.startswith("#/"):
            return f'href="./{html.escape(reader_url, quote=True)}"'
        if url.startswith("#") and unquote(url[1:]) in aliases:
            return f'href="{route}/@{aliases[unquote(url[1:])]}"'
        return f'href="{html.escape(urljoin(source_url, url), quote=True)}"'

    source = re.sub(r'href="([^"]+)"', link, done["html"])
    check_tags(source)
    source = re.sub(r'<a href="(https?://[^"]+)"', r'<a class="ext" href="\1" target="_blank" rel="noopener noreferrer"', source)
    page = parse(source)
    spans, quotes = locate_markdown(page, done, passages)
    ranges = section_ranges(page, done["outline"])
    mentions = names_in(page, names, numbered_ranges(ranges, done["outline"]), name_sections)
    body = weave(page, spans, mentions, {}, done["math"], route)
    counts = Counter(section_at(ranges, start) for start, _ in spans.values())
    code_blocks = {b["id"] for b in done["source_blocks"] if b["kind"] in ("fence", "code_block")}
    code = {p["id"] for p in passages if p["source_block"] in code_blocks}
    return {"html": body, "outline": [{**entry, "ties": counts[entry["id"]], "page": None} for entry in done["outline"]],
            "heading_aliases": done["heading_aliases"],
            "words": len(page.visible.split()), "formulas": len(done["math"]), "pages": 0,
            "order": sorted(spans, key=lambda pid: spans[pid][0]), "code": code, "display_quotes": quotes,
            "paragraphs": {pid: paragraph(page, start, stop, quotes[pid]) for pid, (start, stop) in spans.items()}}


def check_tags(source: str) -> None:
    """paper.md may hold a little HTML, and nothing that runs."""
    for tag in re.findall(r"<[^>]+>", source):
        tag = html.unescape(tag)
        name = TAG_NAME.match(tag)
        if name and name[1].lower() not in ALLOWED_TAGS:
            raise ReadingError(f"paper.md may not use <{name[1]}>")
        if re.search(r"\son\w+\s*=", tag, re.I) or re.search(r"javascript:|vbscript:", re.sub(r"[\x00-\x20]", "", tag), re.I):
            raise ReadingError(f"paper.md may not use this tag: {tag[:80]}")


def parse(source: str) -> Page:
    page = Page()
    code = link = 0
    length = 0
    for match in PART.finditer(source):
        raw = match[0]
        if match[1] is not None:
            part = Part("math", raw=match[1], text=html.unescape(match[2]), start=length, code=code > 0, link=link > 0)
            length += len(part.text)
            page.parts.append(part)
        elif raw.startswith("<"):
            if re.match(r"<code\b", raw):
                code += 1
            elif raw.startswith("</code"):
                code -= 1
            elif re.match(r"<a\b", raw):
                link += 1
            elif raw.startswith("</a"):
                link -= 1
            page.parts.append(Part("tag", raw=raw))
            if BLOCK.match(raw):
                # Blocks end words. A space here is the reader's, not the paper's.
                page.parts.append(Part("text", text=" ", start=length, added=True))
                length += 1
        else:
            text = html.unescape(raw)
            page.parts.append(Part("text", text=text, start=length, code=code > 0, link=link > 0))
            length += len(text)
    page.visible = "".join(part.text for part in page.parts if part.kind != "tag")
    return page


def normal(text: str) -> str:
    text = unicodedata.normalize("NFKC", text)
    return text.replace("’", "'").replace("‘", "'").replace("“", '"').replace("”", '"').replace("−", "-").replace("⁡", "").replace("⁢", "").replace("​", "")


def squash(text: str) -> str:
    """A word without what a line end can add: spaces and hyphens."""
    return re.sub(r"[\s\-‐‑]", "", text)


def compare(theirs: list[str], ours: list[str]) -> tuple[dict[int, int], list[dict]]:
    """Line our words up with the PDF's. Returns our word -> PDF word, and every difference.

    Blocks may move: a footnote leaves the foot of its page and a figure leaves
    the top. So what fails to line up in place is compared again as a whole, and
    only what still fails is a difference.
    """
    found: dict[int, int] = {}
    left_theirs, left_ours = list(range(len(theirs))), list(range(len(ours)))
    for _ in range(3):
        a = [theirs[i] for i in left_theirs]
        b = [ours[i] for i in left_ours]
        opcodes = SequenceMatcher(None, a, b, autojunk=False).get_opcodes()
        next_theirs: list[int] = []
        next_ours: list[int] = []
        for tag, a0, a1, b0, b1 in opcodes:
            if tag == "equal":
                for k in range(b1 - b0):
                    found[left_ours[b0 + k]] = left_theirs[a0 + k]
            elif tag == "replace" and squash("".join(a[a0:a1])) == squash("".join(b[b0:b1])):
                for k in range(b0, b1):
                    found[left_ours[k]] = left_theirs[a0]
            else:
                next_theirs.extend(left_theirs[a0:a1])
                next_ours.extend(left_ours[b0:b1])
        left_theirs, left_ours = next_theirs, next_ours
        if not left_theirs and not left_ours:
            break
    if not left_theirs and not left_ours:
        return found, []
    # What remains is compared letter by letter, so that one split formula or a
    # moved block does not read as a run of different words.
    a = "".join(squash(theirs[i]) for i in left_theirs)
    b = "".join(squash(ours[i]) for i in left_ours)
    differences = []
    for tag, a0, a1, b0, b1 in SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
        if tag != "equal":
            differences.append({"pdf": a[max(0, a0 - 12):a1 + 12], "ours": b[max(0, b0 - 12):b1 + 12], "gone": a[a0:a1], "new": b[b0:b1]})
    # The same letters in another order is a move across a page turn, not a change.
    if Counter("".join(d["gone"] for d in differences)) == Counter("".join(d["new"] for d in differences)):
        return found, []
    return found, differences


def spot(squeezed: str, quote: str) -> list[int]:
    hits = []
    at = squeezed.find(quote)
    while at >= 0:
        hits.append(at)
        at = squeezed.find(quote, at + 1)
    return hits


def squeeze(visible: str) -> tuple[str, list[int]]:
    """The visible text without spaces, each letter remembering where it came from."""
    letters: list[str] = []
    back: list[int] = []
    for index, char in enumerate(visible):
        for letter in normal(char):
            if not letter.isspace():
                letters.append(letter)
                back.append(index)
    return "".join(letters), back


def locate(page: Page, passages: list[dict]) -> tuple[dict[str, tuple[int, int]], list[str]]:
    squeezed, back = squeeze(page.visible)
    where: dict[str, tuple[int, int]] = {}
    errors = []
    for passage in passages:
        target = re.sub(r"\s+", "", normal(passage["quote"]))
        hits = spot(squeezed, target)
        if passage.get("nth"):
            hits = hits[passage["nth"] - 1:passage["nth"]]
        if len(hits) != 1:
            errors.append(f"passage {passage['id']}: found {len(hits)} times in paper.md, needs exactly one")
            continue
        where[passage["id"]] = (back[hits[0]], back[hits[0] + len(target) - 1] + 1)
    return where, errors


def paragraph(page: Page, start: int, stop: int, quote: str) -> dict | None:
    """The plain text of the paragraph holding a passage, split round its quote.

    None when the quote crosses a paragraph's edge or the paragraph's words do not
    read as the quote with only spaces changed.
    """
    edges = [0]
    length = 0
    for part in page.parts:
        if part.kind == "tag":
            if PARAGRAPH.match(part.raw):
                edges.append(length)
        else:
            length = part.start + len(part.text)
    edges.append(len(page.visible))
    if any(start < edge < stop for edge in edges):
        return None
    first = max(edge for edge in edges if edge <= start)
    last = min(edge for edge in edges if edge >= stop)
    text = " ".join(page.visible[first:last].split())
    lead = page.visible[first:start]
    before = " ".join(lead.split())
    if before and lead[-1].isspace():
        before += " "
    if not text[len(before):].startswith(quote) or not text.startswith(before):
        return None
    return {"text": text, "before": before, "after": text[len(before) + len(quote):]}


def section_ranges(page: Page, outline: list[dict]) -> list[tuple[str, int]]:
    """Where each section begins in the visible text."""
    ranges = []
    wanted = {entry["id"] for entry in outline}
    for index, part in enumerate(page.parts):
        if part.kind == "tag":
            match = re.match(r'<h[234] id="([^"]+)"', part.raw)
            if match and match[1] in wanted:
                following = next((p for p in page.parts[index:] if p.kind != "tag"), None)
                ranges.append((match[1], following.start if following else len(page.visible)))
    return ranges


def section_at(ranges: list[tuple[str, int]], offset: int) -> str | None:
    current = None
    for name, start in ranges:
        if start <= offset:
            current = name
    return current


def names_in(page: Page, names: list[str], ranges: list[tuple[str, int]], sections: list[str] | None) -> list[tuple[int, int, str]]:
    """Lean names printed as code. Only code counts: `Index` in a sentence is a word."""
    if not names:
        return []
    pattern = re.compile(r"(?<![A-Za-z0-9_'])(" + "|".join(re.escape(n) for n in sorted(names, key=len, reverse=True)) + r")(?![A-Za-z0-9_'])")
    found = []
    allowed = None if sections is None else {f"s-{s}" for s in sections}
    # Syntax highlighting splits `Namespace.name` across spans. Read each code
    # run as one string, while keeping separate code elements and links apart.
    runs: list[tuple[int, str]] = []
    joining = False
    for part in page.parts:
        if part.kind == "tag":
            if re.match(r"</?(?:code|a)\b", part.raw):
                joining = False
        elif part.kind == "text" and part.code and not part.link:
            if joining and runs[-1][0] + len(runs[-1][1]) == part.start:
                runs[-1] = (runs[-1][0], runs[-1][1] + part.text)
            else:
                runs.append((part.start, part.text))
            joining = True
        else:
            joining = False
    for offset, text in runs:
        for match in pattern.finditer(text):
            start = offset + match.start()
            place = section_at(ranges, start)
            if allowed is None or (place in allowed or (place or "").split(".")[0] in allowed):
                found.append((start, offset + match.end(), match[1]))
    return found


def weave(page: Page, spans: dict[str, tuple[int, int]], names: list[tuple[int, int, str]], marks: dict[int, str], math: list[str], route: str) -> str:
    """Write the page with passages, names and page marks in place."""
    edges = sorted({*(s for pair in spans.values() for s in pair), *(s for trio in names for s in trio[:2]), *marks})
    placed: set[int] = set()
    out: list[str] = []

    def passages_at(start: int, stop: int) -> str:
        return " ".join(sorted(key for key, (a, b) in spans.items() if a < stop and b > start))

    def name_at(start: int) -> str | None:
        return next((name for a, b, name in names if a <= start < b), None)

    def wrap(chunk: str, start: int, stop: int) -> str:
        name = name_at(start)
        if name:
            chunk = f'<a class="nm" data-name="{html.escape(name)}" href="{route}/{html.escape(name)}">{chunk}</a>'
        ids = passages_at(start, stop)
        if ids:
            chunk = f'<span class="q" data-p="{html.escape(ids)}">{chunk}</span>'
        return chunk

    def mark(offset: int) -> None:
        if offset in marks and offset not in placed:
            placed.add(offset)
            out.append(marks[offset])

    for part in page.parts:
        if part.kind == "tag":
            out.append(part.raw)
        elif part.kind == "math":
            mark(part.start)
            out.append(wrap(math[int(part.raw)], part.start, part.start + len(part.text)))
        else:
            stop = part.start + len(part.text)
            if part.added and not part.code and out and out[-1].startswith("<"):
                continue
            cuts = [part.start] + [e for e in edges if part.start < e < stop] + [stop]
            for a, b in zip(cuts, cuts[1:]):
                mark(a)
                chunk = part.text[a - part.start:b - part.start]
                out.append(wrap(html.escape(chunk, quote=False), a, b))
    return "".join(out)


def page_marks(words: list[tuple[int, int]], found: dict[int, int], theirs_pages: list[int], label: str, route: str) -> dict[int, str]:
    """A mark where each PDF page begins, in the order a reader meets them."""
    marks: dict[int, str] = {}
    reached = 0
    for index, (start, _stop) in enumerate(words):
        if index not in found:
            continue
        page = theirs_pages[found[index]]
        if page == reached + 1:
            reached = page
            text = label.format(page=page)
            marks[start] = f'<a class="pg" data-page="{page}" href="{route}/@page-{page}" title="Open page {page} of the PDF" aria-label="Open page {page} of the PDF">{text}</a>'
    return marks


def build(folder: Path, slug: str, passages: list[dict], names: list[str], pdf_words: list[dict], reading_config: dict, link_config: dict) -> dict:
    """The reading copy, or an exception listing each word that differs from the PDF."""
    markdown = folder / "paper.md"
    done = render(markdown, slug)
    check_tags(markdown.read_text(encoding="utf-8").split("```")[0])
    route = f"./#/{slug}"
    source = re.sub(r'href="#([^"]+)"', lambda m: f'href="{route}/@{m[1]}"', done["html"])
    source = re.sub(r'<a href="(https?://[^"]+)"', r'<a class="ext" href="\1" target="_blank" rel="noopener noreferrer"', source)
    # A plot takes its width from the paper and reserves its height before it loads.
    for figure in reading_config.get("figure", []):
        x0, y0, x1, y1 = figure["box"]
        source = source.replace(f'class="zoom" data-figure="{figure["name"]}"', f'class="zoom" style="--natural:{round(x1 - x0)}" data-figure="{figure["name"]}"')
        source = source.replace(f'{figure["name"]}" alt=', f'{figure["name"]}" width="{round(x1 - x0)}" height="{round(y1 - y0)}" loading="lazy" decoding="async" alt=')
    page = parse(source)

    # A list's bullets are drawn by the page, so they are not words on either side.
    words = [(m.start(), m.end()) for m in re.finditer(r"\S+", page.visible) if m[0] not in BULLETS]
    ours = [normal(page.visible[a:b]) for a, b in words]
    boxes = reading_config.get("figure", [])
    kept = [w for w in pdf_words if w["text"] not in BULLETS and not any(f["page"] == w["page"] and inside(w["box"], f["box"]) for f in boxes)]
    theirs = [w["text"] for w in kept]
    found, differences = compare(theirs, ours)
    if differences:
        lines = [f"  PDF has {d['gone']!r}, paper.md has {d['new']!r}  (near {d['pdf']!r})" for d in differences[:80]]
        raise ReadingError(f"paper.md differs from the PDF in {len(differences)} places:\n" + "\n".join(lines))

    spans, errors = locate(page, passages)
    if errors:
        raise ReadingError("\n".join(errors))
    ranges = section_ranges(page, done["outline"])
    mentions = names_in(page, names, ranges, link_config.get("name_sections"))
    marks = page_marks(words, found, [w["page"] for w in kept], reading_config.get("page_label", "{page}"), route)
    body = weave(page, spans, mentions, marks, done["math"], route)

    counts: dict[str, int] = {}
    for start, _stop in spans.values():
        place = section_at(ranges, start)
        if place:
            counts[place] = counts.get(place, 0) + 1
    offsets = dict(ranges)
    starts = [start for start, _stop in words]

    def page_of(entry: dict) -> int:
        """The PDF page a section starts on: its first word that lines up with the PDF."""
        for index in range(bisect_left(starts, offsets.get(entry["id"], 0)), len(words)):
            if index in found:
                return kept[found[index]]["page"]
        return 1

    outline = [{**entry, "ties": counts.get(entry["id"], 0), "page": page_of(entry)} for entry in done["outline"]]
    order = sorted(spans, key=lambda pid: spans[pid][0])
    code = {pid for pid, (start, _stop) in spans.items() if any(p.code and p.kind != "tag" and p.start <= start < p.start + len(p.text) for p in page.parts)}
    quotes = {p["id"]: p["quote"] for p in passages}
    paragraphs = {pid: paragraph(page, start, stop, quotes[pid]) for pid, (start, stop) in spans.items()}
    return {"html": body, "outline": outline, "words": len(ours), "formulas": len(done["math"]), "pages": len(marks), "order": order, "code": code,
            "paragraphs": paragraphs}


def inside(box: list[float], outer: list[float]) -> bool:
    x, y = (box[0] + box[2]) / 2, (box[1] + box[3]) / 2
    return outer[0] <= x <= outer[2] and outer[1] <= y <= outer[3]
