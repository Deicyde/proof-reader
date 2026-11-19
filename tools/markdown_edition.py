"""Write a paper's reading copy as one Markdown file that reads well on GitHub.

    python3 tools/markdown_edition.py <slug>      writes papers/<slug>/README.md

The file is the paper's own Markdown with the Lean beside it. Under each paragraph
that links to Lean, a folded block opens the statements it is about, copied from the
compiled source with a link to their lines, and the page's comparison with the Lean.
A table at the top lists the statements and comparisons. Formulas are written as
plain Unicode text, as in Physlib's API maps, so that they copy as they read. Nothing is written that the
website does not already show: the words are the paper, plain titles, Lean source and
the comparisons in links.json. The source must be a Markdown paper.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import paper as tool  # noqa: E402
import plain_maths  # noqa: E402

SITE = "https://wcook04.github.io/proof-reader/#/{slug}"
REPO = "https://github.com/wcook04/proof-reader/blob/main/papers/{slug}/{path}#L{line}-L{end}"
VERDICT = {"same": "Same statement", "stronger": "Lean is stronger", "weaker": "Lean is weaker",
           "different": "Different statement"}


def blocks(text: str) -> list[str]:
    """Paragraphs as GitHub sees them: runs of lines between blank lines."""
    return re.split(r"\n[ \t]*\n", text.strip("\n"))


MATHS = re.compile(r"\$\$(.+?)\$\$|(?<![\\$])\$(.+?)(?<!\\)\$", re.S)


def plain_text(paragraph: str) -> str:
    """Write each formula as plain Unicode text, as Physlib's API maps do, so the
    maths reads the same in the file, on GitHub and when copied."""
    return MATHS.sub(lambda m: plain_maths.convert(m[1] or m[2]), paragraph)


def squash(text: str) -> str:
    return re.sub(r"\s+", " ", text).strip()


def excerpt(lines: list[str], first: int, last: int, keyword: str, whole: bool = False) -> tuple[str, int, int]:
    """A declaration's comment and statement, verbatim, up to where its proof starts."""
    at = tool.declaration_line(lines, first, last)
    end = tool.statement_end(lines, at, last, keyword)
    # A `let x :=` in the statement is not where the proof starts.
    while end < last and re.search(r"\blet\b", lines[end - 1]) and not re.search(r":=\s*(by)?\s*$", lines[end - 1]):
        end = tool.statement_end(lines, end + 1, last, keyword)
    top = first
    above = tool.comment_above(lines, at)
    if above and above[0] < top:
        top = above[0]
    return "\n".join(lines[top - 1:last if whole else end]), at, end


def details(entries: list[dict]) -> str:
    if len(entries) == 1:
        heading = f"{entries[0]['title']} · <code>{entries[0]['name']}</code>"
    else:
        heading = f"{len(entries)} statements: " + "; ".join(e["title"] for e in entries)
    label = "Lean proof" if all(e.get("proof") for e in entries) else "Lean"
    out = ["<details>", f"<summary><b>{label}</b> · {heading}</summary>", ""]
    for e in entries:
        if len(entries) > 1:
            out += [f"**{e['title']}** · `{e['name']}`", ""]
        out += ["```lean", e["code"], "```", "", e["where"], ""]
        if e.get("comparison"):
            out += [e["comparison"], ""]
    out.append("</details>")
    return "\n".join(out)


def build(slug: str) -> Path:
    resolved = tool.resolve(slug)
    folder, config, links = resolved["folder"], resolved["config"], resolved["links"]
    if resolved["source"]["kind"] != "markdown":
        raise tool.PaperError("a Markdown edition needs a Markdown paper")
    written, texts = resolved["shards"]["written"], resolved["shards"]["texts"]
    plain = links.get("plain", {})
    fidelity = links.get("fidelity", {})
    checks = {c["name"]: c for c in resolved["checks"]}
    lean = config["lean"]
    project = tool.lean_project(folder, config)

    def lean_entry(name: str, proof: bool = False) -> dict:
        row = written[name]
        lines = texts[row["module"]].splitlines()
        code, at, _ = excerpt(lines, row["line"], row["end_line"], row["keyword"], whole=proof)
        path = tool.module_file(project, row["module"]).relative_to(project).as_posix()
        url = lean["source_lines"].format(path=path, line=at, end=row["end_line"])
        span = f"[{Path(path).name}, lines {at}–{row['end_line']}][{name}] in {lean['source_name']}"
        where = (f"Copied whole from {span}." if proof
                 else f"Statement copied from {span}; the proof is at the link.")
        return {"name": name, "title": plain.get(name, name), "code": code, "where": where, "url": url,
                "proof": proof}

    def check_entry(name: str) -> dict:
        c = checks[name]
        url = REPO.format(slug=slug, path=c["file"], line=c["line"], end=c["end_line"])
        code = c["code"].split(":= by")[0].rstrip() + " := by"
        where = (f"Written for this page and accepted by Lean against the two files: "
                 f"[{c['file']}, lines {c['line']}–{c['end_line']}][{name}]. It is not in Physlib.")
        return {"name": name, "title": c["doc"].rstrip("."), "code": code, "where": where, "url": url}

    def comparison(name: str) -> str | None:
        f = fidelity.get(name)
        if not f:
            return None
        return f"**Comparison with the page: {VERDICT.get(f['verdict'], f['verdict']).lower()}.** {f['text']}"

    # Which paragraph carries each comparison and each written-for-the-page check.
    compare_at, checks_at = {}, {}
    for name, f in fidelity.items():
        because = f.get("because") or []
        if because:
            compare_at[name] = because[0]
            if f.get("checks"):
                checks_at.setdefault(because[-1], []).extend(f["checks"])

    source = (folder / config["paper"]["markdown"]).read_text(encoding="utf-8")
    body, _, refs = source.partition("\n[file]:") if "\n[file]:" in source else (source, "", "")
    paragraphs = blocks(body)
    attached: dict[int, list[dict]] = {}
    home: dict[str, str] = {}
    for p in links["passages"]:
        for name in p.get("lean", []):
            if p["role"] in ("states", "defines") and name not in home:
                home[name] = p["id"]
    for p in links["passages"]:
        for name in p.get("lean", []):
            home.setdefault(name, p["id"])
    shown: set[str] = set()
    for p in links["passages"]:
        quote = squash(p["quote"])
        hits = [i for i, b in enumerate(paragraphs) if quote in squash(b)]
        if len(hits) != 1:
            raise tool.PaperError(f"passage {p['id']}: found in {len(hits)} paragraphs, needs one")
        bucket = attached.setdefault(hits[0], [])
        for name in p.get("lean", []):
            if any(e["name"] == name for e in bucket):
                continue
            # Each statement once, where the page states it; a proof paragraph after
            # that statement shows the whole Lean proof.
            if p["role"] == "proves":
                if name not in shown:
                    continue
                bucket.append(lean_entry(name, proof=True))
                continue
            if home[name] != p["id"]:
                continue
            shown.add(name)
            entry = lean_entry(name)
            if compare_at.get(name) == p["id"]:
                entry["comparison"] = comparison(name)
            bucket.append(entry)
        for name in checks_at.get(p["id"], []):
            if not any(e["name"] == name for e in bucket):
                bucket.append(check_entry(name))

    # The table of statements, in reading order.
    rows, seen, urls = [], set(), {}
    for i in sorted(attached):
        for e in attached[i]:
            if e["name"] in seen or e.get("proof"):
                continue
            seen.add(e["name"])
            f = fidelity.get(e["name"])
            urls[e["name"]] = e["url"]
            if e["name"] in checks:
                verdict = "Written for this page; not in Physlib"
            elif f:
                verdict = VERDICT.get(f["verdict"], f["verdict"])
            else:
                continue
            rows.append(f"| {e['title']} | [`{e['name']}`][{e['name']}] | {verdict} |")

    title_end = next(i for i, b in enumerate(paragraphs) if b.startswith("## Introduction"))
    head, rest = paragraphs[:title_end], range(title_end, len(paragraphs))
    out = ["<!-- Written by tools/markdown_edition.py from paper.md, links.json and the Lean. "
           "Edit those, then run it again. -->", ""]
    out += ["\n\n".join(head), ""]
    out += [f"[Read it with the Lean beside it]({SITE.format(slug=slug)}) · "
            f"[Lean source]({lean['source']}) · "
            "Each ▸ **Lean** under a paragraph opens the statements that paragraph is about.", ""]
    out += ["| Statement on this page | Lean | Comparison with the page |", "| --- | --- | --- |", *rows, ""]
    for i in rest:
        out += [plain_text(paragraphs[i]), ""]
        if attached.get(i):
            out += [details(attached[i]), ""]
    if refs:
        out += ["[file]:" + refs.rstrip("\n")]
    out += [f"[{name}]: {url}" for name, url in urls.items()] + [""]
    target = folder / "README.md"
    target.write_text("\n".join(out), encoding="utf-8")
    return target


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("slug")
    args = parser.parse_args()
    try:
        print(build(args.slug))
    except (tool.PaperError, tool.reading_copy.ReadingError) as error:
        print(error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
