# What the checks show

Programs test the text, the links and the Lean on every page. None of them shows that a
sentence of the paper means the same as the Lean it is linked to: a person has to read both.
This page lists what each program establishes and where it stops.

## The reading copy of a PDF

`paper.py check` compares the reading copy with text extracted from the PDF. It skips the
top 7.5% and bottom 5.5% of each page, repeated headers and footers, bullet marks, and words
inside figure crops. The figures themselves are copied from the PDF.

It treats some typographic differences as equal, such as ligatures and line-break hyphens,
and it allows blocks of text to move. These allowances can also let a change in the order
of words or characters pass. A pass helps find transcription errors; it does not establish
an exact copy. Read the reading copy against the original PDF, and read code listings by
eye, including side-by-side columns. The original PDF is one click away on the page.

For a Markdown paper there is no PDF to compare. `check` confirms each linked quotation
against its exact heading and block in the source.

## Links between the paper and the Lean

For both kinds of source, `check` confirms that every quotation appears exactly once, that
any exact Lean lines lie inside their declaration, and that every Lean name exists. A
missing quotation or name stops the build. Names printed in the paper are linked by
matching the name alone, so `STLC` in the paper's Haskell opens the Lean `STLC`.

## Lean's own report

For declarations taken from Lean's report on compiled modules, the page shows what each
declaration uses and the axioms Lean reports for it. Lean reports what a proof depends on;
it does not report whether a Lean statement means what the paper says.

Evidence differs by page:

- *Contextual Embeddings*: `paper.py extract` compiled the authors' project with Lean
  4.16.0, the version the authors name, and the declaration data is Lean's output.
- The three PCP companions: Lean compiled the listed modules of Troy Lee's project in a
  GitHub Actions run ([pcp-extract.yml](../.github/workflows/pcp-extract.yml)), and every
  declaration's dependencies and axiom report come from that run. Troy Lee's original
  reading guide keeps an earlier extraction, with a statement-only compilation of the
  headline theorem. The [source review](../papers/pcp-full-argument/source-review.md)
  records the source commit and file hashes.
- The coupled spring page: Lean 4.35.0 compiled two unchanged PhyslibAlpha modules, and
  our supplementary proofs were compiled against them
  ([coupled-spring-extract.yml](../.github/workflows/coupled-spring-extract.yml)).

## Comparisons of a statement with its Lean

Where a page has comparisons, each stated result and each relevant author axiom says
whether the Lean states the same as the paper, more, less, or something different. The
comparisons are AI judgements, and each page says that the links, notes and comparisons
have not been reviewed by the paper's authors.

A comparison can cite a check: a Lean file of ours under `papers/<slug>/checks/`, compiled
against the authors' Lean by `paper.py extract`, with the axioms Lean reports for it. The
page shows the file and those axioms. `check` stops if a check file has changed since
`extract` compiled it. Sentence-by-sentence comparisons have not been written for the PCP
pages.

## Comparator runs

[Comparator](https://github.com/leanprover/comparator) tests whether a proof proves a
separately written challenge statement. Comparator accepted Troy Lee's proofs of the
three PCP headline statements in one run, and Bjørn Kjos-Hanssen's proof of one coupled
spring statement in another. Each run also includes a control that Comparator rejected.

When a page shows a run, the build reads each configured theorem's statement and its lines
from `Challenge.lean`, and links the run's files at the commit it builds. The build stops if
a file's SHA-256 differs from `receipt.json`, if the challenge has no theorem of a configured
name, or if the receipt does not record both an accepted run and a rejected control. Each
declaration in the run then has a closed "Comparator evidence" fold beneath its axiom
report. Comparator tests a proof against the challenge statement; it does not test whether
that statement means what the paper says.
