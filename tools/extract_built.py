#!/usr/bin/env python3
"""Write a paper's generated/lean.json from modules someone has already compiled.

`paper.py extract` builds the authors' whole project with lake. When only some modules
are needed, or the project is too large to build for one page, this reads the compiled
.olean files of a project built elsewhere instead, the way the Plectis maths site's
declaration-graph extractor does: the project's own toolchain and LEAN_PATH, nothing
written into the project.

Each module is used only if the compiled project's source of it is byte-identical to
the paper's copy under papers/<slug>/lean/, its .olean is newer than its source, and
the compiled project's git tree has no changes to tracked files.

A theorem whose proof is not built can still have its statement compiled: --statement
MODULE:NAME:FIRST:LAST takes those source lines of the paper's copy, turns
`theorem NAME (binders) :` and the final `:= by` into `def NAME (binders) : Prop :=`,
checks that nothing else changed, and compiles that definition against the modules.
Its row is marked "statement-compiled": Lean read the statement here, and the proof
was not built here, so it carries no axiom report.

    python3 tools/extract_built.py pcp-reading-guide --project /path/to/compiled/clone \\
        --statement PCP.Theorem:np_subset_pcp:25:33
"""
from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TEMPLATE = ROOT / "tools" / "extract_built.lean.template"
MARKER = "PROOF_READER_JSON:"


def lean_env(project: Path, binary: Path | None = None) -> tuple[str, dict[str, str]]:
    toolchain = (project / "lean-toolchain").read_text(encoding="utf-8").strip()
    folder = toolchain.replace("/", "--").replace(":", "---")
    lean = binary or Path.home() / ".elan" / "toolchains" / folder / "bin" / "lean"
    paths = [project / ".lake" / "build" / "lib" / "lean"]
    packages = project / ".lake" / "packages"
    if packages.is_dir():
        paths += sorted(p / ".lake" / "build" / "lib" / "lean" for p in packages.iterdir() if p.is_dir())
    env = {**os.environ, "LEAN_PATH": os.pathsep.join(str(p) for p in paths if p.is_dir())}
    return str(lean), env


def check_modules(project: Path, copy: Path, modules: list[str]) -> None:
    # A git checkout must have no changes to tracked files; any tree must hold, byte for
    # byte, the paper's copy of each module it compiled (checked below).
    if (project / ".git").exists() and subprocess.run(["git", "-C", str(project), "diff", "--quiet"]).returncode != 0:
        sys.exit(f"{project} has changes to tracked files: its .olean files may not be the authors' Lean")
    for m in modules:
        rel = m.replace(".", "/") + ".lean"
        src, ours = project / rel, copy / rel
        olean = project / ".lake" / "build" / "lib" / "lean" / (m.replace(".", "/") + ".olean")
        if src.read_bytes() != ours.read_bytes():
            sys.exit(f"{m}: the compiled project's source differs from the paper's copy")
        if not olean.is_file() or olean.stat().st_mtime < src.stat().st_mtime:
            sys.exit(f"{m}: no .olean newer than its source in {project}")


def surrogate(copy: Path, spec: str) -> tuple[str, dict]:
    module, name, first, last = spec.split(":")
    first, last = int(first), int(last)
    lines = (copy / (module.replace(".", "/") + ".lean")).read_text(encoding="utf-8").split("\n")
    original = lines[first - 1:last]
    head = re.compile(rf"^theorem {re.escape(name)}(\s.*?)\s:$")
    tail = re.compile(r"^(.*\S) := by$")
    if not head.match(original[0]) or not tail.match(original[-1]):
        sys.exit(f"{module}:{first}-{last} is not `theorem {name} ... :` through `... := by`")
    text = [head.sub(rf"def {name}\1 : Prop :=", original[0]), *original[1:-1], tail.sub(r"\1", original[-1])]
    # The only differences: the keyword, `: Prop :=` for the colon, and no `:= by`.
    back = [re.sub(rf"^def {re.escape(name)}(.*) : Prop :=$", rf"theorem {name}\1 :", text[0]), *text[1:-1], text[-1] + " := by"]
    if back != original:
        sys.exit("the statement surrogate changed more than the keyword and the proof delimiter")
    spaces = [l.split()[1] for l in lines[:first - 1] if l.startswith("namespace ")]
    opened = [l for l in lines[:first - 1] if l.startswith("open ")]
    body = "\n".join([*(f"namespace {s}" for s in spaces), *opened, *text, *(f"end {s}" for s in reversed(spaces))])
    full = ".".join([*spaces, name])
    return body, {"name": full, "module": module, "line": first, "end_line": last, "source": "\n".join(original)}


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("slug")
    ap.add_argument("--project", type=Path, required=True, help="a compiled Lake project at the authors' commit")
    ap.add_argument("--statement", action="append", default=[], help="MODULE:NAME:FIRST:LAST of a theorem to compile as a statement only")
    ap.add_argument("--lean", type=Path, help="the lean binary to run (default: the project's toolchain under ~/.elan)")
    args = ap.parse_args()
    folder = ROOT / "papers" / args.slug
    config = tomllib.loads((folder / "paper.toml").read_text(encoding="utf-8"))
    copy = folder / config["lean"].get("project", "lean")
    statement_modules = {s.split(":")[0] for s in args.statement}
    modules = [m for m in config["lean"]["modules"] if m not in statement_modules]
    project = args.project.resolve()
    check_modules(project, copy, modules)
    pieces = [surrogate(copy, s) for s in args.statement]
    roots = sorted({p[1]["name"].split(".")[0] for p in pieces})
    source = TEMPLATE.read_text(encoding="utf-8")
    source = source.replace("__IMPORTS__", "\n".join(f"import {m}" for m in modules))
    source = source.replace("__MODULES__", ", ".join(f"`{m}" for m in modules))
    source = source.replace("__ROOTS__", ", ".join(f"`{r}" for r in roots)).replace("__SURROGATE_ROOTS__", ", ".join(roots) or "nothing")
    source = source.replace("__SURROGATE__", "\n\n".join(p[0] for p in pieces))
    lean, env = lean_env(project, args.lean)
    with tempfile.TemporaryDirectory(prefix="proof-reader-built-") as scratch:
        driver = Path(scratch) / "ProofReaderBuiltDriver.lean"
        driver.write_text(source, encoding="utf-8")
        run = subprocess.run([lean, str(driver)], cwd=scratch, env=env, capture_output=True, text=True)
    lines = [line for line in run.stdout.splitlines() if line.startswith(MARKER)]
    if run.returncode != 0 or not lines:
        sys.exit(f"extraction failed:\n{run.stdout[-3000:]}\n{run.stderr[-3000:]}")
    report = json.loads(lines[-1][len(MARKER):])
    rows = []
    by_name = {p[1]["name"]: p[1] for p in pieces}
    for row in report["declarations"]:
        if row.pop("surrogate"):
            spec = by_name.get(row["name"])
            if not spec:
                continue
            # A statement: its binders are in the type, its conclusion in the value.
            row.update(kind="theorem", module=spec["module"], line=spec["line"], end_line=spec["end_line"],
                       type_dependencies=sorted(set(row["type_dependencies"]) | set(row["value_dependencies"])),
                       value_dependencies=[], axioms=[], provenance="statement-compiled",
                       type=spec["source"].rsplit(" := by", 1)[0])
        else:
            row["provenance"] = "lean"
        rows.append(row)
    out = {
        "lean_version": report["lean_version"],
        "modules": [*modules, *sorted(statement_modules)],
        "provenance": {"kind": "lean", "text": f"Read by Lean {report['lean_version']} from the authors' compiled modules."},
        "declarations": rows,
    }
    target = folder / "generated" / "lean.json"
    target.write_text(json.dumps(out, ensure_ascii=False, indent=1, sort_keys=True) + "\n", encoding="utf-8")
    print(f"wrote {target.relative_to(ROOT)}: {len(rows)} constants from {len(modules)} compiled modules"
          f" and {len(pieces)} compiled statement(s), on Lean {report['lean_version']}")


if __name__ == "__main__":
    main()
