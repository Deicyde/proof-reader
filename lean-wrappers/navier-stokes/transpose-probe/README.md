# Why Comparator rejected `transposeApply` in the readable cell file

**Finding.** The readable cell file and the library define the same
`transposeApply` and state the same three cell theorems over the same 1,923
definitions. The only difference behind the Comparator rejection is the name
of one auxiliary proof that Lean generates during elaboration; no
mathematical statement changes.

When Comparator judged the authors' standalone readable file
`CellLayerChallenge.lean` against the library, it stopped with
"Const does not match between challenge and target
'Breakdown.AdjointDefect.transposeApply'" (Actions run
[44819023135](https://github.com/wcook04/proof-reader/actions/runs/44819023135)).
The two source definitions are byte-identical
(`CellLayerChallenge.lean` lines 3521 to 3522 and
`Breakdown/CertCell/StatementDefs.lean` lines 2717 to 2718):

```lean
def transposeApply (K : Space →L[ℝ] Space) (z : Space) : Space :=
  ∑ i : Fin 3, inner ℝ (K (unitVector i)) z • unitVector i
```

## What the probes show

Run [44963653045](https://github.com/wcook04/proof-reader/actions/runs/44963653045)
printed the elaborated constant, with every implicit argument, once in a Lean
process that imports only `CellLayerChallenge` and once in a process that
imports only `Breakdown.CertCell.StatementDefs` (`ClosureReadable.lean`,
`ClosureLibrary.lean`, `ClosureDump.lean`). Compared field by field
(`compare_closure.py`):

- the types are identical, and so are the reducibility hints (`regular 45`)
  and the universe parameters;
- the values differ at exactly one subterm. Inside the instance arguments of
  `inner` the Euclidean space carries its exponent, the numeral `2 : ℝ≥0∞`
  of `EuclideanSpace ℝ (Fin 3) = PiLp 2 _`. That numeral is built from a proof
  of `Nat.AtLeastTwo (1 + 1)`. Lean abstracts such nested proofs into
  auxiliary theorems and reuses an earlier one of the same module with the
  same statement. The readable file defines `traceFreeConst := √(7/2)` near
  its top (line 187), so its first such theorem is
  `Breakdown.CellCert.Exterior.traceFreeConst._proof_2`. In the library
  `traceFreeConst` lives in another module, and the first such theorem of
  `StatementDefs` belongs to `labelPhase` (line 937):
  `Breakdown.CertCell.labelPhase._proof_1`;
- the two auxiliary theorems have the same statement and the same proof, and
  after renaming that one constant the two values are identical.

Comparator compares the constants by name and structure, so the different
auxiliary name is enough for a rejection. The kernel would accept the two
definitions as equal (the differing subterms are proofs of the same
proposition), and nothing in the meaning of `transposeApply`, the transpose
`Kᵀz`, depends on the name.

## The whole cell statement closure

Comparator stops at the first mismatch, so the run also compared every
constant of the `Breakdown` namespace that the statements of the three cell
theorems use (`StmtReadable.lean`, `StmtLibrary.lean`, `compare_stmt.py`;
run [44964522151](https://github.com/wcook04/proof-reader/actions/runs/44964522151)).
Inside Lean each auxiliary proof constant was replaced by a name made from the
hash of its statement. With that one normalization, all 1,923 constants agree
in kind, universe parameters, type, value and reducibility hints, and neither
environment has a constant the other lacks. So the readable file states the
same three cell theorems, over the same definitions, as the library; the
remaining differences are names of auxiliary proofs.

The accepted cell comparison (`comparator-cell-layer.json`, which uses
`CellLayerTheorems` and the library's definitions) is a separate check and is
unchanged.

## Files

| File | Purpose |
|---|---|
| `DumpSupport.lean`, `ProbeReadable.lean`, `ProbeLibrary.lean`, `transpose_names.txt`, `compare_probe_dumps.py` | The outside review's probes, unchanged. Both probes stop with an error at their own reference formula, because `_root_.inner` is not a name in this Mathlib (`inner` is exported from `Inner`), so their reflexivity check did not run; their `#print` output is still recorded in the run artefact. |
| `ClosureDump.lean` | `#dump_closure` (full constant data, including hints and safety) and `#dump_statement_hashes` (normalized hashes of a statement closure). |
| `ClosureReadable.lean`, `ClosureLibrary.lean` | Closure of `transposeApply` and of `matrixDivergence` in each environment. |
| `StmtReadable.lean`, `StmtLibrary.lean` | Statement closure of the three cell theorems in each environment. |
| `compare_closure.py`, `compare_stmt.py` | The comparisons. |

The workflow is `.github/workflows/navier-stokes-transpose-probe.yml`. It
edits no author file.
