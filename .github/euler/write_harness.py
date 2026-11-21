"""Write Comparator challenge, controls and solution modules from the authors' pinned Statement.lean.

Run in formalization/lean. Nothing from the authors is stored in this repository."""
from pathlib import Path
statement = Path("TorusEuler/Statement.lean").read_text()
imports = [l for l in statement.splitlines() if l.startswith("import ")]
if not imports or any(not l.startswith("import Mathlib.") for l in imports):
    raise SystemExit("Statement.lean must import Mathlib only, so the challenge is independent of the proof")
claim = "\ntheorem TorusEuler.theorem11 : TorusEuler.Theorem11 := sorry\n"
# Positive challenge: the authors' definitions verbatim, the theorem restated with sorry.
Path("Challenge.lean").write_text(statement + claim)
# Control 1: same name, changed conclusion (the negation).
Path("ControlStatement.lean").write_text(
    statement + "\ntheorem TorusEuler.theorem11 : ¬ TorusEuler.Theorem11 := sorry\n")
# Control 2: same theorem text, one conclusion removed from a definition it unfolds to.
old = "HasOffOriginLimits T u ∧ HasOffOriginLimits T (timeDerivative T u)"
if statement.count(old) != 1:
    raise SystemExit("Expected exactly one off-origin clause pair for the definition control")
Path("ControlDefinition.lean").write_text(statement.replace(old, "HasOffOriginLimits T u") + claim)
Path("Solution.lean").write_text("import TorusEuler\n")
with open("lakefile.toml", "a") as f:
    for name in ["Challenge", "ControlStatement", "ControlDefinition", "Solution"]:
        f.write(f'\n[[lean_lib]]\nname = "{name}"\n')
