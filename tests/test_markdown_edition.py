"""The GitHub Markdown edition stays in step with its sources and copies Lean exactly."""
from __future__ import annotations

import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import markdown_edition  # noqa: E402

SLUG = "coupled-spring"
FOLDER = ROOT / "papers" / SLUG


class MarkdownEditionTest(unittest.TestCase):
    def setUp(self) -> None:
        self.before = (FOLDER / "README.md").read_text(encoding="utf-8")

    def tearDown(self) -> None:
        (FOLDER / "README.md").write_text(self.before, encoding="utf-8")

    def test_committed_edition_matches_its_sources(self) -> None:
        markdown_edition.build(SLUG)
        self.assertEqual((FOLDER / "README.md").read_text(encoding="utf-8"), self.before,
                         "run python3 tools/markdown_edition.py coupled-spring")

    def test_every_lean_block_is_copied_verbatim(self) -> None:
        sources = "\n".join(p.read_text(encoding="utf-8") for p in FOLDER.rglob("*.lean"))
        blocks = re.findall(r"```lean\n(.*?)\n```", self.before, re.S)
        self.assertGreater(len(blocks), 10)
        for block in blocks:
            self.assertIn(block, sources)

    def test_every_paper_paragraph_survives(self) -> None:
        paper = (FOLDER / "paper.md").read_text(encoding="utf-8")
        squash = markdown_edition.squash
        edition = squash(self.before)
        for paragraph in markdown_edition.blocks(paper):
            self.assertIn(squash(markdown_edition.plain_text(paragraph)), edition)

    def test_no_tex_reaches_the_file(self) -> None:
        prose = re.sub(r"```.*?```", "", self.before, flags=re.S)
        self.assertNotIn("$", prose)
        self.assertNotRegex(prose, r"\\[A-Za-z]")

    def test_a_fold_never_breaks_a_sentence(self) -> None:
        # A fold opens after a full stop, never inside "The function U = … on ℝ²
        # is called…" or before the formula that ends "and therefore".
        for before in re.findall(r"(.*)\n\n<details>", self.before):
            if not before.startswith("#"):
                self.assertTrue(markdown_edition.sentence_ends(before), before)

    def test_definitions_show_their_bodies(self) -> None:
        fold = self.before.split("· `couplingPotential`\n", 1)[1].split("</details>", 1)[0]
        self.assertIn("(x 0) ^ 2 + x 0 * x 1 + (x 1) ^ 2", fold)

    def test_comparisons_are_labelled_as_unreviewed(self) -> None:
        for line in re.findall(r"\*\*Comparison with the page[^*]*\*\*", self.before):
            self.assertIn("made by AI and not reviewed", line)

    def test_proofs_written_for_the_page_are_shown_whole(self) -> None:
        self.assertIn("exact couplingPotential_pos x hx", self.before)
        self.assertIn("have h1sq : (x 1) ^ 2 = 0", self.before)

    def test_global_minimum_uses_its_own_proof(self) -> None:
        built = markdown_edition.tool.edition(SLUG)
        claims = {claim["id"]: claim for claim in built["claims"]}
        passages = {passage["id"]: passage for passage in built["passages"]}
        original = passages[claims["local-minimum"]["passage"]]
        self.assertEqual(original["lean"], ["coupled_spring_potential"])
        self.assertIn("a local minimum", original["quote"])
        global_result = passages[claims["global-minimum"]["passage"]]
        self.assertEqual(global_result["lean"], [])
        self.assertEqual(global_result["checks"], ["couplingPotential_origin_lt"])
        self.assertEqual(claims["global-minimum"]["checks"], global_result["checks"])
        self.assertIn("For every nonzero", global_result["quote"])
        self.assertEqual(passages["strict-positivity"]["checks"], ["couplingPotential_pos"])
        self.assertEqual(passages["completed-square"]["checks"], ["couplingPotential_eq_sq_add_sq"])

    def test_definitions_are_shown_whole_and_empty_docstrings_dropped(self) -> None:
        self.assertIn("toFun := fun y => iteratedFDeriv ℝ 2 f x₀ ![y,y]", self.before)
        self.assertNotIn("/-- . -/", self.before)

    def test_formulas_read_as_physlib_writes_them(self) -> None:
        convert = markdown_edition.plain_maths.convert
        cases = {
            r"U(x_0,x_1)=x_0^2+x_0x_1+x_1^2": "U(x₀, x₁) = x₀² + x₀x₁ + x₁²",
            r"D^2f(a)(y,y)\ge C\lVert y\rVert^2": "D²f(a)(y, y) ≥ C‖y‖²",
            r"U(h)\le\tfrac32\lVert h\rVert^2": "U(h) ≤ (3/2)‖h‖²",
            r"2\left(y_0+\tfrac c2y_1\right)^2+2\left(1-\tfrac{c^2}4\right)y_1^2": "2(y₀ + (c/2)y₁)² + 2(1 − c²/4)y₁²",
            r"\begin{pmatrix}2&1\\1&2\end{pmatrix}": "[[2, 1], [1, 2]]",
            r"W(-2,0)=4-8=-4<W(0)": "W(−2, 0) = 4 − 8 = −4 < W(0)",
            r"t\to-\infty": "t → −∞",
            r"\lvert c\rvert<2": "|c| < 2",
            r"\tfrac94": "9/4",
            r"c=\pm2": "c = ±2",
            r"-\nabla U": "−∇U",
            r"\sqrt3": "√3",
            r"U_{-2}(x)": "U₋₂(x)",
        }
        for tex, text in cases.items():
            self.assertEqual(convert(tex), text)

if __name__ == "__main__":
    unittest.main()
