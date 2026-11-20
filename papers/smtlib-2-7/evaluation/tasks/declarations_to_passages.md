# Task: find the passages of the SMT-LIB standard that each Lean declaration formalises

This folder holds everything you may use. Do not read, list or search anything outside this folder.
Do not use the network. If you recognise the Lean code from somewhere, say so in your notes and
do not use that memory.

## Inputs

- `lean/Spec/`: a Lean 4 formalisation of the lexicon and grammar of the SMT-LIB 2 standard, with
  the expected behaviour of a lexer, a parser and a reader.
- `declarations.json`: every declaration written in those files, one record each, with its `id`.
- `passages.jsonl`: the standard, versions 2.0, 2.5, 2.6 and 2.7, split into numbered passages.
  Each line has an `id` such as `2.7-p025-09`, the version, the PDF page, the section, the run-in
  heading, the kind (`prose`, `production`, `example`, `footnote`), the Appendix B or inline
  grammar rule it states (`production`), and the exact `text`.

## What to produce

Write `out/declarations.json`: a JSON list with exactly one record for every declaration in
`declarations.json`, in any order:

```json
{
  "id": "Spec.Lexicon.keyword",
  "kind": "syntax_definition | representation | derived_property | operational_model | unclear",
  "matches": [
    {"passage": "2.7-p025-21", "relation": "defines | uses | version_difference"}
  ],
  "tension": null,
  "notes": ""
}
```

- `kind`: `syntax_definition` states a rule of the standard's lexicon or grammar; `representation`
  is a data type or helper that carries syntax without itself stating a rule; `derived_property`
  is a proposition about the formalisation; `operational_model` describes how a lexer, parser or
  reader behaves, which the standard mostly does not specify.
- `matches`: the passages this declaration formalises (`defines`), or depends on without
  formalising (`uses`), or needs because the formalisation depends on a difference between
  versions (`version_difference`, citing the passage of the other version). Use the 2.7 passage
  where the rule did not change. Cite only passage ids from `passages.jsonl`. Prefer few, exact
  passages over many approximate ones: a wrong passage counts against you. An empty list is a
  valid answer.
- `tension`: `null`, or `{"passages": [ids], "description": "..."}` when the standard is silent,
  ambiguous, self-contradictory, or different between versions on exactly the choice this
  declaration makes, so its authors had to decide. Point at the passages that show it. Flag only
  tension you can show in the text.
- `notes`: anything you were unsure of, in one or two sentences.

Read the Lean and the passages properly; do not decide from names alone. When you are done,
check that the file is valid JSON, that it has one record per declaration id, and that every
passage id exists.
