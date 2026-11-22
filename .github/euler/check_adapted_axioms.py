"""Check the axioms of every proved adapted statement: only propext, Classical.choice, Quot.sound.

Reads $OUT/axioms.txt (the "depends on axioms" lines of VerifyAdapted.lean) and
$ADAPTED/TARGETS.json, writes $OUT/axioms.json and exits nonzero on any missing or other axiom.
"""
import json
import os
import re
from pathlib import Path

out = Path(os.environ["OUT"])
targets = json.loads(Path(os.environ["ADAPTED"], "TARGETS.json").read_text())
proved = {t["lean_name"] for t in targets if t["status"] == "proved"}
found = {}
for line in (out / "axioms.txt").read_text().splitlines():
    m = re.match(r"'([^']+)' depends on axioms: \[(.*)\]", line)
    if m:
        found[m.group(1)] = [a.strip() for a in m.group(2).split(",") if a.strip()]
allowed = {"propext", "Classical.choice", "Quot.sound"}
bad = {n: a for n, a in found.items() if not set(a) <= allowed}
missing = sorted(proved - set(found))
report = {"proved_targets": len(proved), "axiom_lines": len(found), "missing": missing, "non_standard": bad,
          "axiom_sets": sorted({tuple(a) for a in found.values()})}
(out / "axioms.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))
if bad or missing:
    raise SystemExit("axiom check failed")
