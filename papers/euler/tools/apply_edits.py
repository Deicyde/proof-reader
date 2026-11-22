"""Apply every confirmed-with-edit verdict of round six directly to links.json (idempotent)."""
import glob
import json
import sys
from pathlib import Path

links_path, r6 = Path(sys.argv[1]), Path(sys.argv[2])
L = json.loads(links_path.read_text())
P = {p["id"]: p for p in L["passages"]}
findings = {k: json.loads((r6 / f"return_{k}/return_euler_r6_{k}/findings.json").read_text()) for k in "AB"}
done = 0
for f in sorted(glob.glob(str(r6 / "verdicts_*.json"))):
    for v in json.loads(Path(f).read_text()):
        if v["decision"] != "confirmed-with-edit":
            continue
        card = findings[v["ref"][0]][int(v["ref"][1:])]["card"]
        kind, _, key = card.partition(":")
        field, text, lean = (v.get("fixed_field") or ""), v["fixed_text"].strip(), v.get("fixed_lean")
        if kind == "tie":
            rows = P[key]["comparisons"]
            targets = [c for c in rows if c["lean"] == lean] or (rows if len(rows) == 1 else [])
            if not targets:
                raise SystemExit(f"{v['ref']}: no comparison for {lean} on {key}")
            for c in targets:
                if field.endswith("fidelity") or text in ("same", "stronger", "weaker", "different"):
                    c["fidelity"] = text
                else:
                    c["note"] = text
        elif kind == "declaration":
            note = L["notes"].setdefault(key, {"on": "lean", "because": []})
            if field.endswith("title"):
                L["plain"][key] = text
            elif field.endswith("summary"):
                note["summary"] = text
            else:
                note["text"] = text
        else:
            entry = L["fidelity"][key]
            if field.endswith("verdict") or text in ("same", "stronger", "weaker", "different"):
                entry["verdict"] = text
            else:
                entry["text"] = text
        done += 1
links_path.write_text(json.dumps(L, ensure_ascii=False, indent=1) + "\n")
print("applied", done, "confirmed-with-edit fixes")
