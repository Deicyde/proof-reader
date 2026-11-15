# Proof Reader

[Will Cook’s home page: all projects and videos](https://wcook04.github.io/)

Proof Reader displays a research paper beside its proof in
[Lean](https://lean-lang.org), a language for writing mathematical statements
and proofs that a computer can check. Click a linked statement in the paper to
open the authors' corresponding Lean code. You can also explore a diagram of
the proof steps and the connections between them.

**[Read a paper in it](https://wcook04.github.io/proof-reader/#/contextual-embeddings)**: *Contextual Embeddings* by Frohlich, Foster, Kavvos and Wang (PLDI 2026), shown with the authors' Lean under CC BY 4.0. The links and comparisons between the paper and the Lean were made with AI and have not been reviewed by the authors.

[![A paper on the left page with one sentence highlighted, and on the right the graph of its Lean proof above the exact Lean lines the sentence describes.](web/public/reader.webp)](https://wcook04.github.io/proof-reader/#/contextual-embeddings)

For a specific example, [open a paragraph and its five linked lines of Lean](https://wcook04.github.io/proof-reader/#/contextual-embeddings/@isoR-clam),
linked to Lean lines 217 to 221.

The PCP collection contains a [detailed argument](papers/pcp-full-argument/paper.md),
a [specialist paper](papers/pcp-specialist/paper.md), and a [worked exposition](papers/pcp-exposition/paper.md).
In the reader these use the routes `#/pcp-full-argument`, `#/pcp-specialist`,
and `#/pcp-exposition`; Troy Lee's [original reading guide](papers/pcp-reading-guide/guide.md)
remains at `#/pcp-reading-guide`. The algebraic proof is due to Amireddy,
Behera, Srinivasan, Sudan and Willumsgaard; Lee wrote the Lean formalization.
AI agents wrote the three explanations under Will Cook's direction.

On a desktop, the paper is on the left and the proof diagram is on the right.
As you scroll, the diagram highlights the step linked to the passage you are
reading. Click a statement or diagram card to see its Lean code. Use **Back**
to return to the diagram without losing your place, or the **Graph / Lean**
toggle to choose what stays beside the paper.

Citations and figures open beneath the paragraph that mentions them. Each
linked statement has its own address, so you can send someone directly to it.
The contents also include an index of named Lean definitions and theorems
(called **declarations**), with the assumptions each proof uses (**axioms**).

For PDF papers, a program checks the reading copy against extracted text, and the original PDF
is one click away. Markdown-source pages render their supplied text directly and check each
linked quote against its exact source heading and block. Declaration titles, links, notes and
comparisons are marked as AI-made and not reviewed by the authors. Comparisons can be held;
where one cites a Lean check written for the page, the check and its reported axioms are shown.

Evidence differs by page. Some declaration data comes from Lean's report on compiled modules.
The PCP companions reuse the original guide's retained interface extraction, including a
statement-only compilation of the headline theorem. Their other selected declarations are
source-read: proof-use dependencies and axiom reports have not been extracted for those
declarations, and comparisons are held. The [source review](papers/pcp-full-argument/source-review.md)
records the source pin and hashes. Neither a source link nor a correspondence check establishes
that the prose and Lean have the same meaning.

## Run the site

Use Python 3.11 or later, Node 20.19 or later, and [Poppler](https://poppler.freedesktop.org/)
(`brew install poppler` on macOS; `sudo apt-get install poppler-utils` on Ubuntu).
From a fresh clone:

```sh
git clone https://github.com/wcook04/proof-reader.git
cd proof-reader
cd web
npm ci
cd ..
python3 tools/paper.py build
cd web
npm run dev
```

Open the address it prints and choose a paper. The paper build creates the data the site needs
from checked-in declaration records, so reading the existing papers does not require Lean.
After changing a paper's files, run `python3 tools/paper.py build`
again from the repository root.

From `web/`, `npm run build` writes a static site to `web/dist`.
`npm run preview` serves that build locally. If you set `VITE_BASE_PATH` for
the build, use the same setting for the preview. For example, a build made with
`VITE_BASE_PATH=/proof-reader/ npm run build` needs
`VITE_BASE_PATH=/proof-reader/ npm run preview`.

To test the reading controls in a real browser, build the site and run the
browser test script. It needs Playwright for Python, and takes `--browser firefox` or `webkit` as well:

```sh
cd web && VITE_BASE_PATH=/proof-reader/ npm run build && cd ..
python3 tests/journey.py --shots /tmp/journey
```

`tests/speed.py` measures a paper's first screen on a home connection.

`tools/capture_images.py` retakes the social card, the picture above and the front page's two pictures of the reader from a running site.

## Add a paper

To add a paper, create a folder containing its PDF or Markdown source, the Lean project,
and links between passages and Lean statements. For a PDF, provide a reading copy as well.
The build command turns those files into pages for the website.

```
papers/<slug>/
  paper.pdf      the authors' PDF, unchanged, for a PDF source
  paper.md       a PDF reading copy, or the supplied Markdown source
  paper.toml     title, authors, licences and the Lean modules to read
  lean/          the authors' Lean project, unchanged
  links.json     which passage goes with which declaration, plain titles, notes and comparisons
  checks/        optional Lean files of ours that test a statement against the authors' Lean
  generated/     recorded declaration data and its provenance, plus any compiled checks
```

The [add-paper guide](skills/add-paper/SKILL.md) gives the PDF procedure for a
person or an AI assistant. For a Markdown source, set `[paper] markdown` in
`paper.toml`; `links.json` identifies exact unique quotations with a heading and
block anchor. Source-read declarations must be labelled as such. Comparisons may
be held with `fidelity_held`, in which case the page does not present them. The
`[reading.companions]` table maps relative Markdown paths to other reader editions,
for example `"../companion/paper.md" = "companion"`. Links to those paths open the
companion, and a heading fragment opens the corresponding section.

The PDF commands are:

```sh
python3 tools/paper.py new my-paper       # then add the PDF, Lean and paper.toml
python3 tools/paper.py extract my-paper   # build the Lean, list its declarations, compile checks/
python3 tools/transcribe.py my-paper      # draft paper.md from the PDF's structure
# define a result under claims in links.json, with its passage and Lean declaration
python3 tools/paper.py check my-paper     # compare the text and check the links
python3 tools/paper.py build              # write the data the site reads
```

`extract` needs [elan](https://github.com/leanprover/elan), the Lean installer,
and uses the Lean version specified by the paper's authors. `check` and `build` need Python 3.11 and Poppler, and, for
a paper with a `paper.md`, Node with `npm ci` run in `web/`. `transcribe.py` also
needs `pypdf`. The authors' code runs on your machine, so read a project you do not
trust before extracting it.

## What `paper.py check` establishes

For a PDF, the command compares the reading copy with extracted text. It skips the top
7.5% and bottom 5.5% of each page, repeated headers and footers, bullet marks, and words
inside figure crops. The figures themselves are copied from the PDF.

It treats some typographic differences as equivalent, such as ligatures and line-break
hyphens, and allows text blocks to move. These allowances can also let changes in word
or character order pass. The check helps find transcription errors; a pass does not
certify an exact copy. Review the reading copy alongside the original PDF.

For Markdown, it checks exact source quotations and heading/block anchors; it does not compare
against a PDF. For both source types, it confirms that every quotation appears exactly once, that exact Lean lines lie
inside their declaration and that every Lean name exists. No program confirms that a sentence is
about the code it is linked to: a person has to read both. Names printed in the paper are linked
by matching the name alone, so `STLC` in the paper's Haskell opens the Lean `STLC`. Lean reports
what a proof depends on, and does not report whether a Lean statement means what the paper says.

When comparisons are provided, each claimed result and relevant author axiom carries a comparison:
the Lean says the same as the paper, more, less, or something different. `check` stops if one is
missing unless comparisons are explicitly held for the page.
A comparison is AI judgement. Where it cites a check, the check is a Lean file of ours under
`papers/<slug>/checks/`, compiled by `extract` against the authors' Lean, with the axioms Lean
reports for it. `check` stops if a check file has changed since `extract` compiled it. Each page
says that the links, notes and comparisons have not been reviewed by the authors, until an author
has reviewed them.

## Repository map

Authored paper files and checked-in declaration records live under `papers/`.
`tools/paper.py build` turns them into `web/public/papers/`. The website build
command then packages them with the application in `web/dist/`. Both output directories are ignored by Git:
change their sources and rebuild them.

| Source | What it holds |
| --- | --- |
| [papers/](papers/) | One folder for each paper |
| [skills/add-paper/](skills/add-paper/) | How to fill in a new paper |
| [tools/paper.py](tools/paper.py) | Extract the Lean, compare with the PDF and build the data |
| [tools/transcribe.py](tools/transcribe.py) | Draft a paper's reading text from its PDF |
| [tools/reading.py](tools/reading.py) | Compare the reading copy with the PDF and mark its linked statements |
| [render-paper.mjs](web/tools/render-paper.mjs) | Typeset `paper.md` with Markdown and KaTeX |
| [extract.lean.template](tools/extract.lean.template) | The Lean program that lists a project's declarations |
| [web/](web/) | The website |
| [web/src/map/](web/src/map/) | The map, copied from [lean-exposition](https://github.com/wcook04/lean-exposition) |
| [history.ts](web/src/app/history.ts) | Saved reading position and open statements for the Back button |
| [web/src/lean/](web/src/lean/) | Code for displaying and colouring Lean source |
| [web/src/proof/](web/src/proof/) | The proof diagram and Lean panel beside the paper |
| [check-source.mjs](web/tools/check-source.mjs) | Find source files that the application and tools do not use; run with `npm run check:source` in `web/` |
| [tests/](tests/) | Python unit tests and the browser [journey](tests/journey.py) |
| [Pages workflow](.github/workflows/pages.yml) | Check every paper, build the site and publish to GitHub Pages |

## Related work and videos

[Introduction to the projects](https://www.youtube.com/watch?v=FwgaZYH2otY) · [Proof Reader short](https://www.youtube.com/watch?v=LZxaDZ-gQm8) · [Full comparison of the three maths readers](https://www.youtube.com/watch?v=ZE9thkr5jew)

[Lean Exposition](https://github.com/wcook04/lean-exposition) contains writing guides and tools for explaining a Lean proof in three papers
with different levels of detail. Its
[reading website](https://wcook04.github.io/lean-exposition-site/) presents those draft
explanations beside the graph; [this video walks through that site](https://www.youtube.com/watch?v=sYMDcT7vyng).
For PDF papers, Proof Reader's reading copy keeps the original paper's wording.

## Licence

Code is Apache-2.0; see [LICENSE](LICENSE) and [NOTICE](NOTICE). Each paper and Lean
project keeps its own licence and credit, named in its `paper.toml` and on its page.

Proof Reader is one of Will Cook's sites. Find the other websites and code on
[Will's home page](https://wcook04.github.io/), and the [project videos](https://wcook04.github.io/#videos).
