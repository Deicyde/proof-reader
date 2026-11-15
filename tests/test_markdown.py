"""Markdown-source contract. Renderer tests use the real pinned Node dependencies.

The edition fixture's extracted metadata is synthetic. These tests exercise the
reader pipeline and make no claim about Lean elaboration or theorem verification.
Run from the repository root after `npm ci` in web/.
"""
import contextlib
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
import paper
import reading


class MarkdownAnchors(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / "guide.md"

    def resolve(self, text, quote, heading="Section", block=1, **extra):
        self.path.write_text(text, encoding="utf-8")
        item = {"id": "p", "quote": quote, "anchor": {"heading": heading, "block": block}, **extra}
        return reading.resolve_markdown(self.path, "test", [item])

    def test_source_map_keeps_fences_lists_and_tables_whole(self):
        source = ("# Guide\n\n## Section\n\n[Source](code.lean)\n\n"
                  "```lean\ndef x := 1\n\n# this is code\n```\n\n"
                  "- First item.\n\n  Continued here.\n- Second item.\n\n"
                  "| Lean | Meaning |\n| --- | --- |\n| `x` | The result. |\n")
        done, passages = self.resolve(source, "The result.", block=4)
        blocks = [b for b in done["source_blocks"] if b["heading"] == "Section"]
        self.assertEqual([b["kind"] for b in blocks], ["paragraph_open", "fence", "bullet_list_open", "table_open"])
        self.assertEqual(passages[0]["source_lines"], [20, 20])
        built = reading.build_markdown(done, "test", passages, [], "https://example.org/docs/guide.md")
        self.assertIn('<table>', built["html"])
        self.assertIn('https://example.org/docs/code.lean', built["html"])
        self.assertIn('data-p="p"', built["html"])

    def test_frontmatter_is_hidden_but_source_lines_are_preserved(self):
        source = '---\ntitle: "Private metadata"\nauthors:\n  - "Author"\n---\n\n## Section\n\nA linked sentence.\n'
        done, passages = self.resolve(source, "A linked sentence.")
        built = reading.build_markdown(done, "test", passages, [], "")
        self.assertNotIn("Private metadata", built["html"])
        self.assertEqual(passages[0]["source_lines"], [9, 9])

    def test_opening_horizontal_rules_do_not_hide_ordinary_prose(self):
        source = '---\n\nAn ordinary opening paragraph.\n\n---\n\n## Section\n\nA linked sentence.\n'
        done, passages = self.resolve(source, "A linked sentence.")
        built = reading.build_markdown(done, "test", passages, [], "")
        self.assertIn("An ordinary opening paragraph.", built["html"])
        self.assertEqual(passages[0]["source_lines"], [9, 9])

    def test_exact_raw_quote_is_unique_globally_before_anchor(self):
        with self.assertRaisesRegex(reading.ReadingError, "found 2 times"):
            self.resolve("## Section\n\nSame text.\n\n## Other\n\nSame text.\n", "Same text.")

    def test_source_quote_is_not_whitespace_normalised(self):
        with self.assertRaisesRegex(reading.ReadingError, "found 0 times"):
            self.resolve("## Section\n\nThe exact\nwords.\n", "The exact words.")

    def test_crlf_source_keeps_its_exact_newlines(self):
        self.path.write_bytes(b"## Section\r\n\r\nThe exact\r\nwords.\r\n")
        passage = {"id": "p", "quote": "The exact\r\nwords.", "anchor": {"heading": "Section", "block": 1}}
        _, passages = reading.resolve_markdown(self.path, "test", [passage])
        self.assertEqual(passages[0]["source_quote"], "The exact\r\nwords.")
        with self.assertRaisesRegex(reading.ReadingError, "found 0 times"):
            reading.resolve_markdown(self.path, "test", [{**passage, "quote": "The exact\nwords."}])

    def test_anchor_cannot_point_to_another_block(self):
        with self.assertRaisesRegex(reading.ReadingError, "outside its heading/block"):
            self.resolve("## Section\n\nFirst.\n\nSecond.\n", "Second.")

    def test_duplicate_headings_are_ambiguous(self):
        with self.assertRaisesRegex(reading.ReadingError, "resolves to 2 source blocks"):
            self.resolve("## Section\n\nFirst.\n\n## Section\n\nSecond.\n", "Second.")

    def test_no_nth_or_page_override(self):
        for extra in ({"nth": 1}, {"page": 1}):
            with self.subTest(extra=extra), self.assertRaisesRegex(reading.ReadingError, "not nth or page"):
                self.resolve("## Section\n\nOnce.\n", "Once.", **extra)

    def test_invalid_or_empty_anchors_fail(self):
        with self.assertRaisesRegex(reading.ReadingError, "positive integer"):
            self.resolve("## Section\n\nOnce.\n", "Once.", block=True)
        with self.assertRaisesRegex(reading.ReadingError, "found 0 times"):
            self.resolve("## Section\n\nOnce.\n", "")

    def test_markdown_formatting_is_rendered_without_rewording(self):
        source = "## Section\n\n`Foo.bar` accepts **every** proof with |x| ≤ n.\n"
        done, passages = self.resolve(source, "`Foo.bar` accepts **every** proof with |x| ≤ n.")
        built = reading.build_markdown(done, "test", passages, ["Foo.bar"], "https://example.org/guide.md")
        self.assertEqual(built["display_quotes"]["p"], "Foo.bar accepts every proof with |x| ≤ n.")
        self.assertIn('data-name="Foo.bar"', built["html"])
        self.assertNotIn("p", built["code"])
        self.assertEqual(self.path.read_text(), source)

    def test_rendered_collision_inside_one_block_fails(self):
        done, passages = self.resolve("## Section\n\nA **word** and a `word`.\n", "**word**")
        with self.assertRaisesRegex(reading.ReadingError, "rendered quote found 2 times"):
            reading.build_markdown(done, "test", passages, [], "https://example.org/guide.md")

    def test_qualified_names_cross_highlight_spans_but_not_code_elements(self):
        page = reading.parse('<code><span>Foo</span><span>.</span>bar</code> <code>Foo</code><code>.bar</code>')
        found = reading.names_in(page, ["Foo.bar"], [], None)
        self.assertEqual(len(found), 1)
        self.assertEqual(page.visible[found[0][0]:found[0][1]], "Foo.bar")

    def test_name_sections_cover_unnumbered_subheadings_and_exclude_others(self):
        source = ("## 1. Intro\n\nSee `Foo.bar`.\n\n## 3. Definitions\n\n### Details\n\nHere `Foo.bar` again.\n\n"
                  "## 4. Theorem\n\nIt holds.\n")
        done, passages = self.resolve(source, "It holds.", heading="4. Theorem")
        built = reading.build_markdown(done, "test", passages, ["Foo.bar"], "https://example.org/guide.md", ["3"])
        intro, rest = built["html"].split('id="s-3"')
        self.assertNotIn('data-name="Foo.bar"', intro)
        self.assertIn('data-name="Foo.bar"', rest.split('id="s-4"')[0])
        everywhere = reading.build_markdown(done, "test", passages, ["Foo.bar"], "https://example.org/guide.md")
        self.assertIn('data-name="Foo.bar"', everywhere["html"].split('id="s-3"')[0])

    def test_fenced_quote_stays_code_and_has_no_pdf_coordinates(self):
        done, passages = self.resolve("## Section\n\n```lean\ndef x_y : Nat := 0\n```\n", "def x_y : Nat := 0")
        built = reading.build_markdown(done, "test", passages, [], "https://example.org/guide.md")
        self.assertEqual(built["code"], {"p"})
        self.assertIsNone(passages[0]["page"])
        self.assertEqual(passages[0]["rects"], [])
        self.assertEqual(built["pages"], 0)
        self.assertNotIn('class="pg"', built["html"])

    def test_dotted_heading_links_use_reader_routes(self):
        source = "## 3. The definitions\n\n[Continue](#4-the-pcp-theorem).\n\n## 4. The PCP theorem\n\nIt holds.\n"
        done, passages = self.resolve(source, "It holds.", heading="4. The PCP theorem")
        built = reading.build_markdown(done, "test", passages, [], "https://example.org/guide.md")
        self.assertIn('href="./#/test/@s-4"', built["html"])
        self.assertEqual([e["id"] for e in built["outline"]], ["s-3", "s-4"])

    def test_companion_routes_stay_on_the_reader_with_a_remote_markdown_source(self):
        source = ("## Section\n\n[Companion](#/other), [Its section](#/other#2-the-test), "
                  "[Its declaration](#/other/Thing.name), [a mapped source](../other/main.md#3-its-result), "
                  "and [external](https://example.org/#/other).\n")
        done, passages = self.resolve(source, "Companion")
        built = reading.build_markdown(done, "test", passages, [], "https://example.org/guide.md", companions={"../other/main.md": "other"})
        for target in ("./#/other", "./#/other/@2-the-test", "./#/other/Thing.name", "./#/other/@3-its-result", "https://example.org/#/other"):
            self.assertIn(f'href="{target}"', built["html"])

    def test_an_indefinite_article_is_not_an_appendix_number(self):
        source = "## 2. Example\n\n### A first case\n\nIt holds.\n\n### A second case\n\nIt fails.\n\n## A. Appendix\n\nDetails.\n"
        done, passages = self.resolve(source, "It holds.", heading="A first case")
        built = reading.build_markdown(done, "test", passages, [], "")
        self.assertEqual([(e["id"], e["number"], e["title"]) for e in built["outline"][1:]], [
            ("s-a-first-case", "", "A first case"), ("s-a-second-case", "", "A second case"), ("s-A", "A", "Appendix")])
        self.assertEqual(built["heading_aliases"]["a-first-case"], "s-a-first-case")

    def test_active_html_after_a_code_fence_is_rejected(self):
        source = "## Section\n\n```lean\ndef x := 0\n```\n\nSafe words.\n\n<script>alert(1)</script>\n"
        done, passages = self.resolve(source, "Safe words.", block=2)
        with self.assertRaisesRegex(reading.ReadingError, "may not use <script>"):
            reading.build_markdown(done, "test", passages, [], "https://example.org/guide.md")

    def test_encoded_active_link_is_rejected(self):
        with self.assertRaises(reading.ReadingError):
            reading.check_tags('<a href="&#x6a;ava&#10;script:alert(1)">x</a>')


class StatementSheets(unittest.TestCase):
    def test_closure_is_leaves_first_with_prose_notes_and_boundary(self):
        decl = lambda name, keyword, statement, body=(), note=None: {
            "id": name, "keyword": keyword, "uses_statement": list(statement), "uses": list(statement) + list(body), "note": note}
        declarations = [decl("T", "theorem", ["B"], ["Proofonly"]), decl("B", "def", [], ["A"]), decl("A", "def", [], [], {"text": "ours"}),
                        decl("Proofonly", "def", [])]
        passages = [{"id": "p1", "lean": ["B"], "role": "explains", "code": False},
                    {"id": "p2", "lean": ["A"], "role": "uses", "code": False},
                    {"id": "p3", "lean": ["A"], "role": "defines", "code": True}]
        rows = {"T": {"type_dependencies": ["B", "Nat"], "value_dependencies": ["Proofonly", "Classical.choice"]},
                "B": {"type_dependencies": [], "value_dependencies": ["A", "List.map", "instHAdd"]},
                "A": {"type_dependencies": ["Nat"], "value_dependencies": []}, "Proofonly": {}}
        owner = lambda n: n if n in rows else None
        [sheet] = paper.statement_sheets([{"id": "c", "title": "C", "lean": ["T"]}], declarations, passages, {"rows": rows, "owner": owner})
        self.assertEqual([e["id"] for e in sheet["heads"]], ["T"])
        self.assertEqual([e["id"] for e in sheet["entries"]], ["A", "B"])
        self.assertEqual({e["id"]: e["reading"] for e in sheet["entries"]}, {"A": "note", "B": "authors"})
        self.assertEqual((sheet["explained"], sheet["total"]), (1, 2))
        self.assertEqual([b["name"] for b in sheet["boundary"]], ["List.map", "Nat"])


class MarkdownEdition(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.folder = self.root / "papers" / "example"
        (self.folder / "lean").mkdir(parents=True)
        (self.folder / "generated").mkdir()
        self.source = b"# Example\n\n## 1. Statement\n\nHere is `Demo.statement`.\n"
        (self.folder / "guide.md").write_bytes(self.source)
        (self.folder / "lean" / "lean-toolchain").write_text("fixture-only\n")
        (self.folder / "lean" / "Demo.lean").write_text("def statement : Prop := True\n")
        (self.folder / "generated" / "lean.json").write_text(json.dumps({
            "modules": ["Demo"], "lean_version": "synthetic test fixture",
            "declarations": [{"name": "Demo.statement", "module": "Demo", "kind": "definition", "type": "Prop",
                              "line": 1, "end_line": 1, "axioms": [], "type_dependencies": [],
                              "value_dependencies": [], "structural_dependencies": []}]}))
        (self.folder / "paper.toml").write_text(
            '[paper]\ntitle="Example"\nauthors=["Author"]\nmarkdown="guide.md"\nurl="https://example.org/guide.md"\n'
            '[lean]\nmodules=["Demo"]\n[shelf]\nexample="statement"\n')
        (self.folder / "links.json").write_text(json.dumps({
            "schema": 1, "claims": [{"id": "claim", "title": "Here is Demo.statement", "section": "1", "passage": "statement", "lean": ["Demo.statement"]}],
            "passages": [{"id": "statement", "section": "1", "role": "states", "quote": "Here is `Demo.statement`.", "lean": ["Demo.statement"], "anchor": {"heading": "1. Statement", "block": 1}}],
            "plain": {"Demo.statement": "The statement"}, "fidelity_held": "Synthetic test fixture, not a Lean check."}))
        self.stack = contextlib.ExitStack()
        self.addCleanup(self.stack.close)
        self.stack.enter_context(patch.object(paper, "PAPERS", self.root / "papers"))
        self.stack.enter_context(patch.object(paper, "PUBLIC", self.root / "public"))

    def test_build_skips_all_pdf_tools_preserves_bytes_and_removes_stale_pdf_assets(self):
        out = paper.PUBLIC / "example"
        out.mkdir(parents=True)
        (out / "paper.pdf").write_bytes(b"old PDF")
        (out / "first-page.png").write_bytes(b"old image")
        run = subprocess.run

        def only_node(args, **kwargs):
            self.assertEqual(args[0], "node", f"Markdown unexpectedly ran a PDF tool: {args}")
            return run(args, **kwargs)

        with patch.object(paper.subprocess, "run", side_effect=only_node), patch.object(paper, "pdf_words", side_effect=AssertionError("PDF read")), patch.object(paper, "ink_box", side_effect=AssertionError("PDF crop")):
            paper.build(["example"])
        self.assertEqual((out / "source.md").read_bytes(), self.source)
        self.assertFalse((out / "paper.pdf").exists())
        self.assertFalse((out / "first-page.png").exists())
        edition = json.loads((out / "edition.json").read_text())
        self.assertEqual(edition["source"]["sha256"], hashlib.sha256(self.source).hexdigest())
        self.assertIsNone(edition["paper"]["crop"])
        self.assertEqual(edition["paper"]["sizes"], [])
        self.assertEqual(edition["passages"][0]["quote"], "Here is Demo.statement.")
        self.assertEqual(edition["passages"][0]["source_quote"], "Here is `Demo.statement`.")
        self.assertEqual(edition["shelf"]["example"]["page_label"], "")
        self.assertEqual(json.loads((paper.PUBLIC / "index.json").read_text())["papers"][0]["source_kind"], "markdown")

    def test_build_copies_local_markdown_image_beside_reading_html(self):
        name = "assets/figure.png"
        image = b"\x89PNG\r\n\x1a\nfixture"
        (self.folder / "assets").mkdir()
        (self.folder / name).write_bytes(image)
        (self.folder / "guide.md").write_bytes(self.source + f"\n![A proof map]({name})\n".encode())

        paper.build(["example"])

        out = paper.PUBLIC / "example"
        self.assertEqual((out / name).read_bytes(), image)
        self.assertIn(f'src="papers/example/{name}"', (out / "reading.html").read_text())
        edition = json.loads((out / "edition.json").read_text())
        self.assertEqual(edition["source"]["images"], {name: hashlib.sha256(image).hexdigest()})

    def test_missing_or_escaping_markdown_image_fails_check(self):
        source = self.source + b"\n![A proof map](assets/missing.png)\n"
        (self.folder / "guide.md").write_bytes(source)
        with self.assertRaisesRegex(paper.PaperError, "image is missing"):
            paper.edition("example")

        (self.folder / "guide.md").write_bytes(self.source + b"\n![A proof map](../outside.png)\n")
        (self.folder.parent / "outside.png").write_bytes(b"outside")
        with self.assertRaisesRegex(paper.PaperError, "image path must stay within"):
            paper.edition("example")

        (self.folder / "assets").mkdir()
        (self.folder / "assets" / "escape.png").symlink_to(self.folder.parent / "outside.png")
        (self.folder / "guide.md").write_bytes(self.source + b"\n![A proof map](assets/escape.png)\n")
        with self.assertRaisesRegex(paper.PaperError, "image path escapes"):
            paper.edition("example")

    def test_source_read_lean_data_is_labelled_and_unknown_provenance_fails(self):
        report = json.loads((self.folder / "generated" / "lean.json").read_text())
        report["provenance"] = {"kind": "source-read", "text": "Read from the source by hand."}
        (self.folder / "generated" / "lean.json").write_text(json.dumps(report))
        built = paper.edition("example")
        self.assertEqual(built["lean"]["provenance"]["kind"], "source-read")
        report["provenance"] = {"kind": "kernel"}
        (self.folder / "generated" / "lean.json").write_text(json.dumps(report))
        with self.assertRaisesRegex(paper.PaperError, "unknown provenance"):
            paper.edition("example")

    def test_extracted_lean_data_defaults_to_lean_provenance(self):
        self.assertEqual(paper.edition("example")["lean"]["provenance"], {"kind": "lean"})

    def test_passage_only_declarations_and_axiom_reports_in_a_mixed_edition(self):
        path = self.folder / "generated" / "lean.json"
        report = json.loads(path.read_text())
        report["provenance"] = {"kind": "source-read"}
        cases = {"statement": ("statement-compiled", []), "unextracted": (None, []),
                 "built": ("lean", []), "standard": ("lean", ["propext"]), "admitted": ("lean", ["sorryAx"])}
        template = report["declarations"][0]
        report["declarations"] = [
            {**template, "name": f"Demo.{name}", "kind": "theorem", "line": line,
             "end_line": line, "provenance": provenance, "axioms": axioms}
            for line, (name, (provenance, axioms)) in enumerate(cases.items(), start=1)]
        path.write_text(json.dumps(report))
        (self.folder / "lean" / "Demo.lean").write_text("".join(f"theorem {name} : True := by trivial\n" for name in cases))
        links_path = self.folder / "links.json"
        links = json.loads(links_path.read_text())
        links["passages"][0]["lean"] = [f"Demo.{name}" for name in cases]
        links["plain"].update({f"Demo.{name}": f"The {name} result" for name in cases})
        links_path.write_text(json.dumps(links))
        built = paper.edition("example")
        self.assertEqual({d["id"]: d["passages"] for d in built["declarations"]}, {f"Demo.{name}": ["statement"] for name in cases})
        self.assertEqual(built["analytics"]["free_of_axioms"], ["Demo.built"])
        self.assertEqual(built["analytics"]["standard_axioms"]["propext"], ["Demo.standard"])
        self.assertEqual(built["analytics"]["sorry"], ["Demo.admitted"])

    def test_companion_can_read_a_shared_lean_project(self):
        shared = self.root / "papers" / "shared" / "lean"
        shared.parent.mkdir()
        (self.folder / "lean").rename(shared)
        config = (self.folder / "paper.toml").read_text()
        (self.folder / "paper.toml").write_text(config.replace(
            '[lean]\nmodules=', '[lean]\nproject="../shared/lean"\nmodules='))
        built = paper.edition("example")
        declaration = built["declarations"][0]
        self.assertEqual(declaration["file"], "lean/Demo.lean")
        self.assertEqual(built["lean"]["files"][declaration["file"]],
                         "def statement : Prop := True\n")
        self.assertEqual(built["lean"]["toolchain"], "fixture-only")

    def test_source_config_is_explicit_and_exclusive(self):
        for config in ({"paper": {}}, {"paper": {"pdf": "paper.pdf", "markdown": "guide.md"}}):
            with self.subTest(config=config), self.assertRaisesRegex(paper.PaperError, "exactly one"):
                paper.paper_source(self.folder, config)
        source = paper.paper_source(self.folder, {"paper": {"markdown": "guide.md"}})
        self.assertEqual(source["kind"], "markdown")

    def test_pdf_figure_crops_cannot_leak_into_markdown(self):
        with self.assertRaisesRegex(paper.PaperError, "crops require a PDF"):
            paper.paper_source(self.folder, {"paper": {"markdown": "guide.md"}, "reading": {"figure": [{"name": "old.svg"}]}})


if __name__ == "__main__":
    unittest.main()
