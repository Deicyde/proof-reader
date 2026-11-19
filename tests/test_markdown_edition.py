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
        edition = squash(self.before.replace("$`", "$").replace("`$", "$"))
        for paragraph in markdown_edition.blocks(paper):
            self.assertIn(squash(paragraph), edition)

    def test_inline_maths_stays_on_one_line(self) -> None:
        self.assertEqual(markdown_edition.github_math("a $x\\lVert\ny\\rVert$ b"), "a $x\\lVert y\\rVert$ b")
        self.assertEqual(markdown_edition.github_math("$A\\\\B$"), "$`A\\\\B`$")


if __name__ == "__main__":
    unittest.main()
