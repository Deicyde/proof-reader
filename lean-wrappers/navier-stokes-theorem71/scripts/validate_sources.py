#!/usr/bin/env python3
"""Static integration checks. This never substitutes for Lean elaboration.

Run after install_wrapper.py --apply against an isolated checkout. Supply
--original for the unchanged input lean/ directory to check preserved APIs.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
FORBIDDEN = ("sorry", "admit", "axiom", "native_decide", "unsafe")
ORIGINALS = {
    "Breakdown/Cert/ExtendedSigmaProfileOfHeld.lean": "extendedSigmaProfileOfHeldHolds_of",
    "Breakdown/Cert/Rescale.lean": "weakPeriodicSimilarityProfileExists_of_sigma",
    "Breakdown/Weak/OrbitOfParts.lean": "weakOrbitOfParts_holds",
}

def code_only(text: str) -> str:
    """Remove nested comments and string literals, preserving line numbers."""
    out = []
    depth = 0
    in_string = False
    i = 0
    while i < len(text):
        if depth:
            if text.startswith("/-", i):
                depth += 1; out.extend("  "); i += 2
            elif text.startswith("-/", i):
                depth -= 1; out.extend("  "); i += 2
            else:
                out.append("\n" if text[i] == "\n" else " "); i += 1
        elif in_string:
            if text[i] == "\\" and i + 1 < len(text):
                out.extend("  "); i += 2
            elif text[i] == '"':
                in_string = False; out.append(" "); i += 1
            else:
                out.append("\n" if text[i] == "\n" else " "); i += 1
        elif text.startswith("/-", i):
            depth = 1; out.extend("  "); i += 2
        elif text.startswith("--", i):
            end = text.find("\n", i)
            if end < 0: end = len(text)
            out.extend(" " * (end - i)); i = end
        elif text[i] == '"':
            in_string = True; out.append(" "); i += 1
        else:
            out.append(text[i]); i += 1
    if depth or in_string:
        raise ValueError("Unclosed comment or string")
    return "".join(out)

def compact(text: str) -> str:
    return re.sub(r"\s+", "", text)

def signature(source: str, name: str) -> str:
    src = code_only(source)
    m = re.search(r"\btheorem\s+" + re.escape(name) + r"(?=\s)", src)
    if not m: raise ValueError(f"Missing theorem {name}")
    end = src.find(":=", m.start())
    if end < 0: raise ValueError(f"Missing theorem body for {name}")
    return compact(src[m.start():end])

def validate(lean: Path, original: Path | None) -> dict:
    errors = []
    rows = []
    wrappers = sorted((ROOT / "wrapper").glob("*.lean"))
    for src in wrappers:
        text = src.read_text()
        clean = code_only(text)
        bad = [x for x in FORBIDDEN if re.search(r"\b" + re.escape(x) + r"\b", clean)]
        if "debug.skipKernelTC" in clean: bad.append("debug.skipKernelTC")
        installed = lean / src.name
        if not installed.exists() or installed.read_bytes() != src.read_bytes():
            errors.append(f"Installed wrapper differs: {src.name}")
        if bad: errors.append(f"Forbidden proof mechanism in {src.name}: {bad}")
        if "NOT COMPILED" not in text: errors.append(f"Missing compilation label: {src.name}")
        rows.append({"path": "wrapper/" + src.name, "sha256": hashlib.sha256(src.read_bytes()).hexdigest(),
                     "compiled": False, "forbidden_tokens": bad})
    graph = {}
    external = set()
    for path in lean.rglob("*.lean"):
        if ".lake" in path.relative_to(lean).parts: continue
        module = str(path.relative_to(lean).with_suffix("")).replace("/", ".")
        graph[module] = re.findall(r"^\s*import\s+([A-Za-z0-9_.]+)", code_only(path.read_text()), re.M)
    visiting, visited = set(), set()
    def visit(module: str) -> None:
        if module in visited: return
        if module in visiting: raise ValueError(f"Import cycle at {module}")
        if module not in graph:
            if module.split(".")[0] in {"Mathlib", "Lean", "Init", "Std", "Batteries"}:
                external.add(module); return
            raise ValueError(f"Unresolved local module: {module}")
        visiting.add(module)
        for child in graph[module]: visit(child)
        visiting.remove(module); visited.add(module)
    for src in wrappers: visit(src.stem)
    preserved = []
    if original:
        for path, name in ORIGINALS.items():
            same = signature((original / path).read_text(), name) == signature((lean / path).read_text(), name)
            preserved.append({"path": path, "declaration": name, "original_type_preserved": same})
            if not same: errors.append(f"Changed original signature: {name}")
        before = code_only((original / "Breakdown/Defs.lean").read_text())
        before = before.split("def WeakPeriodicSimilarityProfileExists : Prop :=", 1)[1]
        before = before[before.index("0 < P ∧"):].split("end Breakdown", 1)[0]
        after = code_only((ROOT / "wrapper/Theorem71KeepTypes.lean").read_text())
        after = after.split("def WeakProfileAt", 1)[1]
        after = after[after.index("0 < P ∧"):].split("theorem WeakProfileAt.forget", 1)[0]
        identical_weak_body = compact(before) == compact(after)
        if not identical_weak_body: errors.append("WeakProfileAt differs from the original existential body")
    else:
        identical_weak_body = None
    config = json.loads((ROOT / "wrapper/comparator-theorem71.json").read_text())
    if set(config["permitted_axioms"]) != {"propext", "Quot.sound", "Classical.choice"}:
        errors.append("Unexpected axiom allowlist")
    matches = []
    ch = (ROOT / "wrapper/Theorem71Challenge.lean").read_text()
    sol = (ROOT / "wrapper/Theorem71Solution.lean").read_text()
    for target in config["theorem_names"]:
        name = target.split(".")[-1]
        same = signature(ch, name) == signature(sol, name)
        matches.append({"target": target, "source_signatures_equal": same})
        if not same: errors.append(f"Challenge/solution type drift: {target}")
    control = (ROOT / "wrapper/Theorem71Control.lean").read_text()
    control_different = signature(control, "theorem71_extended") != signature(sol, "theorem71_extended")
    if not control_different: errors.append("Control has the same source signature")
    return {"status": "static_pass_not_compiled" if not errors else "static_failure", "errors": errors,
            "new_lean_modules": rows, "reachable_local_modules": len(visited),
            "external_package_imports": sorted(external), "import_cycle_found": False,
            "preserved_original_types": preserved, "weak_profile_body_matches_original": identical_weak_body,
            "comparator_signatures": matches, "control_type_is_different": control_different,
            "lean_compilation_performed": False, "comparator_performed": False}

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("lean_dir", type=Path)
    parser.add_argument("--original", type=Path)
    args = parser.parse_args()
    try:
        result = validate(args.lean_dir.resolve(), args.original.resolve() if args.original else None)
    except (OSError, ValueError) as exc:
        raise SystemExit(f"Static validation failed: {exc}") from exc
    print(json.dumps(result, indent=2))
    if result["status"] != "static_pass_not_compiled": raise SystemExit(1)

if __name__ == "__main__":
    main()
