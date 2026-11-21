/-
# Small algebraic checks on the physical contracts

Status: COMPILED with Lean v4.33.1 at the packet Mathlib pin. These lemmas only check the
normalization of formulas and a supplied norm-square identity. They do not
assert either physical endpoint.
-/
import Theorem11Challenge

open MeasureTheory

noncomputable section

namespace Theorem11

/-- At physical time zero and blow-up time one, the comparison datum is W(0). -/
theorem comparisonField_one_zero (W : Velocity) : comparisonField W 1 0 = W 0 := by
  funext x
  simp [comparisonField]

/-- Rescaling at time zero leaves the selected physical datum unchanged. -/
theorem rescaleAtOne_zero (u : Velocity) : rescaleAtOne u 0 = u 0 := by
  funext y
  simp [rescaleAtOne]

/-- Algebraic half of the realization bridge. Integrability must be supplied
separately when constructing a `SpaceConclusion`; it is not inferred here. -/
theorem gradientNorm_eq_norm_of_sq_eq
    {X : Type*} [SeminormedAddCommGroup X] (a : X) (v : VectorField)
    (h : ‖a‖ ^ 2 = ∫ x, gradientSquare v x) : gradientNorm v = ‖a‖ := by
  unfold gradientNorm
  rw [← h, Real.sqrt_sq_eq_abs, abs_of_nonneg (norm_nonneg a)]

end Theorem11
