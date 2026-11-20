# Task: does each Lean declaration state exactly the rule in its passages?

This folder holds everything you may use. Do not read, list or search anything outside this folder.
Do not use the network. If you recognise the Lean code from somewhere, say so in your notes and
do not use that memory.

## Inputs

- `lean/Spec/`: a Lean 4 formalisation of the lexicon and grammar of the SMT-LIB 2 standard.
- `passages.jsonl`: the standard, versions 2.0, 2.5, 2.6 and 2.7, split into numbered passages.
- `items.json`: each item names one declaration in `lean/Spec/` and the passages of the standard
  it is meant to state.

Some declarations may state their passages exactly. Some may differ from them, either by
accident or because whoever wrote the Lean chose a reading of their own. You are not told which.

## What to produce

Write `out/answers.json`: a JSON list with one record per item:

```json
{
  "item": "item-01",
  "verdict": "exact | differs | unsure",
  "difference": "",
  "evidence": ""
}
```

- `verdict`: `exact` when the declaration accepts exactly what the passages allow, for the
  version the passages come from; `differs` when it accepts something the passages exclude or
  excludes something they allow; `unsure` when you cannot tell.
- `difference`: when it differs, the input or case that is treated differently, stated
  concretely (for example "accepts `0012` as a numeral"), and which side allows it.
- `evidence`: the line of Lean and the words of the passage you compared.

Read the definitions the declaration uses as well as the declaration itself. Judge each item on
its own. When you are done, check that the file is valid JSON with one record per item.
