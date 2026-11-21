"""Write Comparator's challenge, three controls and solution for the authors' final commit fd3a158.

Run in formalization/lean. Nothing from the authors is stored in this repository: the statement
file and the definition of the uniqueness statement are copied from their checkout on the runner.

The challenge states two theorems against the authors' own definitions:
- TorusEuler.theorem11 : TorusEuler.Theorem11, the existence form in Statement.lean;
- TorusEuler.Paper.theorem_1_1 : TorusEuler.Paper.Statement.theorem_1_1, Theorem 1.1 with the
  uniqueness of the maximal solution, whose definition (Paper/S678/Statements.lean) uses only
  Statement.lean's definitions.
Three controls change one thing each and must be rejected.
"""
import re
from pathlib import Path

statement = Path("TorusEuler/Statement.lean").read_text()
imports = [l for l in statement.splitlines() if l.startswith("import ")]
if not imports or any(not l.startswith("import Mathlib.") for l in imports):
    raise SystemExit("Statement.lean must import Mathlib only, so the challenge is independent of the proof")
if not statement.rstrip().endswith("end TorusEuler"):
    raise SystemExit("Statement.lean must close its namespace")

source = Path("TorusEuler/Paper/S678/Statements.lean").read_text()
found = re.search(r"^def Statement\.theorem_1_1 : Prop :=\n(?:  .*\n)+", source, re.M)
if not found:
    raise SystemExit("could not find the definition of Statement.theorem_1_1")
body = found.group(0)
for name in re.findall(r"\b([A-Z][A-Za-z]+)\b", body):
    if name not in {"Statement", "Prop", "Vec3", "Velocity", "Pressure", "EulerSingularityWitness",
                    "IsMaximalEulerSolution", "EqOn", "Ico", "T"}:
        raise SystemExit(f"the uniqueness statement uses {name}, which Statement.lean may not define")
paper = "\nopen Set\n\nnamespace TorusEuler.Paper\n\n" + body + "\nend TorusEuler.Paper\n"
existence = "\ntheorem TorusEuler.theorem11 : TorusEuler.Theorem11 := sorry\n"
uniqueness = "\ntheorem TorusEuler.Paper.theorem_1_1 : TorusEuler.Paper.Statement.theorem_1_1 := sorry\n"

Path("Challenge.lean").write_text(statement + paper + existence + uniqueness)
# Control 1: the existence theorem negated.
Path("ControlStatement.lean").write_text(
    statement + paper + "\ntheorem TorusEuler.theorem11 : ¬ TorusEuler.Theorem11 := sorry\n" + uniqueness)
# Control 2: the time-derivative limit removed from the definition both theorems unfold to.
old = "HasOffOriginLimits T u ∧ HasOffOriginLimits T (timeDerivative T u)"
if statement.count(old) != 1:
    raise SystemExit("Expected exactly one off-origin clause pair for the definition control")
Path("ControlDefinition.lean").write_text(statement.replace(old, "HasOffOriginLimits T u") + paper + existence + uniqueness)
# Control 3: uniqueness without the equal lifespan.
lifespan = "T' = T ∧ EqOn v u (Ico 0 T)"
if paper.count(lifespan) != 1:
    raise SystemExit("Expected exactly one lifespan clause for the uniqueness control")
Path("ControlUniqueness.lean").write_text(statement + paper.replace(lifespan, "EqOn v u (Ico 0 T)") + existence + uniqueness)
Path("Solution.lean").write_text("import TorusEuler\n")
with open("lakefile.toml", "a") as f:
    for name in ["Challenge", "ControlStatement", "ControlDefinition", "ControlUniqueness", "Solution"]:
        f.write(f'\n[[lean_lib]]\nname = "{name}"\n')
print("wrote the challenge, three controls and the solution")
