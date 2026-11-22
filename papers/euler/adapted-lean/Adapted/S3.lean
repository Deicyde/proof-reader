import TorusEuler.Paper.Spine

/-! # Section 3. Localized wave profiles -/

open TorusEuler TorusEuler.Paper

namespace Adapted.S3

/-- Lemma 3.1. There are odd smooth one-periodic functions `F_h`,
`0 < h ≤ 1`, with zero-mean primitives `P_h`, such that
`F_h'(0)=1`, `-Ch ≤ F_h' ≤ 1`, `‖F_h‖∞ ≤ Ch`, and
`‖∂_s^j F_h‖∞ ≤ C_j h^(1-j)` for `j ≥ 2`.

`ProfileFamily` lists these properties, with the constants chosen before `h`.
The statement asserts existence of the family; its proof supplies the family
constructed by the authors. The exponent `1-j` is an integer difference. -/
theorem lemma_3_1 :
    ∃ F P : ℝ → ℝ → ℝ, ProfileFamily F P := by
  exact ⟨waveProfile, wavePressurePrimitive, TorusEuler.Paper.lemma_3_1⟩

end Adapted.S3
