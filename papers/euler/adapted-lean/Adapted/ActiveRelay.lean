import Adapted.ActiveRelayCalculus
import Adapted.ActiveRelayLeading
import TorusEuler.PaperHierarchyRelay
import TorusEuler.PaperHierarchyActiveNormBounds
import TorusEuler.Paper.Proofs.S5a.Proposition51
import TorusEuler.Paper.Proofs.S5b.Library.Fields

/-! # The relay estimates on their actual active interval

The generic-time estimates for the raw potential and linear relay are
applied directly to slices indexed by `[t₀,T]`. Their word bounds follow
from the authors' active-profile compactness lemma. The geometric
coefficient budget still comes from the original parent on `[0,T]`.
No extension of an arbitrary active profile is assumed.
-/

open Set Function ContinuousLinearMap UnitAddTorus
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper TorusEuler.HierarchyTwistedProfile
open TorusEuler.HierarchyTwistedProfile.PhysicalApproximationData

set_option maxHeartbeats 1200000

noncomputable section

namespace Adapted.ActiveRelay

/-- Multiplication by a scalar depending only on time preserves the
smoothness of each label-phase slice of an active profile. -/
theorem weighted_slice_smooth {t₀ T : ℝ} {k : Vec3}
    {V : ℝ → Vec3 × ℝ → Vec3} (hV : Profile t₀ T k V) (γ : ℝ → ℝ)
    (t : Icc t₀ T) : ContDiff ℝ ∞ (fun x => (γ t)⁻¹ • V t x) := by
  have hs : ContDiff ℝ ∞ (V t) :=
    contDiffOn_univ.mp (hV.1.comp (contDiff_const.prodMk contDiff_id).contDiffOn
      (fun x _ => ⟨t.2, mem_univ x⟩))
  exact (contDiff_const (c := ((γ t)⁻¹ : ℝ))).smul hs

/-- The active norm is a bound for each of its weighted derivative words.
The boundedness premise is obtained from active smoothness and the two
periodicity laws, without using any values before activation. -/
theorem weighted_word_bound {ℓ h t₀ T : ℝ} {k : Vec3}
    {V : ℝ → Vec3 × ℝ → Vec3} {γ : ℝ → ℝ} {B : ℝ}
    (htT : t₀ < T) (hV : Profile t₀ T k V)
    (hγ : ∀ t ∈ Icc t₀ T, ‖(γ t)⁻¹‖ ≤ B) (n : ℕ) :
    HierarchyRelayWordBound ℓ h n (norm ℓ h t₀ T γ n V)
      (fun (t : Icc t₀ T) x => (γ t)⁻¹ • V t x) := by
  exact hierarchyRelayWordBound_of_finiteNorm (fun w _ =>
    paperHierarchyActiveWord_bddAbove htT hV.1 hV.2.1 hV.2.2
      (fun _ ht => ht) (fun t => (γ t)⁻¹) hγ w)

/-- Active weighted norms are nonnegative for smooth twisted profiles. -/
theorem norm_nonneg {ℓ h t₀ T : ℝ} {k : Vec3}
    {V : ℝ → Vec3 × ℝ → Vec3} {γ : ℝ → ℝ} {B : ℝ}
    (htT : t₀ < T) (hV : Profile t₀ T k V)
    (hγ : ∀ t ∈ Icc t₀ T, ‖(γ t)⁻¹‖ ≤ B) (n : ℕ) :
    0 ≤ norm ℓ h t₀ T γ n V :=
  (weighted_word_bound htT hV hγ n).1

/-- The zero field is an active profile for every carrier. -/
theorem profile_zero (t₀ T : ℝ) (k : Vec3) :
    Profile t₀ T k (fun _ _ => (0 : Vec3)) :=
  ⟨contDiffOn_const, fun _ _ _ _ => rfl, fun _ _ _ _ _ => rfl⟩

/-- The weighted active norm of the zero field is zero. -/
theorem norm_zero (ℓ h t₀ T : ℝ) (γ : ℝ → ℝ) (n : ℕ) :
    norm ℓ h t₀ T γ n (fun _ _ => (0 : Vec3)) = 0 := by
  unfold norm S5.fieldNorm
  have hz : (fun (t : Icc t₀ T) (_ : Vec3 × ℝ) => (γ t)⁻¹ • (0 : Vec3)) =
      (0 : Icc t₀ T → Vec3 × ℝ → Vec3) := by
    funext t x
    exact smul_zero _
  rw [hz]
  exact S5b.fieldNorm_zero

/-- The raw divergence correction obeys (5.31) on the active interval
under a fixed normalized coefficient budget. -/
theorem completion_bound {T t₀ D lam ℓ h K B : ℝ}
    {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    {γ : ℝ → ℝ} (hT : 0 < T) (hP : S5.Parent T U X pU D lam)
    (hL : S5.Launch T X k lam t₀) (hℓ : ℓ ≠ 0) (n : ℕ)
    {V : ℝ → Vec3 × ℝ → Vec3} (hV : Profile t₀ T k V)
    (hVmean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => V t (a, s)) = 0)
    (hγ : ∀ t ∈ Icc t₀ T, ‖(γ t)⁻¹‖ ≤ B)
    (hCoeff : WaveRelayCoefficientBudget ℓ h n K
      (fun (t : Icc t₀ T) a => fderiv ℝ (X t 0) (X 0 t a))
      (fun (t : Icc t₀ T) a => S5.strainField U X t a)
      (fun (t : Icc t₀ T) a => lam⁻¹ • S5.waveVector X k t a)) :
    norm ℓ h t₀ T γ n (curlCorrection X k V) ≤
      completionOrderConstant n * K ^ 2 * lam⁻¹ * norm ℓ h t₀ T γ (n + 1) V := by
  have hlam : 0 < lam := zero_lt_one.trans_le hP.frequency_ge_one
  let W (t : Icc t₀ T) (x : Vec3 × ℝ) := (γ t)⁻¹ • V t x
  let G (t : Icc t₀ T) (x : Vec3 × ℝ) := fderiv ℝ (X t 0) (X 0 t x.1)
  let κ (t : Icc t₀ T) (a : Vec3) := lam⁻¹ • S5.waveVector X k t a
  have hWp (t : Icc t₀ T) (a : Vec3) :
      Function.Periodic (fun s => W t (a, s)) 1 := by
    intro s
    exact congrArg ((γ t)⁻¹ • ·) (hV.2.1 t t.2 a s)
  have hWmean (t : Icc t₀ T) (a : Vec3) : phaseMean (fun s => W t (a, s)) = 0 := by
    change phaseMean (fun s => (γ t)⁻¹ • V t (a, s)) = 0
    rw [phaseMean_const_smul, hVmean t t.2 a, smul_zero]
  have hb := hierarchyFiniteWordNorm_waveCompletion_le (G := G) (k := κ)
    n hℓ hlam (weighted_slice_smooth hV γ) hWp hWmean
    (weighted_word_bound hL.start_lt hV hγ (n + 1))
    (fun i => (hCoeff.curl i).1) (fun i => (hCoeff.curl i).2)
    hCoeff.potential.1 hCoeff.potential.2
  have hScale (t : Icc t₀ T) (a : Vec3) : lam • κ t a = S5.waveVector X k t a := by
    dsimp [κ]
    rw [smul_smul, mul_inv_cancel₀ hlam.ne', one_smul]
  dsimp only at hb
  simp_rw [hScale] at hb
  have hEq : (fun (t : Icc t₀ T) x => (γ t)⁻¹ • curlCorrection X k V t x) =
      fun (t : Icc t₀ T) x =>
        curlOfDerivative ((hierarchyRelayLabelJet
          (relayPotentialProfile (S5.waveVector X k t) (W t)) x).comp (G t x)) := by
    funext t x
    rw [curlCorrection_eq_relayPotential hT hP hL hV t.2 x]
    rw [show relayPotentialProfile (S5.waveVector X k t) (W t) =
      (γ t)⁻¹ • relayPotentialProfile (S5.waveVector X k t) (V t) from
        relayPotentialProfile_const_smul (γ t)⁻¹ _ _]
    simp only [hierarchyRelayLabelJet, fderiv_const_smul_field, Pi.smul_apply,
      smul_comp, curlOfDerivative_smul]
    rfl
  rw [norm, S5.fieldNorm, hEq]
  refine hb.trans_eq ?_
  dsimp only [completionOrderConstant, norm, S5.fieldNorm]
  ring

/-- The actual material derivative of the active correction obeys (5.32).
The raw identity from `ActiveRelayCalculus` converts the existing generic-time
linear-relay estimate to the paper's differential expression. -/
theorem relay_bound {T t₀ D lam ℓ h K B : ℝ}
    {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    {γ : ℝ → ℝ} (hT : 0 < T) (hP : S5.Parent T U X pU D lam)
    (hL : S5.Launch T X k lam t₀) (hℓ : ℓ ≠ 0) (n : ℕ)
    {V f : ℝ → Vec3 × ℝ → Vec3} {q : ℝ → Vec3 × ℝ → ℝ}
    (hV : Profile t₀ T k V) (hf : Profile t₀ T k f) (hq : Profile t₀ T k q)
    (hVmean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => V t (a, s)) = 0)
    (hfmean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => f t (a, s)) = 0)
    (htrans : ∀ t ∈ Icc t₀ T, ∀ a s, ⟪S5.waveVector X k t a, V t (a, s)⟫_ℝ = 0)
    (hqmean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => q t (a, s)) = 0)
    (hmom : ∀ t ∈ Icc t₀ T, ∀ a s,
      material t₀ T U X V t (a, s) + phaseGradient X k q t (a, s) = f t (a, s))
    (hγ : ∀ t ∈ Icc t₀ T, ‖(γ t)⁻¹‖ ≤ B)
    (hCoeff : WaveRelayCoefficientBudget ℓ h n K
      (fun (t : Icc t₀ T) a => fderiv ℝ (X t 0) (X 0 t a))
      (fun (t : Icc t₀ T) a => S5.strainField U X t a)
      (fun (t : Icc t₀ T) a => lam⁻¹ • S5.waveVector X k t a)) :
    norm ℓ h t₀ T γ n
        (fun t x => material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x) ≤
      waveRelayOrderConstant n * K ^ 2 * lam⁻¹ *
        (norm ℓ h t₀ T γ (n + 1) V + norm ℓ h t₀ T γ (n + 1) f) := by
  have hlam : 0 < lam := zero_lt_one.trans_le hP.frequency_ge_one
  let W (t : Icc t₀ T) (x : Vec3 × ℝ) := (γ t)⁻¹ • V t x
  let F (t : Icc t₀ T) (x : Vec3 × ℝ) := (γ t)⁻¹ • f t x
  let G (t : Icc t₀ T) (a : Vec3) := fderiv ℝ (X t 0) (X 0 t a)
  let M (t : Icc t₀ T) (a : Vec3) := S5.strainField U X t a
  let κ (t : Icc t₀ T) (a : Vec3) := lam⁻¹ • S5.waveVector X k t a
  have hPeriod (Z : ℝ → Vec3 × ℝ → Vec3) (hZ : Profile t₀ T k Z)
      (t : Icc t₀ T) (a : Vec3) :
      Function.Periodic (fun s => (γ t)⁻¹ • Z t (a, s)) 1 :=
    fun s => congrArg ((γ t)⁻¹ • ·) (hZ.2.1 t t.2 a s)
  have hMean (Z : ℝ → Vec3 × ℝ → Vec3)
      (hZ : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => Z t (a, s)) = 0)
      (t : Icc t₀ T) (a : Vec3) :
      phaseMean (fun s => (γ t)⁻¹ • Z t (a, s)) = 0 := by
    rw [phaseMean_const_smul, hZ t t.2 a, smul_zero]
  have hb := hierarchyFiniteWordNorm_waveLinearRelay_le
    (G := G) (M := M) (k := κ) (V := W) (f := F) n hℓ hlam
    (weighted_slice_smooth hV γ) (weighted_slice_smooth hf γ)
    (hPeriod V hV) (hPeriod f hf) (hMean V hVmean) (hMean f hfmean)
    (weighted_word_bound hL.start_lt hV hγ (n + 1))
    (weighted_word_bound hL.start_lt hf hγ (n + 1))
    hCoeff.potential hCoeff.potentialTime hCoeff.pressureAmplitude hCoeff.pressureSource
    hCoeff.curl hCoeff.material hCoeff.gradient
  have hScale (t : Icc t₀ T) : (fun a => lam • κ t a) = S5.waveVector X k t := by
    funext a
    dsimp [κ]
    rw [smul_smul, mul_inv_cancel₀ hlam.ne', one_smul]
  dsimp only at hb
  simp_rw [hScale] at hb
  have hEq :
      (fun (t : Icc t₀ T) x => (γ t)⁻¹ •
        (material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x)) =
      fun (t : Icc t₀ T) x => hierarchyLinearRelayAt (G t x.1) (M t x.1)
        (relayPotentialProfile (S5.waveVector X k t) (W t))
        (relayPotentialTimeProfile (M t) (S5.waveVector X k t) (W t) (F t))
        (relayPhasePressureProfile (M t) (S5.waveVector X k t) (W t) (F t)) x := by
    funext t x
    rw [material_curlCorrection_eq_relay hT hP hL hV hf hq htrans hqmean hmom t.2 x]
    exact (hierarchyLinearRelayAt_input_const_smul (γ t)⁻¹ (G t x.1)
      (M t) (S5.waveVector X k t) (V t) (f t) x).symm
  rw [norm, S5.fieldNorm, hEq]
  exact hb

/-- Bernstein's inequality supplies one list of parent velocity jet bounds
before any parent, time interval or scale is chosen. -/
theorem exists_parent_velocity_jets (hB1 : Statement.lemma_B_1) :
    ∃ R : ℕ → ℝ, (∀ n, 0 ≤ R n) ∧
      ∀ {T : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {D lam : ℝ},
        S5.Parent T U X pU D lam →
        ∀ n j : ℕ, 1 ≤ j → j ≤ n → ∀ t ∈ Icc 0 T, ∀ x,
          ‖iteratedFDeriv ℝ j (U t) x‖ ≤ R n * D ^ j := by
  obtain ⟨R, hR, H⟩ := Lib.S5a.exists_velocityJets_of_lemmaB1 hB1
  refine ⟨R, hR, ?_⟩
  intro T U X pU D lam hP n j hj hjn t ht x
  have hD : 1 ≤ D := one_le_two.trans hP.scale_ge_two
  have hD0 : 0 ≤ D := zero_le_one.trans hD
  obtain ⟨v, hv⟩ := hP.velocity_band
  have hlift : (fun y => v t (toUnitTorus y)) = U t := funext fun y => (hv t ht).1 y
  rw [← hlift]
  apply H (v t) hD
  · intro q hq
    exact (hv t ht).2 q
      ((mul_le_mul_of_nonneg_right (by norm_num : (2 : ℝ) ≤ 4) hD0).trans_lt hq)
  · rw [hlift]
    exact Lib.S5a.contDiff_slice hP.velocity_smooth ht
  · intro y
    rw [hlift]
    exact hP.gradient_le t ht y
  · exact hj
  · exact hjn

/-- Both active relay inequalities have one order-independent exponent
`2(15+a)`, with order constants chosen before the parent or the fields. -/
theorem parent_estimates (hB1 : Statement.lemma_B_1) :
    ∃ K : ℕ → ℝ, (∀ n, 0 ≤ K n) ∧
      ∀ a : ℕ, 16 ≤ a →
      ∀ {T : ℝ} (_hT : 0 < T) {U : Velocity} {X : ℝ → Velocity}
        {pU : Pressure} {k : Vec3} {D lam t₀ : ℝ} {center : ℝ → Vec3},
        S5.Parent T U X pU D lam → S5.Launch T X k lam t₀ →
        S5.Origin T U X k D lam t₀ center →
        let ℓ := S5.radius D a
        let h := S5.width lam
        let γ := S5.weight lam center
        ∀ n : ℕ, ∀ V : ℝ → Vec3 × ℝ → Vec3, Profile t₀ T k V →
          (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => V t (x, s)) = 0) →
          (∀ t ∈ Icc t₀ T, ∀ x s, ⟪S5.waveVector X k t x, V t (x, s)⟫_ℝ = 0) →
          norm ℓ h t₀ T γ n (curlCorrection X k V) ≤
            K n * D ^ (2 * (15 + a)) * lam⁻¹ * norm ℓ h t₀ T γ (n + 1) V ∧
          ∀ (f : ℝ → Vec3 × ℝ → Vec3) (q : ℝ → Vec3 × ℝ → ℝ),
            Profile t₀ T k f → Profile t₀ T k q →
            (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => f t (x, s)) = 0) →
            (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => q t (x, s)) = 0) →
            (∀ t ∈ Icc t₀ T, ∀ x s,
              material t₀ T U X V t (x, s) + phaseGradient X k q t (x, s) = f t (x, s)) →
            norm ℓ h t₀ T γ n
                (fun t x => material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x) ≤
              K n * D ^ (2 * (15 + a)) * lam⁻¹ *
                (norm ℓ h t₀ T γ (n + 1) V + norm ℓ h t₀ T γ (n + 1) f) := by
  obtain ⟨R, hR, hJets⟩ := exists_parent_velocity_jets hB1
  obtain ⟨L, hL, hCoeffs⟩ := exists_transportedWaveRelayCoefficientBudget R hR
  let K (n : ℕ) := max (completionOrderConstant n) (waveRelayOrderConstant n) * (2 * L n) ^ 2
  have hComp (n : ℕ) : 0 ≤ completionOrderConstant n := by
    unfold completionOrderConstant
    positivity
  refine ⟨K, fun n => mul_nonneg ((hComp n).trans (le_max_left _ _)) (sq_nonneg _), ?_⟩
  intro a ha T hT U X pU k D lam t₀ center hP hLaunch hO ℓ h γ n V hV hVmean htrans
  obtain ⟨d, _⟩ := Bridge.exists_truncatedHierarchyParent hT hP hLaunch.carrier_ne_zero
  have hD : 1 ≤ D := one_le_two.trans hP.scale_ge_two
  have hD0 : 0 < D := zero_lt_one.trans_le hD
  have hlam : 0 < lam := zero_lt_one.trans_le hP.frequency_ge_one
  have hℓ : 0 < ℓ := Bridge.radius_pos hP a
  have hsmall : ℓ * D ^ (16 : ℕ) ≤ 1 :=
    (mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hD ha) hℓ.le).trans
      (inv_mul_cancel₀ (pow_ne_zero a hD0.ne')).le
  have hI : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hLaunch
  have hCoeff0 := hCoeffs hT hP.time_le_one hD hP.flow hP.velocity_smooth
    hP.velocity_periodic hP.deformation_le hP.inverse_deformation_le (hJets hP)
    hlam ⟨hLaunch.start_nonneg, hLaunch.start_lt.le⟩ hLaunch.frequency
    d.inverse d.strain d.covector
    (fun t ht x => d.inverse_value (t, x, 0) ⟨ht, mem_univ _⟩)
    (fun t ht x => d.strain_value (t, x, 0) ⟨ht, mem_univ _⟩)
    (fun t ht x => d.covector_value (t, x, 0) ⟨ht, mem_univ _⟩)
    hI (h := h) hℓ.le hsmall n
  let B := 2 * L n * D ^ (15 + a)
  have hwidth : 1 + ‖ℓ⁻¹‖ ≤ 2 * D ^ a := by
    have heq : ℓ⁻¹ = D ^ a := inv_inv _
    rw [heq, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hD0.le _)]
    linarith [one_le_pow₀ hD (n := a)]
  have hCoeff := hCoeff0.mono (show L n * (1 + ‖ℓ⁻¹‖) * D ^ (15 : ℕ) ≤ B by
    calc
      _ ≤ L n * (2 * D ^ a) * D ^ (15 : ℕ) :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hwidth (hL n)) (by positivity)
      _ = _ := by dsimp [B]; rw [pow_add]; ring)
  have hGeq : (fun (t : Icc t₀ T) x => d.inverse.val.val.val (t, x, 0)) =
      (fun (t : Icc t₀ T) x => fderiv ℝ (X t 0) (X 0 t x)) :=
    funext fun t => funext fun x => d.inverse_value (t, x, 0) ⟨hI t.2, mem_univ _⟩
  have hMeq : (fun (t : Icc t₀ T) x => d.strain.val.val.val (t, x, 0)) =
      (fun (t : Icc t₀ T) x => S5.strainField U X t x) :=
    funext fun t => funext fun x => d.strain_value (t, x, 0) ⟨hI t.2, mem_univ _⟩
  have hκeq : (fun (t : Icc t₀ T) x => lam⁻¹ • d.covector.val.val.val (t, x, 0)) =
      (fun (t : Icc t₀ T) x => lam⁻¹ • S5.waveVector X k t x) := by
    funext t x
    rw [d.covector_value (t, x, 0) ⟨hI t.2, mem_univ _⟩]
    rfl
  rw [hGeq, hMeq, hκeq] at hCoeff
  obtain ⟨Bγ, hBγ⟩ := Bridge.Origin.exists_inverse_weight_bound hP hLaunch hO
  have hCap (Z : ℝ) (hZ : Z ≤ max (completionOrderConstant n) (waveRelayOrderConstant n)) :
      Z * B ^ 2 * lam⁻¹ ≤ K n * D ^ (2 * (15 + a)) * lam⁻¹ := by
    calc
      _ ≤ max (completionOrderConstant n) (waveRelayOrderConstant n) * B ^ 2 * lam⁻¹ :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hZ (sq_nonneg _))
          (inv_nonneg.mpr hlam.le)
      _ = _ := by
        dsimp only [B, K]
        rw [mul_pow, ← pow_mul, Nat.mul_comm (15 + a) 2]
        ring
  constructor
  · exact (completion_bound hT hP hLaunch hℓ.ne' n hV hVmean hBγ hCoeff).trans
      (mul_le_mul_of_nonneg_right (hCap _ (le_max_left _ _))
        (norm_nonneg hLaunch.start_lt hV hBγ (n + 1)))
  · intro f q hf hq hfmean hqmean hmom
    exact (relay_bound hT hP hLaunch hℓ.ne' n hV hf hq hVmean hfmean htrans hqmean hmom hBγ hCoeff).trans
      (mul_le_mul_of_nonneg_right (hCap _ (le_max_right _ _))
        (add_nonneg (norm_nonneg hLaunch.start_lt hV hBγ (n + 1))
          (norm_nonneg hLaunch.start_lt hf hBγ (n + 1))))

/-- Lemma 5.5 in raw active-profile form, including the actual periodized
leading field with zero force. Only already proved Bernstein, coefficient,
primitive and relay estimates are used. -/
theorem lemma_5_5 (hB1 : Statement.lemma_B_1) :
  ∃ a₀ : ℕ, ∀ a : ℕ, a₀ ≤ a → ∃ C : ℕ, ∃ K : ℕ → ℝ,
    ∀ {T : ℝ} (_hT : 0 < T) {U : Velocity} {X : ℝ → Velocity}
      {pU : Pressure} {k : Vec3} {D lam t₀ : ℝ} {center : ℝ → Vec3},
      S5.Parent T U X pU D lam → S5.Launch T X k lam t₀ →
      S5.Origin T U X k D lam t₀ center →
      let ℓ := S5.radius D a
      let h := S5.width lam
      let γ := S5.weight lam center
      (∀ n : ℕ, ∀ V : ℝ → Vec3 × ℝ → Vec3, Profile t₀ T k V →
        (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => V t (x, s)) = 0) →
        (∀ t ∈ Icc t₀ T, ∀ x s, ⟪S5.waveVector X k t x, V t (x, s)⟫_ℝ = 0) →
        norm ℓ h t₀ T γ n (curlCorrection X k V) ≤
          K n * D ^ C * lam⁻¹ * norm ℓ h t₀ T γ (n + 1) V ∧
        ∀ (f : ℝ → Vec3 × ℝ → Vec3) (q : ℝ → Vec3 × ℝ → ℝ),
          Profile t₀ T k f → Profile t₀ T k q →
          (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => f t (x, s)) = 0) →
          (∀ t ∈ Icc t₀ T, ∀ x, phaseMean (fun s => q t (x, s)) = 0) →
          (∀ t ∈ Icc t₀ T, ∀ x s,
            material t₀ T U X V t (x, s) + phaseGradient X k q t (x, s) = f t (x, s)) →
          norm ℓ h t₀ T γ n
            (fun t x => material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x) ≤
            K n * D ^ C * lam⁻¹ *
              (norm ℓ h t₀ T γ (n + 1) V + norm ℓ h t₀ T γ (n + 1) f)) ∧
      (∀ amp : ℝ → Vec3 → Vec3, S5.IsSeed U X k t₀ T center amp →
        let V : ℝ → Vec3 × ℝ → Vec3 := fun t p =>
          phaseTwistedPeriodizeCentered k (S5.leading ℓ h amp) t p.1 p.2
        let q : ℝ → Vec3 × ℝ → ℝ := fun t p =>
          phaseTwistedPeriodizeCentered k (S5.leadingPressure U X k ℓ h amp) t p.1 p.2
        (∀ t ∈ Icc t₀ T, ∀ x s,
          material t₀ T U X V t (x, s) + phaseGradient X k q t (x, s) = 0) ∧
        ∀ n : ℕ, norm ℓ h t₀ T γ n
          (fun t x => material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x) ≤
          K n * D ^ C * lam⁻¹ * norm ℓ h t₀ T γ (n + 1) V) := by
  obtain ⟨K, hK, H⟩ := parent_estimates hB1
  refine ⟨16, fun a ha => ⟨2 * (15 + a), K, ?_⟩⟩
  intro T hT U X pU k D lam t₀ center hP hL hO ℓ h γ
  have hMain := H a ha hT hP hL hO
  refine ⟨hMain, ?_⟩
  intro amp hamp V q
  obtain ⟨d, _⟩ := Bridge.exists_truncatedHierarchyParent hT hP hL.carrier_ne_zero
  have hℓ : 0 < ℓ := Bridge.radius_pos hP a
  have hfit : 2 * ℓ < 1 / 2 := Bridge.radius_fits hP.scale_ge_two (by omega : 3 ≤ a)
  have hh : 0 < h := Bridge.width_pos hP
  have hh1 : h ≤ 1 := Bridge.width_le_one hP
  obtain ⟨hV, hq, hVmean, htrans, hqmean, hmom⟩ :=
    leading_admissible hT d hP hL hamp hℓ hfit hh hh1
  refine ⟨hmom, ?_⟩
  intro n
  have hb := (hMain n V hV hVmean htrans).2 (fun _ _ => 0) q
    (profile_zero t₀ T k) hq (fun _ _ _ => phaseMean_const 0) hqmean hmom
  simpa only [norm_zero, add_zero] using hb

end Adapted.ActiveRelay

end
