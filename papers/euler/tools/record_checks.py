#!/usr/bin/env python3
"""Write papers/euler/generated/checks.json from a run of euler-checks.yml.

    python3 papers/euler/tools/record_checks.py RUN_ID ARTIFACT_FOLDER

`paper.py extract` compiles a paper's checks itself, which needs the authors' package built
on this machine. The Euler package takes hours to build, so the checks are compiled on
GitHub Actions instead (.github/workflows/euler-checks.yml) and this script records that
run's result in the same format: each theorem with its lines, docstring and the axioms Lean
printed for it, and the hash of each check file the run compiled.
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(HERE.parent.parent / "tools"))
import paper  # noqa: E402


def qualified(text: str) -> dict[str, str]:
    """Each top-level declaration's bare name mapped to its name inside its namespaces."""
    stack, names = [], {}
    for line in text.splitlines():
        if m := re.match(r"^namespace\s+(\S+)", line):
            stack.append(m.group(1))
        elif re.match(r"^end\s+\S+", line) and stack:
            stack.pop()
        elif m := paper.WRITTEN.match(line):
            if not line[:1].isspace():
                names[m.group(2)] = ".".join(stack + [m.group(2)])
    return names


def main() -> int:
    run_id, folder = sys.argv[1], Path(sys.argv[2])
    report: dict = {"files": {}, "checks": [],
                    "compiled_by": f"https://github.com/wcook04/proof-reader/actions/runs/{run_id}"}
    for path in sorted((HERE / "checks").glob("*.lean")):
        stem = path.stem
        if (folder / f"{stem}.exit").read_text().strip() != "0":
            raise SystemExit(f"{stem} did not compile in run {run_id}")
        output = (folder / f"{stem}.log").read_text(encoding="utf-8")
        axioms = paper.parse_axioms(output)
        text = path.read_text(encoding="utf-8")
        full = qualified(text)
        for item in paper.check_declarations(text):
            name = full.get(item["name"], item["name"])
            if name not in axioms:
                continue  # a def that the run did not print axioms for
            if "sorryAx" in axioms[name]:
                raise SystemExit(f"{name} uses sorry")
            report["checks"].append({**item, "name": name, "file": f"checks/{path.name}",
                                     "axioms": axioms[name], "status": "checked"})
        report["files"][f"checks/{path.name}"] = hashlib.sha256(path.read_bytes()).hexdigest()
    out = HERE / "generated" / "checks.json"
    out.write_text(json.dumps(report, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    print(f"wrote {out.relative_to(HERE.parent.parent)}: {len(report['checks'])} checks")
    return 0


if __name__ == "__main__":
    sys.exit(main())
