import TorusEuler.Paper.SBD.Statements

/-! # Keeping the real exponent in the coefficient bound (D.6)

Use `D^a` as the base of the authors' integer-exponent estimates. This
preserves the scale `ℓ ≤ D^(-a)` in D.2(c); rounding `a` up would not.
-/

open Set TorusEuler TorusEuler.Paper.AppendixD
open scoped ContDiff

namespace Adapted.RealPowers

variable {I X : Type*} [NormedAddCommGroup X] [NormedSpace ℝ X]

/-- The bound (D.6), with its real exponent unchanged:
`|c|_m ≤ C_m D^(a(m+1))` for a smooth phase-independent coefficient.
The derivative suprema are required to be finite. -/
def CoefficientPowerReal (C : ℕ → ℝ) (D a : ℝ) (c : I → Vec3 → X) : Prop :=
  (∀ t, ContDiff ℝ ∞ (c t)) ∧
    (∀ m, ∀ w ∈ appendixCoefficientOrderWords m,
      BddAbove (hierarchyJetValues False (hierarchyLabelDirection 1) w c)) ∧
    ∀ m, coefficientOrderNorm m c ≤ C m * D ^ (a * ((m : ℝ) + 1))

/-- A real exponent is encoded exactly by rescaling the base, without
changing the exponent, the coefficient, or its derivative constants. -/
theorem coefficientPower_rescale {C : ℕ → ℝ} {D a : ℝ} (hD : 0 ≤ D)
    (k : ℕ) (c : I → Vec3 → X) :
    CoefficientPower C (D ^ a) k c ↔
      CoefficientPowerReal C D (a * (k : ℝ)) c := by
  have hp (m : ℕ) : D ^ ((a * (k : ℝ)) * ((m : ℝ) + 1)) =
      (D ^ a) ^ (k * (m + 1)) := by
    rw [← Real.rpow_mul_natCast hD]
    congr 1
    push_cast
    ring
  simp only [CoefficientPower, CoefficientPowerReal, hp]

/-- Increasing a real coefficient exponent preserves the bound when
`D ≥ 1` and the fixed-order constants are nonnegative. -/
theorem coefficientPowerReal_mono {C : ℕ → ℝ} {D a b : ℝ} {c : I → Vec3 → X}
    (hc : CoefficientPowerReal C D a c) (hC : ∀ m, 0 ≤ C m)
    (hD : 1 ≤ D) (hab : a ≤ b) : CoefficientPowerReal C D b c := by
  refine ⟨hc.1, hc.2.1, fun m => (hc.2.2 m).trans ?_⟩
  exact mul_le_mul_of_nonneg_left
    (Real.rpow_le_rpow_of_exponent_le hD
      (mul_le_mul_of_nonneg_right hab (by positivity))) (hC m)

end Adapted.RealPowers
