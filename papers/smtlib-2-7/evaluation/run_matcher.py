#!/usr/bin/env python3
"""Run one matcher in a fresh, sandboxed Codex session and audit what it did.

    python3 run_matcher.py PREPARED_DIR CONDITION TASK RUN_DIR [--model M] [--effort E]

PREPARED_DIR is the output of prepare_runs.py. TASK is `declarations_to_passages` or
`passages_to_declarations`. The session gets a fresh CODEX_HOME (a link to the existing
login and a minimal config, so no personal instructions or skills), the workspace-write
sandbox (no network; writes only inside RUN_DIR) and the task text as TASK.md. Reads are
not confined by the sandbox, so every command the session ran is checked afterwards for
paths outside RUN_DIR and recorded in audit.json.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent


def eligible_passages() -> list[str]:
    rows = json.loads((HERE / "inventory" / "passages.json").read_text(encoding="utf-8"))
    return [p["id"] for p in rows if p["version"] == "2.7" and p["part"] in ("3", "B")
            and p["kind"] in ("prose", "production")]


def codex_home(base: Path, model: str, effort: str) -> Path:
    home = base / "codex-home"
    home.mkdir(parents=True, exist_ok=True)
    auth = Path.home() / ".codex" / "auth.json"
    link = home / "auth.json"
    if not link.exists():
        link.symlink_to(auth)
    # The model list Codex fetched for this login; without it the account's models are refused.
    shutil.copy(Path.home() / ".codex" / "models_cache.json", home / "models_cache.json")
    (home / "config.toml").write_text(
        f'model = "{model}"\nmodel_reasoning_effort = "{effort}"\nsandbox_mode = "workspace-write"\n'
        'project_doc_max_bytes = 0\n'
        '[sandbox_workspace_write]\nnetwork_access = false\n', encoding="utf-8")
    return home


def empty_home(base: Path) -> Path:
    """An empty HOME, so the session finds no personal skills (~/.agents/skills) or shell setup."""
    home = base / "home"
    home.mkdir(parents=True, exist_ok=True)
    return home


def audit(events: Path, run_dir: Path) -> dict:
    commands = []
    outside = []
    for line in events.read_text(encoding="utf-8").splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        item = event.get("item") or {}
        if item.get("type") == "command_execution" and item.get("command"):
            cmd = item["command"]
            if cmd not in commands:
                commands.append(cmd)
    allowed = str(run_dir.resolve())
    for cmd in commands:
        for path in re.findall(r"(?<![\w.])(/[^\s'\"`;|&()<>]+|~[^\s'\"`;|&()<>]*)", cmd):
            p = path.rstrip(",")
            if p.startswith(("/dev/null", "/bin/", "/usr/", "/opt/homebrew/bin", "/tmp/tmp")):
                continue
            if not os.path.realpath(os.path.expanduser(p)).startswith(allowed) and not os.path.realpath(p).startswith(os.path.realpath(allowed)):
                outside.append({"command": cmd[:300], "path": p})
        if re.search(r"\.\.(/|\s|$)", cmd):
            outside.append({"command": cmd[:300], "path": "parent directory reference"})
    return {"commands": len(commands), "outside_paths": outside, "command_list": commands}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("prepared", type=Path)
    ap.add_argument("condition")
    ap.add_argument("task")
    ap.add_argument("run_dir", type=Path)
    ap.add_argument("--model", default="gpt-6.2-sol")
    ap.add_argument("--effort", default="high")
    args = ap.parse_args()
    run = args.run_dir
    if run.exists():
        shutil.rmtree(run)
    shutil.copytree(args.prepared / args.condition, run)
    (run / "out").mkdir(exist_ok=True)
    shutil.copy(HERE / "tasks" / f"{args.task}.md", run / "TASK.md")
    if args.task == "passages_to_declarations":
        (run / "eligible_passages.json").write_text(json.dumps(eligible_passages(), indent=0) + "\n", encoding="utf-8")
    inputs = hashlib.sha256()
    for path in sorted(run.rglob("*")):
        if path.is_file():
            inputs.update(str(path.relative_to(run)).encode() + b"\0" + path.read_bytes())
    base = run.parent / f".{run.name}-env"
    home = codex_home(base, args.model, args.effort)
    env = {**os.environ, "CODEX_HOME": str(home), "HOME": str(empty_home(base))}
    started = time.time()
    events = run.parent / f"{run.name}.events.jsonl"
    with events.open("w", encoding="utf-8") as sink:
        proc = subprocess.run(
            ["codex", "exec", "--skip-git-repo-check", "--ephemeral", "-C", str(run), "-s", "workspace-write",
             "-o", str(run.parent / f"{run.name}.last_message.txt"),
             "--json", "Read TASK.md in this folder and carry out the task exactly. Write only inside this folder."],
            env=env, stdout=sink, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL)
    record = {"condition": args.condition, "task": args.task, "model": args.model, "effort": args.effort,
              "codex_cli": subprocess.run(["codex", "--version"], capture_output=True, text=True).stdout.strip(),
              "inputs_sha256": inputs.hexdigest(), "exit": proc.returncode,
              "seconds": round(time.time() - started), "audit": audit(events, run)}
    (run.parent / f"{run.name}.audit.json").write_text(json.dumps(record, indent=1) + "\n", encoding="utf-8")
    print(json.dumps({k: v for k, v in record.items() if k != "audit"} | {
        "commands": record["audit"]["commands"], "outside": len(record["audit"]["outside_paths"])}))
    return proc.returncode


if __name__ == "__main__":
    raise SystemExit(main())
