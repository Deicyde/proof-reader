# Our Lean checks against the authors' package

Lean files of ours that import the authors' package at `fd3a158` and add statements beside
theirs. They change none of the authors' files. Both were written by an AI review (round two,
f7) and are compiled by [`euler-checks.yml`](../../../.github/workflows/euler-checks.yml).

- `ClosedSlabSetting.lean`: the opening paragraph of Section 8 also states that the velocities
  converge uniformly on the closed slab to a continuous field. `Text.section8_setting` states
  only the construction. This packages the authors' `Paper.Lib.S678b.closedSlab_velocity_limit`
  as that statement, using Proposition 8.1.
- `TransverseUnique.lean`: Lemma 5.3 (ii) bounds a transverse solution assumed to exist. This
  states the authors' existence and uniqueness of that solution as `∃!` and joins it to Lemma 5.3.

**Result.** [Run 44887791276](https://github.com/wcook04/proof-reader/actions/runs/44887791276)
compiled both files against the authors' package at `fd3a158` with
`-DautoImplicit=false -DrelaxedAutoImplicit=false -DwarningAsError=true`. All five theorems
(`ReviewF7.closedSlabLimit_of_theorem71`, `ReviewF7.closedSlabSetting_of`,
`ReviewF7.closedSlabSetting`, `TorusEuler.Paper.Fidelity.transverseSolution_existsUnique`,
`TorusEuler.Paper.Fidelity.lemma_5_3_with_unique_transverse_solution`) depend only on
`propext`, `Classical.choice` and `Quot.sound`.
