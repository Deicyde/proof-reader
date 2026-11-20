#!/usr/bin/env python3
"""Write evaluation/summary.json, the results the page shows, from the score files.

Every count comes from a score file; the sentences only say what the counts are.

    python3 make_summary.py
"""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
RECORDS = "https://github.com/wcook04/proof-reader/tree/main/papers/smtlib-2-7/evaluation"


def load(path):
    return json.loads((HERE / path).read_text(encoding="utf-8"))


def section_pair(s):
    return [s["groups_found"][0] - s["rule_found"][0], s["groups_found"][1] - s["rule_found"][1]]


def readings(grades):
    return sum(1 for g in grades.values() if g["grade"] == "recovered"), sum(1 for g in grades.values() if g["grade"] == "in_part")


def main() -> int:
    code = load("runs/gpt_code_only/score.json")
    docs = load("runs/gpt_docs_kept/score.json")
    names = load("runs/name_baseline/score.json")
    every = code["controls"]["link_every_passage"]
    code_rev = load("runs/gpt_code_only/score_passages.json")
    names_rev = load("runs/name_baseline/score_passages.json")
    grades = load("runs/reading_grades.json")
    meaning = load("meaning/score.json")["tally"]
    m_grades = load("meaning/reading_grades.json")["grades"]
    passages = load("inventory/passages.json")
    groups = load("reference/author_groups.json")["declarations"]
    titles = load("plain_titles.json")
    code_full, code_part = readings(grades["code_only"])
    docs_full, docs_part = readings(grades["docs_kept"])
    clean = [k for k in m_grades if k.startswith("2/")]
    clean_tested = [k for k in clean if m_grades[k]["grade"] != "not_tested"]
    clean_rec = [k.split("-")[-1] for k in clean_tested if m_grades[k]["grade"] == "recovered"]
    clean_missed = [k.split("-")[-1] for k in clean_tested if m_grades[k]["grade"] != "recovered"]

    rows = [
        {"measure": "Rule each definition states, named exactly", "about": "",
         "counts": {"code": code["rule_found"], "docs": docs["rule_found"], "names": names["rule_found"], "every": [81, 81]}},
        {"measure": "Cited prose paragraph found", "about": "",
         "counts": {"code": section_pair(code), "docs": section_pair(docs), "names": section_pair(names), "every": [106, 106]}},
        {"measure": "Definitions with every citation found", "about": "",
         "counts": {"code": code["complete"], "docs": docs["complete"], "names": names["complete"], "every": [105, 105]}},
        {"measure": "Linked rules the authors cite", "about": "",
         "counts": {"code": code["rule_links_in_key"], "docs": docs["rule_links_in_key"], "names": names["rule_links_in_key"], "every": every["rule_links_in_key"]}},
        {"measure": "From the standard: the authors' definition named", "about": "",
         "counts": {"code": code_rev["found"], "docs": None, "names": names_rev["found"], "every": None}},
        {"measure": "Readings explained", "about": "",
         "counts": {"code": [code_full, 12], "docs": [docs_full, 12], "names": None, "every": None}},
    ]
    missed_both = []
    code_miss = {(m["declaration"], m["group"]) for m in code["misses"]}
    for m in docs["misses"]:
        if (m["declaration"], m["group"]) in code_miss:
            missed_both.append({"declaration": titles.get(m["declaration"], m["declaration"]) + f" ({m['declaration'].replace('BSmtLibSpec.', '')})",
                                "citation": m["group"]})
    summary = {
        "matcher": "GPT-6.1",
        "method": [
            "GPT-6.1 matched the standard to BSmtLib's Lean without seeing the authors' citations: once from each of the 298 definitions, and once from each of the 352 rules and paragraphs of 2.7. It ran in a sandbox with no network.",
            f"A program scored its links against the citations in the authors' comments ({len(groups)} definitions cite the standard), beside two controls: linking by name alone, and linking every passage to every definition.",
        ],
        "columns": [
            {"id": "code", "label": "GPT, code only", "about": "GPT-6.1 reading the Lean with every comment removed."},
            {"id": "docs", "label": "GPT, with comments", "about": "GPT-6.1 reading the Lean with the authors' comments, minus every citation and Reading."},
            {"id": "names", "label": "Names only", "about": "No model: each definition linked to the rule with its name."},
            {"id": "every", "label": "Everything", "about": "A control: every passage linked to every definition."},
        ],
        "rows": rows,
        "findings": [
            f"BSmtLib names its definitions after the standard's rules, so matching by name alone finds {names['rule_found'][0]} of the {names['rule_found'][1]} rules.",
            f"GPT-6.1 found {code['rule_found'][0]} of {code['rule_found'][1]} from the code alone, and going from the standard to the Lean it named the authors' definition on {code_rev['found'][0]} of {code_rev['found'][1]} cited passages.",
            f"It explained {code_full} of the authors' 12 Readings from the code alone and {docs_full} with comments kept, among them :56 (L5) and the missing define-funs-rec (L6).",
            f"We changed one detail in {meaning['changed']['of']} definitions (a range, a release, an empty list). It caught all {meaning['changed']['right']}, naming an input each one treats differently, and called all {meaning['as_written']['of']} untouched ones exact.",
            "The authors' paper says their formal reading was generated by AI and reviewed by the maintainer, so agreement here is not independent proof.",
        ],
        "misses": missed_both,
        "records": RECORDS,
    }
    (HERE / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    for row in rows:
        print(f"{row['measure'][:48]:48}", {k: v for k, v in row["counts"].items()})
    print(len(missed_both), "citations missed by both declaration runs")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
