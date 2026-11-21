"""Append `#print axioms` for every top-level theorem a Lean file declares, with its namespace."""
import re
import sys

path = sys.argv[1]
text = open(path, encoding="utf-8").read()
stack, names = [], []
for line in text.splitlines():
    if m := re.match(r"^namespace\s+(\S+)", line):
        stack.append(m.group(1))
    elif re.match(r"^end\s+\S+", line) and stack:
        stack.pop()
    elif m := re.match(r"^theorem\s+(\S+)", line):
        names.append(".".join(stack + [m.group(1)]))
with open(path, "a", encoding="utf-8") as f:
    f.write("\n" + "".join(f"#print axioms {n}\n" for n in names))
print(names)
