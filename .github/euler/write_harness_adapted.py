"""Add the adapted statement layer to the authors' project and write Comparator's files for it.

Run in formalization/lean of the authors' checkout at fd3a158, with ADAPTED pointing at
papers/euler/adapted-lean of this repository.

The challenge states one theorem, Adapted.S1.theorem_1_1 (Theorem 1.1 in its global form:
existence, every blow-up property and uniqueness of the maximal solution), against the authors'
Statement.lean definitions only. Its statement is copied from Adapted/S1.lean. Two controls
change one thing each and must be rejected: the statement negated, and uniqueness without the
equal lifespan.
"""
import os
import re
import shutil
from pathlib import Path

adapted = Path(os.environ["ADAPTED"])
shutil.copytree(adapted / "Adapted", "Adapted")
for f in ("Adapted.lean", "VerifyAdapted.lean"):
    shutil.copyfile(adapted / f, f)

statement = Path("TorusEuler/Statement.lean").read_text()
imports = [l for l in statement.splitlines() if l.startswith("import ")]
if not imports or any(not l.startswith("import Mathlib.") for l in imports):
    raise SystemExit("Statement.lean must import Mathlib only, so the challenge is independent of the proof")

s1 = Path("Adapted/S1.lean").read_text()
found = re.search(r"^theorem theorem_1_1 :\n(.*?) := by\n", s1, re.S | re.M)
if not found:
    raise SystemExit("could not find Adapted.S1.theorem_1_1")
body = found.group(1)
allowed = {"Vec3", "Velocity", "Pressure", "ContDiff", "SpatiallyPeriodic", "Function", "Odd", "IsMaximalEulerSolution",
           "Ico", "T", "Tendsto", "HasOffOriginLimits", "C", "EqOn", "ENNReal", "ofReal"}
for name in re.findall(r"\b([A-Z][A-Za-z]+)\b", body):
    if name not in allowed:
        raise SystemExit(f"the adapted statement uses {name}, which may need more than Statement.lean")
head = ("\nopen Filter MeasureTheory Set TorusEuler\nopen scoped ContDiff ENNReal Topology\n\n"
        "namespace Adapted.S1\n\n")
tail = "\nend Adapted.S1\n"
challenge = statement + head + "theorem theorem_1_1 :\n" + body + " := sorry\n" + tail
Path("AdaptedChallenge.lean").write_text(challenge)
Path("AdaptedControlStatement.lean").write_text(
    statement + head + "theorem theorem_1_1 :\n    ¬ (" + body.strip() + ") := sorry\n" + tail)
lifespan = "T' = T ∧ EqOn v u (Ico 0 T)"
if challenge.count(lifespan) != 1:
    raise SystemExit("expected exactly one lifespan clause for the uniqueness control")
Path("AdaptedControlUniqueness.lean").write_text(challenge.replace(lifespan, "EqOn v u (Ico 0 T)"))
Path("AdaptedSolution.lean").write_text("import Adapted\n")
with open("lakefile.toml", "a") as f:
    f.write('\n[[lean_lib]]\nname = "Adapted"\nleanOptions = { autoImplicit = false, relaxedAutoImplicit = false }\n')
    for name in ["AdaptedChallenge", "AdaptedControlStatement", "AdaptedControlUniqueness", "AdaptedSolution"]:
        f.write(f'\n[[lean_lib]]\nname = "{name}"\n')
print("added the adapted layer and wrote the challenge, two controls and the solution")
