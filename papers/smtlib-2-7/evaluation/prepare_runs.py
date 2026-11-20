#!/usr/bin/env python3
"""Make the read-only input folders the matchers see, and the frozen inventories they answer for.

Conditions (the authors' Lean is never changed; these are copies):
  code_only   every comment removed: names, types and bodies remain
  docs_kept   documentation kept, except every paragraph that cites the standard, names a
              Reading, carries a Standard/Property/Formalism tag or names a version or release

In both, the namespace `BSmtLibSpec` is renamed `Spec`, so the project's name is not a cue.
The top file BSmtLibSpec.lean (the authors' list of Readings) and BSmtLibSpec/Facts/ are
left out. Each folder also holds the passage inventory, the declaration inventory and the
task text. A residual scan fails the build if any citation-like text survives.

    python3 papers/smtlib-2-7/evaluation/prepare_runs.py OUT_DIR
"""
from __future__ import annotations

import hashlib
import json
import re
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
PAPER = HERE.parent
ROOT = PAPER.parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import paper as reader  # noqa: E402

SPEC = PAPER / "lean" / "BSmtLibSpec"
CITING = re.compile(
    r"\b(Standard|Readings?|Property|Formalism)\s*:|\bReadings?\s+[LGM]\d|\b[LGM]\d{1,2}\b(?=[ ,.;)]|$)"
    r"|§|App\.\s*B|Appendix\s+B|\b2\.[0567]\b|\brelease\s+\d{4}|\bSMT-LIB\s+2\.\d")
RESIDUAL = re.compile(r"§|App\.\s*B|Appendix B|Reading\s+[LGM]\d|Standard:|Formalism:|Property:")


def lean_comments(text: str) -> list[tuple[int, int, str]]:
    """Spans of comments as (start, end, kind): kind is 'line', 'doc', 'module' or 'block'.
    Block comments nest; string and character literals are skipped."""
    spans, i, n = [], 0, len(text)
    while i < n:
        c = text[i]
        if c == '"':
            i += 1
            while i < n and text[i] != '"':
                i += 2 if text[i] == "\\" else 1
            i += 1
        elif c == "'" and i + 2 < n and (text[i + 2] == "'" or (text[i + 1] == "\\" and i + 3 < n and text[i + 3] == "'")):
            i += 4 if text[i + 1] == "\\" else 3
        elif text.startswith("--", i):
            j = text.find("\n", i)
            j = n if j < 0 else j
            spans.append((i, j, "line"))
            i = j
        elif text.startswith("/-", i):
            kind = "doc" if text.startswith("/--", i) else "module" if text.startswith("/-!", i) else "block"
            depth, j = 1, i + 2
            while j < n and depth:
                if text.startswith("/-", j):
                    depth, j = depth + 1, j + 2
                elif text.startswith("-/", j):
                    depth, j = depth - 1, j + 2
                else:
                    j += 1
            spans.append((i, j, kind))
            i = j
        else:
            i += 1
    return spans


def strip_all(text: str) -> str:
    out, last = [], 0
    for start, end, _ in lean_comments(text):
        out.append(text[last:start])
        last = end
    out.append(text[last:])
    return re.sub(r"\n[ \t]*\n(?:[ \t]*\n)+", "\n\n", "".join(out))


def strip_citing(text: str) -> str:
    out, last = [], 0
    for start, end, kind in lean_comments(text):
        out.append(text[last:start])
        last = end
        body = text[start:end]
        if kind == "line":
            if not CITING.search(body):
                out.append(body)
            continue
        opener = body[:3] if kind in ("doc", "module") else body[:2]
        inner = body[len(opener):-2]
        paragraphs = re.split(r"\n[ \t]*\n", inner)
        keep = [p for p in paragraphs if not CITING.search(" ".join(p.split()))]
        if any(p.strip() for p in keep):
            out.append(opener + "\n\n".join(keep) + "-/")
        elif kind == "doc":
            out.append("/-- -/")
    out.append(text[last:])
    return "".join(out)


def rename(text: str) -> str:
    return re.sub(r"\bBSmtLibSpec\b", "Spec", text)


def declarations() -> list[dict]:
    folder, config = reader.load_paper("smtlib-2-7")
    info, _ = reader.shards(folder, config)
    rows = []
    for name, row in sorted(info["written"].items(), key=lambda kv: (kv[1]["module"], kv[1]["line"])):
        path = row["module"].replace(".", "/") + ".lean"
        rows.append({"id": name, "module": row["module"], "file": path, "line": row["line"],
                     "end_line": row["end_line"], "keyword": row["keyword"]})
    return rows


def passages() -> list[dict]:
    rows = json.loads((HERE / "inventory" / "passages.json").read_text(encoding="utf-8"))
    return [{k: p[k] for k in ("id", "version", "release", "page", "section", "heading", "kind", "production", "text")}
            for p in rows]


def build(out: Path) -> dict:
    decls = declarations()
    report = {"declarations": len(decls), "conditions": {}}
    for condition, transform in (("code_only", strip_all), ("docs_kept", strip_citing)):
        target = out / condition
        if target.exists():
            shutil.rmtree(target)
        (target / "lean").mkdir(parents=True)
        residual = []
        for path in sorted(SPEC.rglob("*.lean")):
            rel = path.relative_to(SPEC.parent)
            if "Facts" in rel.parts:
                continue
            text = rename(transform(path.read_text(encoding="utf-8")))
            for k, line in enumerate(text.splitlines(), 1):
                if RESIDUAL.search(line) or re.search(r"\bBSmtLib", line):
                    residual.append(f"{rel}:{k}: {line.strip()}")
            joined = " ".join(text.split())
            for m in RESIDUAL.finditer(joined):
                residual.append(f"{rel}: joined text: {joined[max(0, m.start() - 40): m.end() + 40]}")
            dest = target / "lean" / rename(str(rel))
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_text(text, encoding="utf-8")
        if residual:
            raise SystemExit(f"{condition}: citation-like text survived:\n" + "\n".join(residual[:20]))
        (target / "declarations.json").write_text(json.dumps(
            [{**d, "id": rename(d["id"]), "module": rename(d["module"]), "file": rename(d["file"])} for d in decls],
            indent=1) + "\n", encoding="utf-8")
        with (target / "passages.jsonl").open("w", encoding="utf-8") as f:
            for p in passages():
                f.write(json.dumps(p, ensure_ascii=False) + "\n")
        digest = hashlib.sha256()
        for path in sorted(target.rglob("*")):
            if path.is_file():
                digest.update(str(path.relative_to(target)).encode() + b"\0" + path.read_bytes())
        report["conditions"][condition] = {"files": sum(1 for p in target.rglob("*") if p.is_file()),
                                           "sha256": digest.hexdigest()}
    return report


if __name__ == "__main__":
    print(json.dumps(build(Path(sys.argv[1])), indent=1))
