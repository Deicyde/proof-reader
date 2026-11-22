# The adapted edition's Lean statements

One Lean statement for each numbered result of the adapted edition of Alpöge, Buckmaster and
Coiculescu's *Finite-Time Singularity Formation for the Three-Dimensional Euler Equations*, written
to match the edition's wording, with a docstring in the paper's words. Each is proved by
reduction to the authors' Lean formalization at
[`fd3a158`](https://github.com/mcoiculescu/EulerBlowupPublic/tree/fd3a1588967810b9abe42a1dcf46ee662d6434e2);
the authors' library is not re-proved or changed. The mathematics and the formalization it
rests on are the authors'.

- `Adapted/S1.lean` … `Adapted/SD.lean`, `Adapted/Auxiliary.lean`: one file per section; the
  helper files (`Norms`, `RealPowers`, `ActiveRelay*`) state shared definitions once.
- `Adapted.lean` imports them all; `VerifyAdapted.lean` checks every name, kind and axiom set.
- `TARGETS.json` / `TARGETS.md`: for each of the 42 numbered results, whether it is proved and
  from which of the authors' declarations, or left as a named open target with the reason.

Theorem 1.1 is stated in its global form (existence, every blow-up property and uniqueness of
the maximal solution) against the definitions of the authors' `Statement.lean`, and is proved
from their `Paper.theorem_1_1`. All 42 results are proved. Theorem 7.1 reruns the authors' construction proof (their Section 6 to 8 library)
with its conclusions extended: their local proofs establish that the central covector is the transported
covector of the same step and that the first wave is the prescribed one of (6.3), and the rerun keeps both.
The copied proof text is the authors', in the namespace `TorusEuler.Paper.Lib.S678a.AdaptedS7`.

`.github/workflows/euler-adapted-lean.yml` builds the layer against the authors' project on
public CI, checks that every proof uses only `propext`, `Classical.choice` and `Quot.sound`, and
judges the adapted Theorem 1.1 with Comparator (five kernels) together with two controls that
must be rejected; `receipt.json` records the run.
