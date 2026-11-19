"""Import one Physlib API map from the public tracker and build its reading copy."""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
from pathlib import Path
from urllib.request import urlopen

ROOT = Path(__file__).resolve().parents[1]
SLUG = "physlib-gauge-theory"
FOLDER = ROOT / "api-maps" / SLUG
PUBLIC = ROOT / "web" / "public" / "api-maps" / SLUG
PATH = "Physlib/ClassicalFieldTheory/GaugeTheory"
INDEX = (
    "https://raw.githubusercontent.com/Kernel-Science/physlib-website/"
    "1afd9e675f930e2d45adaea8edb4bd05b002b634/web2/data/APIMap.json"
)
RAW = "https://raw.githubusercontent.com"
REPO = "leanprover-community/physlib"


def download(url: str) -> bytes:
    with urlopen(url, timeout=30) as response:
        return response.read()


def refresh() -> None:
    index = json.loads(download(INDEX))
    if index["repo"] != REPO or not re.fullmatch(r"[a-f0-9]{40}", index["commit"]):
        raise ValueError("The tracker index must identify a fixed Physlib commit")
    node = next(node for node in index["nodes"] if node["path"] == PATH)
    paths = {node["file"], "LICENSE", *(g["file"] for g in node["leanReferences"])}
    if node["file"] != f"{PATH}/API-map.md" or any(".." in Path(path).parts or path.startswith("/") for path in paths):
        raise ValueError("Unexpected Physlib source paths")
    base = f"{RAW}/{REPO}/{index['commit']}"
    sources = {path: download(f"{base}/{path}") for path in sorted(paths)}
    for path, content in sources.items():
        target = FOLDER / ("API-map.md" if path == node["file"] else path if path == "LICENSE" else f"lean/{path}")
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(content)
    snapshot = {
        "repo": REPO, "commit": index["commit"], "index": INDEX, "path": PATH,
        "file": node["file"], "title": node["title"],
        "leanReferences": node["leanReferences"], "references": node["references"],
        "maps": maps_of(index),
    }
    (FOLDER / "index.json").write_text(json.dumps(snapshot, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def maps_of(index: dict) -> list[dict]:
    """Every API map in the tracker index, with its claim counts and the maps it cites."""
    return [{
        "path": n["path"], "title": n["title"],
        "done": sum(1 for r in n["requirements"] if r["done"]), "total": len(n["requirements"]),
        "cites": [p["path"] for p in n["parents"]],
    } for n in sorted(index["nodes"], key=lambda n: n["path"])]


def check_maps(snapshot: dict) -> None:
    maps = snapshot.get("maps") or []
    paths = {m["path"] for m in maps}
    if snapshot["path"] not in paths or len(paths) != len(maps):
        raise ValueError("The map list must name each API map once, including this one")
    for m in maps:
        if any(c not in paths for c in m["cites"]) or not 0 <= m["done"] <= m["total"]:
            raise ValueError(f"{m['path']} cites an unknown map or has impossible claim counts")


def check_phrases(phrases: dict, groups: list[dict]) -> list[dict]:
    """Each Lean citation's phrases: the map's own words that its declarations state.

    Proof Reader drafts these matches (phrases.json); the Markdown is unchanged. Every
    declaration needs a phrase, and every phrase names declarations of its own citation.
    The renderer then fails unless each phrase occurs exactly once in its citation's paragraph.
    """
    flat = []
    for group in groups:
        number = str(group["index"])
        own = {d["fullName"] for d in group["declarations"]}
        entries = phrases.get(number) or []
        named = {name for entry in entries for name in entry["names"]}
        if named != own:
            raise ValueError(f"Lean citation [{number}] phrases name {sorted(named ^ own)} differently from the index")
        for entry in entries:
            quote = entry["quote"]
            if not quote.strip() or quote != " ".join(quote.split()) or not entry["names"]:
                raise ValueError(f"Lean citation [{number}] has an empty, untrimmed or unnamed phrase")
            flat.append({"citation": int(number), "quote": quote, "names": entry["names"]})
    if set(phrases) != {str(group["index"]) for group in groups}:
        raise ValueError("phrases.json and the index list different Lean citations")
    return flat


def check_concepts(concepts: list[dict], groups: list[dict]) -> list[dict]:
    """The physics topic of each Lean citation (concepts.json); each topic has one colour."""
    listed = [n for concept in concepts for n in concept["citations"]]
    if sorted(listed) != sorted(group["index"] for group in groups):
        raise ValueError("concepts.json must place every Lean citation in exactly one topic")
    if any(not c["name"].strip() for c in concepts) or len({c["name"] for c in concepts}) != len(concepts):
        raise ValueError("Topic names must be distinct and nonempty")
    return concepts


def build() -> None:
    snapshot = json.loads((FOLDER / "index.json").read_text(encoding="utf-8"))
    check_maps(snapshot)
    groups = snapshot["leanReferences"]
    refs = snapshot["references"]
    source = FOLDER / "API-map.md"
    markdown = source.read_text(encoding="utf-8")
    prose, lean_heading, bibliography = markdown.partition("\n## Lean References\n")
    lean_list, ref_heading, ref_list = bibliography.partition("\n## References\n")
    listed = re.findall(r"^(\d+)\. (\S+\.lean) — (.+(?:\n +[^\n]+)*)", lean_list, re.M)
    expected = [(str(group["index"]), group["file"], [d["text"] for d in group["declarations"]]) for group in groups]
    actual = [(i, file, re.findall(r"`([^`]+)`", names)) for i, file, names in listed]
    if not lean_heading or not ref_heading or actual != expected:
        raise ValueError("The Markdown Lean references differ from the pinned tracker index")
    expected_refs = [(str(ref["index"]), ref["text"]) for ref in refs]
    actual_refs = [(i, " ".join(text.split())) for i, text in re.findall(r"^(\d+)\. (.+(?:\n +[^\n]+)*)", ref_list, re.M)]
    if expected_refs != actual_refs or set(re.findall(r"\[(\d+)\]", prose)) != {g[0] for g in expected} or set(re.findall(r"\{(\d+)\}", prose)) != {ref[0] for ref in expected_refs}:
        raise ValueError("The citations in the Markdown differ from the pinned tracker index")
    files = {file: (FOLDER / "lean" / file).read_text(encoding="utf-8") for file in sorted({g["file"] for g in groups})}
    glossary = json.loads((FOLDER / "glossary.json").read_text(encoding="utf-8"))
    names = {decl["fullName"] for group in groups for decl in group["declarations"]}
    if glossary.keys() != names:
        raise ValueError(f"Glossary and index name different declarations: {', '.join(sorted(glossary.keys() ^ names))}")
    notes = json.loads((FOLDER / "notes.json").read_text(encoding="utf-8"))
    if notes.keys() != names or any(not n.strip() or n != n.strip() for n in notes.values()):
        raise ValueError(f"notes.json needs one trimmed reading note per declaration: {', '.join(sorted(notes.keys() ^ names))}")
    if len(set(glossary.values())) != len(glossary) or any(not title.strip() or title != title.strip() for title in glossary.values()):
        raise ValueError("Glossary titles must be distinct, nonempty and trimmed")
    for group in groups:
        lines = files[group["file"]].splitlines()
        for decl in group["declarations"]:
            first = decl.get("line")
            name = decl["text"].split(".")[-1]
            if not first or not re.search(rf"\b{re.escape(name)}(?=\s|[:(\[{{]|$)", lines[first - 1]):
                raise ValueError(f"{decl['text']} was not found at its indexed source line")
    maths = json.loads((FOLDER / "maths.json").read_text(encoding="utf-8"))
    phrases = check_phrases(json.loads((FOLDER / "phrases.json").read_text(encoding="utf-8")), groups)
    here = next(m for m in snapshot["maps"] if m["path"] == snapshot["path"])
    rendered = subprocess.run(
        ["node", str(ROOT / "web" / "tools" / "render-paper.mjs"), str(source), SLUG, "lean", "--api-map"],
        input=json.dumps({"maths": maths, "references": refs, "phrases": phrases,
                          "notes": notes,
                          "concepts": check_concepts(json.loads((FOLDER / "concepts.json").read_text(encoding="utf-8")), groups),
                          "status": {"done": here["done"], "total": here["total"]}}, ensure_ascii=False),
        text=True, capture_output=True, check=False,
    )
    if rendered.returncode:
        raise ValueError(rendered.stderr.strip())
    page = json.loads(rendered.stdout)
    page.pop("math")
    PUBLIC.mkdir(parents=True, exist_ok=True)
    for name, data in (("edition.json", {**snapshot, **page, "glossary": glossary}), ("source.json", files)):
        (PUBLIC / name).write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")
    shutil.copyfile(source, PUBLIC / "API-map.md")
    shutil.copyfile(FOLDER / "LICENSE", PUBLIC / "LICENSE")
    shutil.copyfile(FOLDER / "phrases.json", PUBLIC / "phrases.json")
    print(f"built {SLUG} ({len(groups)} citation groups, {sum(len(g['declarations']) for g in groups)} Lean declarations, {len(phrases)} matched phrases)")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--refresh", action="store_true", help="retrieve the source files at the tracker's pinned revision")
    args = parser.parse_args()
    if args.refresh:
        refresh()
    build()
