import TorusEuler.Paper.Spine

/-! # Section 4. Selecting initial data by the endpoint problem

A `C^{1,1/2}` coefficient is represented by its half-Hölder value and
its half-Hölder first spatial derivative. Continuity of this pair is
continuity with values in `C^{1,1/2}`. We use the maximum norm of the
pair, then the supremum in time. The paper does not prescribe a
sum-versus-maximum convention for this norm. The proof below absorbs
only the explicit factor `2^p` needed when each of the two component
bounds is passed to the authors' stronger estimate.

`M`, `K`, `Ω` and their derivatives in Theorem 4.2 are representations
of the coefficients (4.1); their evaluation equalities identify the
fields. They are not independent coefficients or extra Euler hypotheses.
The time interval remains `[0,T]` throughout.
-/

open MeasureTheory Set
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper

namespace Adapted.S4

noncomputable section

local notation "Torus" => UnitAddTorus (Fin 3)
local notation "C½" => HalfHolder Torus Vec3
local notation "K½" => HalfHolder Torus (Vec3 →L[ℝ] Vec3)
local notation "DK½" => HalfHolder Torus (Vec3 →L[ℝ] (Vec3 →L[ℝ] Vec3))
local notation "S" => endpointHalfHolderSolenoidal
local notation "P" => endpointStrongSpatialProjection
local notation "J(" T ")" => Icc (0 : ℝ) T
local notation "Slab(" T ")" => Set.prod (Icc (0 : ℝ) T) (univ : Set Vec3)

/-- The solenoidal space has the inherited norm used in the fixed-time inverse. -/
local instance solenoidalNormedGroup : NormedAddCommGroup S := inferInstance

/-- Scalar multiplication on the solenoidal subspace uses the inherited norm. -/
local instance solenoidalNormedSpace : NormedSpace ℝ S := inferInstance

/-- A coefficient and its first spatial derivative are continuous in time
with values in `C^{0,1/2}`. This is the `C_t C^{1,1/2}` regularity of
Theorem 4.2 and Theorem A.1, with derivatives taken on the periodic lift. -/
def C1HalfOn {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (T : ℝ) (F : ℝ → HalfHolder Torus E)
    (DF : ℝ → HalfHolder Torus (Vec3 →L[ℝ] E)) : Prop :=
  ContinuousOn (fun t => (F t, DF t)) J(T) ∧
  ∀ t ∈ J(T), ∀ x : Vec3,
    HasFDerivAt (fun y => HalfHolder.eval (toUnitTorus y) (F t))
      (HalfHolder.eval (toUnitTorus x) (DF t)) x

/-- The norm `‖F‖_{C_t C^{1,1/2}}`: the supremum in time of the
maximum of the half-Hölder norms of `F` and its first spatial derivative. -/
def c1HalfNorm {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (T : ℝ) (F : ℝ → HalfHolder Torus E)
    (DF : ℝ → HalfHolder Torus (Vec3 →L[ℝ] E)) : ℝ :=
  endpointClosedTimeNorm T (fun t => (F t, DF t))

/-- The `C_t C^{1,1/2}` norm bounds the value and the first spatial
derivative uniformly. These are the two inputs used by the authors'
stronger coefficient estimate. -/
theorem c1HalfNorm_bounds {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {T : ℝ} {F : ℝ → HalfHolder Torus E}
    {DF : ℝ → HalfHolder Torus (Vec3 →L[ℝ] E)}
    (hT : 0 ≤ T) (h : C1HalfOn T F DF) :
    0 ≤ c1HalfNorm T F DF ∧
    ∀ t ∈ J(T),
      Differentiable ℝ (fun x => HalfHolder.eval (toUnitTorus x) (F t)) ∧
      ∀ x : Vec3,
        ‖HalfHolder.eval (toUnitTorus x) (F t)‖ ≤ c1HalfNorm T F DF ∧
        ‖fderiv ℝ (fun y => HalfHolder.eval (toUnitTorus y) (F t)) x‖ ≤
          c1HalfNorm T F DF := by
  refine ⟨endpointClosedTimeNorm_nonneg hT _, ?_⟩
  intro t ht
  have hPair := norm_le_endpointClosedTimeNorm h.1 ht
  change max ‖F t‖ ‖DF t‖ ≤ c1HalfNorm T F DF at hPair
  have hF := (le_max_left ‖F t‖ ‖DF t‖).trans hPair
  have hDF := (le_max_right ‖F t‖ ‖DF t‖).trans hPair
  refine ⟨fun x => (h.2 t ht x).differentiableAt, ?_⟩
  intro x
  constructor
  · exact (((HalfHolder.norm_le_iff (f := F t) (norm_nonneg (F t))).mp le_rfl).1
      (toUnitTorus x)).trans hF
  · rw [(h.2 t ht x).fderiv]
    exact (((HalfHolder.norm_le_iff (f := DF t) (norm_nonneg (DF t))).mp le_rfl).1
      (toUnitTorus x)).trans hDF

/-- The actual `C_t C^{1,1/2}` norm supplies the coefficient bounds in
the authors' normalized endpoint inverse. -/
theorem c1HalfOn_coefficientBound {F : ℝ → K½} {DF : ℝ → DK½}
    (h : C1HalfOn 1 F DF) :
    EndpointCoefficientC1Bound F (c1HalfNorm 1 F DF) (c1HalfNorm 1 F DF) := by
  obtain ⟨hN, hBounds⟩ := c1HalfNorm_bounds (by norm_num : (0 : ℝ) ≤ 1) h
  exact ⟨hN, hN, h.1.fst, hBounds⟩

/-- Lemma 4.1. If `H♯ ≤ Id` as quadratic forms, then for every
`z ∈ H¹₀([0,T];ℝ³)` and `ξ = D_aX z` the Hessian integral is at most
one half of `∫ |ξ_t|²`; hence the endpoint energy is at least that
same half integral. A Sobolev path is represented by its square-integrable
derivative of zero time mean, and `z` is its primitive. -/
theorem lemma_4_1 :
  ∀ (T : ℝ) (U : Velocity) (X : ℝ → Velocity), MeanParentFlow T U X →
    (∀ t ∈ J(T), ∀ (a w : Vec3), ⟪meanHsharp T U X t a w, w⟫_ℝ ≤ ‖w‖ ^ 2) →
    ∀ (a : Vec3) (v : Lp Vec3 2 (volume.restrict (Ioc (0 : ℝ) T))), endpointIntegral T v = 0 →
      let z : ℝ → Vec3 := endpointPrimitive v
      let ξ : ℝ → Vec3 := fun t => meanDeformation X t a (z t)
      let ξt : ℝ → Vec3 := fun t => meanGradient U X t a (ξ t) + meanDeformation X t a (v t)
      (∫ t in (0 : ℝ)..T, ⟪meanHsharp T U X t a (ξ t), ξ t⟫_ℝ) ≤
          (1 / 2 : ℝ) * ∫ t in (0 : ℝ)..T, ‖ξt t‖ ^ 2 ∧
        (1 / 2 : ℝ) * (∫ t in (0 : ℝ)..T, ‖ξt t‖ ^ 2) ≤
          ∫ t in (0 : ℝ)..T,
            (⟪meanKinetic X t a (v t), v t⟫_ℝ + ⟪meanVorticity U X t a (v t), z t⟫_ℝ) := by
  exact TorusEuler.Paper.lemma_4_1

set_option maxHeartbeats 800000 in
/-- Theorem 4.2. Under `H♯ ≤ Id`, the endpoint system (4.9) has a
unique solution in the stated Hölder class and
`‖v‖_{C_t C^{0,1/2}} ≤ A ‖L‖_{C_t C^{0,1/2}}`, where
`A = C(D₋ + ‖M‖∞ + ‖K‖_{C_t C^{1,1/2}} + ‖Ω‖_{C_t C^{1,1/2}})^p`.
For a smooth force, the displacement and recovered velocity and pressure
are smooth and satisfy (4.11)–(4.12). The same `A` bounds the fixed-time
inverse. The endpoint conditions select `b(0)`. -/
theorem theorem_4_2 :
  ∃ (C : ℝ) (p : ℕ), 0 ≤ C ∧
  ∀ (T : ℝ) (U : Velocity) (X : ℝ → Velocity), MeanParentFlow T U X →
  (∀ t ∈ J(T), ∀ (a w : Vec3), ⟪meanHsharp T U X t a w, w⟫_ℝ ≤ ‖w‖ ^ 2) →
  ∀ D : ℝ, 1 ≤ D →
  (∀ t ∈ J(T), ∀ a, ‖meanDeformationInv X t a‖ ≤ D) →
  ∀ M : ℝ → BoundedContinuousFunction Torus (Vec3 →L[ℝ] Vec3), ContinuousOn M J(T) →
  (∀ t ∈ J(T), ∀ a, M t (toUnitTorus a) = meanGradient U X t a) →
  ∀ (K Ω : ℝ → K½) (DK DΩ : ℝ → DK½),
  C1HalfOn T K DK → C1HalfOn T Ω DΩ →
  (∀ t ∈ J(T), ∀ a, HalfHolder.eval (toUnitTorus a) (K t) = meanKinetic X t a) →
  (∀ t ∈ J(T), ∀ a, HalfHolder.eval (toUnitTorus a) (Ω t) = meanVorticity U X t a) →
  let A : ℝ := C * (D + endpointClosedTimeNorm T M +
    c1HalfNorm T K DK + c1HalfNorm T Ω DΩ) ^ p
  -- the inverse for every Hölder source, with the bound (4.10)
  (∀ src : ℝ → C½, ContinuousOn src J(T) →
    ∃ (z v : ℝ → S) (c : S) (φ : Pressure) (G : ℝ → C½),
      EndpointSystemSolution T K Ω src z v c φ G ∧
      endpointClosedTimeNorm T v ≤ A * endpointClosedTimeNorm T src ∧
      ∀ (z' v' : ℝ → S) (c' : S) (φ' : Pressure) (G' : ℝ → C½),
        EndpointSystemSolution T K Ω src z' v' c' φ' G' →
        EqOn z' z J(T) ∧ EqOn v' v J(T) ∧ c' = c ∧ EqOn G' G J(T)) ∧
  -- smooth forces: smoothness, (4.11) and (4.12)
  (∀ f : Velocity, ContDiffOn ℝ ∞ (Function.uncurry f) Slab(T) →
    (∀ t ∈ J(T), SpatiallyPeriodic (f t)) →
    ∀ src : ℝ → C½,
    (∀ t ∈ J(T), ∀ a, HalfHolder.eval (toUnitTorus a) (src t) =
      -∫ s in (0 : ℝ)..t, (meanDeformation X s a).adjoint (f s (X 0 s a))) →
    (∃ (z v : ℝ → S) (c : S) (φ : Pressure) (G : ℝ → C½),
      EndpointSystemSolution T K Ω src z v c φ G) ∧
    ∀ (z v : ℝ → S) (c : S) (φ : Pressure) (G : ℝ → C½),
      EndpointSystemSolution T K Ω src z v c φ G →
      let vl : ℝ → Vec3 → Vec3 := fun t a => HalfHolder.eval (toUnitTorus a) (v t : C½)
      let b : ℝ → Vec3 → Vec3 := fun t x => meanDeformation X t (X t 0 x) (vl t (X t 0 x))
      ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (z q.1 : C½))
        Slab(T) ∧
      (∀ x, b 0 x = HalfHolder.eval (toUnitTorus x) (c : C½)) ∧
      ∃ qLabel : Pressure, ContDiffOn ℝ ∞ (Function.uncurry qLabel) Slab(T) ∧
        (∀ t ∈ J(T), SpatiallyPeriodic (qLabel t) ∧ (∫ x in centeredCell, qLabel t x) = 0) ∧
        (∀ t ∈ J(T), ∀ a,
          meanKinetic X t a (derivWithin (fun r => vl r a) J(T) t) + gradient (qLabel t) a =
            (meanDeformation X t a).adjoint (f t (X 0 t a)) -
              (2 : ℝ) • (meanDeformation X t a).adjoint
                (derivWithin (fun r => meanDeformation X r a) J(T) t (vl t a))) ∧
        let q : ℝ → Vec3 → ℝ := fun t x => qLabel t (X t 0 x)
        ContDiffOn ℝ ∞ (Function.uncurry b) Slab(T) ∧
        ContDiffOn ℝ ∞ (Function.uncurry q) Slab(T) ∧
        (∀ t ∈ J(T), SpatiallyPeriodic (b t) ∧ SpatiallyPeriodic (q t)) ∧
        ∀ t ∈ J(T), ∀ x, divergence (b t) x = 0 ∧
          fderivWithin ℝ (Function.uncurry b) Slab(T) (t, x) (1, U t x) +
            fderiv ℝ (U t) x (b t x) + gradient (q t) x = f t x) ∧
  -- the fixed-time inverse
  ∀ t ∈ J(T), ∃ e : S ≃L[ℝ] S,
    (∀ w : S, e w = P ((K t).coefficientMul (w : C½))) ∧
    ‖(e.symm : S →L[ℝ] S).comp P‖ ≤ A := by
  obtain ⟨C, p, hC, h⟩ := TorusEuler.Paper.theorem_4_2
  refine ⟨C * 2 ^ p, p, mul_nonneg hC (by positivity), ?_⟩
  intro T U X hParent hH D hD hDinv M hM hMe K Ω DK DΩ hK hΩ hKe hΩe
  let nK := c1HalfNorm T K DK
  let nΩ := c1HalfNorm T Ω DΩ
  let nM := endpointClosedTimeNorm T M
  obtain ⟨hKn, hKb⟩ := c1HalfNorm_bounds hParent.time_pos.le hK
  obtain ⟨hΩn, hΩb⟩ := c1HalfNorm_bounds hParent.time_pos.le hΩ
  have hMn : 0 ≤ nM := endpointClosedTimeNorm_nonneg hParent.time_pos.le M
  have hMbound : ∀ t ∈ J(T), ∀ a, ‖meanGradient U X t a‖ ≤ nM := by
    intro t ht a
    rw [← hMe t ht a]
    have hMt : ‖M t‖ ≤ nM := norm_le_endpointClosedTimeNorm (f := M) hM ht
    exact ((M t).norm_coe_le_norm _).trans hMt
  have hKfun : ∀ t ∈ J(T),
      (fun a => HalfHolder.eval (toUnitTorus a) (K t)) = meanKinetic X t :=
    fun t ht => funext (hKe t ht)
  have hΩfun : ∀ t ∈ J(T),
      (fun a => HalfHolder.eval (toUnitTorus a) (Ω t)) = meanVorticity U X t :=
    fun t ht => funext (hΩe t ht)
  have hK0 : ∀ t ∈ J(T), ∀ a, ‖meanKinetic X t a‖ ≤ nK := by
    intro t ht a
    simpa only [hKe t ht a] using ((hKb t ht).2 a).1
  have hK1 : ∀ t ∈ J(T), ∀ a, ‖fderiv ℝ (meanKinetic X t) a‖ ≤ nK := by
    intro t ht a
    simpa only [hKfun t ht] using ((hKb t ht).2 a).2
  have hΩ0 : ∀ t ∈ J(T), ∀ a, ‖meanVorticity U X t a‖ ≤ nΩ := by
    intro t ht a
    simpa only [hΩe t ht a] using ((hΩb t ht).2 a).1
  have hΩ1 : ∀ t ∈ J(T), ∀ a, ‖fderiv ℝ (meanVorticity U X t) a‖ ≤ nΩ := by
    intro t ht a
    simpa only [hΩfun t ht] using ((hΩb t ht).2 a).2
  have hOld := h T U X hParent hH D nM nK nK nΩ nΩ hD hDinv
    hMbound hK0 hK1 hΩ0 hΩ1 K Ω hKe hΩe
  have hBase : D + nM + nK + nK + nΩ + nΩ ≤ 2 * (D + nM + nK + nΩ) := by
    linarith only [hD, hMn]
  have hBase0 : 0 ≤ D + nM + nK + nK + nΩ + nΩ := by
    dsimp [nK, nΩ]
    linarith only [hD, hMn, hKn, hΩn]
  have hA : C * (D + nM + nK + nK + nΩ + nΩ) ^ p ≤
      (C * 2 ^ p) * (D + nM + nK + nΩ) ^ p := by
    calc
      _ ≤ C * (2 * (D + nM + nK + nΩ)) ^ p :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hBase0 hBase p) hC
      _ = _ := by rw [mul_pow]; ring
  refine ⟨?_, hOld.2.1, ?_⟩
  · intro src hsrc
    obtain ⟨z, v, c, φ, G, hSol, hBound, hUnique⟩ := hOld.1 src hsrc
    refine ⟨z, v, c, φ, G, hSol, ?_, hUnique⟩
    exact hBound.trans (mul_le_mul_of_nonneg_right hA
      (endpointClosedTimeNorm_nonneg hParent.time_pos.le src))
  · intro t ht
    obtain ⟨e, he, hBound⟩ := hOld.2.2 t ht
    exact ⟨e, he, hBound.trans hA⟩

end

end Adapted.S4
