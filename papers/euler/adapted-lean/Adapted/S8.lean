import TorusEuler.Paper.Spine
import TorusEuler.Paper.Proofs.S678b.Library.Limit

/-! # Section 8. The limit and its terminal behavior

The hypotheses `Theorem71Conclusions c C T` fix one common construction,
with activation times converging to `T = T∞`. They must be retained in
every result below: none is a theorem about an arbitrary Euler solution.

The one added definition, `MaximalEulerEvolution`, allows the lifespan
in Proposition 8.1 to be finite or infinite, as it is in the paper at
that point. The proof obtains existence from the constructed solution
and Corollary 8.3. It does not invoke a general maximal-existence theorem.
-/

open TorusEuler TorusEuler.Paper Filter MeasureTheory Set
open scoped ContDiff ENNReal Topology

namespace Adapted.S8

noncomputable section

/-- A maximal smooth Euler solution with lifespan `T_* ∈ (0,∞]`.
At finite lifespan this is the authors' `IsMaximalEulerSolution`. Infinite
lifespan means that the same velocity and pressure solve Euler smoothly
on every finite positive time interval. The fields are periodic lifts;
the pressure has zero spatial mean. -/
def MaximalEulerEvolution (Tstar : WithTop ℝ) (u : Velocity) (p : Pressure) : Prop :=
  (∃ S : ℝ, Tstar = (S : WithTop ℝ) ∧ IsMaximalEulerSolution S u p) ∨
    (Tstar = ⊤ ∧ ∀ S : ℝ, 0 < S → IsEulerSolution S u p)

/-- For this construction, every maximal solution from the limiting
initial datum has lifespan `T∞` and agrees with the preterminal limit.
The infinite-lifespan case is excluded by finite maximality in
Corollary 8.3, not by the definition of maximal lifespan. -/
theorem maximal_evolution_agrees
    {P : InductiveEulerParameters} {c : InductiveEulerConstruction P}
    {T : ℝ} {u v : Velocity} {p q : Pressure} {Tstar : WithTop ℝ}
    (h81 : Proposition81Conclusions c T u p) (h83 : Corollary83Conclusions T u p)
    (hv : MaximalEulerEvolution Tstar v q) (h0 : v 0 = u 0) :
    Tstar = (T : WithTop ℝ) ∧ EqOn v u (Ico 0 T) := by
  rcases hv with ⟨S, hstar, hmax⟩ | ⟨_, hglobal⟩
  · have hS : S = T := h83.maximal_time S v q hmax h0
    exact ⟨hstar.trans (congrArg (fun r : ℝ => (r : WithTop ℝ)) hS),
      (h81.maximal_agreement S v q hmax h0).2⟩
  · have hlong : IsEulerSolution (T + 1) v q :=
      hglobal (T + 1) (by linarith [h83.time_pos])
    have heq : ∀ t ∈ Ico 0 T, v t = u t := by
      intro t ht
      apply hlong.velocity_eq_on_common_interval h81.euler h0 t
      simpa only [min_eq_right (show T ≤ T + 1 by linarith)] using ht
    exact False.elim (h83.maximal.2 (T + 1) (by linarith) ⟨v, q, hlong, heq⟩)

/-- **Proposition 8.1.** The data `U_j(0)` converge in every `C^(m,1/2)`
to an odd divergence-free field `u₀`; in particular `u₀` is smooth.
There is a maximal smooth Euler solution from `u₀`. For every such
solution, with lifespan `T_* ∈ (0,∞]`, one has `T_* ≥ T∞`, and
`U_j → u` in `C([0,S]; C^(m,1/2))` for every `S < T∞` and integer
`m ≥ 0`. The solution is smooth and odd on `[0,T∞) × 𝕋³`.

The possibility `T_* = ∞` is included in the statement. Its exclusion
for these data follows from the later terminal result, which this short
reduction may use. No maximal-solution existence is assumed. -/
theorem proposition_8_1
    (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (C T : ℝ)
    (h71 : Theorem71Conclusions c C T) :
    ∃ u₀ : Vec3 → Vec3,
      (∀ m : ℕ, Tendsto (fun j => spatialHolderHalfNorm m (c.stages.velocity j 0 - u₀))
        atTop (𝓝 0)) ∧
      SpatiallyPeriodic u₀ ∧ Function.Odd u₀ ∧ (∀ x, divergence u₀ x = 0) ∧
      ContDiff ℝ ∞ u₀ ∧
      (∃ (Tstar : WithTop ℝ) (u : Velocity) (p : Pressure),
        MaximalEulerEvolution Tstar u p ∧ u 0 = u₀) ∧
      ∀ (Tstar : WithTop ℝ) (u : Velocity) (p : Pressure),
        MaximalEulerEvolution Tstar u p → u 0 = u₀ →
          (T : WithTop ℝ) ≤ Tstar ∧
          (∀ S < T, ∀ m : ℕ,
            TendstoUniformlyOn (fun j t => spatialHolderHalfNorm m (c.stages.velocity j t - u t))
              (fun _ => 0) atTop (Icc 0 S)) ∧
          ContDiffOn ℝ ∞ (Function.uncurry u) (Ico 0 T ×ˢ (univ : Set Vec3)) ∧
          ∀ t ∈ Ico 0 T, Function.Odd (u t) := by
  obtain ⟨u, p, h81⟩ := TorusEuler.Paper.proposition_8_1 P c C T h71
  have h82 := TorusEuler.Paper.proposition_8_2 P c C T u p h71 h81
  have h83 := TorusEuler.Paper.corollary_8_3 P c C T u p h71 h81 h82
  refine ⟨u 0, h81.initial_convergence,
    h81.euler.periodic_velocity 0 ⟨le_rfl, h83.time_pos⟩,
    h81.initial_odd, h81.initial_divergence_free, h81.initial_smooth,
    ⟨(T : WithTop ℝ), u, p, Or.inl ⟨T, rfl, h83.maximal⟩, rfl⟩, ?_⟩
  intro Tstar v q hv h0
  obtain ⟨hTstar, heq⟩ := maximal_evolution_agrees h81 h83 hv h0
  refine ⟨by rw [hTstar], ?_, ?_, ?_⟩
  · intro S hST m
    apply (h81.convergence S hST m).congr
    exact Eventually.of_forall fun j t ht => by
      dsimp only
      rw [heq ⟨ht.1, ht.2.trans_lt hST⟩]
  · exact h81.euler.smooth_velocity.congr
      (fun z hz => congrFun (heq hz.1) z.2)
  · intro t ht
    rw [heq ht]
    exact h81.odd t ht

/-- **Proposition 8.2.** The solution has bounded velocity on `[0,T∞)`,
and `|curl u(t,0)| → ∞` as `t ↑ T∞`.

Only these two conclusions are exposed here. The additional lower
bound on every sufficiently late activation interval is established by
the authors' proof and is used internally in Corollary 8.3. -/
theorem proposition_8_2
    (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (C T : ℝ)
    (u : Velocity) (p : Pressure)
    (h71 : Theorem71Conclusions c C T) (h81 : Proposition81Conclusions c T u p) :
    (∃ M : ℝ, ∀ t ∈ Ico 0 T, torusLInf (u t) ≤ ENNReal.ofReal M) ∧
      Tendsto (fun t => ‖curl (u t) 0‖) (𝓝[Ico 0 T] T) atTop := by
  have h82 := TorusEuler.Paper.proposition_8_2 P c C T u p h71 h81
  exact ⟨h82.bounded_velocity, h82.central_curl⟩

/-- **Corollary 8.3.** The maximal existence time is
`T_* = T∞ ∈ (0,∞)`, and both integrals in (1.2) diverge.

`T` is already the activation-time limit in `h71`. The maximality
conclusion applies to the constructed velocity itself. The equality of
lifespans ranges over finite and infinite candidates. No quantitative
curl lower bound is assumed: it is obtained from Proposition 8.2 inside
this proof. This reduction does not establish the general
Beale–Kato–Majda continuation criterion. -/
theorem corollary_8_3
    (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (C T : ℝ)
    (u : Velocity) (p : Pressure)
    (h71 : Theorem71Conclusions c C T) (h81 : Proposition81Conclusions c T u p) :
    IsMaximalEulerSolution T u p ∧
    (∀ (Tstar : WithTop ℝ) (v : Velocity) (q : Pressure),
      MaximalEulerEvolution Tstar v q → v 0 = u 0 → Tstar = (T : WithTop ℝ)) ∧
    0 < T ∧
    (∫⁻ t in Ico 0 T, torusLInf (fderiv ℝ (u t))) = ⊤ ∧
    (∫⁻ t in Ico 0 T, torusLInf (curl (u t))) = ⊤ := by
  have h82 := TorusEuler.Paper.proposition_8_2 P c C T u p h71 h81
  have h83 := TorusEuler.Paper.corollary_8_3 P c C T u p h71 h81 h82
  exact ⟨h83.maximal,
    fun _ _ _ hv h0 => (maximal_evolution_agrees h81 h83 hv h0).1,
    h83.time_pos, h83.gradient_integral, h83.curl_integral⟩

/-- **Proposition 8.4.** For every compact `K ⊂ 𝕋³ \ {0}` and every
integer `m ≥ 0`, both `u(t)` and `∂_t u(t)` converge in `C^m(K)` as
`t ↑ T∞`.

`HasOffOriginLimits` quantifies over every such compact set and every
order, and requires uniform convergence of all spatial derivatives
through that order to a field that is `C^m` near the compact set. On the
periodic lift, removing the torus origin means removing the integer
lattice. The two occurrences below are both necessary. -/
theorem proposition_8_4
    (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (C T : ℝ)
    (u : Velocity) (p : Pressure)
    (h71 : Theorem71Conclusions c C T) (h81 : Proposition81Conclusions c T u p) :
    HasOffOriginLimits T u ∧ HasOffOriginLimits T (timeDerivative T u) := by
  have h84 := TorusEuler.Paper.proposition_8_4 P c C T u p h71 h81
  exact ⟨h84.velocity, h84.time_derivative⟩

/-- **Opening of Section 8.** On the common interval `[0,T∞]`, the
velocities converge uniformly to a continuous periodic field `w` on
`[0,T∞] × 𝕋³`.

This statement includes `w` and the uniform convergence, which the
authors' declaration named `Text.section8_setting` does not contain.
The limit is defined at the terminal time; Euler evolution there is
not asserted. -/
theorem section8_setting
    (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (C T : ℝ)
    (h71 : Theorem71Conclusions c C T) :
    ∃ w : Velocity,
      ContinuousOn (Function.uncurry w) (Icc 0 T ×ˢ (univ : Set Vec3)) ∧
      (∀ t ∈ Icc 0 T, SpatiallyPeriodic (w t)) ∧
      TendstoUniformlyOn (fun j => Function.uncurry (c.stages.velocity j))
        (Function.uncurry w) atTop (Icc 0 T ×ˢ (univ : Set Vec3)) := by
  obtain ⟨u, p, h81⟩ := TorusEuler.Paper.proposition_8_1 P c C T h71
  obtain ⟨w, hcont, hconv, _⟩ :=
    TorusEuler.Paper.Lib.S678b.closedSlab_velocity_limit h71 h81
  refine ⟨w, hcont, ?_, hconv⟩
  intro t ht n x
  have hshift := hconv.tendsto_at (x := (t, x + latticeVector n)) ⟨ht, mem_univ _⟩
  have hbase := hconv.tendsto_at (x := (t, x)) ⟨ht, mem_univ _⟩
  have hshift' : Tendsto (fun j => c.stages.velocity j t x) atTop
      (𝓝 (w t (x + latticeVector n))) := by
    have hperiod : (fun j => c.stages.velocity j t (x + latticeVector n)) =
        (fun j => c.stages.velocity j t x) :=
      funext (fun j => c.stages.periodic_velocity j t n x)
    simpa only [Function.uncurry_apply_pair, hperiod] using hshift
  exact tendsto_nhds_unique hshift' hbase

end

end Adapted.S8
