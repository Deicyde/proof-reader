#!/usr/bin/env python3
"""Record a run of euler-comparator-final.yml as papers/euler/comparator/.

    python3 papers/euler/tools/record_comparator.py RUN_ID JUDGE_ARTIFACT BUILD_ARTIFACT UPSTREAM

The run judged files written on the runner from the authors' checkout; nothing of theirs was
committed. This script writes the same files again from UPSTREAM (their repository at fd3a158)
with .github/euler/write_harness_final.py, stops unless each matches the SHA-256 the run
recorded, and writes the folder paper.py's [comparator] reads: Challenge.lean, Solution.lean,
comparator.json, the rejected controls under negative/, definition/ and uniqueness/, and
receipt.json with the run's verdicts.
"""
from __future__ import annotations

import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent
ROOT = HERE.parent.parent
CONTROLS = {
    "negative": ("ControlStatement", "control-statement", "TorusEuler.theorem11 negated"),
    "definition": ("ControlDefinition", "control-definition",
                   "the time-derivative limit HasOffOriginLimits T (timeDerivative T u) removed from EulerSingularityWitness"),
    "uniqueness": ("ControlUniqueness", "control-uniqueness",
                   "the equal lifespan T' = T removed from the uniqueness clause of Statement.theorem_1_1"),
}


def sha(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main() -> int:
    run_id, judge, build, upstream = sys.argv[1], Path(sys.argv[2]), Path(sys.argv[3]), Path(sys.argv[4])
    recorded = dict(reversed(line.split()) for line in (build / "source-inputs.sha256").read_text().splitlines())
    judgment = json.loads((judge / "judgment.json").read_text())
    if judgment["status"] != "accepted_unconditional_statement":
        raise SystemExit(f"run {run_id} did not record an accepted statement")
    with tempfile.TemporaryDirectory(prefix="euler-harness-") as scratch:
        work = Path(scratch)
        lean = upstream / "formalization/lean"
        (work / "TorusEuler/Paper/S678").mkdir(parents=True)
        shutil.copyfile(lean / "TorusEuler/Statement.lean", work / "TorusEuler/Statement.lean")
        shutil.copyfile(lean / "TorusEuler/Paper/S678/Statements.lean", work / "TorusEuler/Paper/S678/Statements.lean")
        shutil.copyfile(lean / "lakefile.toml", work / "lakefile.toml")
        subprocess.run([sys.executable, str(ROOT / ".github/euler/write_harness_final.py")], cwd=work, check=True)
        for name in ("Challenge.lean", "ControlStatement.lean", "ControlDefinition.lean", "ControlUniqueness.lean", "TorusEuler/Statement.lean"):
            if sha(work / name) != recorded[name]:
                raise SystemExit(f"{name} written here differs from the file run {run_id} judged")
        out = HERE / "comparator"
        if out.exists():
            shutil.rmtree(out)
        out.mkdir()
        shutil.copyfile(work / "Challenge.lean", out / "Challenge.lean")
        shutil.copyfile(work / "Solution.lean", out / "Solution.lean")
        shutil.copyfile(judge / "challenge.json", out / "comparator.json")
        hashes = {"Challenge.lean": sha(out / "Challenge.lean"), "Solution.lean": sha(out / "Solution.lean"),
                  "comparator.json": sha(out / "comparator.json")}
        controls = {}
        for folder, (module, stem, change) in CONTROLS.items():
            (out / folder).mkdir()
            shutil.copyfile(work / f"{module}.lean", out / folder / "Challenge.lean")
            shutil.copyfile(judge / f"{stem}.json", out / folder / "comparator.json")
            log = (judge / f"{stem}.log").read_text(errors="replace").splitlines()
            controls[folder] = {"config": f"{folder}/comparator.json", "change": change,
                                "exit": int((judge / f"{stem}.exit").read_text()),
                                "output": [l for l in log if l.startswith("error:")][:3]}
            for f in ("Challenge.lean", "comparator.json"):
                hashes[f"{folder}/{f}"] = sha(out / folder / f)
    log = (judge / "challenge.log").read_text(errors="replace").splitlines()
    accepted_lines = [l for l in log if "accepts the solution" in l or "Your solution is okay!" in l or l.startswith("Running ")]
    config = json.loads((out / "comparator.json").read_text())
    kernels = sorted(l[: -len(" accepts the solution")] for l in log if l.endswith(" accepts the solution"))
    receipt = {
        "schema": 1,
        "what": "Comparator judged the authors' proofs of Theorem 1.1, in its existence form and with uniqueness of the maximal solution, against a challenge file holding only the authors' definitions.",
        "run": f"https://github.com/wcook04/proof-reader/actions/runs/{run_id}",
        "date": "2026-11-21",
        "commit": judgment["authors_commit"],
        "lake": (judge / "judge-lean.txt").read_text().splitlines()[0],
        "toolchain": "leanprover/lean4:v4.34.0-rc2 (authors' package and exports); Comparator on Lean v4.36.0",
        "sandbox": (judge / "judge-lean.txt").read_text().splitlines()[-1],
        "mode": "Lean's default kernel and four external kernels (" + ", ".join(k for k in kernels if k != "Lean default kernel")
                + "); sandboxed with bubblewrap; --paranoid was not completed",
        "kernels": kernels,
        "permitted_axioms": config["permitted_axioms"],
        "accepted": {"config": "comparator.json", "theorem_names": config["theorem_names"], "exit": 0, "output": accepted_lines},
        "rejected_control": controls["negative"],
        "other_rejected_controls": {k: v for k, v in controls.items() if k != "negative"},
        "sha256": hashes,
        "authors_files_sha256": {k: v for k, v in recorded.items() if k in ("TorusEuler/Statement.lean", "lean-toolchain", "lake-manifest.json")},
        "limits": "Comparator establishes that the authors' compiled proofs prove exactly these two statements, using only the permitted axioms, against definitions copied unchanged from their Statement.lean and their statement of Theorem 1.1. It does not say that the definitions mean what the paper means; the comparisons on the page address that.",
        "imports": "Challenge.lean imports Mathlib only: the authors' Statement.lean followed by their definition of Statement.theorem_1_1.",
    }
    (out / "receipt.json").write_text(json.dumps(receipt, ensure_ascii=False, indent=1) + "\n")
    print(f"recorded run {run_id}: {', '.join(kernels)}; controls {', '.join(f'{k} exit {v['exit']}' for k, v in controls.items())}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
