import Adapted.S4

/-! # Appendix A. The Hölder inverse

`C1HalfOn` and `c1HalfNorm`, defined once in `Adapted.S4`, express the
coefficient regularity and its actual norm. Theorem A.1 no longer asks
for separate arbitrary caps on the value and its derivative.

Lemma A.2 uses the actual `C¹` norm, namely the sum of the uniform
norms of the coefficient and its first derivative. Its proof passes
`2 sup ‖DB‖` to the authors' Lipschitz estimate and absorbs `2^p` in
the one absolute constant common to the spatial and time-path cases.
-/

open MeasureTheory Set
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper Adapted.S4

namespace Adapted.SA

noncomputable section

local notation "A" => UnitAddTorus (Fin 3)
local notation "C½" => HalfHolder A Vec3
local notation "K½" => HalfHolder A (Vec3 →L[ℝ] Vec3)
local notation "DK½" => HalfHolder A (Vec3 →L[ℝ] (Vec3 →L[ℝ] Vec3))
local notation "S" => endpointHalfHolderSolenoidal
local notation "J(" T ")" => Icc (0 : ℝ) T
local notation "Slab(" T ")" => Set.prod (Icc (0 : ℝ) T) (univ : Set Vec3)
local notation "Paths" => Lp Vec3 2 (volume.restrict (Ioc (0 : ℝ) 1))

/-- The solenoidal subspace carries its inherited norm. -/
local instance solenoidalNormedGroup : NormedAddCommGroup S := inferInstance

/-- The solenoidal subspace carries its inherited real normed-space structure. -/
local instance solenoidalNormedSpace : NormedSpace ℝ S := inferInstance

set_option maxHeartbeats 800000 in
/-- Theorem A.1. Under (A.1)–(A.2), the integrated endpoint system
has a unique displacement, constant solenoidal field, and pressure gradient
in the stated Hölder class. With
`Q = 2 + κ⁻¹ + μ⁻¹ + ‖K‖₁ + ‖Ω‖₁`, the velocity obeys
`‖z_t‖₀ ≤ C Q^p ‖L‖₀`. Smooth coefficients and source give smooth
`z`, `c` and `∇φ`. All constants precede the coefficient data. -/
theorem theorem_A_1 :
  ∃ (C : ℝ) (p : ℕ), 0 ≤ C ∧
  ∀ (K Ω : ℝ → K½) (DK DΩ : ℝ → DK½) (κ μ : ℝ),
    (∀ t ∈ J(1), ∀ a, IsSelfAdjoint (HalfHolder.eval a (K t))) →
    (∀ t ∈ J(1), ∀ a, (HalfHolder.eval a (Ω t)).adjoint = -HalfHolder.eval a (Ω t)) →
    C1HalfOn 1 K DK → C1HalfOn 1 Ω DΩ →
    0 < κ → (∀ t ∈ J(1), ∀ a (w : Vec3), κ * ‖w‖ ^ 2 ≤ ⟪HalfHolder.eval a (K t) w, w⟫_ℝ) →
    0 < μ → EndpointSobolevEnergyBound K Ω μ →
    let Q : ℝ := 2 + κ⁻¹ + μ⁻¹ + c1HalfNorm 1 K DK + c1HalfNorm 1 Ω DΩ
    ∀ L : ℝ → C½, ContinuousOn L J(1) →
      ∃ (z v : ℝ → S) (c : S) (φ : Pressure) (G : ℝ → C½),
        EndpointSystemSolution 1 K Ω L z v c φ G ∧
        (∀ (z' v' : ℝ → S) (c' : S) (φ' : Pressure) (G' : ℝ → C½),
          EndpointSystemSolution 1 K Ω L z' v' c' φ' G' →
          EqOn z' z J(1) ∧ EqOn v' v J(1) ∧ c' = c ∧ EqOn G' G J(1)) ∧
        endpointClosedTimeNorm 1 v ≤ C * Q ^ p * endpointClosedTimeNorm 1 L ∧
        (ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (K q.1)) Slab(1) →
          ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (Ω q.1)) Slab(1) →
          ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (L q.1)) Slab(1) →
          ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (z q.1 : C½))
              Slab(1) ∧
            ContDiff ℝ ∞ (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) (c : C½)) ∧
            ContDiffOn ℝ ∞ (fun q : ℝ × Vec3 => HalfHolder.eval (toUnitTorus q.2) (G q.1)) Slab(1)) := by
  obtain ⟨C, p, hC, h⟩ := TorusEuler.Paper.theorem_A_1
  refine ⟨C * 2 ^ p, p, mul_nonneg hC (by positivity), ?_⟩
  intro K Ω DK DΩ κ μ hSym hSkew hK hΩ hκ hPos hμ hEnergy
  dsimp only
  intro L hL
  let nK := c1HalfNorm 1 K DK
  let nΩ := c1HalfNorm 1 Ω DΩ
  have hKb := c1HalfOn_coefficientBound hK
  have hΩb := c1HalfOn_coefficientBound hΩ
  have hKn : 0 ≤ nK := hKb.1
  have hΩn : 0 ≤ nΩ := hΩb.1
  have hBase : 2 + κ⁻¹ + μ⁻¹ + nK + nK + nΩ + nΩ ≤
      2 * (2 + κ⁻¹ + μ⁻¹ + nK + nΩ) := by
    linarith only [inv_nonneg.mpr hκ.le, inv_nonneg.mpr hμ.le]
  have hBase0 : 0 ≤ 2 + κ⁻¹ + μ⁻¹ + nK + nK + nΩ + nΩ := by
    linarith only [inv_nonneg.mpr hκ.le, inv_nonneg.mpr hμ.le, hKn, hΩn]
  have hBound : C * (2 + κ⁻¹ + μ⁻¹ + nK + nK + nΩ + nΩ) ^ p ≤
      (C * 2 ^ p) * (2 + κ⁻¹ + μ⁻¹ + nK + nΩ) ^ p := by
    calc
      _ ≤ C * (2 * (2 + κ⁻¹ + μ⁻¹ + nK + nΩ)) ^ p :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hBase0 hBase p) hC
      _ = _ := by rw [mul_pow]; ring
  obtain ⟨z, v, c, φ, G, hSol, hUnique, hNorm, hSmooth⟩ :=
    h K Ω κ μ nK nK nΩ nΩ hSym hSkew hKb hΩb hκ hPos hμ hEnergy L hL
  refine ⟨z, v, c, φ, G, hSol, hUnique, ?_, hSmooth⟩
  exact hNorm.trans (mul_le_mul_of_nonneg_right hBound
    (endpointClosedTimeNorm_nonneg (by norm_num) L))

/-- The coefficient norm `‖B‖_{C¹_a L(H)}` of (A.5): uniform
operator norm plus uniform norm of the first derivative of the periodic lift. -/
def coefficientC1Norm {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    (B : HalfHolder A (H →L[ℝ] H)) : ℝ :=
  ‖B.val.1‖ + spatialSupNorm (fderiv ℝ (fun x => HalfHolder.eval (toUnitTorus x) B))

/-- The compressed operator `RB` is an isomorphism on the solenoidal
half-Hölder space with bound (A.5), using the actual `C¹` coefficient norm.
At each higher order allowed by `B`, the same operator and its inverse
preserve `C^{k,1/2}` with bounded norms. -/
def C1FreezingConclusion {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    (R : HalfHolder A H →L[ℝ] HalfHolder A H)
    (hR : ∀ f, R (R f) = R f) (C : ℝ) (p : ℕ)
    (B : HalfHolder A (H →L[ℝ] H)) (μ : ℝ) : Prop :=
  ∃ e : freezingFixedSpace R ≃L[ℝ] freezingFixedSpace R,
    (e : freezingFixedSpace R →L[ℝ] freezingFixedSpace R) =
      freezingCompression R B.coefficientMul hR ∧
    (∀ v : freezingFixedSpace R, ‖v‖ ≤ C * (2 + μ⁻¹ + coefficientC1Norm B) ^ p * ‖e v‖) ∧
    ∀ k : ℕ, 1 ≤ k →
      SpatialHolderHalf k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) B) →
      (∀ v : freezingFixedSpace R,
        SpatialHolderHalf k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) v.val) ↔
          SpatialHolderHalf k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) (e v).val)) ∧
      ∃ Ck : ℝ, 0 ≤ Ck ∧ ∀ v : freezingFixedSpace R,
        SpatialHolderHalf k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) v.val) →
        spatialHolderHalfNorm k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) (e v).val) ≤
            Ck * spatialHolderHalfNorm k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) v.val) ∧
          spatialHolderHalfNorm k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) v.val) ≤
            Ck * spatialHolderHalfNorm k (fun x : Vec3 => HalfHolder.eval (toUnitTorus x) (e v).val)

/-- Passing from the Lipschitz estimate to (A.5) costs only the
absolute factor `2^p`: `sup |B| + 2 sup |DB|` is at most twice the
quantity `2 + μ⁻¹ + ‖B‖_{C¹}`. -/
theorem freezingConclusion_of_c1 {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    (R : HalfHolder A H →L[ℝ] HalfHolder A H)
    (hR : ∀ f, R (R f) = R f) {C μ : ℝ} {p : ℕ}
    (B : HalfHolder A (H →L[ℝ] H)) (hC : 0 ≤ C) (hμ : 0 < μ)
    (hM : 0 ≤ spatialSupNorm (fderiv ℝ (fun x => HalfHolder.eval (toUnitTorus x) B)))
    (h : FreezingConclusion R hR C p B μ
      (2 * spatialSupNorm (fderiv ℝ (fun x => HalfHolder.eval (toUnitTorus x) B)))) :
    C1FreezingConclusion R hR (C * 2 ^ p) p B μ := by
  obtain ⟨e, he, hBound, hHigher⟩ := h
  refine ⟨e, he, ?_, hHigher⟩
  intro v
  let M := spatialSupNorm (fderiv ℝ (fun x => HalfHolder.eval (toUnitTorus x) B))
  have hBase : 2 + μ⁻¹ + ‖B.val.1‖ + 2 * M ≤
      2 * (2 + μ⁻¹ + coefficientC1Norm B) := by
    dsimp [coefficientC1Norm, M]
    linarith only [inv_nonneg.mpr hμ.le, norm_nonneg B.val.1]
  have hBase0 : 0 ≤ 2 + μ⁻¹ + ‖B.val.1‖ + 2 * M := by
    dsimp [M]
    positivity
  refine (hBound v).trans ?_
  calc
    _ ≤ C * (2 * (2 + μ⁻¹ + coefficientC1Norm B)) ^ p * ‖e v‖ :=
      mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hBase0 hBase p) hC) (norm_nonneg _)
    _ = _ := by rw [mul_pow]; ring

set_option maxHeartbeats 800000 in
/-- Lemma A.2. In either the spatial case `H=ℝ³, R=P` or the
time-path case `H=L²([0,1];ℝ³), R=PQ`, suppose `B ∈ C^{1,1/2}`
and (A.4) holds with `μ>0` (on zero-time-mean paths in the second
case). Then `RB` is an isomorphism on the range of `R` in
`C^{0,1/2}`, with (A.5). If `B ∈ C^{k,1/2}`, `k≥1`, it is an
isomorphism at that order as well. One pair of dimension-dependent
constants serves both cases. -/
theorem lemma_A_2 :
  ∃ (C : ℝ) (p : ℕ), 0 ≤ C ∧
    (∀ (B : HalfHolder A (Vec3 →L[ℝ] Vec3)) (μ : ℝ),
      0 < μ → SpatialHolderHalf 1 (fun x => HalfHolder.eval (toUnitTorus x) B) →
      (∀ a (w : Vec3), μ * ‖w‖ ^ 2 ≤ ⟪HalfHolder.eval a B w, w⟫_ℝ) →
      C1FreezingConclusion endpointStrongSpatialLeray endpointStrongSpatialLeray_idempotent
        C p B μ) ∧
    (∀ (B : HalfHolder A (Paths →L[ℝ] Paths)) (μ : ℝ),
      0 < μ → SpatialHolderHalf 1 (fun x => HalfHolder.eval (toUnitTorus x) B) →
      (∀ a (w : Paths), endpointIntegral 1 w = 0 → μ * ‖w‖ ^ 2 ≤ ⟪HalfHolder.eval a B w, w⟫_ℝ) →
      C1FreezingConclusion (endpointStrongMixedLeray 1)
        (endpointStrongMixedLeray_idempotent zero_lt_one) C p B μ) := by
  obtain ⟨C, p, hC, hSpatial, hMixed⟩ := TorusEuler.Paper.lemma_A_2
  refine ⟨C * 2 ^ p, p, mul_nonneg hC (by positivity), ?_, ?_⟩
  · intro B μ hμ hB hCoercive
    obtain ⟨hM, hLip⟩ := halfHolder_lipschitz_of_spatialHolderHalf_one B hB
    exact freezingConclusion_of_c1 endpointStrongSpatialLeray
      endpointStrongSpatialLeray_idempotent B hC hμ hM
      (hSpatial B μ _ hμ (mul_nonneg zero_le_two hM) hLip hCoercive)
  · intro B μ hμ hB hCoercive
    obtain ⟨hM, hLip⟩ := halfHolder_lipschitz_of_spatialHolderHalf_one B hB
    exact freezingConclusion_of_c1 (endpointStrongMixedLeray 1)
      (endpointStrongMixedLeray_idempotent zero_lt_one) B hC hμ hM
      (hMixed B μ _ hμ (mul_nonneg zero_le_two hM) hLip hCoercive)

end

end Adapted.SA
