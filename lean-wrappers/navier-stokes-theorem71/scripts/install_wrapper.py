#!/usr/bin/env python3
"""Install the reviewed additions into an isolated authors' Lean checkout.

Default: read-only preflight. --apply is required for writes. SHA-256 pins
prevent fuzzy application or overwriting an unrelated source revision.
No network calls, compiler installation, or repository publication occur.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile

ROOT = Path(__file__).resolve().parents[1]
TOOLCHAIN = "leanprover/lean4:v4.33.1"
MATHLIB = "0df444a360eaa60ab8c11dca51a86af692955474"

def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()

def strict_patch(original: str, lines: list[str]) -> str:
    """Apply one unified file diff at its exact line locations, without fuzz."""
    source = original.splitlines(keepends=True)
    out: list[str] = []
    cursor = 0
    i = 0
    while i < len(lines):
        m = re.match(r"@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@", lines[i])
        if not m:
            raise ValueError(f"Expected a hunk header: {lines[i]!r}")
        old_start = int(m.group(1)) - 1
        old_count = int(m.group(2) or 1)
        new_count = int(m.group(4) or 1)
        if old_start < cursor or old_start > len(source):
            raise ValueError("Overlapping or out-of-range hunk")
        out.extend(source[cursor:old_start])
        cursor = old_start
        i += 1
        consumed = emitted = 0
        while i < len(lines) and not lines[i].startswith("@@ "):
            line = lines[i]
            tag, body = line[:1], line[1:]
            if tag not in (" ", "+", "-"):
                raise ValueError(f"Unsupported patch line: {line!r}")
            if tag in (" ", "-"):
                if cursor >= len(source) or source[cursor] != body:
                    raise ValueError(f"Exact patch context mismatch at source line {cursor + 1}")
                cursor += 1
                consumed += 1
            if tag in (" ", "+"):
                out.append(body)
                emitted += 1
            i += 1
        if consumed != old_count or emitted != new_count:
            raise ValueError("Hunk length mismatch")
    out.extend(source[cursor:])
    return "".join(out)

def parse_patch(text: str) -> dict[str, list[str]]:
    lines = text.splitlines(keepends=True)
    files: dict[str, list[str]] = {}
    i = 0
    while i < len(lines):
        if not lines[i].startswith("--- a/") or i + 1 >= len(lines):
            raise ValueError("Expected an old-file patch header")
        old = lines[i][6:].rstrip("\n")
        new = lines[i + 1][6:].rstrip("\n")
        if not lines[i + 1].startswith("+++ b/") or old != new:
            raise ValueError("Only same-path file edits are supported")
        p = Path(old)
        if p.is_absolute() or ".." in p.parts or old in files:
            raise ValueError("Unsafe or duplicate patch path")
        i += 2
        start = i
        while i < len(lines) and not lines[i].startswith("--- a/"):
            i += 1
        files[old] = lines[start:i]
    return files

def atomically_write(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    mode = path.stat().st_mode & 0o777 if path.exists() else 0o644
    fd, tmp = tempfile.mkstemp(prefix=".theorem71-", dir=path.parent)
    try:
        with os.fdopen(fd, "wb") as stream:
            stream.write(data)
        os.chmod(tmp, mode)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)

def preflight(lean: Path) -> tuple[dict[Path, bytes], dict]:
    if (lean / "lean-toolchain").read_text().strip() != TOOLCHAIN:
        raise ValueError("Unexpected Lean toolchain")
    manifest = json.loads((lean / "lake-manifest.json").read_text())
    ml = [p for p in manifest.get("packages", []) if p.get("name") == "mathlib"]
    if len(ml) != 1 or ml[0].get("rev") != MATHLIB:
        raise ValueError("Unexpected Mathlib revision")
    pins = json.loads((ROOT / "patches/keep-witness-pins.json").read_text())
    patch = parse_patch((ROOT / "patches/keep-witness.patch").read_text())
    if set(patch) != {p["path"] for p in pins["files"]}:
        raise ValueError("Patch/pin inventory mismatch")
    updates: dict[Path, bytes] = {}
    rows = []
    states = set()
    for p in pins["files"]:
        dest = lean / p["path"]
        data = dest.read_bytes()
        digest = sha(data)
        if digest == p["before_sha256"]:
            states.add("original")
            result = strict_patch(data.decode("utf-8"), patch[p["path"]]).encode("utf-8")
            if sha(result) != p["after_sha256"]:
                raise ValueError(f"Patched hash mismatch: {p['path']}")
            updates[dest] = result
        elif digest == p["after_sha256"]:
            states.add("patched")
        else:
            raise ValueError(f"Source hash mismatch: {p['path']}; no files were changed")
        rows.append({"path": p["path"], "current_sha256": digest,
                     "installed_sha256": p["after_sha256"]})
    if len(states) > 1:
        raise ValueError("Mixed original/patched state; inspect the isolated checkout before continuing")
    modules = []
    for src in sorted((ROOT / "wrapper").iterdir()):
        if src.suffix not in (".lean", ".json"):
            continue
        dest = lean / src.name
        data = src.read_bytes()
        if dest.exists() and dest.read_bytes() != data:
            raise ValueError(f"Refusing to replace different existing wrapper: {dest.name}")
        if not dest.exists():
            updates[dest] = data
        if src.suffix == ".lean":
            modules.append(src.stem)
    lake_path = lean / "lakefile.toml"
    lake = lake_path.read_text()
    registered = set(re.findall(r'\[\[lean_lib\]\]\s*name\s*=\s*"([^"]+)"', lake))
    missing = [m for m in modules if m not in registered]
    if missing:
        lake += "\n# Theorem 7.1 review additions. No default target is changed.\n"
        lake += "".join(f'\n[[lean_lib]]\nname = "{m}"\n' for m in missing)
        updates[lake_path] = lake.encode()
    receipt = {"authors_commit": pins["authors_commit"], "toolchain": TOOLCHAIN,
               "mathlib_rev": MATHLIB, "source_state": sorted(states),
               "patched_sources": rows, "modules": modules,
               "files_to_write": [str(p.relative_to(lean)) for p in updates],
               "compiled": False, "comparator_run": False}
    return updates, receipt

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("lean_dir", type=Path)
    parser.add_argument("--apply", action="store_true", help="Write only after every preflight check succeeds")
    args = parser.parse_args()
    lean = args.lean_dir.resolve()
    try:
        updates, receipt = preflight(lean)
        if args.apply:
            for path, data in updates.items():
                atomically_write(path, data)
            receipt["status"] = "installed_not_compiled"
            atomically_write(lean / "theorem71-install-receipt.json",
                             (json.dumps(receipt, indent=2) + "\n").encode())
        else:
            receipt["status"] = "preflight_pass_no_writes"
        print(json.dumps(receipt, indent=2))
    except (OSError, ValueError, KeyError) as exc:
        raise SystemExit(f"Preflight failed: {exc}") from exc

if __name__ == "__main__":
    main()
