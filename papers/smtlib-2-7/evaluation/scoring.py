#!/usr/bin/env python3
"""The authors' citations as passages of the standard, and the scores of a matcher against them.

Reference. Each `Standard:` citation in BSmtLibSpec names a release, a section, sometimes a
run-in heading, and sometimes an Appendix B rule. `reference()` turns every citation into
groups of passage ids from the frozen inventory: one group for each cited section or heading,
one for the rule the declaration defines. A matcher satisfies a group by naming any passage
in it. Other rules a citation mentions are acceptable links but are not required.

Scores (declarations to passages), all over fixed denominators:
  groups_found        required groups the matcher named a passage in, over all required groups
  complete            cited declarations with every required group found
  rule_found          cited declarations whose defined Appendix B rule was named exactly
  links_in_key        links on cited declarations that land in that declaration's groups,
                      over all links on cited declarations; the rest go to review. The authors
                      often cite a whole section, so this is generous: linking everything scores
                      about 3%, the base rate
  rule_links_in_key   of the grammar-rule passages linked on cited declarations, those stating a
                      rule the citation names; the sharper measure of precision
  links_outside_key   links on declarations the authors did not cite, listed for review: the
                      authors' key is not a complete answer, so these are neither right nor wrong
A declaration the matcher did not answer for counts as answered with nothing.

    python3 scoring.py reference
    python3 scoring.py score PREDICTIONS.json LABEL OUT_PREFIX
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
KEY = HERE / "reference" / "key_rows.json"
PASSAGES = HERE / "inventory" / "passages.json"
TOKEN = re.compile(r"(?P<v>\b2\.[0567]\b)|§\s?(?P<sec>\d+(?:\.\d+)*)\.?\s*(?P<head>[A-Z][A-Za-z -]*?)?(?=[;:,.(]|\s+and\s|\s+as\s|$)"
                   r"|(?P<appb>App\.\s*B)|⟨(?P<prod>[a-z_0-9]+)\s*⟩|(?P<stop>[;.])")


def load_passages() -> list[dict]:
    return json.loads(PASSAGES.read_text(encoding="utf-8"))


def clauses(text: str) -> tuple[list[tuple[str, str, str | None]], list[tuple[str, str]]]:
    """Sections (version, section, heading) and Appendix B rules (version, rule) a citation names."""
    regions, rules = [], []
    version, in_appb = "2.7", False
    for m in TOKEN.finditer(text):
        if m.group("v"):
            version = m.group("v")
        elif m.group("sec"):
            head = (m.group("head") or "").strip() or None
            regions.append((version, m.group("sec"), head))
            in_appb = False
        elif m.group("appb"):
            in_appb = True
        elif m.group("prod") and in_appb:
            rules.append((version, m.group("prod")))
        elif m.group("stop"):
            in_appb = False
    return regions, rules


def region_ids(passages: list[dict], version: str, section: str, head: str | None) -> list[str]:
    inside = [p for p in passages if p["version"] == version and p["part"] != "B"
              and (p["section"] == section or p["section"].startswith(section + "."))]
    if head:
        wanted = {h.strip().lower() for h in re.split(r"\s+and\s+", head)}
        narrow = [p for p in inside if (p["heading"] or "").lower() in wanted]
        if narrow:
            inside = narrow
    return [p["id"] for p in inside]


def rule_ids(passages: list[dict], version: str, rule: str) -> list[str]:
    return [p["id"] for p in passages if p["version"] == version and p["production"] == rule]


def reference() -> dict:
    passages = load_passages()
    rows = json.loads(KEY.read_text(encoding="utf-8"))
    out, unresolved = {}, []
    for row in rows:
        text = row.get("standard_citation_text")
        if not text:
            continue
        regions, rules = clauses(text)
        groups, acceptable = [], set()
        for version, section, head in regions:
            ids = region_ids(passages, version, section, head)
            if ids:
                groups.append({"kind": "section", "label": f"{version} §{section}" + (f" {head}" if head else ""), "ids": ids})
            else:
                unresolved.append({"declaration": row["declaration"], "clause": f"{version} §{section} {head or ''}".strip()})
        subject = row.get("production_subject")
        for version, rule in rules:
            ids = rule_ids(passages, version, rule)
            if not ids:
                unresolved.append({"declaration": row["declaration"], "clause": f"{version} App. B ⟨{rule}⟩"})
                continue
            if rule == subject:
                groups.append({"kind": "rule", "label": f"{version} ⟨{rule}⟩", "ids": ids, "rule": rule})
            else:
                acceptable.update(ids)
        for g in groups:
            acceptable.update(g["ids"])
        out[row["declaration"]] = {"citation": text, "groups": groups, "acceptable": sorted(acceptable),
                                   "readings": row.get("readings", []), "subject_rule": subject}
    return {"declarations": out, "unresolved": unresolved}


def canonical(name: str) -> str:
    return re.sub(r"^Spec\.", "BSmtLibSpec.", name)


def score(predictions: list[dict], ref: dict, all_declarations: list[str]) -> dict:
    by_decl: dict[str, set[str]] = {d: set() for d in all_declarations}
    unknown = []
    for rec in predictions:
        name = canonical(rec.get("id", ""))
        if name not in by_decl:
            unknown.append(rec.get("id"))
            continue
        by_decl[name] |= {m["passage"] for m in rec.get("matches") or [] if m.get("passage")}
    cited = ref["declarations"]
    groups_total = groups_found = complete = rule_total = rule_found = 0
    links_cited = links_in_key = rule_links = rule_links_in_key = 0
    rule_of = {q["id"]: q["production"] for q in load_passages() if q["production"]}
    misses, off_key = [], []
    for name, entry in cited.items():
        predicted = by_decl.get(name, set())
        found_all = True
        for g in entry["groups"]:
            groups_total += 1
            hit = bool(predicted & set(g["ids"]))
            groups_found += hit
            if g["kind"] == "rule":
                rule_total += 1
                rule_found += hit
            if not hit:
                found_all = False
                misses.append({"declaration": name, "group": g["label"]})
        complete += found_all and bool(entry["groups"])
        links_cited += len(predicted)
        inside = predicted & set(entry["acceptable"])
        links_in_key += len(inside)
        cited_rules = {rule_of[q] for q in entry["acceptable"] if q in rule_of}
        for q in predicted:
            if q in rule_of:
                rule_links += 1
                rule_links_in_key += rule_of[q] in cited_rules
        for pid in sorted(predicted - inside):
            off_key.append({"declaration": name, "passage": pid})
    outside = [{"declaration": n, "passage": p} for n, ps in by_decl.items() if n not in cited for p in sorted(ps)]
    eligible = sum(1 for e in cited.values() if e["groups"])
    return {
        "cited_declarations": eligible,
        "groups_found": [groups_found, groups_total],
        "complete": [complete, eligible],
        "rule_found": [rule_found, rule_total],
        "links_in_key": [links_in_key, links_cited],
        "rule_links_in_key": [rule_links_in_key, rule_links],
        "links_per_cited_declaration": round(links_cited / eligible, 2) if eligible else 0,
        "links_on_cited_outside_their_key": len(off_key),
        "links_outside_key": len(outside),
        "answered": sum(1 for rec in predictions if canonical(rec.get("id", "")) in by_decl),
        "unknown_ids": unknown,
        "misses": misses,
        "review_on_cited": off_key,
        "review_uncited": outside,
    }


def fraction(pair: list[int]) -> str:
    return f"{pair[0]} / {pair[1]}" + (f" ({100 * pair[0] / pair[1]:.0f}%)" if pair[1] else "")


def main() -> int:
    if sys.argv[1] == "reference":
        ref = reference()
        out = HERE / "reference" / "author_groups.json"
        out.write_text(json.dumps(ref, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
        ds = ref["declarations"]
        print(f"{len(ds)} cited declarations, {sum(len(d['groups']) for d in ds.values())} required groups, "
              f"{sum(1 for d in ds.values() for g in d['groups'] if g['kind'] == 'rule')} rule groups, "
              f"{len(ref['unresolved'])} unresolved clauses")
        for u in ref["unresolved"]:
            print("  unresolved:", u)
        return 0
    if sys.argv[1] == "score":
        preds = json.loads(Path(sys.argv[2]).read_text(encoding="utf-8"))
        ref = json.loads((HERE / "reference" / "author_groups.json").read_text(encoding="utf-8"))
        decls = [canonical(d["id"]) for d in json.loads((HERE / "reference" / "declarations.json").read_text())]
        everything = [{"id": d, "matches": [{"passage": q["id"]} for q in load_passages()]} for d in decls]
        controls = {"link_every_passage": {k: v for k, v in score(everything, ref, decls).items()
                                           if k in ("groups_found", "links_in_key", "rule_links_in_key")}}
        result = {"label": sys.argv[3], **score(preds, ref, decls), "controls": controls}
        Path(sys.argv[4] + ".json").write_text(json.dumps(result, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
        for k in ("groups_found", "complete", "rule_found", "links_in_key", "rule_links_in_key"):
            base = controls["link_every_passage"].get(k)
            print(f"{k:18} {fraction(result[k]):24}" + (f" link-everything control: {fraction(base)}" if base else ""))
        print(f"answered {result['answered']} of {len(decls)}; unknown ids {len(result['unknown_ids'])}; "
              f"links to review: {result['links_on_cited_outside_their_key']} on cited, {result['links_outside_key']} on uncited")
        return 0
    raise SystemExit(__doc__)


if __name__ == "__main__":
    raise SystemExit(main())
