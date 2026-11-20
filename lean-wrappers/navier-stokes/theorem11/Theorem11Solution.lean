import Theorem11Challenge
import SpaceCore
import SmoothReadings
import Theorem11PhysicalBridges

/-!
Implementation of the deliberately named weaker endpoints; compiler status below.
Authoring status: NOT COMPILED.

There is no declaration `Theorem11.theorem11Space` or
`Theorem11.theorem11Torus` in this file: those names are reserved for proofs
of the full physical contracts. The main Comparator plan targets those names
and must fail until they genuinely exist.
-/

open MeasureTheory Set Real
open scoped ContDiff ENNReal

noncomputable section

namespace Theorem11

/-- Same-profile, arbitrary-tolerance quantitative construction in the
library's concrete frequency space, with local smooth physical readings. -/
theorem theorem11SpaceCore (W : Velocity) (q : Pressure) (P : ℝ)
    (R : Space ≃ₗᵢ[ℝ] Space) (A : ℝ) (h : IsLibraryProfile W q P R A)
    (ε : ℝ) (hε : 0 < ε) : Nonempty (Theorem11Core.SpaceWitness W ε) := by
  have hs := libraryProfile_to_similarity h
  rcases h with ⟨hP, _, _, _, _, hper, hn, _, _⟩
  exact Theorem11Core.space_core W q P R A hP hs hper hn ε hε

/-- A physical weaker endpoint: one compact datum, arbitrarily close to the
selected profile, admits a smooth finite-energy solution on each compact
subinterval before time one. The energy constant may depend on that interval.
This does not assert the full physical blow-up or convergence theorem. -/
theorem theorem11SpaceLocal : Theorem11SpaceLocal := by
  intro W q P R A h ε hε
  obtain ⟨d⟩ := theorem11SpaceCore W q P R A h ε hε
  refine ⟨d.datum, d.datum_test.1, d.datum_test.2.1, d.datum_test.2.2,
    d.initial_gradient_finite, d.initial_gradient_close, ?_⟩
  intro T hT hT1
  obtain ⟨U, p, hs, hi, hE, _, _⟩ := d.local_physical T hT hT1
  exact ⟨U, p, smooth_before_of_library hs hi, energy_before_of_library hE⟩

/-- The same compact datum and quantitative constants work on every compact
slab. The physical norm and rescaled error are genuine spatial integrals.
This is the strongest physical endpoint implemented in the supplied proof source;
compilation is still required.
-/
theorem theorem11SpaceSlabs : Theorem11SpaceSlabs := by
  intro W q P R A h ε hε
  have hp := libraryProfile_to_similarity h
  obtain ⟨d⟩ := theorem11SpaceCore W q P R A h ε hε
  let C : ℝ := max d.lowerConstant (max d.upperConstant d.errorConstant)
  have hcu : d.upperConstant ≤ C := (le_max_left _ _).trans (le_max_right _ _)
  have hce : d.errorConstant ≤ C := (le_max_right _ _).trans (le_max_right _ _)
  refine ⟨d.datum, d.lowerConstant, C, d.exponent,
    d.datum_test.1, d.datum_test.2.1, d.datum_test.2.2,
    d.initial_gradient_finite, d.initial_gradient_close,
    d.lowerConstant_pos, le_max_left _ _, d.exponent_pos, d.exponent_lt_quarter, ?_⟩
  intro T hT hT1
  obtain ⟨U, p, hs, hi, hE, _, _, hquant⟩ :=
    Theorem11Core.local_physical_quantitative W q A ε hp d T hT hT1
  refine ⟨U, p, smooth_before_of_library hs hi, energy_before_of_library hE, ?_⟩
  intro t ht
  obtain ⟨hf, _, hlo, hhi, he, hconv⟩ := hquant t ⟨ht.1, ht.2.le⟩
  have hdt : 0 ≤ 1 - t := by linarith [ht.2, hT1]
  refine ⟨hf, hlo, ?_, he, ?_⟩
  · exact hhi.trans (mul_le_mul_of_nonneg_right hcu (Real.rpow_nonneg hdt _))
  · exact hconv.trans (mul_le_mul_of_nonneg_right hce (Real.rpow_nonneg hdt _))

/-- The old existential statement is a consequence of the selected profile.
This compatibility theorem does not discard the selected profile in Core. -/
theorem profile_exists_of_libraryProfile (W : Velocity) (q : Pressure) (P : ℝ)
    (R : Space ≃ₗᵢ[ℝ] Space) (A : ℝ) (h : IsLibraryProfile W q P R A) :
    Breakdown.PeriodicSimilarityProfileExists :=
  libraryProfile_to_exists h

end Theorem11
