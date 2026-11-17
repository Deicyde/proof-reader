import PhyslibAlpha.ClassicalMechanics.CoupledSpringPotential

/-- The coupled spring potential equals `(x₀ + x₁/2)² + (3/4) x₁²` at every point. -/
theorem couplingPotential_eq_sq_add_sq (x : EuclideanSpace ℝ (Fin 2)) :
    couplingPotential x = (x 0 + x 1 / 2) ^ 2 + 3 / 4 * (x 1) ^ 2 := by
  unfold couplingPotential
  ring

/-- The coupled spring potential is zero at the origin. -/
theorem couplingPotential_origin :
    couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) = 0 := by
  first
    | simp [couplingPotential]
    | norm_num [couplingPotential]

/-- At every point the coupled spring potential is at least its value at the origin. -/
theorem couplingPotential_origin_le (x : EuclideanSpace ℝ (Fin 2)) :
    couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) ≤ couplingPotential x := by
  rw [couplingPotential_origin, couplingPotential_eq_sq_add_sq]
  positivity
