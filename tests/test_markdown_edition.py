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
        }
        for tex, text in cases.items():
            self.assertEqual(convert(tex), text)

if __name__ == "__main__":
    unittest.main()
