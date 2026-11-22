"""Apply the packet-talk rewrites where the current text still equals the text they were made from."""
import json
import sys
from pathlib import Path

euler, r6 = Path(sys.argv[1]), Path(sys.argv[2])
before = json.loads((r6 / "packet_talk.json").read_text())
after = json.loads((r6 / "packet_talk_fixed.json").read_text())
L = json.loads((euler / "links.json").read_text())
P = {p["id"]: p for p in L["passages"]}
notes = {k: json.loads((euler / "notes" / k).read_text()) for k in ("glossary.json", "section-aids.json", "showcase.json")}
applied, unchanged, conflicts = 0, 0, []
for old, new in zip(before, after):
    if old["text"] == new["text"]:
        unchanged += 1
        continue
    w = old["where"]
    if w == "comparison":
        row = P[old["passage"]]["comparisons"][old["index"]]
        if row["note"] != old["text"]:
            conflicts.append(old["passage"]); continue
        row["note"] = new["text"]
    elif w == "declaration":
        if L["notes"][old["name"]]["text"] != old["text"]:
            conflicts.append(old["name"]); continue
        L["notes"][old["name"]]["text"] = new["text"]
    elif w == "result":
        if L["fidelity"][old["name"]]["text"] != old["text"]:
            conflicts.append(old["name"]); continue
        L["fidelity"][old["name"]]["text"] = new["text"]
    else:
        d = notes[w]
        key = old["key"] if isinstance(d, dict) else int(old["key"])
        if d[key] != old["text"]:
            conflicts.append(f"{w}:{key}"); continue
        d[key] = new["text"]
    applied += 1
(euler / "links.json").write_text(json.dumps(L, ensure_ascii=False, indent=1) + "\n")
for k, d in notes.items():
    (euler / "notes" / k).write_text(json.dumps(d, ensure_ascii=False, indent=1) + "\n")
print(f"applied {applied}, unchanged {unchanged}, conflicts {len(conflicts)}: {conflicts}")
