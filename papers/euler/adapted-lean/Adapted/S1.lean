import TorusEuler.Paper.Spine

/-! # The singular solution and the frequency schedule

The torus is represented by integer-periodic functions on `ℝ³`. The definitions
`IsMaximalEulerSolution`, `torusLInf` and `HasOffOriginLimits` are the authors'
definitions in `TorusEuler/Statement.lean`; none is changed by this layer.
Theorem 1.1 is closed: it has no construction parameters or unproved hypotheses.
Its time interval is `[0,T)`, with `T` a positive real number.
-/

open Filter MeasureTheory Set TorusEuler TorusEuler.Paper
open scoped ContDiff ENNReal Topology

namespace Adapted.S1

/-- **Theorem 1.1.** There is an odd divergence-free smooth initial velocity
on the three-dimensional torus whose maximal classical Euler solution is
smooth and odd up to a finite positive time. The time integrals of the
gradient and vorticity supremum norms diverge, the velocity remains bounded,
and the vorticity at the origin tends to infinity. On every compact set
away from the origin, the velocity and its time derivative converge in every
spatial `C^m` norm. The maximal lifespan and velocity are unique.

`HasOffOriginLimits T f` quantifies over every compact subset of the complement
of the integer lattice and every `m : ℕ`; it includes uniform convergence of
all spatial derivatives through order `m`. Pressure has zero spatial mean.
No Euler equation or smoothness at the origin is asserted at or after `T`. -/
theorem theorem_1_1 :
    ∃ (u₀ : Vec3 → Vec3) (T : ℝ) (u : Velocity) (p : Pressure),
      ContDiff ℝ ∞ u₀ ∧ SpatiallyPeriodic u₀ ∧ Function.Odd u₀ ∧
      (∀ x, divergence u₀ x = 0) ∧
      0 < T ∧ IsMaximalEulerSolution T u p ∧ u 0 = u₀ ∧
      (∀ t ∈ Ico 0 T, Function.Odd (u t)) ∧
      (∫⁻ t in Ico 0 T, torusLInf (fderiv ℝ (u t))) = ⊤ ∧
      (∫⁻ t in Ico 0 T, torusLInf (curl (u t))) = ⊤ ∧
      (∃ C : ℝ, ∀ t ∈ Ico 0 T, torusLInf (u t) ≤ ENNReal.ofReal C) ∧
      Tendsto (fun t => ‖curl (u t) 0‖) (𝓝[Ico 0 T] T) atTop ∧
      HasOffOriginLimits T u ∧ HasOffOriginLimits T (timeDerivative T u) ∧
      (∀ (T' : ℝ) (v : Velocity) (q : Pressure),
        IsMaximalEulerSolution T' v q → v 0 = u₀ →
          T' = T ∧ EqOn v u (Ico 0 T)) := by
  obtain ⟨u₀, T, u, p, hw, hunique⟩ := TorusEuler.Paper.theorem_1_1
  rcases hw with ⟨hs, hp, ho, hd, hm, hi, hodd, hgrad, hcurl, hbound, hblow, hu, hut⟩
  exact ⟨u₀, T, u, p, hs, hp, ho, hd, hm.1.time_pos, hm, hi, hodd,
    hgrad, hcurl, hbound, hblow, hu, hut, hunique⟩

/-- **Remark 1.2.** The solution in Theorem 1.1 may be chosen so that it
extends smoothly in space and time through the singular time away from the
origin. The extension agrees with that same singular solution; it is not
required to satisfy the Euler equations beyond the singular time.

`SmoothTerminalExtension` asks for an open neighbourhood of the terminal
slice of the punctured torus, a smooth periodic field there, and agreement
with the velocity on the full physical slab away from the origin. -/
theorem remark_1_2 :
    ∃ (u₀ : Vec3 → Vec3) (T : ℝ) (u : Velocity) (p : Pressure),
      EulerSingularityWitness u₀ T u p ∧
      (∀ (T' : ℝ) (v : Velocity) (q : Pressure),
        IsMaximalEulerSolution T' v q → v 0 = u₀ →
          T' = T ∧ EqOn v u (Ico 0 T)) ∧
      SmoothTerminalExtension T u :=
  TorusEuler.Paper.remark_1_2

/-- **Lemma 1.3.** For the schedule (1.14), the orders satisfy
`q_j ≤ q_{j+1} ≤ q_j + 1` and tend to infinity, and
`L_{j+1} ≤ (log λ_{j-1})²` for every `j ≥ 1`.

The hypotheses of Subsection 1.5 are retained: `b ≥ 1`, a nondecreasing
positive threshold `B` dominating the fixed-order majorant `F` and satisfying
(1.13), `N ≥ B(1)`, and the simultaneous recursions for `q` and `λ`.
`AdmissibleThreshold b F B` spells out those four threshold conditions.
The values of the order and threshold at index zero play no role. -/
theorem lemma_1_3
    (b : ℕ) (F B : ℕ → ℝ) (N : ℝ) (q : ℕ → ℕ) (freq : ℕ → ℝ)
    (hb : 1 ≤ b) (hB : AdmissibleThreshold b F B) (hN : B 1 ≤ N)
    (hq : q 1 = 1) (hfreq : freq 0 = N)
    (hrec : ∀ j : ℕ, 1 ≤ j → freq j = freq (j - 1) ^ frequencyExponent b (q j))
    (hmax : ∀ j : ℕ, 1 ≤ j →
      IsGreatest {s : ℕ | 1 ≤ s ∧ s ≤ q j + 1 ∧ B s ≤ freq (j - 1)} (q (j + 1))) :
    (∀ j : ℕ, 1 ≤ j → q j ≤ q (j + 1) ∧ q (j + 1) ≤ q j + 1) ∧
      Tendsto q atTop atTop ∧
      ∀ j : ℕ, 1 ≤ j → Schedule.L freq (j + 1) ≤ Real.log (freq (j - 1)) ^ 2 :=
  TorusEuler.Paper.lemma_1_3 b B N q freq hb
    (fun s hs => ⟨hB.pos s hs, hB.floor s hs⟩) hN hq hfreq hrec hmax

end Adapted.S1
