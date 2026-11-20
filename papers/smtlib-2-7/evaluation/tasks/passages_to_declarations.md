# Task: for each passage of the SMT-LIB 2.7 standard, find the Lean declarations that formalise it

This folder holds everything you may use. Do not read, list or search anything outside this folder.
Do not use the network. If you recognise the Lean code from somewhere, say so in your notes and
do not use that memory.

## Inputs

- `lean/Spec/`: a Lean 4 formalisation of the lexicon and grammar of the SMT-LIB 2 standard, with
  the expected behaviour of a lexer, a parser and a reader.
- `declarations.json`: every declaration written in those files, one record each, with its `id`.
- `passages.jsonl`: the standard, versions 2.0, 2.5, 2.6 and 2.7, split into numbered passages
  with their version, PDF page, section, run-in heading, kind, grammar rule and exact text.
- `eligible_passages.json`: the ids of the 2.7 passages you must answer for: every prose passage
  and grammar rule in chapter 3 and Appendix B.

## What to produce

Write `out/passages.json`: a JSON list with exactly one record for every id in
`eligible_passages.json`, in any order:

```json
{
  "passage": "2.7-p025-21",
  "status": "formalised | partly_formalised | not_formalised | not_a_rule",
  "targets": [
    {"id": "Spec.Lexicon.keyword", "relation": "defines | checks | uses"}
  ],
  "notes": ""
}
```

- `status`: `formalised` when the Lean states the passage's rule; `partly_formalised` when it
  states some of it (say which part in `notes`); `not_formalised` when the passage states a rule
  that no declaration states; `not_a_rule` when the passage states no syntactic rule (an
  introduction, a motivation, a semantic or operational matter). If you cannot tell, use
  `not_formalised` and say why in `notes`.
- `targets`: the declarations that state the rule (`defines`), check something against it
  (`checks`), or depend on it (`uses`). Cite only ids from `declarations.json`. Prefer the
  declaration that states the rule over everything that mentions it: a wrong target counts
  against you. An empty list is a valid answer.
- `notes`: anything you were unsure of, in one or two sentences.

Read the passages and the Lean properly; do not decide from names alone. When you are done,
check that the file is valid JSON, that it has one record per eligible id, and that every
declaration id exists.
