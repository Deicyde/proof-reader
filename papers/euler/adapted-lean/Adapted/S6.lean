import TorusEuler.Paper.Spine

/-! # Section 6. The initial wave

`FirstWaveOrigin ρ T λ` is the central pair in (6.3): its wave vector starts at
`λ e₁`, its amplitude starts at a positive multiple of `e₂`, and the attained
maximum of its amplitude on `[0,T]` is `λ^(-3/4)`. The equations and
transversality are part of that definition. This lemma estimates that pair;
it does not construct the spatially localized perturbation.
-/

open TorusEuler TorusEuler.Paper Set
open scoped InnerProductSpace

namespace Adapted.S6

/-- **Lemma 6.1.** If `T|B_ρ| ≤ 1/8`, the first wave satisfies the two
conditions (5.5) for every `𝖣 ≥ 2`, and its strength at the origin at time
zero lies between `λ^(1/4)/2` and `λ^(1/4)`.

Here `B_ρ = 2π(e₁ + ρe₃) ⊗ e₂`, and
`γ(t) = λ^(3/4)|𝐚(t,0)|`. The three conjuncts are the propagation bound,
the positive-coupling bound, and the initial-strength interval. The
standing assumptions are `0 < ρ ≤ 1`, `λ ≥ 1` and `T > 0`. -/
theorem lemma_6_1 (ρ T lam : ℝ) (hρ : 0 < ρ) (hρ₁ : ρ ≤ 1)
    (hlam : 1 ≤ lam) (hT : 0 < T) (hsmall : T * ‖stationaryShearGradient ρ‖ ≤ 1 / 8)
    (w : FirstWaveOrigin ρ T lam) :
    (∀ D : ℝ, 2 ≤ D → ∀ b : ℝ → Vec3,
      (∀ t ∈ Icc 0 T, HasDerivWithinAt b
        (affineWaveAmplitudeOperator (stationaryShearGradient ρ) (w.covector t) (b t))
          (Icc 0 T) t) →
      (∀ t ∈ Icc 0 T, ⟪w.covector t, b t⟫_ℝ = 0) →
      ∀ t' t : ℝ, t' ∈ Icc 0 T → t ∈ Icc 0 T → t' ≤ t →
        ‖b t‖ / (lam ^ (3 / 4 : ℝ) * ‖w.amplitude t‖) ≤
          D * (‖b t'‖ / (lam ^ (3 / 4 : ℝ) * ‖w.amplitude t'‖))) ∧
    (∀ D : ℝ, 2 ≤ D → ∀ t ∈ Icc 0 T,
      D⁻¹ ≤ MovingWaveVector.entry
        (MovingWaveVector.frame w.covector w.amplitude t) (stationaryShearGradient ρ) 0 1) ∧
    (lam ^ (1 / 4 : ℝ) / 2 ≤ ‖w.amplitude 0‖ * ‖w.covector 0‖ ∧
      ‖w.amplitude 0‖ * ‖w.covector 0‖ ≤ lam ^ (1 / 4 : ℝ)) := by
  have h := (TorusEuler.Paper.lemma_6_1 ρ T lam hρ hρ₁ hlam hT hsmall).2 w
  exact ⟨h.propagation, h.coupling, h.initial_strength⟩

end Adapted.S6
