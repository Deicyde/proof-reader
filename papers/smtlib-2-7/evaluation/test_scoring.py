"""The scorer must not reward predictions that know nothing.

Each control is a prediction file a careless or dishonest matcher could produce. The Type B
review of 20 November showed that the first scorer gave 105/105 to a prediction pointing every
declaration at chapter 3, and 12/12 Readings to a flag on every declaration. These tests keep
the replacement honest.

    python3 -m unittest papers/smtlib-2-7/evaluation/test_scoring.py
"""
import json
import random
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import scoring  # noqa: E402

REF = json.loads((HERE / "reference" / "author_groups.json").read_text(encoding="utf-8"))
DECLS = [scoring.canonical(d["id"]) for d in json.loads((HERE / "reference" / "declarations.json").read_text())]
PASSAGES = [p["id"] for p in scoring.load_passages()]


def ratio(pair):
    return pair[0] / pair[1] if pair[1] else 0.0


class Controls(unittest.TestCase):
    def test_every_passage_everywhere_has_no_precision(self):
        preds = [{"id": d, "matches": [{"passage": p} for p in PASSAGES]} for d in DECLS]
        s = scoring.score(preds, REF, DECLS)
        self.assertEqual(s["groups_found"][0], s["groups_found"][1])
        self.assertLess(ratio(s["links_in_key"]), 0.05)
        self.assertLess(ratio(s["rule_links_in_key"]), 0.25)

    def test_saying_nothing_finds_nothing(self):
        s = scoring.score([], REF, DECLS)
        self.assertEqual(s["groups_found"][0], 0)
        self.assertEqual(s["complete"][0], 0)
        self.assertEqual(s["groups_found"][1], sum(len(e["groups"]) for e in REF["declarations"].values()))

    def test_answering_one_easy_row_keeps_the_denominator(self):
        name, entry = next((n, e) for n, e in REF["declarations"].items() if n.endswith("Lexicon.digit"))
        preds = [{"id": name, "matches": [{"passage": entry["groups"][0]["ids"][0]}]}]
        s = scoring.score(preds, REF, DECLS)
        self.assertEqual(s["complete"][1], s["cited_declarations"])
        self.assertLess(ratio(s["groups_found"]), 0.02)

    def test_random_passages_score_near_zero(self):
        rng = random.Random(0)
        preds = [{"id": d, "matches": [{"passage": rng.choice(PASSAGES)} for _ in range(2)]} for d in DECLS]
        s = scoring.score(preds, REF, DECLS)
        self.assertLess(ratio(s["groups_found"]), 0.05)
        self.assertLess(ratio(s["links_in_key"]), 0.05)

    def test_the_authors_own_groups_score_perfectly(self):
        preds = [{"id": n, "matches": [{"passage": g["ids"][0]} for g in e["groups"]]} for n, e in REF["declarations"].items()]
        s = scoring.score(preds, REF, DECLS)
        self.assertEqual(s["groups_found"][0], s["groups_found"][1])
        self.assertEqual(s["links_in_key"][0], s["links_in_key"][1])

    def test_a_section_number_alone_earns_nothing(self):
        preds = [{"id": d, "matches": [{"passage": "3"}, {"passage": "2.7"}]} for d in DECLS]
        s = scoring.score(preds, REF, DECLS)
        self.assertEqual(s["groups_found"][0], 0)


if __name__ == "__main__":
    unittest.main()
