#!/usr/bin/env python3
"""Write the page's links.json from the matcher's runs and the authors' own citations.

A passage of the 2.7 PDF is linked to a declaration when a run found the link, or when
the authors cite exactly that passage (a grammar rule, or a paragraph under a cited
run-in heading). Whole-section citations are scored but not drawn: one citation of §3.6
would mark thirty paragraphs. Each link says which runs found it and whether the authors
cite this passage for the declaration, another passage, or none. Older releases are
scored but cannot be drawn on the 2.7 PDF.

    python3 build_links.py RUNS_DIR
RUNS_DIR holds declarations_to_passages.json and passages_to_declarations.json.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
PAPER = HERE.parent
NARROW = 4  # a cited heading region this small is drawn as links; larger regions are not

RUN_LABELS = {
    "code_only_declarations": "GPT-6.1 reading each declaration's code with every comment removed",
    "code_only_passages": "GPT-6.1 reading each passage of the standard against that code",
}
# Only the declaration that states a passage's rule is drawn on the page. A run's "uses"
# links (a declaration that depends on the rule) are scored but would bury the answer.
ROLE = {"defines": "defines"}


def is_rule_text(p: dict) -> bool:
    """A grammar rule or a sentence of prose; not an example list the split took for prose."""
    if p["kind"] == "production":
        return True
    return p["kind"] == "prose" and not p["text"].lstrip().startswith((":", "(", "#", "|", '"')) and "." in p["text"]


def primary_order(name: str) -> tuple:
    """The declaration that states a rule first: the syntax predicate, then validity, then the type."""
    last = name.rsplit(".", 1)[-1]
    return (0 if ".Syntax.Is" in name else 1 if last == "Valid" else 3 if last in ("tokens", "token") else 2, name)


def real(name: str) -> str:
    return name.replace("Spec.", "BSmtLibSpec.", 1) if name.startswith("Spec.") else name


def main() -> int:
    runs = Path(sys.argv[1])
    passages = {p["id"]: p for p in json.loads((HERE / "inventory" / "passages.json").read_text(encoding="utf-8"))}
    groups = json.loads((HERE / "reference" / "author_groups.json").read_text(encoding="utf-8"))["declarations"]
    titles = json.loads((HERE / "plain_titles.json").read_text(encoding="utf-8"))

    links: dict[str, dict[str, dict]] = {}  # passage -> declaration -> {found_by, role}

    def add(pid: str, decl: str, run: str | None, role: str) -> None:
        p = passages.get(pid)
        if not p or p["version"] != "2.7" or p["anchor"]["status"] == "unanchored" or not is_rule_text(p):
            return
        entry = links.setdefault(pid, {}).setdefault(decl, {"found_by": [], "role": role})
        if run and RUN_LABELS[run] not in entry["found_by"]:
            entry["found_by"].append(RUN_LABELS[run])
        if role == "defines":
            entry["role"] = "defines"

    for rec in json.loads((runs / "declarations_to_passages.json").read_text()):
        for m in rec.get("matches") or []:
            if m.get("relation") in ROLE:
                add(m["passage"], real(rec["id"]), "code_only_declarations", ROLE[m["relation"]])
    for rec in json.loads((runs / "passages_to_declarations.json").read_text()):
        for t in rec.get("targets") or []:
            if t.get("relation") in ROLE:
                add(rec["passage"], real(t["id"]), "code_only_passages", ROLE[t["relation"]])
    for decl, entry in groups.items():
        for g in entry["groups"]:
            if g["kind"] == "rule":
                for pid in g["ids"]:
                    add(pid, decl, None, "defines")
            elif len(g["ids"]) <= NARROW:
                # A cited run-in heading: its opening paragraph states the rule.
                opener = next((q for q in g["ids"] if (passages[q]["text"] or "").startswith((passages[q]["heading"] or "\0") + ".")), None)
                if opener:
                    add(opener, decl, None, "defines")

    out_passages = []
    for pid, decls in sorted(links.items(), key=lambda kv: (passages[kv[0]]["page"], kv[0])):
        p = passages[pid]
        match = {}
        for decl, entry in decls.items():
            cited = groups.get(decl)
            authors, releases = ("uncited", [])
            if cited and pid in cited["acceptable"]:
                authors = "cites"
            elif cited:
                # The same rule, or the same run-in heading, as another release prints it.
                same = sorted({passages[q]["version"] for q in cited["acceptable"]
                               if passages[q]["version"] != "2.7" and (
                                   (p["production"] and passages[q]["production"] == p["production"]) or
                                   (p["heading"] and p["part"] == "3" and passages[q]["heading"] == p["heading"]))})
                authors, releases = ("other_release", same) if same else ("elsewhere", [])
            match[decl] = {"found_by": entry["found_by"], "authors": authors, **({"releases": releases} if releases else {})}
        role = "defines" if any(e["role"] == "defines" for e in decls.values()) else "uses"
        out_passages.append({
            "id": pid.replace(".", "-"), "section": p["section"] if p["part"] != "B" else "Appendix B",
            "role": role, "page": p["page"], "quote": p["anchor"]["quote"],
            "lean": sorted(decls, key=primary_order), "match": match,
            **({"title": p["heading"]} if p["heading"] else {}),
        })
    links_json = {"schema": 1, "claims": [], "passages": out_passages, "plain": titles, "notes": {}}
    (PAPER / "links.json").write_text(json.dumps(links_json, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    found = sum(1 for p in out_passages for m in p["match"].values() if m["found_by"])
    only_authors = sum(1 for p in out_passages for m in p["match"].values() if not m["found_by"])
    print(f"{len(out_passages)} passages linked; {found} links found by a run, {only_authors} only cited by the authors")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
