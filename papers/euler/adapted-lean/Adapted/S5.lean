import TorusEuler.Paper.Spine
import TorusEuler.PaperHierarchyActiveInverse
import Adapted.Norms
import Adapted.ActiveRelay

/-!
# Section 5: estimates for one wave over a truncated parent

`PaperParent` fixes the pressure by the Poisson equation and zero mean.
`NormalizedOrigin` restores the attained normalization of the central seed.
Every declaration below uses these hypotheses, rather than silently inheriting
an enlarged class of parents or seeds from the original formal statement.

Fields on the torus are periodic lifts. A twisted profile is periodic in phase
and obeys `f(t,a+n,s+k_*·n) = f(t,a,s)`; its joint smoothness is on the indicated
closed time slab. The full-slab and active-slab versions are distinguished.
The paper's unspecified tensor norms are fixed to Euclidean operator norms.
-/

open Set UnitAddTorus MeasureTheory
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper
open HierarchyTwistedProfile LocalizedAmplitude ChildFlow
open TorusEuler.Paper.AppendixD

noncomputable section

namespace Adapted.S5

/-! ## Standing data and finite-norm adapters -/

/-- The parent of §5.1: the smooth odd divergence-free velocity with (5.1),
(5.2), (5.6), and its zero-mean pressure `Δp_U = -tr((∇U)²)`.
The fields already derived in the paper (oddness and the residual band) are
recorded by the authors' `S5.Parent` interface. -/
def PaperParent (T : ℝ) (U : Velocity) (X : ℝ → Velocity) (pU : Pressure)
    (D lam : ℝ) : Prop :=
  S5.Parent T U X pU D lam ∧
  (∀ t ∈ Icc 0 T, (∫ x in centeredCell, pU t x) = 0) ∧
  ∀ t ∈ Icc 0 T, ∀ x, divergence (gradient (pU t)) x =
    -LinearMap.trace ℝ Vec3 ((fderiv ℝ (U t) x).comp (fderiv ℝ (U t) x)).toLinearMap

/-- The central seed of §5.1 and (5.5), normalized by
`max_{t₀≤t≤T} |a(t,0)| = λ^(-3/4)`: the weight is at most one
and equals one at an actual time of the active interval. -/
def NormalizedOrigin (T : ℝ) (U : Velocity) (X : ℝ → Velocity) (k : Vec3)
    (D lam t₀ : ℝ) (center : ℝ → Vec3) : Prop :=
  S5.Origin T U X k D lam t₀ center ∧
  ∃ t ∈ Icc t₀ T, S5.weight lam center t = 1

/-- A smooth phase-periodic field on `[t₀,T]`, with the coupled lattice
translation of §3.1. No values before `t₀` enter this condition. -/
abbrev ActiveProfile {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (t₀ T : ℝ) (k : Vec3) (f : ℝ → Vec3 × ℝ → E) : Prop :=
  Adapted.ActiveRelay.Profile t₀ T k f

/-- A slice of a field smooth on the closed parent slab is smooth in the
label variable; this version also covers scalar and matrix coefficients. -/
theorem smooth_slice {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {T t : ℝ} {f : ℝ → Vec3 → E}
    (hf : ContDiffOn ℝ ∞ (Function.uncurry f) (Icc 0 T ×ˢ (univ : Set Vec3)))
    (ht : t ∈ Icc 0 T) : ContDiff ℝ ∞ (f t) :=
  contDiffOn_univ.mp (hf.comp (contDiff_const.prodMk contDiff_id).contDiffOn
    (fun x _ => ⟨ht, mem_univ x⟩))

/-- Passing from an order-`m` operator jet to the paper's sum of coordinate
jets costs the number of order-`m` multi-indices, with no change of scale. -/
theorem coefficientOrderNorm_le_of_jets {I E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {c : I → Vec3 → E} (hc : ∀ t, ContDiff ℝ ∞ (c t))
    (m : ℕ) {B : ℝ} (hB : 0 ≤ B)
    (hj : ∀ t x, ‖iteratedFDeriv ℝ m (c t) x‖ ≤ B) :
    coefficientOrderNorm m c ≤ ((appendixCoefficientOrderWords m).card : ℝ) * B := by
  have hval (w : List (Fin 3)) (hw : w ∈ appendixCoefficientOrderWords m) :
      B ∈ upperBounds (hierarchyJetValues False (hierarchyLabelDirection 1) w c) := by
    have hlen : w.length = m := (Finset.mem_filter.mp hw).2
    rintro y (rfl | ⟨t, x, rfl⟩ | ⟨hH, _⟩)
    · exact hB
    · rw [Lib.S5a.labelWord_eq_iteratedFDeriv (hc t)]
      refine (ContinuousMultilinearMap.le_opNorm _ _).trans ?_
      have hprod : ∏ i, ‖coordinateDirection (w.get i)‖ = 1 := by
        simp [coordinateDirection]
      rw [hprod, mul_one]
      rw [hlen]
      exact hj t x
    · exact hH.elim
  unfold coefficientOrderNorm
  calc
    _ ≤ ∑ _w ∈ appendixCoefficientOrderWords m, B :=
      Finset.sum_le_sum fun w hw => csSup_le ⟨0, Or.inl rfl⟩ (hval w hw)
    _ = _ := by rw [Finset.sum_const, nsmul_eq_mul]

/-- A finite sum absorbs every weighted derivative when `ℓ D^C ≤ 1`.
This is the elementary summation in the last sentence of Proposition 5.1. -/
theorem coefficientNorm_le_of_order {I E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {c : I → Vec3 → E} {L : ℕ → ℝ} {D ℓ Af : ℝ} {C n : ℕ}
    (hL : ∀ m, 0 ≤ L m) (hD : 0 < D) (hℓ : 0 ≤ ℓ) (hscale : ℓ ≤ (D ^ C)⁻¹)
    (hAf : 0 ≤ Af)
    (hb : ∀ m, coefficientOrderNorm m c ≤ L m * Af * D ^ (C * m)) :
    coefficientNorm ℓ n c ≤ (∑ j ∈ Finset.range (n + 1), L j) * Af := by
  have hmul : ℓ * D ^ C ≤ 1 :=
    (mul_le_mul_of_nonneg_right hscale (pow_nonneg hD.le C)).trans_eq
      (inv_mul_cancel₀ (pow_ne_zero C hD.ne'))
  unfold coefficientNorm
  calc
    _ ≤ ∑ j ∈ Finset.range (n + 1), L j * Af := by
      apply Finset.sum_le_sum
      intro j hj
      calc
        ℓ ^ j * coefficientOrderNorm j c ≤ ℓ ^ j * (L j * Af * D ^ (C * j)) :=
          mul_le_mul_of_nonneg_left (hb j) (pow_nonneg hℓ j)
        _ = (L j * Af) * (ℓ * D ^ C) ^ j := by rw [pow_mul, mul_pow]; ring
        _ ≤ (L j * Af) * 1 := mul_le_mul_of_nonneg_left
          (pow_le_one₀ (mul_nonneg hℓ (pow_nonneg hD.le C)) hmul) (mul_nonneg (hL j) hAf)
        _ = L j * Af := mul_one _
    _ = _ := (Finset.sum_mul _ _ _).symm

/-- The order-dependent constant after counting coordinate multi-indices
and summing all orders up to `n`. It is fixed before the parent and scale. -/
def coordinateBudget (K : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ j ∈ Finset.range (n + 1), ((appendixCoefficientOrderWords j).card : ℝ) * max (K j) 0

/-- Operator-jet estimates imply both coordinate estimates in (D.6)
and their scaled finite sums in (5.8), with explicit order-dependent constants. -/
theorem coefficient_bounds_of_jets {I E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {c : I → Vec3 → E} {K : ℕ → ℝ} {D : ℝ} {C : ℕ}
    (hD : 0 < D) (hc : ∀ t, ContDiff ℝ ∞ (c t))
    (hj : ∀ m t x, ‖iteratedFDeriv ℝ m (c t) x‖ ≤ K m * D ^ (C * (m + 1))) :
    (∀ m, coefficientOrderNorm m c ≤ coordinateBudget K m * D ^ (C * (m + 1))) ∧
    ∀ ℓ : ℝ, 0 < ℓ → ℓ ≤ (D ^ C)⁻¹ → ∀ n,
      coefficientNorm ℓ n c ≤ coordinateBudget K n * D ^ C := by
  let L (m : ℕ) := ((appendixCoefficientOrderWords m).card : ℝ) * max (K m) 0
  have hL (m : ℕ) : 0 ≤ L m := mul_nonneg (Nat.cast_nonneg _) (le_max_right _ _)
  have hsum (m : ℕ) : L m ≤ coordinateBudget K m :=
    Finset.single_le_sum (fun j _ => hL j) (Finset.mem_range.mpr (by omega))
  have horder (m : ℕ) : coefficientOrderNorm m c ≤ L m * D ^ (C * (m + 1)) := by
    have h := coefficientOrderNorm_le_of_jets hc m
      (mul_nonneg (le_max_right (K m) 0) (pow_nonneg hD.le _)) (fun t x =>
        (hj m t x).trans (mul_le_mul_of_nonneg_right (le_max_left _ _) (pow_nonneg hD.le _)))
    exact h.trans_eq (by dsimp only [L]; ring)
  refine ⟨fun m => (horder m).trans (mul_le_mul_of_nonneg_right (hsum m) (pow_nonneg hD.le _)), ?_⟩
  intro ℓ hℓ hscale n
  apply coefficientNorm_le_of_order hL hD hℓ.le hscale (pow_nonneg hD.le C)
  intro m
  exact (horder m).trans_eq (by rw [Nat.mul_add, Nat.mul_one, pow_add]; ring)

/-- Bernstein's inequality for the truncated parent gives
`|D^j U| ≤ R_n D^j` for `1 ≤ j ≤ n`, with constants chosen before the parent. -/
theorem parent_velocity_jets :
    ∃ R : ℕ → ℝ, (∀ n, 0 ≤ R n) ∧
      ∀ {T : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {D lam : ℝ},
        PaperParent T U X pU D lam →
        ∀ n j : ℕ, 1 ≤ j → j ≤ n → ∀ t ∈ Icc 0 T, ∀ x,
          ‖iteratedFDeriv ℝ j (U t) x‖ ≤ R n * D ^ j := by
  rcases Lib.S5a.exists_velocityJets_of_lemmaB1 TorusEuler.Paper.lemma_B_1 with ⟨R, hR, H⟩
  refine ⟨R, hR, ?_⟩
  intro T U X pU D lam hP n j hj hjn t ht x
  have hD : 1 ≤ D := one_le_two.trans hP.1.scale_ge_two
  have hD0 : 0 ≤ D := zero_le_one.trans hD
  rcases hP.1.velocity_band with ⟨v, hv⟩
  have hlift : (fun y => v t (toUnitTorus y)) = U t :=
    funext fun y => (hv t ht).1 y
  rw [← hlift]
  apply H (v t) hD
  · intro q hq
    exact (hv t ht).2 q
      ((mul_le_mul_of_nonneg_right (by norm_num : (2 : ℝ) ≤ 4) hD0).trans_lt hq)
  · rw [hlift]
    exact Lib.S5a.contDiff_slice hP.1.velocity_smooth ht
  · intro y
    rw [hlift]
    exact hP.1.gradient_le t ht y
  · exact hj
  · exact hjn

/-- One nondecreasing list of coordinate directions represents each spatial
multi-index. Dropping the other orderings can only decrease a sum of norms. -/
theorem coordinate_sum_le_ordered_sum {E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] (m : ℕ) (f : Vec3 → E) :
    (∑ i ∈ (Finset.univ.filter (fun i : Fin m → Fin 3 => Monotone i)),
      spatialSupNorm (spatialDerivativeWord (List.ofFn i) f)) ≤
      ∑ i : Fin m → Fin 3, spatialSupNorm (spatialDerivativeWord (List.ofFn i) f) := by
  classical
  apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _)
  intro i _ _
  exact Real.iSup_nonneg fun x => norm_nonneg _

/-- The `C²` norm used in Lemma 5.10: the sum of the uniform operator
norms of the zeroth, first, and second spatial derivatives. -/
def spatialC2Norm {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (v : Vec3 → E) : ℝ :=
  ∑ j ∈ Finset.range 3, spatialSupNorm (iteratedFDeriv ℝ j v)

/-- Each spatial derivative of order at most two is bounded by the
`C²` norm of a smooth periodic field. -/
theorem norm_jet_le_spatialC2Norm {E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {v : Vec3 → E} (hv : ContDiff ℝ ∞ v)
    (hp : SpatiallyPeriodic v) {j : ℕ} (hj : j ≤ 2) (x : Vec3) :
    ‖iteratedFDeriv ℝ j v x‖ ≤ spatialC2Norm v := by
  have hb := (spatialHolderHalf_of_contDiff_periodic hv hp 2).2 j hj
  apply (norm_le_spatialSupNorm hb.1 x).trans
  unfold spatialC2Norm
  apply Finset.single_le_sum (f := fun i => spatialSupNorm (iteratedFDeriv ℝ i v))
  · intro i hi
    exact Real.iSup_nonneg fun y => norm_nonneg _
  · exact Finset.mem_range.mpr (by omega)

/-- Smooth periodic data on the closed parent slab have finite scaled
half-Hölder norms. This removes the auxiliary finiteness premise of (5.14). -/
theorem holderNormFinite_of_smooth_periodic {E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {T ℓ : ℝ} {f : ℝ → Vec3 → E} (hT : 0 < T) (hℓ : 0 ≤ ℓ)
    (hf : ContDiffOn ℝ ∞ (Function.uncurry f) (Icc 0 T ×ˢ (univ : Set Vec3)))
    (hp : ∀ t ∈ Icc 0 T, SpatiallyPeriodic (f t)) (n : ℕ) :
    HolderFieldNormFinite ℓ n (fun t : Icc (0 : ℝ) T => f t.val) := by
  choose B hB using exists_bound_spatial_jet_of_contDiffOn_periodic hT hf hp
  have hB0 (j : ℕ) : 0 ≤ B j :=
    (norm_nonneg _).trans (hB j 0 ⟨le_rfl, hT.le⟩ 0)
  have hs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (f t.val) :=
    contDiffOn_univ.mp (hf.comp (contDiff_const.prodMk contDiff_id).contDiffOn
      (fun x _ => ⟨t.2, mem_univ x⟩))
  refine ⟨hs, ?_⟩
  intro w hw
  exact (hierarchyJetValues_true_label_bddAbove_csSup_le_of_iteratedFDeriv
    hℓ (hB0 w.length) (hB0 (w.length + 1)) hs w
    (fun t x => hB w.length t.val t.2 x)
    (fun t x => hB (w.length + 1) t.val t.2 x)).1

/-- The weighted finite norm on `[t₀,T]` for a raw active profile;
spatial and phase derivatives are taken before the time weight is applied. -/
abbrev activeNorm {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (ℓ h t₀ T : ℝ) (γ : ℝ → ℝ) (n : ℕ) (V : ℝ → Vec3 × ℝ → E) : ℝ :=
  Adapted.ActiveRelay.norm ℓ h t₀ T γ n V

/-- The operator `∂t + M` on an active profile, with the time derivative
taken within `[t₀,T]` so no extension before activation is presumed. -/
abbrev activeMaterial (t₀ T : ℝ) (U : Velocity) (X : ℝ → Velocity)
    (V : ℝ → Vec3 × ℝ → Vec3) : ℝ → Vec3 × ℝ → Vec3 :=
  Adapted.ActiveRelay.material t₀ T U X V

/-- The phase gradient `κ ∂s q` of a raw active scalar profile. -/
abbrev activePhaseGradient (X : ℝ → Velocity) (k : Vec3)
    (q : ℝ → Vec3 × ℝ → ℝ) : ℝ → Vec3 × ℝ → Vec3 :=
  Adapted.ActiveRelay.phaseGradient X k q

/-- The label gradient `d q = (D_a X)^{-T} ∇_a q`, with the phase held fixed. -/
abbrev activeLabelGradient (X : ℝ → Velocity)
    (q : ℝ → Vec3 × ℝ → ℝ) : ℝ → Vec3 × ℝ → Vec3 :=
  Adapted.ActiveRelay.labelGradient X q

/-- The divergence correction `C[V] = d × Q[V]`, where
`Q[V] = ∂s⁻¹(-κ × V / |κ|²)` is the zero-mean periodic primitive (3.5). -/
abbrev activeCurlCorrection (X : ℝ → Velocity) (k : Vec3)
    (V : ℝ → Vec3 × ℝ → Vec3) : ℝ → Vec3 × ℝ → Vec3 :=
  Adapted.ActiveRelay.curlCorrection X k V

/-! ## The numbered results -/

set_option maxHeartbeats 2000000 in
/-- **Proposition 5.1.** There is an absolute exponent `C` such that
each of `(D_a X)^{±1}`, `M`, `κ/λ`, `λ²/|κ|²`, and `P_κ` satisfies
(D.6). If `|f|_m ≤ C'_m A_f D^m` at every order, then
`|f ∘ X|_m ≤ C_m A_f D^(Cm)`. For `ℓ_* ≤ D^(-C)`, the two
finite-sum estimates (5.8) follow. Every `|·|_m` here is the exact
coordinate sum of Appendix D, with uniformity over `[0,T]`; the explicit
finite-norm domain prevents unbounded real suprema from being read as zero. -/
theorem proposition_5_1 :
    ∃ C : ℕ, ∃ K : ℕ → ℝ, ∀ C' : ℕ → ℝ, ∃ Kf : ℕ → ℝ,
    ∀ {T : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3} {D lam t₀ : ℝ},
      0 < T → PaperParent T U X pU D lam → S5.Launch T X k lam t₀ →
      let F : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t a => fderiv ℝ (X 0 t.val) a
      let G : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t a => fderiv ℝ (X t.val 0) (X 0 t.val a)
      let M : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t => S5.strainField U X t.val
      let κn : Icc (0 : ℝ) T → Vec3 → Vec3 := fun t a => lam⁻¹ • S5.waveVector X k t.val a
      let ν : Icc (0 : ℝ) T → Vec3 → ℝ := fun t a => lam ^ 2 / ‖S5.waveVector X k t.val a‖ ^ 2
      let Pκ : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t a =>
        (‖S5.waveVector X k t.val a‖ ^ 2)⁻¹ •
          InnerProductSpace.rankOne ℝ (S5.waveVector X k t.val a) (S5.waveVector X k t.val a)
      (∀ m : ℕ,
        coefficientOrderNorm m F ≤ K m * D ^ (C * (m + 1)) ∧
        coefficientOrderNorm m G ≤ K m * D ^ (C * (m + 1)) ∧
        coefficientOrderNorm m M ≤ K m * D ^ (C * (m + 1)) ∧
        coefficientOrderNorm m κn ≤ K m * D ^ (C * (m + 1)) ∧
        coefficientOrderNorm m ν ≤ K m * D ^ (C * (m + 1)) ∧
        coefficientOrderNorm m Pκ ≤ K m * D ^ (C * (m + 1))) ∧
      (∀ ℓ : ℝ, 0 < ℓ → ℓ ≤ (D ^ C)⁻¹ → ∀ n : ℕ,
        coefficientNorm ℓ n F ≤ K n * D ^ C ∧ coefficientNorm ℓ n G ≤ K n * D ^ C ∧
        coefficientNorm ℓ n M ≤ K n * D ^ C ∧ coefficientNorm ℓ n κn ≤ K n * D ^ C ∧
        coefficientNorm ℓ n ν ≤ K n * D ^ C ∧ coefficientNorm ℓ n Pκ ≤ K n * D ^ C) ∧
      ∀ {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E] (f : ℝ → Vec3 → E) (Af : ℝ),
        0 ≤ Af →
        (∀ n, CoefficientNormFinite n (fun t : Icc (0 : ℝ) T => f t.val)) →
        (∀ m, coefficientOrderNorm m (fun t : Icc (0 : ℝ) T => f t.val) ≤ C' m * Af * D ^ m) →
        (∀ m, coefficientOrderNorm m (fun t : Icc (0 : ℝ) T => fun x => f t.val (X 0 t.val x)) ≤
          Kf m * Af * D ^ (C * m)) ∧
        ∀ ℓ : ℝ, 0 < ℓ → ℓ ≤ (D ^ C)⁻¹ → ∀ n,
          coefficientNorm ℓ n (fun t : Icc (0 : ℝ) T => fun x => f t.val (X 0 t.val x)) ≤ Kf n * Af := by
  rcases TorusEuler.Paper.proposition_5_1 with ⟨C, K, H⟩
  refine ⟨C, coordinateBudget K, ?_⟩
  intro C'
  rcases H (fun m => (3 : ℝ) ^ m * C' m) with ⟨Kf, Hf⟩
  refine ⟨coordinateBudget Kf, ?_⟩
  intro T U X pU k D lam t₀ hT hP hL F G M κn ν Pκ
  have hD : 0 < D := lt_of_lt_of_le (by norm_num) hP.1.scale_ge_two
  have hl := Hf hT hP.1 hL
  have hFs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (fun a => fderiv ℝ (X 0 t.val) a) :=
    smooth_slice (f := fun r x => fderiv ℝ (X 0 r) x)
      (hP.1.flow.contDiffOn_forwardLabelDerivative hT hP.1.velocity_smooth hP.1.velocity_periodic) t.2
  have hGs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (fun a => fderiv ℝ (X t.val 0) (X 0 t.val a)) :=
    smooth_slice (f := fun r x => fderiv ℝ (X r 0) (X 0 r x))
      (hP.1.flow.contDiffOn_inverseLabelDerivative hT hP.1.velocity_smooth hP.1.velocity_periodic) t.2
  have hMs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (S5.strainField U X t.val) :=
    smooth_slice (f := S5.strainField U X) (Bridge.Parent.strainField_smooth hT hP.1) t.2
  have hκs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (S5.waveVector X k t.val) :=
    smooth_slice (f := S5.waveVector X k) (Bridge.Parent.waveVector_smooth hT hP.1) t.2
  have hκ0 (t : Icc (0 : ℝ) T) (x : Vec3) : ‖S5.waveVector X k t.val x‖ ^ 2 ≠ 0 :=
    pow_ne_zero _ (norm_ne_zero_iff.mpr (Bridge.Parent.waveVector_ne_zero hT hP.1 hL.carrier_ne_zero t.2 x))
  have hνs (t : Icc (0 : ℝ) T) :
      ContDiff ℝ ∞ (fun x => lam ^ 2 / ‖S5.waveVector X k t.val x‖ ^ 2) :=
    contDiff_const.div ((hκs t).norm_sq ℝ) (hκ0 t)
  have hPs (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (fun x =>
      (‖S5.waveVector X k t.val x‖ ^ 2)⁻¹ •
        InnerProductSpace.rankOne ℝ (S5.waveVector X k t.val x) (S5.waveVector X k t.val x)) := by
    apply (((hκs t).norm_sq ℝ).inv (hκ0 t)).smul
    simpa only [Function.comp_apply, Lib.S5a.rankOneBilinear_apply] using
      (Lib.S5a.rankOneBilinear.contDiff.comp (hκs t)).clm_apply (hκs t)
  have hF := coefficient_bounds_of_jets (c := F) (K := K) (C := C)
    hD hFs (fun m t x => (hl.1 m t.val t.2 x).1)
  have hG := coefficient_bounds_of_jets (c := G) (K := K) (C := C)
    hD hGs (fun m t x => (hl.1 m t.val t.2 x).2.1)
  have hM := coefficient_bounds_of_jets (c := M) (K := K) (C := C)
    hD hMs (fun m t x => (hl.1 m t.val t.2 x).2.2.1)
  have hκ := coefficient_bounds_of_jets (c := κn) (K := K) (C := C)
    hD (fun t => ContDiff.const_smul (lam⁻¹) (hκs t))
    (fun m t x => (hl.1 m t.val t.2 x).2.2.2.1)
  have hν := coefficient_bounds_of_jets (c := ν) (K := K) (C := C)
    hD hνs (fun m t x => (hl.1 m t.val t.2 x).2.2.2.2.1)
  have hPκ := coefficient_bounds_of_jets (c := Pκ) (K := K) (C := C)
    hD hPs (fun m t x => (hl.1 m t.val t.2 x).2.2.2.2.2)
  refine ⟨fun m => ⟨hF.1 m, hG.1 m, hM.1 m, hκ.1 m, hν.1 m, hPκ.1 m⟩,
    fun ℓ hℓ hs n => ⟨hF.2 ℓ hℓ hs n, hG.2 ℓ hℓ hs n, hM.2 ℓ hℓ hs n,
      hκ.2 ℓ hℓ hs n, hν.2 ℓ hℓ hs n, hPκ.2 ℓ hℓ hs n⟩, ?_⟩
  intro E _ _ f Af hAf hfin hnorm
  have hfs (t : ℝ) (ht : t ∈ Icc 0 T) : ContDiff ℝ ∞ (f t) := (hfin 0).1 ⟨t, ht⟩
  have hin (m : ℕ) (t : ℝ) (ht : t ∈ Icc 0 T) (x : Vec3) :
      ‖iteratedFDeriv ℝ m (f t) x‖ ≤ ((3 : ℝ) ^ m * C' m) * Af * D ^ m := by
    have h := Lib.S5a.norm_iteratedFDeriv_le_coefficientOrderNorm (hfin m).1
      (fun w hw => (hfin m).2 w (Finset.mem_filter.mp hw).1) ⟨t, ht⟩ x
    exact h.trans ((mul_le_mul_of_nonneg_left (hnorm m) (by positivity)).trans_eq (by ring))
  have hout := hl.2.1 f Af hAf hfs hin
  have hXsm (t : Icc (0 : ℝ) T) : ContDiff ℝ ∞ (X 0 t.val) :=
    contDiff_infty.mpr fun j =>
      (hP.1.flow.labelJets_evolve j hT hP.1.velocity_smooth hP.1.velocity_periodic).1 t.val t.2
  let L (m : ℕ) := ((appendixCoefficientOrderWords m).card : ℝ) * max (Kf m) 0
  have hL (m : ℕ) : 0 ≤ L m := mul_nonneg (Nat.cast_nonneg _) (le_max_right _ _)
  have hsum (m : ℕ) : L m ≤ coordinateBudget Kf m :=
    Finset.single_le_sum (fun j _ => hL j) (Finset.mem_range.mpr (by omega))
  have horder (m : ℕ) : coefficientOrderNorm m
      (fun t : Icc (0 : ℝ) T => fun x => f t.val (X 0 t.val x)) ≤ L m * Af * D ^ (C * m) := by
    have h := coefficientOrderNorm_le_of_jets
      (fun t => (hfs t.val t.2).comp (hXsm t)) m
      (mul_nonneg (mul_nonneg (le_max_right (Kf m) 0) hAf) (pow_nonneg hD.le _))
      (fun t x => (hout m t.val t.2 x).trans (mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_right (le_max_left _ _) hAf) (pow_nonneg hD.le _)))
    exact h.trans_eq (by dsimp only [L]; ring)
  refine ⟨fun m => (horder m).trans (mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_right (hsum m) hAf) (pow_nonneg hD.le _)), ?_⟩
  intro ℓ hℓ hs n
  exact coefficientNorm_le_of_order hL hD hℓ.le hs hAf horder

/-- **Proposition 5.2.** Every solution of the mean equation (5.11) satisfies
`‖B‖_[n] ≤ C_n D^C ‖f̄‖_[n+1]`. The exponent is independent of the derivative order;
the norms range over the whole interval `[0,T]`. -/
theorem proposition_5_2 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℝ,
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam : ℝ} (d : ParentGeometry hT U X k),
      PaperParent T U X pU D lam →
      ∀ (f B : HierarchyTwistedProfile T k Vec3) (q : HierarchyTwistedProfile T k ℝ),
        S5.MeanSolution d f B q →
        ∀ n : ℕ, S5.uNorm (S5.radius D a) (S5.width lam) n B ≤
          K n * D ^ C * S5.uNorm (S5.radius D a) (S5.width lam) (n + 1) f := by
  rcases TorusEuler.Paper.proposition_5_2 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨C, K, H⟩
  refine ⟨C, K, ?_⟩
  intro T hT U X pU k D lam d hP
  exact H hT d hP.1

/-- **Lemma 5.3.** The seed satisfies (5.19). The transverse equation
has the estimate (5.20) for smooth fields given only on `[t₀,T]`, the
zero-initial-data estimate (5.21), and the leading-field bound (5.22).
The same absolute exponent works at every derivative order. -/
theorem lemma_5_3 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℝ,
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      let ℓ := S5.radius D a
      let h := S5.width lam
      let γ := S5.weight lam center
      let M := S5.strainField U X
      let κ := S5.waveVector X k
      let Sg := S5.envelopeSupport ℓ
      -- (5.19)
      (∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
        ∀ t ∈ Icc t₀ T, ∀ x : Vec3, ‖x‖ ≤ 2 * ℓ →
          ‖amp t x‖ ≤ 2 * ‖amp t 0‖ ∧ 0 < ⟪κ t x, M t x (amp t x)⟫_ℝ) ∧
      -- (i): smoothness is required only on the active interval.
      (∀ n : ℕ, ∀ V f : ℝ → Vec3 × ℝ → Vec3,
        ActiveProfile t₀ T k V → ActiveProfile t₀ T k f →
        (∀ x ∉ Sg, ∀ s, V t₀ (x, s) = 0) →
        (∀ t ∈ Icc t₀ T, ∀ x ∉ Sg, ∀ s, f t (x, s) = 0) →
        (∀ t ∈ Icc t₀ T, ∀ x s, ⟪κ t x, V t (x, s)⟫_ℝ = 0) →
        (∀ t ∈ Icc t₀ T, ∀ x s, HasDerivWithinAt (fun r => V r (x, s))
          (affineWaveAmplitudeOperator (M t x) (κ t x) (V t (x, s)) +
            oscillatoryTransverseProjection (κ t x) (f t (x, s))) (Icc t₀ T) t) →
        S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n V ≤
          K n * D ^ C * ((γ t₀)⁻¹ * S5.fieldNorm ℓ h {t₀} (fun _ => 1) n V +
            S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n f)) ∧
      -- (ii), (5.21)
      (∀ n : ℕ, ∀ (f V : HierarchyTwistedProfile T k Vec3) (q : HierarchyTwistedProfile T k ℝ),
        (S5.ops d).average f = 0 →
        (∀ t ∈ Icc 0 T, ∀ x s, t < t₀ ∨ x ∉ Sg → f.val.val.val (t, x, s) = 0) →
        S5.TransverseSolution d f V q →
        S5.wNorm ℓ h t₀ γ n V + lam * S5.wNorm ℓ h t₀ γ n q ≤ K n * D ^ C * S5.wNorm ℓ h t₀ γ n f) ∧
      -- (iii), (5.22)
      (∀ n : ℕ, ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
        S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n
            (fun t x => S5.leading ℓ h amp t x.1 x.2) +
          lam * S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n
            (fun t x => S5.leadingPressure U X k ℓ h amp t x.1 x.2) ≤
          K n * D ^ C * lam ^ (-5 / 4 : ℝ)) := by
  rcases TorusEuler.Paper.lemma_5_3 with ⟨a₁, H₁⟩
  rcases parent_velocity_jets with ⟨R, hR, hJets⟩
  rcases TorusEuler.exists_paper_hierarchy_inverse_of_active_profiles R hR with
    ⟨a₂, _, Ka, hKa, Hactive⟩
  refine ⟨max a₁ a₂, ?_⟩
  intro a ha
  rcases H₁ a (le_of_max_le_left ha) with ⟨C, K, H⟩
  let K' : ℕ → ℝ := fun n => max (K n) 0 + Ka n
  refine ⟨C + 20, K', ?_⟩
  intro T hT U X pU k D lam t₀ center d hP hL hO ℓ h γ M κ Sg
  have hD : 1 ≤ D := one_le_two.trans hP.1.scale_ge_two
  have hD0 : 0 ≤ D := zero_le_one.trans hD
  have hK' (n : ℕ) : 0 ≤ K' n :=
    add_nonneg (le_max_right _ _) (hKa n)
  have hOld (n : ℕ) : K n * D ^ C ≤ K' n * D ^ (C + 20) := by
    apply mul_le_mul
    · exact (le_max_left _ _).trans (le_add_of_nonneg_right (hKa n))
    · exact pow_le_pow_right₀ hD (by omega)
    · positivity
    · exact hK' n
  have hActive (n : ℕ) : Ka n * D ^ 20 ≤ K' n * D ^ (C + 20) := by
    apply mul_le_mul
    · exact le_add_of_nonneg_left (le_max_right _ _)
    · exact pow_le_pow_right₀ hD (by omega)
    · positivity
    · exact hK' n
  have Hpaper := H hT d hP.1 hL hO.1
  refine ⟨Hpaper.1, ?_, ?_, ?_⟩
  · intro n V f hV hf hV0 hf0 hperp hderiv
    have hℓ : 0 < ℓ := Bridge.radius_pos hP.1 a
    have hℓA : ℓ ≤ (D ^ a₂)⁻¹ :=
      inv_anti₀ (pow_pos (zero_lt_one.trans_le hD) _) 
        (pow_le_pow_right₀ hD (le_of_max_le_right ha))
    have hsub : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
    have hS : ∀ x ∈ Sg, ∃ z : Fin 3 → ℤ, ‖x - latticeVector z‖ ≤ 2 * ℓ := by
      intro x hx
      rcases exists_lattice_dist_le_of_mem_periodicEnvelope_tsupport hℓ hx with ⟨z, hz⟩
      exact ⟨z, by rwa [dist_comm, dist_eq_norm] at hz⟩
    have hb := Hactive d hP.1.time_le_one hL.start_nonneg hL.start_lt hP.1.scale_ge_two
      hℓ hℓA hP.1.frequency_ge_one hL.frequency hP.1.flow hP.1.velocity_smooth
      hP.1.velocity_periodic hP.1.deformation_le hP.1.inverse_deformation_le
      hP.1.gradient_le (hJets hP) hO.1.wave n (S := Sg)
      (Lib.S5a.isClosed_envelopeSupport ℓ) hS V f hV.1 hf.1
      (hV.2.1 t₀ ⟨le_rfl, hL.start_lt.le⟩) hf.2.1
      (hV.2.2 t₀ ⟨le_rfl, hL.start_lt.le⟩) hf.2.2 hV0 hf0
      (fun t ht x s => by
        rw [Bridge.oscillation_covector_eq d (hsub ht) x]
        exact hperp t ht x s)
      (fun t ht x s => by
        rw [Bridge.oscillation_covector_eq d (hsub ht) x,
          Bridge.oscillation_strain_eq d (hsub ht) x]
        exact hderiv t ht x s)
    have hb' : S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n V ≤
        Ka n * D ^ 20 * ((γ t₀)⁻¹ * S5.fieldNorm ℓ h {t₀} (fun _ => 1) n V +
          S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n f) := by
      simpa only [paperHierarchyActiveVelocityNorm, paperHierarchyLaunchValueNorm,
        S5.fieldNorm, h, γ, S5.width, S5.weight, one_smul] using hb
    apply hb'.trans
    apply mul_le_mul_of_nonneg_right (hActive n)
    apply add_nonneg
    · apply mul_nonneg
      · dsimp [γ, S5.weight]
        exact inv_nonneg.mpr (mul_nonneg
          (Real.rpow_nonneg (zero_le_one.trans hP.1.frequency_ge_one) _) (norm_nonneg _))
      · exact S5b.fieldNorm_nonneg' _ _ _ _ _ _
    · exact S5b.fieldNorm_nonneg' _ _ _ _ _ _
  · intro n f V q hmean hsupp hsol
    apply (Hpaper.2.2.1 n f V q hmean hsupp hsol).trans
    exact mul_le_mul_of_nonneg_right (hOld n) (S5b.fieldNorm_nonneg' _ _ _ _ _ _)
  · intro n amp hamp
    apply (Hpaper.2.2.2 n amp hamp).trans
    exact mul_le_mul_of_nonneg_right (hOld n) (Real.rpow_nonneg (by linarith [hP.1.frequency_ge_one]) _)

/-- **Proposition 5.4.** For every integer `P ≥ 2`, the profiles obtained
from (5.11), (5.27), and (5.28) are well defined and jointly smooth; their finite
sum is divergence free and satisfies (5.29), with the supports and remainder
(5.30) stated in the paper. Existence and uniqueness spell out “well defined”. -/
theorem proposition_5_4 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a →
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      -- the seed of §5.1, which gives `V₁`, `𝗉₁`, `C₂`, exists
      (∃ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp) ∧
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      let ℓ := S5.radius D a
      let h := S5.width lam
      let A := S5.ops d
      let Sg := S5.envelopeSupport ℓ
      -- the profiles are well defined: existence
      (∃ (R S : HierarchyTwistedProfile T k Vec3)
          (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ ℓ h amp P R S u) ∧
      -- and uniqueness
      (∀ (R S R' S' : HierarchyTwistedProfile T k Vec3)
          (u u' : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ ℓ h amp P R S u → S5.IsExpansion d pU χ ℓ h amp P R' S' u' →
        R = R' ∧ S = S' ∧
          (∀ i ∈ Finset.Icc 1 P, u.V i = u'.V i ∧ u.B i = u'.B i ∧ u.p i = u'.p i ∧ u.q i = u'.q i) ∧
          ∀ i ∈ Finset.Icc 1 (P + 1), S5.Cd u i = S5.Cd u' i) ∧
      -- the identities
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ ℓ h amp P R S u →
        let cS := S5.curlCorrection d S
        let W := S5.expansion u P
        let Pr := S5.expansionPressure u P
        let RP := S5.remainder A u P
        W = (∑ i ∈ Finset.Icc 1 P, S5.Zd u i) + S5.Cd u (P + 1) ∧
        S5.totalDivergence d W = 0 ∧
        -- (5.29)
        A.material W + A.labelAdv W W + A.phaseAdv W W + A.labelGrad Pr + A.phaseGrad Pr + R =
          RP + (S + cS) ∧
        W - A.average W = ∑ i ∈ Finset.Icc 1 P, (u.V i + S5.Cd u (i + 1)) ∧
        -- supports in `supp g`
        (∀ t ∈ Icc 0 T, ∀ x ∉ Sg, ∀ s, (W - A.average W).val.val.val (t, x, s) = 0) ∧
        (∀ i ∈ Finset.Icc 2 P, ∀ t ∈ Icc 0 T, ∀ x ∉ Sg, ∀ s,
          (S5.oscSource A u cS i + S5.suppSource A u i).val.val.val (t, x, s) = 0) ∧
        -- vanishing before activation
        (∀ t ∈ Icc 0 T, t < t₀ → ∀ x s,
          (∀ i ∈ Finset.Icc 1 P,
            (u.V i).val.val.val (t, x, s) = 0 ∧ (u.p i).val.val.val (t, x, s) = 0) ∧
          (∀ i ∈ Finset.Icc 1 (P + 1), (S5.Cd u i).val.val.val (t, x, s) = 0) ∧
          ∀ i ∈ Finset.Icc 2 P, (S5.oscSource A u cS i + S5.suppSource A u i).val.val.val (t, x, s) = 0) ∧
        -- `Y_{P+1} = Z_{P+1} = C_{P+1}`
        S5.Yd u (P + 1) = S5.Cd u (P + 1) ∧ S5.Zd u (P + 1) = S5.Cd u (P + 1) ∧
        -- `R_P` is independent of the phase outside `supp g`
        ∀ t ∈ Icc 0 T, ∀ x ∉ Sg, ∀ s, RP.val.val.val (t, x, s) = RP.val.val.val (t, x, 0) := by
  rcases TorusEuler.Paper.proposition_5_4 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha T hT U X pU k D lam t₀ center d χ hP hL hO
  exact H a ha hT d χ hP.1 hL hO.1

/-- **Lemma 5.5.** For every centered transverse
field, (5.31) bounds its divergence correction. If
`V_t + MV + κ ∂s p = f`, with centered force and pressure, (5.32) bounds
`(∂t+M)C[V] + d p`. The leading oscillation has source zero.

All fields need be smooth only on the active interval. The raw relay estimates
are applied on that interval; time translation supplies the mixed-derivative
identity, and the parent coefficient budget gives `C = 2(15+a)` independently
of derivative order. The leading fields are the actual periodized formulas. -/
theorem lemma_5_5 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℝ,
    ∀ {T : ℝ} (_hT : 0 < T) {U : Velocity} {X : ℝ → Velocity}
      {pU : Pressure} {k : Vec3} {D lam t₀ : ℝ} {center : ℝ → Vec3},
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ →
      NormalizedOrigin T U X k D lam t₀ center →
      let ℓ := S5.radius D a
      let h := S5.width lam
      let γ := S5.weight lam center
      let κ := S5.waveVector X k
      (∀ n : ℕ, ∀ V : ℝ → Vec3 × ℝ → Vec3, ActiveProfile t₀ T k V →
        (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => V t (x, s)) = 0) →
        (∀ t ∈ Icc t₀ T, ∀ x s, ⟪κ t x, V t (x, s)⟫_ℝ = 0) →
        activeNorm ℓ h t₀ T γ n (activeCurlCorrection X k V) ≤
          K n * D ^ C * lam⁻¹ * activeNorm ℓ h t₀ T γ (n + 1) V ∧
        ∀ (f : ℝ → Vec3 × ℝ → Vec3) (q : ℝ → Vec3 × ℝ → ℝ),
          ActiveProfile t₀ T k f → ActiveProfile t₀ T k q →
          (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => f t (x, s)) = 0) →
          (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => q t (x, s)) = 0) →
          (∀ t ∈ Icc t₀ T, ∀ x s,
            activeMaterial t₀ T U X V t (x, s) + activePhaseGradient X k q t (x, s) = f t (x, s)) →
          activeNorm ℓ h t₀ T γ n
            (fun t p => activeMaterial t₀ T U X (activeCurlCorrection X k V) t p +
              activeLabelGradient X q t p) ≤
            K n * D ^ C * lam⁻¹ *
              (activeNorm ℓ h t₀ T γ (n + 1) V + activeNorm ℓ h t₀ T γ (n + 1) f)) ∧
      (∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
        let V : ℝ → Vec3 × ℝ → Vec3 := fun t p =>
          phaseTwistedPeriodizeCentered k (S5.leading ℓ h amp) t p.1 p.2
        let q : ℝ → Vec3 × ℝ → ℝ := fun t p =>
          phaseTwistedPeriodizeCentered k (S5.leadingPressure U X k ℓ h amp) t p.1 p.2
        (∀ t ∈ Icc t₀ T, ∀ x s,
          activeMaterial t₀ T U X V t (x, s) + activePhaseGradient X k q t (x, s) = 0) ∧
        ∀ n : ℕ, activeNorm ℓ h t₀ T γ n
          (fun t p => activeMaterial t₀ T U X (activeCurlCorrection X k V) t p +
            activeLabelGradient X q t p) ≤
          K n * D ^ C * lam⁻¹ * activeNorm ℓ h t₀ T γ (n + 1) V) := by
  obtain ⟨a₀, H⟩ := Adapted.ActiveRelay.lemma_5_5 TorusEuler.Paper.lemma_B_1
  refine ⟨a₀, ?_⟩
  intro a ha
  obtain ⟨C, K, H⟩ := H a ha
  refine ⟨C, K, ?_⟩
  intro T hT U X pU k D lam t₀ center hP hL hO
  exact H hT hP.1 hL hO.1

/-- **Theorem 5.6.** If `D^C λ^(-1/12) ≤ 1`, the hierarchy satisfies
the level estimates (5.34)–(5.36), the sums (5.37), and the remainder estimate
(5.38). The exponent is independent of level, depth, and derivative order. -/
theorem theorem_5_6 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℕ → ℝ, ∃ KP : ℕ → ℕ → ℝ,
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      D ^ C * lam ^ (-1 / 12 : ℝ) ≤ 1 →
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ (S5.radius D a) (S5.width lam) amp P R S u →
        let ℓ := S5.radius D a
        let h := S5.width lam
        let γ := S5.weight lam center
        let A := S5.ops d
        let cS := S5.curlCorrection d S
        let W := S5.expansion u P
        -- (5.34), `p = 1`
        (∀ n : ℕ, S5.wNorm ℓ h t₀ γ n (u.V 1) + lam * S5.wNorm ℓ h t₀ γ n (u.p 1) ≤
          K n 1 * D ^ C * lam ^ (-5 / 4 : ℝ)) ∧
        -- (5.34), `p ≥ 2`
        (∀ n : ℕ, ∀ p ∈ Finset.Icc 2 P,
          S5.wNorm ℓ h t₀ γ n (u.V p) +
              S5.wNorm ℓ h t₀ γ n (S5.oscSource A u cS p + S5.suppSource A u p) +
              lam * S5.wNorm ℓ h t₀ γ n (u.p p) ≤
            K n p * D ^ C * lam ^ (-5 / 4 : ℝ) * lam ^ (-2 * ((p : ℝ) - 1) / 3)) ∧
        -- (5.35)
        (∀ n : ℕ, ∀ p ∈ Finset.Icc 2 P,
          S5.uNorm ℓ h n (u.B p) + S5.uNorm ℓ h n (S5.meanSource A u cS R p) ≤
            K n p * D ^ C * lam ^ (-5 / 2 : ℝ) * lam ^ (-2 * ((p : ℝ) - 2) / 3)) ∧
        -- (5.36), `p ≥ 1`
        (∀ n : ℕ, ∀ p ∈ Finset.Icc 1 P,
          S5.wNorm ℓ h t₀ γ n (S5.Cd u (p + 1)) ≤
            K n p * D ^ C * lam ^ (-9 / 4 : ℝ) * lam ^ (-2 * ((p : ℝ) - 1) / 3)) ∧
        -- (5.37)
        (∀ m : ℕ,
          S5.wNorm ℓ h t₀ γ m (W - A.average W) ≤ KP m P * D ^ C * lam ^ (-5 / 4 : ℝ) ∧
          S5.uNorm ℓ h m (∑ p ∈ Finset.Icc 2 P, u.B p) +
              S5.uNorm ℓ h m (∑ p ∈ Finset.Icc 2 P, S5.meanSource A u cS R p) ≤
            KP m P * D ^ C * lam ^ (-5 / 2 : ℝ)) ∧
        -- (5.38)
        ∀ m : ℕ, S5.uNorm ℓ h m (S5.remainder A u P) ≤
          KP m P * lam ^ (-5 / 4 : ℝ) * lam ^ (-2 * (P : ℝ) / 3) := by
  rcases TorusEuler.Paper.theorem_5_6 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨C, K, KP, H⟩
  refine ⟨C, K, KP, ?_⟩
  intro T hT U X pU k D lam t₀ center d χ hP hL hO
  exact H hT d χ hP.1 hL hO.1

/-- **Lemma 5.7.** Graph evaluation obeys (5.44) and (5.45), with
`Λ₁ = D^C λ^(3/2)`, or `Λ₁ = D^C` for phase-independent fields. The
left side of (5.44) sums once over each spatial multi-index, represented by
a nondecreasing coordinate word; the other orderings are discarded from
the authors' stronger estimate. -/
theorem lemma_5_7 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℝ,
    ∀ {T : ℝ} (_hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3},
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      ∀ {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E] (g₀ : HierarchyTwistedProfile T k E),
      let ℓ := S5.radius D a
      let h := S5.width lam
      let γ := S5.weight lam center
      (∀ t ∈ Icc 0 T, ∀ x ∉ S5.envelopeSupport ℓ, ∀ s,
        g₀.val.val.val (t, x, s) = g₀.val.val.val (t, x, 0)) →
      let F := graphRead (fun t => X t 0) g₀
      let bound := fun (Λ₁ γt : ℝ) (N : ℕ → ℝ) (m : ℕ) (t : ℝ) =>
        (∑ i ∈ (Finset.univ.filter (fun i : Fin m → Fin 3 => Monotone i)), spatialSupNorm (spatialDerivativeWord (List.ofFn i) (F t))) ≤
            K m * Λ₁ ^ m * γt * N m ∧
          SpatialHolderHalf m (F t) ∧
          spatialHolderHalfNorm m (F t) ≤ K m * Λ₁ ^ (m + 1) * γt * N (m + 1)
      -- (5.44), (5.45) on `[t₀,T]`
      (∀ m : ℕ, ∀ t ∈ Icc t₀ T,
        bound (D ^ C * lam ^ (3 / 2 : ℝ)) (γ t) (fun n => S5.wNorm ℓ h t₀ γ n g₀) m t) ∧
      -- on `[0,T]` with `γ` replaced by one
      (∀ m : ℕ, ∀ t ∈ Icc 0 T,
        bound (D ^ C * lam ^ (3 / 2 : ℝ)) 1 (fun n => S5.uNorm ℓ h n g₀) m t) ∧
      -- phase-independent fields
      ((∀ t ∈ Icc 0 T, ∀ x s, g₀.val.val.val (t, x, s) = g₀.val.val.val (t, x, 0)) →
        (∀ m : ℕ, ∀ t ∈ Icc t₀ T, bound (D ^ C) (γ t) (fun n => S5.wNorm ℓ h t₀ γ n g₀) m t) ∧
        ∀ m : ℕ, ∀ t ∈ Icc 0 T, bound (D ^ C) 1 (fun n => S5.uNorm ℓ h n g₀) m t) := by
  classical
  rcases TorusEuler.Paper.lemma_5_7 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨C, K, H⟩
  refine ⟨C, K, ?_⟩
  intro T hT U X pU k D lam t₀ center hP hL hO E _ _ g₀ ℓ h γ hsupp F bound
  have Hread := H hT hP.1 hL hO.1 g₀ hsupp
  refine ⟨?_, ?_, ?_⟩
  · intro m t ht
    have hb := Hread.1 m t ht
    exact ⟨(coordinate_sum_le_ordered_sum m _).trans hb.1, hb.2⟩
  · intro m t ht
    have hb := Hread.2.1 m t ht
    exact ⟨(coordinate_sum_le_ordered_sum m _).trans hb.1, hb.2⟩
  · intro hphase
    refine ⟨?_, ?_⟩
    · intro m t ht
      have hb := (Hread.2.2 hphase).1 m t ht
      exact ⟨(coordinate_sum_le_ordered_sum m _).trans hb.1, hb.2⟩
    · intro m t ht
      have hb := (Hread.2.2 hphase).2 m t ht
      exact ⟨(coordinate_sum_le_ordered_sum m _).trans hb.1, hb.2⟩

/-- **Lemma 5.8.** The approximate velocity `V = U + W♮` is smooth,
odd, and divergence free, and its smooth pressure obeys the momentum identity
(5.46). The oscillatory, mean, and residual estimates are (5.47)–(5.48). -/
theorem lemma_5_8 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ b₀ : ℕ, ∃ Γ₀ : ℕ → ℝ, ∃ K : ℕ → ℕ → ℝ,
    ∀ b : ℕ, b₀ ≤ b → ∀ Γ : ℕ → ℝ, (∀ P, Γ₀ P ≤ Γ P) →
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ (S5.radius D a) (S5.width lam) amp P R S u →
        Γ P * D ^ b * lam ^ (-1 / 12 : ℝ) ≤ 1 →
        let γ := S5.weight lam center
        let A := S5.ops d
        let Y : Velocity := fun t => X t 0
        let W := S5.expansion u P
        let V : Velocity := U + graphRead Y W
        let Pres : Pressure := pU + graphRead Y (S5.expansionPressure u P)
        let RV : Velocity :=
          graphRead Y (S5.remainder A u P + (S + S5.curlCorrection d S))
        let Wosc := graphRead Y (W - A.average W)
        let Wbar := graphRead Y (∑ p ∈ Finset.Icc 2 P, u.B p)
        (ContDiffOn ℝ ∞ (Function.uncurry V) (Icc 0 T ×ˢ (univ : Set Vec3)) ∧
          ∀ t ∈ Icc 0 T, SpatiallyPeriodic (V t) ∧ Function.Odd (V t) ∧
            ∀ x, divergence (V t) x = 0) ∧
        (ContDiffOn ℝ ∞ (Function.uncurry Pres) (Icc 0 T ×ˢ (univ : Set Vec3)) ∧
          ∀ t ∈ Icc 0 T, SpatiallyPeriodic (Pres t)) ∧
        -- (5.46)
        (∀ t ∈ Icc 0 T, ∀ x, momentumResidual (Icc 0 T) V Pres t x = RV t x) ∧
        -- (5.47)
        (∀ t ∈ Icc 0 T, ∀ x, ‖Wosc t x‖ ≤ K 0 P * D ^ b * lam ^ (-5 / 4 : ℝ)) ∧
        -- (5.48)
        (∀ m : ℕ, ∀ t ∈ Icc 0 T, SpatialHolderHalf m (Wosc t) ∧
          spatialHolderHalfNorm m (Wosc t) ≤
            K m P * D ^ (b * (m + 2)) * lam ^ ((3 : ℝ) * ((m : ℝ) + 1) / 2 - 5 / 4)) ∧
        (∀ m : ℕ, ∀ t ∈ Icc 0 T, SpatialHolderHalf m (Wbar t) ∧
          spatialHolderHalfNorm m (Wbar t) ≤ K m P * D ^ (b * (m + 2)) * lam ^ (-5 / 2 : ℝ)) ∧
        ∀ t ∈ Icc 0 T, SpatialHolderHalf 1 (RV t) ∧
          spatialHolderHalfNorm 1 (RV t) ≤
            Γ P * D ^ b * lam ^ (2 : ℝ) * (lam ^ (-2 * (P : ℝ) / 3) + χ.derivativeSize γ) := by
  rcases TorusEuler.Paper.lemma_5_8 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨b₀, Γ₀, K, H⟩
  refine ⟨b₀, Γ₀, K, ?_⟩
  intro b hb Γ hΓ T hT U X pU k D lam t₀ center d χ hP hL hO
  exact H b hb Γ hΓ hT d χ hP.1 hL hO.1

/-- **Lemma 5.9.** The added pressure obeys the upper quadratic-form
bound (5.49). On `[t₀,T]`, the central velocity gradient is the parent gradient
plus `χ̃ a(t,0) ⊗ κ(t,0)` and an error of norm at most `λ^(-1/3)`, as in (5.50). -/
theorem lemma_5_9 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ b₀ : ℕ, ∃ Γ₀ : ℕ → ℝ,
    ∀ b : ℕ, b₀ ≤ b → ∀ Γ : ℕ → ℝ, (∀ P, Γ₀ P ≤ Γ P) →
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ (S5.radius D a) (S5.width lam) amp P R S u →
        Γ P * D ^ b * lam ^ (-1 / 12 : ℝ) ≤ 1 →
        let Y : Velocity := fun t => X t 0
        let V : Velocity := U + graphRead Y (S5.expansion u P)
        let Pnat : Pressure := graphRead Y (S5.expansionPressure u P)
        -- (5.49)
        (∀ t ∈ Icc 0 T, ∀ x v : Vec3,
          ⟪v, fderiv ℝ (gradient (Pnat t)) x v⟫_ℝ ≤ Γ P * D ^ b * lam ^ (-1 / 4 : ℝ) * ‖v‖ ^ 2) ∧
        -- (5.50)
        ∀ t ∈ Icc t₀ T,
          ‖fderiv ℝ (V t) 0 - fderiv ℝ (U t) 0 -
              χ.value t • InnerProductSpace.rankOne ℝ (center t) (S5.waveVector X k t 0)‖ ≤
            lam ^ (-1 / 3 : ℝ) := by
  rcases TorusEuler.Paper.lemma_5_9 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨b₀, Γ₀, H⟩
  refine ⟨b₀, Γ₀, ?_⟩
  intro b hb Γ hΓ T hT U X pU k D lam t₀ center d χ hP hL hO
  exact H b hb Γ hΓ hT d χ hP.1 hL hO.1

/-- **Lemma 5.10.** If the smooth divergence-free perturbation satisfies
`‖v‖_{C_t C²} ≤ λ^(-5/2)`, then the flow of `V+v` satisfies both
bounds (5.51), with `C = Γ_P D^b λ^(1/4)`. The single `C²` hypothesis
is the finite sum of spatial derivative suprema. -/
theorem lemma_5_10 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ b₀ : ℕ, ∃ Γ₀ : ℕ → ℝ,
    ∀ b : ℕ, b₀ ≤ b → ∀ Γ : ℕ → ℝ, (∀ P, Γ₀ P ≤ Γ P) →
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (u : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ (S5.radius D a) (S5.width lam) amp P R S u →
        Γ P * D ^ b * lam ^ (-1 / 12 : ℝ) ≤ 1 →
        let V : Velocity := U + graphRead (fun t => X t 0) (S5.expansion u P)
        let Cflow := Γ P * D ^ b * lam ^ (1 / 4 : ℝ)
        ∀ v : Velocity, ContDiffOn ℝ ∞ (Function.uncurry v) (Icc 0 T ×ˢ (univ : Set Vec3)) →
          (∀ t ∈ Icc 0 T, SpatiallyPeriodic (v t)) →
          (∀ t ∈ Icc 0 T, ∀ x, divergence (v t) x = 0) →
          (∀ t ∈ Icc 0 T, spatialC2Norm (v t) ≤ lam ^ (-5 / 2 : ℝ)) →
          ∀ Yf : ℝ → Velocity, IsLabelFlowOn (V + v) Yf (Icc 0 T) →
            ∀ t ∈ Icc 0 T, ∀ x, ‖fderiv ℝ (Yf 0 t) x‖ ≤ Cflow ∧ ‖fderiv ℝ (Yf t 0) x‖ ≤ Cflow := by
  rcases TorusEuler.Paper.lemma_5_10 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨b₀, Γ₀, H⟩
  refine ⟨b₀, Γ₀, ?_⟩
  intro b hb Γ hΓ T hT U X pU k D lam t₀ center d χ hP hL hO
    amp hamp P hPord R S u hexp hsmall V Cflow v hv hp hdiv hnorm
  have hjets : ∀ t ∈ Icc 0 T, ∀ j ≤ 2, ∀ x,
      ‖iteratedFDeriv ℝ j (v t) x‖ ≤ lam ^ (-5 / 2 : ℝ) := by
    intro t ht j hj x
    exact (norm_jet_le_spatialC2Norm (Lib.S5a.contDiff_slice hv ht) (hp t ht) hj x).trans
      (hnorm t ht)
  exact (H b hb Γ hΓ hT d χ hP.1 hL hO.1 amp hamp P hPord R S u hexp hsmall
    v hv hp hdiv hjets).2

/-- **Proposition 5.11.** For `Λ ≥ 1`, the cutoff `u = S_Λ V` and its
zero-mean Poisson pressure have the stated Fourier supports and satisfy
(5.56)–(5.57). The exponent `2-P` in (5.55) is an integer difference.
The two terms in the sum of time suprema are evaluated at independent times. -/
theorem proposition_5_11 :
  ∀ ψ : Vec3 → ℝ, S5.CutoffSymbol ψ →
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ b₀ : ℕ, ∃ Γ₀ : ℕ → ℝ, ∃ (C : ℝ) (K : ℕ → ℝ),
    ∀ b : ℕ, b₀ ≤ b → ∀ Γ : ℕ → ℝ, (∀ P, Γ₀ P ≤ Γ P) →
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam t₀ : ℝ} {center : ℝ → Vec3} (d : ParentGeometry hT U X k) (χ : PaperWaveCutoff t₀ T),
      PaperParent T U X pU D lam → S5.Launch T X k lam t₀ → NormalizedOrigin T U X k D lam t₀ center →
      ∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
      ∀ P : ℕ, 2 ≤ P →
      ∀ (R S : HierarchyTwistedProfile T k Vec3)
        (w : HierarchyProfiles (HierarchyTwistedProfile T k Vec3) (HierarchyTwistedProfile T k ℝ)),
        S5.IsExpansion d pU χ (S5.radius D a) (S5.width lam) amp P R S w →
        Γ P * D ^ b * lam ^ (-1 / 12 : ℝ) ≤ 1 →
        ∀ Λ : ℝ, 1 ≤ Λ →
        let Y : Velocity := fun t => X t 0
        let V : Velocity := U + graphRead Y (S5.expansion w P)
        let Pres : Pressure := pU + graphRead Y (S5.expansionPressure w P)
        let RV : Velocity := graphRead Y (S5.remainder (S5.ops d) w P + (S + S5.curlCorrection d S))
        let ε := Λ ^ ((2 : ℤ) - P) * (1 + slabSpatialHolderHalfNorm T P V) ^ 2
        let e := C * slabSpatialHolderHalfNorm T 1 RV + K P * ε
        (∃ (u : Velocity) (p : Pressure), S5.IsTruncation T ψ Λ V u p) ∧
        ∀ (u : Velocity) (p : Pressure), S5.IsTruncation T ψ Λ V u p →
          let Ru := momentumResidual (Icc 0 T) u p
          -- `u` smooth, odd, divergence free, frequencies at most `2Λ`
          (ContDiffOn ℝ ∞ (Function.uncurry u) (Icc 0 T ×ˢ (univ : Set Vec3)) ∧
            ∀ t ∈ Icc 0 T, Function.Odd (u t) ∧ (∀ x, divergence (u t) x = 0) ∧
              ∃ c : C(UnitAddTorus (Fin 3), Vec3),
                (∀ x, c (toUnitTorus x) = u t x) ∧ RealTorusFourierBand (2 * Λ) c) ∧
          -- `R_u` odd, divergence free, frequencies at most `4Λ`
          (∀ t ∈ Icc 0 T, Function.Odd (Ru t) ∧ (∀ x, divergence (Ru t) x = 0) ∧
            ∃ c : C(UnitAddTorus (Fin 3), Vec3),
              (∀ x, c (toUnitTorus x) = Ru t x) ∧ RealTorusFourierBand (4 * Λ) c) ∧
          -- (5.56)
          (∀ t ∈ Icc 0 T, SpatialHolderHalf 2 (u t - V t) ∧
            spatialHolderHalfNorm 2 (u t - V t) ≤ K P * ε) ∧
          (∀ t ∈ Icc 0 T, ∀ t' ∈ Icc 0 T, SpatialHolderHalf 1 (Ru t) ∧
            SpatialHolderHalf 0 (fderiv ℝ (gradient (p t' - Pres t'))) ∧
            spatialHolderHalfNorm 1 (Ru t) +
                spatialHolderHalfNorm 0 (fderiv ℝ (gradient (p t' - Pres t'))) ≤ e) ∧
          -- (5.57)
          ∀ t ∈ Icc 0 T, ∀ x v : Vec3,
            ⟪v, fderiv ℝ (gradient (p t - pU t)) x v⟫_ℝ ≤
              (Γ P * D ^ b * lam ^ (-1 / 4 : ℝ) + e) * ‖v‖ ^ 2 := by
  intro ψ hψ
  rcases TorusEuler.Paper.proposition_5_11 ψ hψ with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨b₀, Γ₀, C, K, H⟩
  refine ⟨b₀, Γ₀, C, K, ?_⟩
  intro b hb Γ hΓ T hT U X pU k D lam t₀ center d χ hP hL hO
  exact H b hb Γ hΓ hT d χ hP.1 hL hO.1

/-- **Display (5.13).** For `m ≥ 1`, the kinetic and vorticity coefficients
satisfy `ℓ_*^m (|K|_{m,1/2}+|Ω|_{m,1/2}) ≤ C_m D^C √ℓ_* ≤ C_m/A`.
The coefficient norms use the paper's sum of the supremum and Hölder seminorm.
The local premise `0 < A ≤ D^CA` is the bound for the endpoint inverse used
in this display; (5.13) itself does not establish that inverse bound. -/
theorem eq_5_13 :
  ∀ CA : ℕ, ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ Cm : ℕ → ℝ,
    ∀ {T : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {D lam : ℝ},
      0 < T → PaperParent T U X pU D lam →
      ∀ A : ℝ, 0 < A → A ≤ D ^ CA →
      let ℓ := S5.radius D a
      let Kin : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t => meanKinetic X t.val
      let Om : Icc (0 : ℝ) T → Vec3 → (Vec3 →L[ℝ] Vec3) := fun t => meanVorticity U X t.val
      ∀ m : ℕ, 1 ≤ m →
        ℓ ^ m * (Adapted.Norms.paperHolderOrderNorm m Kin + Adapted.Norms.paperHolderOrderNorm m Om) ≤ Cm m * D ^ C * Real.sqrt ℓ ∧
        Cm m * D ^ C * Real.sqrt ℓ ≤ Cm m / A := by
  intro CA
  rcases TorusEuler.Paper.Text.eq_5_13 CA with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨C, Cm, H⟩
  refine ⟨C, fun m => 2 * Cm m, ?_⟩
  intro T U X pU D lam hT hP A hA hAD ℓ Kin Om m hm
  have hb := H hT hP.1 A hA hAD m hm
  have hK := (Adapted.Norms.paperHolderOrderNorm_comparison m Kin
    (fun w hw => (hb.1 w hw).1)).2
  have hOm := (Adapted.Norms.paperHolderOrderNorm_comparison m Om
    (fun w hw => (hb.1 w hw).2)).2
  have hℓ : 0 ≤ ℓ := (Bridge.radius_pos hP.1 a).le
  constructor
  · calc
      ℓ ^ m * (Adapted.Norms.paperHolderOrderNorm m Kin +
          Adapted.Norms.paperHolderOrderNorm m Om) ≤
          ℓ ^ m * (2 * holderOrderNorm m Kin + 2 * holderOrderNorm m Om) :=
        mul_le_mul_of_nonneg_left (add_le_add hK hOm) (pow_nonneg hℓ m)
      _ = 2 * (ℓ ^ m * (holderOrderNorm m Kin + holderOrderNorm m Om)) := by ring
      _ ≤ 2 * (Cm m * D ^ C * Real.sqrt ℓ) :=
        mul_le_mul_of_nonneg_left hb.2.1 (by norm_num)
      _ = (2 * Cm m) * D ^ C * Real.sqrt ℓ := by ring
  · calc
      (2 * Cm m) * D ^ C * Real.sqrt ℓ = 2 * (Cm m * D ^ C * Real.sqrt ℓ) := by ring
      _ ≤ 2 * (Cm m / A) := mul_le_mul_of_nonneg_left hb.2.2 (by norm_num)
      _ = (2 * Cm m) / A := by ring

/-- **Display (5.14).** Writing `B = Fv` and `g = Fᵀf̄`, one has
`‖v‖_[n],1/2 ≤ C_n D^C ‖g‖_[n],1/2` with no derivative loss. Both norms
use the paper's sum convention. Smooth periodicity on the closed slab supplies
the finite-norm premise of the authors' theorem. -/
theorem eq_5_14 :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ Cn : ℕ → ℝ,
    ∀ {T : ℝ} (hT : 0 < T) {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
      {D lam : ℝ} (d : ParentGeometry hT U X k),
      PaperParent T U X pU D lam →
      ∀ (f B : HierarchyTwistedProfile T k Vec3) (q : HierarchyTwistedProfile T k ℝ),
        S5.MeanSolution d f B q →
        ∀ v : Velocity, ContDiffOn ℝ ∞ (Function.uncurry v) (Icc 0 T ×ˢ (univ : Set Vec3)) →
          (∀ t ∈ Icc 0 T, SpatiallyPeriodic (v t)) →
          (∀ t ∈ Icc 0 T, ∀ x s, B.val.val.val (t, x, s) = fderiv ℝ (X 0 t) x (v t x)) →
          let ℓ := S5.radius D a
          let g : Icc (0 : ℝ) T → Vec3 → Vec3 := fun t x =>
            (meanDeformation X t.val x).adjoint (f.val.val.val (t.val, x, 0))
          ∀ n : ℕ,
            Adapted.Norms.paperHolderFieldNorm ℓ n (fun t : Icc (0 : ℝ) T => v t.val) ≤
                Cn n * D ^ C * Adapted.Norms.paperHolderFieldNorm ℓ n g := by
  rcases TorusEuler.Paper.Text.eq_5_14 with ⟨a₀, H⟩
  refine ⟨a₀, ?_⟩
  intro a ha
  rcases H a ha with ⟨C, Cn, H⟩
  refine ⟨C, fun n => 2 * max (Cn n) 0, ?_⟩
  intro T hT U X pU k D lam d hP f B q hsol v hv hp hB ℓ g n
  let g₀ : ℝ → Vec3 → Vec3 := fun r x =>
    (fderiv ℝ (X 0 r) x).adjoint (f.val.val.val (r, x, 0))
  have hforce : ContDiffOn ℝ ∞ (Function.uncurry fun t x => f.val.val.val (t, x, 0))
      (Icc 0 T ×ˢ (univ : Set Vec3)) := Lib.S5a.slice0_contDiff f
  have hfper : ∀ t ∈ Icc 0 T, SpatiallyPeriodic (fun x => f.val.val.val (t, x, 0)) := by
    intro t ht z x
    have h1 : f.val.val.val (t, x + latticeVector z, 0) =
        f.val.val.val (t, x + latticeVector z, 0 + ⟪k, latticeVector z⟫_ℝ) :=
      ((Lib.S5a.momentum_eval d hsol ht _ _).trans
        (Lib.S5a.momentum_eval d hsol ht _ 0).symm).symm
    exact h1.trans (twistedSlice f t x 0 z)
  have hgs : ContDiffOn ℝ ∞ (Function.uncurry g₀) (Icc 0 T ×ˢ (univ : Set Vec3)) := by
    have adj : ContDiff ℝ ∞ (fun F : Vec3 →L[ℝ] Vec3 => F.adjoint) :=
      (ContinuousLinearMap.adjoint : (Vec3 →L[ℝ] Vec3) ≃ₗᵢ⋆[ℝ] (Vec3 →L[ℝ] Vec3)).contDiff
    exact (adj.comp_contDiffOn (hP.1.flow.contDiffOn_forwardLabelDerivative hT
      hP.1.velocity_smooth hP.1.velocity_periodic)).clm_apply hforce
  have hgp : ∀ t ∈ Icc 0 T, SpatiallyPeriodic (g₀ t) := by
    intro t ht z x
    change (fderiv ℝ (X 0 t) (x + latticeVector z)).adjoint
        (f.val.val.val (t, x + latticeVector z, 0)) =
      (fderiv ℝ (X 0 t) x).adjoint (f.val.val.val (t, x, 0))
    have hF : fderiv ℝ (X 0 t) (x + latticeVector z) = fderiv ℝ (X 0 t) x :=
      Lib.S5a.parent_deformation_periodic hT hP.1 ht z x
    rw [hF]
    exact congrArg (fun w => (fderiv ℝ (X 0 t) x).adjoint w) (hfper t ht z x)
  have hg : HolderFieldNormFinite ℓ n g :=
    holderNormFinite_of_smooth_periodic hT (Bridge.radius_pos hP.1 a).le hgs hgp n
  have hb := H hT d hP.1 f B q hsol v hv hp hB n hg
  have hvNorm := (Adapted.Norms.paperHolderFieldNorm_comparison hb.1).2
  have hgNorm := (Adapted.Norms.paperHolderFieldNorm_comparison hg).1
  have hg0 := Adapted.Norms.holderFieldNorm_nonneg hg
  have hD0 : 0 ≤ D := (by norm_num : (0 : ℝ) ≤ 2).trans hP.1.scale_ge_two
  calc
    _ ≤ 2 * holderFieldNorm (S5.radius D a) n (fun t : Icc (0 : ℝ) T => v t.val) := hvNorm
    _ ≤ 2 * (Cn n * D ^ C * holderFieldNorm ℓ n g) :=
      mul_le_mul_of_nonneg_left hb.2 (by norm_num)
    _ ≤ 2 * (max (Cn n) 0 * D ^ C * holderFieldNorm ℓ n g) := by
      apply mul_le_mul_of_nonneg_left _ (by norm_num)
      exact mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_right (le_max_left _ _) (pow_nonneg hD0 C)) hg0
    _ ≤ 2 * (max (Cn n) 0 * D ^ C * Adapted.Norms.paperHolderFieldNorm ℓ n g) := by
      apply mul_le_mul_of_nonneg_left _ (by norm_num)
      exact mul_le_mul_of_nonneg_left hgNorm (mul_nonneg (le_max_right _ _) (pow_nonneg hD0 C))
    _ = (2 * max (Cn n) 0) * D ^ C * Adapted.Norms.paperHolderFieldNorm ℓ n g := by ring

/-- **Display (5.59).** For a fixed continuous bilinear product,
`‖fg‖_{C^{m,1/2}} ≤ C_m ‖f‖_{C^{m,1/2}} ‖g‖_{C^{m,1/2}}`.
The product is fixed before its constant, and the torus fields are periodic lifts. -/
theorem eq_5_59 :
    ∀ m : ℕ, ∀ {E F G : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
      [NormedAddCommGroup F] [NormedSpace ℝ F] [NormedAddCommGroup G] [NormedSpace ℝ G]
      (B : E →L[ℝ] F →L[ℝ] G),
      ∃ Cm : ℝ, 0 ≤ Cm ∧ ∀ (f : Vec3 → E) (g : Vec3 → F),
        SpatiallyPeriodic f → SpatiallyPeriodic g →
        SpatialHolderHalf m f → SpatialHolderHalf m g →
        spatialHolderHalfNorm m (fun x => B (f x) (g x)) ≤
          Cm * spatialHolderHalfNorm m f * spatialHolderHalfNorm m g := by
  intro m E F G _ _ _ _ _ _ B
  rcases TorusEuler.Paper.Text.eq_5_59 m with ⟨C, hC, H⟩
  refine ⟨C * ‖B‖, mul_nonneg hC (norm_nonneg B), ?_⟩
  intro f g _ _ hf hg
  exact (H B f g hf hg).2

end Adapted.S5
