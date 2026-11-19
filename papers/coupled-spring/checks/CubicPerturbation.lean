import PhyslibAlpha.ClassicalMechanics.CoupledSpringPotential

/-- The coupled spring potential plus the cubic `x₀³`. -/
noncomputable def cubicPerturbation (x : EuclideanSpace ℝ (Fin 2)) : ℝ :=
  couplingPotential x + (x 0) ^ 3

/-- Adding `x₀³` keeps a local minimum at the origin: near the origin `|x₀| < 1/4`, and then
the potential is at least `(x₁ + x₀/2)² + x₀²/2`. -/
theorem cubicPerturbation_isLocalMin :
    IsLocalMin cubicPerturbation (0 : EuclideanSpace ℝ (Fin 2)) := by
  have hc : Continuous (fun x : EuclideanSpace ℝ (Fin 2) => x 0) :=
    (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)).continuous
  have ht : Filter.Tendsto (fun x : EuclideanSpace ℝ (Fin 2) => x 0) (nhds 0) (nhds 0) := by
    simpa using hc.tendsto (0 : EuclideanSpace ℝ (Fin 2))
  have hnear : ∀ᶠ x in nhds (0 : EuclideanSpace ℝ (Fin 2)), |x 0| < 1 / 4 := by
    filter_upwards [ht.eventually (Metric.ball_mem_nhds (0 : ℝ) (by norm_num : (0 : ℝ) < 1 / 4))]
      with x hx
    simpa [Metric.mem_ball, Real.dist_eq] using hx
  filter_upwards [hnear] with x hx
  have h0 : cubicPerturbation (0 : EuclideanSpace ℝ (Fin 2)) = 0 := by
    simp [cubicPerturbation, couplingPotential]
  rw [h0]
  have hlo : -(1 / 4 : ℝ) < x 0 := (abs_lt.mp hx).1
  have hprod : 0 ≤ (x 0) ^ 2 * (x 0 + 1 / 4) := by positivity
  unfold cubicPerturbation couplingPotential
  nlinarith [sq_nonneg (x 1 + x 0 / 2), sq_nonneg (x 0), hprod]

/-- The origin is not a global minimum after adding `x₀³`: the value at `(-2, 0)` is `-4`. -/
theorem cubicPerturbation_not_global :
    cubicPerturbation (!₂[-2, 0] : EuclideanSpace ℝ (Fin 2))
      < cubicPerturbation (0 : EuclideanSpace ℝ (Fin 2)) := by
  simp [cubicPerturbation, couplingPotential]
  norm_num
