#!/usr/bin/env python3
"""Write papers/euler/links.json from the reviewed returns and the reading copy.

    python3 papers/euler/tools/build_links.py R2_RETURNS R3_RETURNS SHORT_TITLES_DIR

R2_RETURNS and R3_RETURNS are the unzipped review returns of rounds two and three (kept
privately, outside this repository). SHORT_TITLES_DIR holds the card titles of at most 40
characters (out_*.json). The inputs combine in this order, the merge rule of the round
three intake:

- passages: every phrase tie of the consolidated return (c8), placed in paper.md by
  tools/reading_copy.py (generated/reading-ties.json);
- claims: the 42 numbered results of the authors' own coverage map, each tied to its
  statement passage and its spine theorem, with the comparison of the paper's statement
  and the Lean (round two f7, as c8 recorded it);
- notes: one reading note on the Lean for every declaration (c1 to c7, keyed by file and
  name, with c8's reconciled text where it has one); each carries its long title;
- plain: the card titles.

Declarations are matched to Lean's own names in generated/lean.json, including private
helpers, which Lean names `_private.<module>.0.<name>`.
"""
from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
ROOT = HERE.parent.parent
ROLE = {"statement": "states", "definition": "defines", "explanation": "explains",
        "derivation": "proves", "example": "explains", "mention": "mentions"}
KINDS = ("Theorem", "Proposition", "Lemma", "Corollary", "Remark")


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def lean_names() -> tuple[dict, dict]:
    """Lean's name for each (file, written name), and each name's file."""
    sys.path.insert(0, str(ROOT / "tools"))
    import paper  # noqa: E402
    rows = paper.read_lean_report(HERE)["declarations"]
    by_written, file_of = {}, {}
    for row in rows:
        name, module = row["name"], row["module"]
        path = module.replace(".", "/") + ".lean"
        file_of[name] = path
        written = name
        m = re.match(rf"_private\.{re.escape(module)}\.\d+\.(.+)$", name)
        if m:
            written = m.group(1)
        by_written.setdefault((path, written), name)
        by_written.setdefault(("", written), name)
    return by_written, file_of


def source_blocks() -> list[dict]:
    done = subprocess.run(["node", str(ROOT / "web/tools/render-paper.mjs"), str(HERE / "paper.md"), "euler", "lean",
                           "--markdown-source"], input=json.dumps({"passages": []}), capture_output=True,
                          text=True, cwd=ROOT / "web")
    if done.returncode:
        raise SystemExit(done.stderr[-2000:])
    return json.loads(done.stdout)["source_blocks"]


# Instances Lean names itself (inst<Class><Type>) carry no review title. The title says
# which structure the instance gives to which type.
INSTANCE_CLASSES = [("HasOrthogonalProjection", "Projection onto {}"),
                    ("NormedAddCommGroup", "Normed group of {}"), ("NormedGroup", "Normed group of {}"),
                    ("NormedSpace", "Normed space of {}"), ("IsProbabilityMeasure", "Probability measure on {}"),
                    ("IsAddHaarMeasure", "Haar measure on {}"), ("MeasureSpace", "Measure space on {}")]
INSTANCE_TYPES = [("Solenoidal", "divergence-free fields"), ("BoundedSpatialJet", "bounded spatial jets"),
                  ("SpatialJetTuple", "spatial jet tuples"), ("TimeHolder", "time-Hölder fields"),
                  ("HalfHolder", "Hölder-½ fields"), ("Torus", "the torus"), ("Circle", "the circle")]


def instance_title(tail: str) -> str | None:
    cls = next((t for key, t in INSTANCE_CLASSES if key in tail), None)
    typ = next((t for key, t in INSTANCE_TYPES if key in tail), None)
    return cls.format(typ) if cls and typ else None


# The reviewed return names 14 topics; the page's colour key takes nine, named by the paper's
# own section titles. Each reviewed topic folds into one of them. A version that keeps the 14
# topics in seven families waits in the private Euler annex until the reviewed returns are restored.
TOPICS = {
    "singularity": ("The singular Euler solution",
                    "The smooth odd periodic initial data, the maximal Euler solution and the conclusions of Theorem 1.1."),
    "wave": ("The wave and its amplification",
             "The Craik–Criminale wave over a linear background, its preceding frame, the strong shear limit, the couplings and the crossing of Section 2."),
    "localized-wave": ("Localized waves over a smooth parent",
                       "The transported phase, the localized amplitude, the narrow periodic profile and its curl completion in Section 3."),
    "endpoint": ("Selecting initial data by the endpoint problem",
                 "The displacement with two end conditions, coercivity and the Hölder inverse of Section 4 and Appendix A."),
    "approximate": ("From a localized wave to an approximate solution",
                    "The truncated parent and its coefficients, the estimates for the mean, pressure and flow, and the approximate Euler solution of Section 5."),
    "hierarchy": ("The finite expansion",
                  "The transverse equation, the leading oscillation and the finite hierarchy of profiles with their bounds at every order."),
    "induction": ("The initial wave and the common sequence",
                  "The first wave over a stationary shear, the choice of the next wave and the common sequence of approximate solutions in Sections 6 and 7."),
    "terminal": ("The limit and its terminal behavior",
                 "Convergence before the accumulation time, the central vorticity and the maximal time, and smooth terminal regularity away from the origin in Section 8 and the auxiliary note."),
    "supporting": ("The frequency cutoff and finite norms",
                   "The Fourier cutoff, the parameter inequalities and the finite norms and coefficient estimates of Appendices B to D."),
}
FOLD = {"singularity": "singularity", "affine-wave": "wave", "amplification": "wave", "localized-wave": "localized-wave",
        "endpoint-inverse": "endpoint", "parent-step": "approximate", "mean-estimates": "approximate",
        "approximate": "approximate", "pressure-flow": "approximate", "hierarchy": "hierarchy",
        "induction": "induction", "terminal": "terminal", "auxiliary-smoothness": "terminal",
        "supporting-estimates": "supporting"}
RANK = {"same": 0, "stronger": 1, "weaker": 2, "different": 3}


def balanced(quote: str) -> bool:
    """A quotation holds whole formulas: an even number of unescaped $ signs."""
    return len(re.findall(r"(?<!\\)\$", quote)) % 2 == 0


def section_of(heading: str) -> str:
    m = re.match(r"(?:Appendix\s+)?([A-Z]|\d+(?:\.\d+)*)\.?\s", heading)
    if heading.startswith("Note "):
        return "Auxiliary note " + heading.split()[1]
    if heading.startswith("Auxiliary note"):
        return "Auxiliary note"
    return m.group(1) if m else heading


def main() -> int:
    r2, r3, short_dir = (Path(a) for a in sys.argv[1:4])
    c8 = r3 / "return_euler_r3_c8/return_euler_r3_c8"
    text = (HERE / "paper.md").read_text(encoding="utf-8")
    carried = load(HERE / "generated/reading-ties.json")["ties"]
    blocks = source_blocks()
    offsets = [0]
    for line in text.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    by_written, file_of = lean_names()
    sys.path.insert(0, str(ROOT / "tools"))
    import paper  # noqa: E402
    folder, config = paper.load_paper("euler")
    shard_info = paper.shards(folder, config)[0]
    lean_written = set(shard_info["written"])
    checks = {c["name"] for c in load(HERE / "generated/checks.json")["checks"]}
    report = {"widened": 0, "dropped_names": [], "no_block": []}

    def resolve(name: str, file: str = "") -> str | None:
        file = file.removeprefix("lean/")
        return by_written.get((file, name)) or by_written.get(("", name))

    # ------------------------------------------------------------ passages
    passages = []
    ties = load(c8 / "ties.json")["ties"]
    for tie in ties:
        where = carried[tie["id"]]
        start, stop = where["start"], where["stop"]
        line = next(i for i in range(len(offsets) - 1) if offsets[i] <= start < offsets[i + 1]) + 1
        block = next((b for b in blocks if b["line"] <= line <= b["end_line"]), None)
        if block is None:
            report["no_block"].append(tie["id"])
            continue
        block_stop = offsets[block["end_line"]]
        block_start = offsets[block["line"] - 1]
        # A quotation must occur once in the whole paper; widen a short one inside its block.
        def repeated() -> bool:
            # Once typeset, $x$ and $$x$$ read the same, so compare without the $ signs too.
            within = text[block_start:block_stop].replace("$", "")
            return text.count(text[start:stop]) > 1 or within.count(text[start:stop].replace("$", "")) > 1

        while repeated():
            # Widen by whole words, and never to a space inside a formula.
            nxt = stop
            while True:
                nxt = text.find(" ", nxt + 1)
                if nxt < 0 or nxt > block_stop or balanced(text[start:nxt]):
                    break
            if 0 < nxt <= block_stop:
                stop = nxt
            elif start > block_start:
                back = start
                while True:
                    back = text.rfind(" ", block_start, back - 1)
                    if back < 0 or balanced(text[back + 1:stop]):
                        break
                start = max(block_start, back + 1)
            else:
                break
            report["widened"] += 1
        names, lines, used_checks = [], None, []
        for row in tie["lean"]:
            if row["file"].startswith("checks/"):
                if row["name"] in checks:
                    used_checks.append(row["name"])
                continue
            name = resolve(row["name"], row["file"])
            if not name or name not in lean_written:
                report["dropped_names"].append(row["name"])
                continue
            if name not in names:
                names.append(name)
                if len(names) == 1 and row.get("lines"):
                    lines = row["lines"]
        item = {"id": tie["id"], "section": section_of(block["heading"]), "role": ROLE[tie["role"]],
                "quote": text[start:stop], "lean": names, "anchor": {"heading": block["heading"], "block": block["block"]},
                "topic": FOLD[tie["topic"]]}
        # One comparison per declaration: where the review compared two rows of the tie with
        # the same declaration, the one that differs more from the words is kept.
        compared: dict[str, dict] = {}
        for row in tie["lean"]:
            name = resolve(row["name"], row["file"]) if not row["file"].startswith("checks/") else None
            if name not in names:
                continue
            entry = {"lean": name, "fidelity": row["fidelity"], "note": str(row.get("fidelity_note", "")).strip()}
            held = compared.get(name)
            if not held or RANK[entry["fidelity"]] > RANK[held["fidelity"]]:
                compared[name] = entry
        if compared:
            item["comparisons"] = [compared[n] for n in names if n in compared]
        if lines:
            item["lines"] = lines
        if used_checks:
            item["checks"] = used_checks
            item["title"] = "Our check beside the authors' Lean"
        if names or used_checks:
            passages.append(item)
    ids = {p["id"] for p in passages}

    # ------------------------------------------------------------ claims and comparisons
    coverage = load(c8 / "result_coverage.json")["results"]
    context = {r["result"]: r for r in load(c8 / "result_fidelity_context.json")["results"]}
    claims, fidelity = [], {}
    for row in coverage:
        result = row["result"]
        spine = resolve(row["spine_theorem"])
        statement_ties = [t for t in row["statement_ties"] if t in ids] or [t for t in row["spine_ties"] if t in ids]
        if not spine or not statement_ties:
            raise SystemExit(f"result {result}: spine {row['spine_theorem']} or its passages are missing")
        m = re.search(rf"\*\*({'|'.join(KINDS)}) {re.escape(result)}( \([^*]*\))?\.\*\*", text)
        title = f"{m.group(1)} {result}" + (m.group(2) or "") if m else f"Display ({result})" if not result[0].isalpha() or "." in result else result
        claims.append({"id": f"result-{result}", "title": title, "section": result.split(".")[0],
                       "passage": statement_ties[0], "lean": [spine]})
        ctx = context[result]
        fidelity[spine] = {"verdict": ctx["verdict"], "text": ctx["note"], "because": statement_ties}

    # ------------------------------------------------------------ titles and notes
    short = {}
    for path in sorted(short_dir.glob("out_*.json")):
        short.update(load(path))
    long_title, note_text, note_file = {}, {}, {}
    for k in range(1, 8):
        folder = r3 / f"return_euler_r3_c{k}/return_euler_r3_c{k}"
        occ = folder / "lean_annotation_occurrences.json"
        rows = load(occ)["declarations"] if occ.exists() else [
            {**v, "name": n} for n, v in load(folder / "lean_annotations.json")["declarations"].items()]
        private = folder / "private_occurrences.json"
        if private.exists():
            rows += load(private)["declarations"]
        for row in rows:
            name = resolve(row["name"], row.get("file", ""))
            if name:
                long_title.setdefault(name, row["title"].strip())
                note_text.setdefault(name, row["note"].strip())
    c8_titles, c8_notes = load(c8 / "titles.json"), load(c8 / "notes.json")
    for written, title in c8_titles.items():
        name = resolve(written)
        if name:
            long_title[name] = title.strip()
            if written in c8_notes:
                note_text[name] = c8_notes[written].strip()
    linked: dict[str, list[str]] = {}
    for p in passages:
        for n in p["lean"]:
            linked.setdefault(n, []).append(p["id"])
    plain, notes = {}, {}
    written_of = {}
    for (path, w), n in by_written.items():
        if path:
            written_of.setdefault(n, w)
    for name, title in long_title.items():
        if name not in lean_written:
            continue
        w = written_of.get(name, name)
        # A private helper repeated in two files shares its sibling's card title when its own
        # long title has no short form.
        card = title if len(title) <= 40 else short.get(w) or short.get(name) or next(
            (t for t in (long_title.get(o) for o, ow in written_of.items() if ow == w and o != name) if t and len(t) <= 40), None)
        if card:
            plain[name] = card
        if name in note_text:
            entry = {"text": note_text[name], "on": "lean", "because": linked.get(name, [])}
            if card != title:
                entry["summary"] = title
            notes[name] = entry

    # Instances Lean names itself carry no review title. Each one here gives the normed group
    # or normed space structure on a type of divergence-free fields, or an orthogonal
    # projection onto one, and is titled by that structure; any other declaration left
    # without a title stops the build.
    roots = [n for p in passages for n in p["lean"]] + [n for c in claims for n in c["lean"]] + sorted(notes)
    untitled = []
    for name in sorted(paper.reachable(roots, shard_info["uses"]) - set(plain)):
        row = shard_info["written"][name]
        title = instance_title(name.rsplit(".", 1)[-1]) if row["keyword"] == "instance" else None
        if title:
            plain[name] = title
        else:
            untitled.append(f"{row['keyword']} {name}")
    if untitled:
        raise SystemExit("no title for:\n" + "\n".join(untitled))
    first_seen = list(dict.fromkeys(p["topic"] for p in passages))
    topics = [{"id": t, "name": TOPICS[t][0], "description": TOPICS[t][1]} for t in first_seen]
    links = {"schema": 1, "topics": topics, "claims": claims, "passages": passages, "plain": dict(sorted(plain.items())),
             "notes": dict(sorted(notes.items())), "fidelity": dict(sorted(fidelity.items())),
             # Every declaration with a reading note is on the page, linked from the paper or not.
             "show_also": sorted(n for n in notes if n not in linked)}
    (HERE / "links.json").write_text(json.dumps(links, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    print(f"links.json: {len(claims)} claims, {len(passages)} passages, {len(plain)} plain titles, "
          f"{len(notes)} notes, {len(fidelity)} comparisons; widened {report['widened']} steps, "
          f"{len(set(report['dropped_names']))} Lean names not in lean.json, {len(report['no_block'])} ties outside a block")
    if report["dropped_names"]:
        print("  not in lean.json:", sorted(set(report["dropped_names"]))[:15])
    return 0


if __name__ == "__main__":
    sys.exit(main())
