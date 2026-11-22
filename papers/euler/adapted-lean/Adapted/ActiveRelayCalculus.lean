import TorusEuler.Paper.S5.Vocabulary
import TorusEuler.Paper.Proofs.S5Bridge.Parent
import TorusEuler.HierarchyTwistedRelayBounds
import TorusEuler.HierarchyRelayPotentialCoefficientBounds

/-! # Calculus on the active time interval

These definitions and identities use only values on `[t₀,T]`. In particular,
the time derivative of the curl correction is taken within that interval.
-/

open Set ContinuousLinearMap
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper

namespace Adapted.ActiveRelay

noncomputable section

set_option maxHeartbeats 1200000

/-- A smooth phase-periodic field on the active interval, with the coupled
lattice translation of Section 3.1. No extension before activation is used. -/
def Profile {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (t₀ T : ℝ) (k : Vec3) (V : ℝ → Vec3 × ℝ → E) : Prop :=
  ContDiffOn ℝ ∞ (Function.uncurry V) (Icc t₀ T ×ˢ univ) ∧
  (∀ t ∈ Icc t₀ T, ∀ a s, V t (a, s + 1) = V t (a, s)) ∧
  ∀ t ∈ Icc t₀ T, ∀ a s (z : Fin 3 → ℤ),
    V t (a + latticeVector z, s + ⟪k, latticeVector z⟫_ℝ) = V t (a, s)

/-- The finite label-phase norm weighted by the central amplitude on
the active interval. The time weight is constant under every spatial derivative. -/
def norm {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (ℓ h t₀ T : ℝ) (γ : ℝ → ℝ) (n : ℕ) (V : ℝ → Vec3 × ℝ → E) : ℝ :=
  S5.fieldNorm ℓ h (Icc t₀ T) (fun t => (γ t)⁻¹) n V

/-- The operator `∂t + M`, using the derivative within the active interval. -/
def material (t₀ T : ℝ) (U : Velocity) (X : ℝ → Velocity)
    (V : ℝ → Vec3 × ℝ → Vec3) : ℝ → Vec3 × ℝ → Vec3 :=
  fun t p => derivWithin (fun r => V r p) (Icc t₀ T) t +
    S5.strainField U X t p.1 (V t p)

/-- The phase gradient `κ ∂s q`. -/
def phaseGradient (X : ℝ → Velocity) (k : Vec3)
    (q : ℝ → Vec3 × ℝ → ℝ) : ℝ → Vec3 × ℝ → Vec3 :=
  fun t p => deriv (fun s => q t (p.1, s)) p.2 • S5.waveVector X k t p.1

/-- The label gradient `(D_aX)^{-T} ∇_a q`, with the phase held fixed. -/
def labelGradient (X : ℝ → Velocity)
    (q : ℝ → Vec3 × ℝ → ℝ) : ℝ → Vec3 × ℝ → Vec3 :=
  fun t p => (fderiv ℝ (X t 0) (X 0 t p.1)).adjoint
    (gradient (fun a => q t (a, p.2)) p.1)

/-- The divergence correction `C[V] = d × Q[V]`, with the actual
zero-mean phase primitive `Q[V] = ∂s⁻¹(-κ × V / |κ|²)`. -/
def curlCorrection (X : ℝ → Velocity) (k : Vec3)
    (V : ℝ → Vec3 × ℝ → Vec3) : ℝ → Vec3 × ℝ → Vec3 :=
  fun t p => curlOfDerivative
    ((fderiv ℝ (fun a => wavePotential (S5.waveVector X k t a)
      (fun s => V t (a, s)) p.2) p.1).comp (fderiv ℝ (X t 0) (X 0 t p.1)))

/-- Time differentiation commutes with the label jet for a potential
smooth only on a nondegenerate closed active interval. Translation to
`[0,b-a]` permits direct use of the authors' closed-slab theorem. -/
theorem hasDerivWithinAt_relayLabelJet_of_activeSmooth
    {a b t : ℝ} (hab : a < b) (ht : t ∈ Icc a b)
    {Q : ℝ → Vec3 × ℝ → Vec3} {Qt : Vec3 × ℝ → Vec3}
    (hQ : ContDiffOn ℝ ∞ (Function.uncurry Q) (Icc a b ×ˢ univ))
    (hQt : ∀ y, HasDerivWithinAt (fun r => Q r y) (Qt y) (Icc a b) t)
    (x : Vec3 × ℝ) :
    HasDerivWithinAt (fun r => hierarchyRelayLabelJet (Q r) x)
      (hierarchyRelayLabelJet Qt x) (Icc a b) t := by
  have hpos : 0 < b - a := sub_pos.mpr hab
  have hforward : MapsTo (fun r : ℝ => r + a) (Icc 0 (b - a)) (Icc a b) := by
    intro r hr
    constructor <;> linarith [hr.1, hr.2]
  have hbackward : MapsTo (fun r : ℝ => r - a) (Icc a b) (Icc 0 (b - a)) := by
    intro r hr
    constructor <;> linarith [hr.1, hr.2]
  have hshift : ContDiffOn ℝ ∞ (fun p : HierarchyProfilePoint => Q (p.1 + a) p.2)
      (hierarchyProfileSlab (b - a)) :=
    hQ.comp ((contDiffOn_fst.add contDiffOn_const).prodMk contDiffOn_snd)
      (fun p hp => ⟨hforward hp.1, mem_univ p.2⟩)
  let W := HierarchySmoothProfile.ofSmooth _ hshift
  have hW (r : ℝ) (hr : r ∈ Icc 0 (b - a)) (y : Vec3 × ℝ) :
      W.val (r, y) = Q (r + a) y :=
    HierarchySmoothProfile.ofSmooth_apply hshift ⟨hr, mem_univ y⟩
  have hWt (y : Vec3 × ℝ) : HasDerivWithinAt (fun r => W.val (r, y))
      (Qt y) (Icc 0 (b - a)) (t - a) := by
    have h := (hQt y).scomp_of_eq (t - a)
      ((hasDerivWithinAt_id (t - a) (Icc 0 (b - a))).add_const a)
      hforward (by simp only [id_eq, sub_add_cancel])
    have h' : HasDerivWithinAt (fun r => Q (r + a) y)
        (Qt y) (Icc 0 (b - a)) (t - a) := by
      simpa only [Function.comp_def, id_eq, one_smul] using h
    exact h'.congr_of_mem (fun r hr => hW r hr y) (hbackward ht)
  have hjet := TorusEuler.hasDerivWithinAt_relayLabelJet_of_smoothProfile
    hpos (hbackward ht) W hWt x
  have h := hjet.scomp t ((hasDerivWithinAt_id t (Icc a b)).sub_const a) hbackward
  have h' : HasDerivWithinAt
      (fun r => hierarchyRelayLabelJet (fun y => W.val (r - a, y)) x)
      (hierarchyRelayLabelJet Qt x) (Icc a b) t := by
    simpa only [Function.comp_def, id_eq, one_smul] using h
  apply h'.congr_of_mem _ ht
  intro r hr
  have heq : (fun y => W.val (r - a, y)) = Q r := by
    funext y
    simpa only [sub_add_cancel] using hW (r - a) (hbackward hr) y
  rw [heq]

/-- The normalized wave potential preserves joint smoothness on the
active interval; this is the authors' phase-primitive regularity theorem. -/
theorem contDiffOn_relayPotentialProfile
    {a b : ℝ} (hab : a < b) {κ : ℝ → Vec3 → Vec3}
    {V : ℝ → Vec3 × ℝ → Vec3}
    (hκ : ContDiffOn ℝ ∞ (Function.uncurry κ) (Icc a b ×ˢ univ))
    (hV : ContDiffOn ℝ ∞ (Function.uncurry V) (Icc a b ×ˢ univ))
    (hκne : ∀ t ∈ Icc a b, ∀ x, κ t x ≠ 0) :
    ContDiffOn ℝ ∞
      (Function.uncurry (fun t => relayPotentialProfile (κ t) (V t)))
      (Icc a b ×ˢ univ) := by
  let S : Set (ℝ × Vec3) := Icc a b ×ˢ univ
  let K (p : (ℝ × Vec3) × ℝ) := κ p.1.1 p.1.2
  let W (p : (ℝ × Vec3) × ℝ) := V p.1.1 (p.1.2, p.2)
  have hK : ContDiffOn ℝ ∞ K (S ×ˢ (univ : Set ℝ)) :=
    hκ.comp contDiffOn_fst (fun p hp => hp.1)
  have hW : ContDiffOn ℝ ∞ W (S ×ˢ (univ : Set ℝ)) :=
    hV.comp (contDiffOn_fst.fst.prodMk (contDiffOn_fst.snd.prodMk contDiffOn_snd))
      (fun p hp => ⟨hp.1.1, mem_univ _⟩)
  have hne (p : (ℝ × Vec3) × ℝ) (hp : p ∈ S ×ˢ (univ : Set ℝ)) :
      ‖K p‖ ^ 2 ≠ 0 :=
    pow_ne_zero 2 (norm_ne_zero_iff.mpr (hκne p.1.1 hp.1.1 p.1.2))
  let F (p : ℝ × Vec3) (s : ℝ) :=
    (-(‖κ p.1 p.2‖ ^ 2)⁻¹) • cross3 (κ p.1 p.2) (V p.1 (p.2, s))
  have hF : ContDiffOn ℝ ∞ (Function.uncurry F) (S ×ˢ (univ : Set ℝ)) := by
    have hCross : ContDiffOn ℝ ∞ (fun p => cross3 (K p) (W p)) (S ×ˢ (univ : Set ℝ)) := by
      simpa only [Function.comp_apply, relayCrossMap_apply, cross3Left_apply] using
        (relayCrossMap.contDiff.comp_contDiffOn hK).clm_apply hW
    exact ((hK.norm_sq ℝ).inv hne).neg.smul hCross
  have hP : ContDiffOn ℝ ∞ (Function.uncurry (fun p => phasePrimitive (F p)))
      (S ×ˢ (univ : Set ℝ)) :=
    contDiffOn_phasePrimitive ((convex_Icc a b).prod convex_univ)
      ((uniqueDiffOn_Icc hab).prod uniqueDiffOn_univ) hF
  let reindex (p : HierarchyProfilePoint) := ((p.1, p.2.1), p.2.2)
  have hR : ContDiffOn ℝ ∞ reindex (Icc a b ×ˢ (univ : Set (Vec3 × ℝ))) :=
    (contDiffOn_fst.prodMk contDiffOn_snd.fst).prodMk contDiffOn_snd.snd
  have hMap : MapsTo reindex (Icc a b ×ˢ (univ : Set (Vec3 × ℝ)))
      (S ×ˢ (univ : Set ℝ)) := fun p hp => ⟨⟨hp.1, mem_univ _⟩, mem_univ _⟩
  change ContDiffOn ℝ ∞ (Function.uncurry (fun p => phasePrimitive (F p)) ∘ reindex) _
  exact hP.comp hR hMap

/-- The label jet of a differentiable label-phase field is its derivative
in the label with the phase held fixed. -/
theorem relayLabelJet_eq_slice {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {f : Vec3 × ℝ → E} {x : Vec3 × ℝ} (hf : DifferentiableAt ℝ f x) :
    hierarchyRelayLabelJet f x = fderiv ℝ (fun a => f (a, x.2)) x.1 := by
  rw [hierarchyRelayLabelJet, (hasFDerivAt_profile_partials hf).fderiv]
  ext v
  simp

/-- A smooth active profile is smooth in its label and phase variables
at each time of the closed interval. -/
theorem Profile.smooth_slice {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {t₀ T : ℝ} {k : Vec3} {V : ℝ → Vec3 × ℝ → E}
    (hV : Profile t₀ T k V) {t : ℝ} (ht : t ∈ Icc t₀ T) : ContDiff ℝ ∞ (V t) :=
  contDiffOn_univ.mp (hV.1.comp (contDiff_const.prodMk contDiff_id).contDiffOn
    (fun p _ => ⟨ht, mem_univ p⟩))

/-- The raw divergence correction is the relay's actual pulled-back
curl of the wave potential, at every active time and label-phase point. -/
theorem curlCorrection_eq_relayPotential
    {T t₀ D lam : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    (hT : 0 < T) (hP : S5.Parent T U X pU D lam) (hL : S5.Launch T X k lam t₀)
    {V : ℝ → Vec3 × ℝ → Vec3} (hV : Profile t₀ T k V)
    {t : ℝ} (ht : t ∈ Icc t₀ T) (x : Vec3 × ℝ) :
    curlCorrection X k V t x =
      curlOfDerivative ((hierarchyRelayLabelJet
        (relayPotentialProfile (S5.waveVector X k t) (V t)) x).comp
          (fderiv ℝ (X t 0) (X 0 t x.1))) := by
  have hsub : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
  have hQ := contDiffOn_relayPotentialProfile (κ := S5.waveVector X k) hL.start_lt
    ((Bridge.Parent.waveVector_smooth (k := k) hT hP).mono (prod_mono hsub subset_rfl)) hV.1
    (fun r hr a => Bridge.Parent.waveVector_ne_zero hT hP hL.carrier_ne_zero (hsub hr) a)
  have hincl : ContDiff ℝ ∞ (fun p : Vec3 × ℝ => (t, p)) :=
    contDiff_const.prodMk contDiff_id
  have hQt0 := hQ.comp (s := (univ : Set (Vec3 × ℝ))) (f := fun p => (t, p))
    hincl.contDiffOn (fun p _ => ⟨ht, mem_univ p⟩)
  have hQt : ContDiff ℝ ∞ (relayPotentialProfile (S5.waveVector X k t) (V t)) := by
    simpa only [Function.comp_def, Function.uncurry] using
      (contDiffOn_univ.mp hQt0)
  rw [relayLabelJet_eq_slice (hQt.differentiable (by simp) x)]
  rfl

/-- A smooth active profile has its actual time derivative within the
closed interval, including both endpoints. -/
theorem Profile.hasDerivWithinAt_time
    {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {t₀ T : ℝ} {k : Vec3} {V : ℝ → Vec3 × ℝ → E}
    (hV : Profile t₀ T k V) {t : ℝ} (ht : t ∈ Icc t₀ T) (x : Vec3 × ℝ) :
    HasDerivWithinAt (fun r => V r x)
      (derivWithin (fun r => V r x) (Icc t₀ T) t) (Icc t₀ T) t := by
  have hcurve : ContDiffOn ℝ ∞ (fun r => V r x) (Icc t₀ T) :=
    hV.1.comp (contDiffOn_id.prodMk contDiffOn_const) (fun r hr => ⟨hr, mem_univ x⟩)
  exact (hcurve.differentiableOn (by simp) t ht).hasDerivWithinAt

/-- The raw momentum equation gives the actual time derivative of the
velocity profile on the active interval. -/
theorem velocity_equation_of_momentum
    {T t₀ : ℝ} {U : Velocity} {X : ℝ → Velocity} {k : Vec3}
    {V f : ℝ → Vec3 × ℝ → Vec3} {q : ℝ → Vec3 × ℝ → ℝ}
    (hV : Profile t₀ T k V)
    (hMom : ∀ t ∈ Icc t₀ T, ∀ a s,
      material t₀ T U X V t (a, s) + phaseGradient X k q t (a, s) = f t (a, s))
    {t : ℝ} (ht : t ∈ Icc t₀ T) (a : Vec3) (s : ℝ) :
    HasDerivWithinAt (fun r => V r (a, s))
      (f t (a, s) - S5.strainField U X t a (V t (a, s)) -
        deriv (fun r => q t (a, r)) s • S5.waveVector X k t a) (Icc t₀ T) t := by
  apply (hV.hasDerivWithinAt_time ht (a, s)).congr_deriv
  have hm := hMom t ht a s
  dsimp only [material, phaseGradient] at hm
  rw [← hm]
  abel

/-- Transversality and zero phase mean recover the normalized phase
pressure from the active momentum equation. -/
theorem phasePressure_value_of_momentum
    {T t₀ D lam : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    (hT : 0 < T) (hP : S5.Parent T U X pU D lam) (hL : S5.Launch T X k lam t₀)
    {V f : ℝ → Vec3 × ℝ → Vec3} {q : ℝ → Vec3 × ℝ → ℝ}
    (hV : Profile t₀ T k V) (hq : Profile t₀ T k q)
    (htrans : ∀ t ∈ Icc t₀ T, ∀ a s, ⟪S5.waveVector X k t a, V t (a, s)⟫_ℝ = 0)
    (hqMean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => q t (a, s)) = 0)
    (hMom : ∀ t ∈ Icc t₀ T, ∀ a s,
      material t₀ T U X V t (a, s) + phaseGradient X k q t (a, s) = f t (a, s))
    {t : ℝ} (ht : t ∈ Icc t₀ T) (a : Vec3) (s : ℝ) :
    q t (a, s) = relayPhasePressureProfile (S5.strainField U X t)
      (S5.waveVector X k t) (V t) (f t) (a, s) := by
  have hsub : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
  let K := S5.waveVector X k t a
  let M := S5.strainField U X t a
  let p (r : ℝ) := q t (a, r)
  let v (r : ℝ) := V t (a, r)
  let force (r : ℝ) := f t (a, r)
  let slope (r : ℝ) := oscillatoryPressureSlope M K (force r) (v r)
  have hκ := (hP.flow.hasDerivWithinAt_labelWaveVector hT
    (hP.velocity_smooth.of_le (by simp)) hP.velocity_periodic
    ⟨le_rfl, hT.le⟩ (hsub ht) a k).mono hsub
  have hD (r : ℝ) : deriv p r = slope r := by
    have hv := velocity_equation_of_momentum hV hMom ht a r
    have hvκ := hκ.inner ℝ hv
    have hz : HasDerivWithinAt
        (fun u => ⟪S5.waveVector X k u a, V u (a, r)⟫_ℝ) 0 (Icc t₀ T) t :=
      (hasDerivWithinAt_const t (Icc t₀ T) (0 : ℝ)).congr_of_mem
        (fun u hu => htrans u hu a r) ht
    have hh := (hvκ.derivWithin (uniqueDiffOn_Icc hL.start_lt t ht)).symm.trans
      (hz.derivWithin (uniqueDiffOn_Icc hL.start_lt t ht))
    change ⟪K, force r - M (v r) - deriv p r • K⟫_ℝ + ⟪-(M.adjoint K), v r⟫_ℝ = 0 at hh
    rw [inner_sub_right, inner_sub_right, inner_smul_right, inner_neg_left,
      ContinuousLinearMap.adjoint_inner_left, real_inner_self_eq_norm_sq] at hh
    change deriv p r = (⟪K, force r⟫_ℝ - 2 * ⟪K, M (v r)⟫_ℝ) / ‖K‖ ^ 2
    apply (eq_div_iff (pow_ne_zero 2 (norm_ne_zero_iff.mpr
      (Bridge.Parent.waveVector_ne_zero hT hP hL.carrier_ne_zero (hsub ht) a)))).2
    linarith
  have hpSmooth : ContDiff ℝ ∞ p :=
    (hq.smooth_slice ht).comp (contDiff_const.prodMk contDiff_id)
  have hCont : Continuous slope := by
    rw [← funext hD]
    exact hpSmooth.continuous_deriv (by simp)
  have hDer (r : ℝ) : HasDerivAt p (slope r) r :=
    (hpSmooth.differentiable (by simp) r).hasDerivAt.congr_deriv (hD r)
  change p s = phasePrimitive slope s
  rw [phasePrimitive_deriv hDer hCont, phaseOscillation, hqMean t ht a, sub_zero]

/-- The cross product is continuous on a set whenever its two factors
are continuous there, by its bounded bilinear realization. -/
theorem continuousOn_cross {Y : Type*} [TopologicalSpace Y] {S : Set Y}
    {u v : Y → Vec3} (hu : ContinuousOn u S) (hv : ContinuousOn v S) :
    ContinuousOn (fun y => cross3 (u y) (v y)) S := by
  simpa only [Function.comp_apply, relayCrossMap_apply, cross3Left_apply] using
    (relayCrossMap.continuous.comp_continuousOn hu).clm_apply hv

/-- The actual potential-time source on the active interval follows from
the momentum equation; the parallel pressure term cancels in the cross product. -/
theorem potential_time_of_momentum
    {T t₀ D lam : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    (hT : 0 < T) (hP : S5.Parent T U X pU D lam) (hL : S5.Launch T X k lam t₀)
    {V f : ℝ → Vec3 × ℝ → Vec3} {q : ℝ → Vec3 × ℝ → ℝ}
    (hV : Profile t₀ T k V) (hf : Profile t₀ T k f)
    (hMom : ∀ t ∈ Icc t₀ T, ∀ a s,
      material t₀ T U X V t (a, s) + phaseGradient X k q t (a, s) = f t (a, s))
    {t : ℝ} (ht : t ∈ Icc t₀ T) (a : Vec3) (s : ℝ) :
    HasDerivWithinAt
      (fun r => relayPotentialProfile (S5.waveVector X k r) (V r) (a, s))
      (relayPotentialTimeProfile (S5.strainField U X t) (S5.waveVector X k t)
        (V t) (f t) (a, s)) (Icc t₀ T) t := by
  have hsub : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
  let K (r : ℝ) := S5.waveVector X k r a
  let M (r : ℝ) := S5.strainField U X r a
  let W (r σ : ℝ) := V r (a, σ)
  let F (r σ : ℝ) := f r (a, σ)
  let I : Set (ℝ × ℝ) := Icc t₀ T ×ˢ univ
  have hPoint : Continuous (fun z : ℝ × ℝ => (z.1, a)) :=
    continuous_fst.prodMk continuous_const
  have hPhasePoint : Continuous (fun z : ℝ × ℝ => (z.1, a, z.2)) :=
    continuous_fst.prodMk (continuous_const.prodMk continuous_snd)
  have hK0 := (Bridge.Parent.waveVector_smooth (k := k) hT hP).continuousOn.comp
    (s := I) (f := fun z : ℝ × ℝ => (z.1, a)) hPoint.continuousOn
    (fun z hz => ⟨hsub hz.1, mem_univ _⟩)
  have hK : ContinuousOn (fun z : ℝ × ℝ => K z.1) I := by
    simpa only [Function.comp_def, Function.uncurry, K] using hK0
  have hM0 := (Bridge.Parent.strainField_smooth hT hP).continuousOn.comp
    (s := I) (f := fun z : ℝ × ℝ => (z.1, a)) hPoint.continuousOn
    (fun z hz => ⟨hsub hz.1, mem_univ _⟩)
  have hM : ContinuousOn (fun z : ℝ × ℝ => M z.1) I := by
    simpa only [Function.comp_def, Function.uncurry, M] using hM0
  have hW0 := hV.1.continuousOn.comp (s := I)
    (f := fun z : ℝ × ℝ => (z.1, a, z.2)) hPhasePoint.continuousOn
    (fun z hz => ⟨hz.1, mem_univ _⟩)
  have hW : ContinuousOn (fun z : ℝ × ℝ => W z.1 z.2) I := by
    simpa only [Function.comp_def, Function.uncurry, W] using hW0
  have hF0 := hf.1.continuousOn.comp (s := I)
    (f := fun z : ℝ × ℝ => (z.1, a, z.2)) hPhasePoint.continuousOn
    (fun z hz => ⟨hz.1, mem_univ _⟩)
  have hF : ContinuousOn (fun z : ℝ × ℝ => F z.1 z.2) I := by
    simpa only [Function.comp_def, Function.uncurry, F] using hF0
  have hkn (z : ℝ × ℝ) (hz : z ∈ I) : ‖K z.1‖ ^ 2 ≠ 0 :=
    pow_ne_zero 2 (norm_ne_zero_iff.mpr
      (Bridge.Parent.waveVector_ne_zero hT hP hL.carrier_ne_zero (hsub hz.1) a))
  have hInv := (hK.norm.pow 2).inv₀ hkn
  have hCross := continuousOn_cross hK hW
  have hAdj := (ContinuousLinearMap.adjoint (𝕜 := ℝ) (E := Vec3) (F := Vec3)).continuous.comp_continuousOn hM
  have hSource : ContinuousOn (fun z : ℝ × ℝ =>
      wavePotentialTimeSource (M z.1) (K z.1) (W z.1 z.2) (F z.1 z.2)) I := by
    have hin := hK.inner (𝕜 := ℝ) (hM.clm_apply hK)
    unfold wavePotentialTimeSource
    exact (hInv.smul (((continuousOn_cross (hAdj.clm_apply hK) hW).add
      (continuousOn_cross hK (hM.clm_apply hW))).sub (continuousOn_cross hK hF))).sub
      (((continuousOn_const.mul hin).div ((hK.norm.pow 2).pow 2)
        (fun z hz => pow_ne_zero 2 (hkn z hz))).smul hCross)
  apply hasDerivWithinAt_wavePotential_time (κ := K) (V := W) (f := F)
    (q := fun r σ => deriv (fun τ => q r (a, τ)) σ) (M := M) ht
  · intro r hr
    exact Bridge.Parent.waveVector_ne_zero hT hP hL.carrier_ne_zero (hsub hr) a
  · intro r hr
    exact (hP.flow.hasDerivWithinAt_labelWaveVector hT
      (hP.velocity_smooth.of_le (by simp)) hP.velocity_periodic
      ⟨le_rfl, hT.le⟩ (hsub hr) a k).mono hsub
  · intro r hr σ
    exact velocity_equation_of_momentum hV hMom hr a σ
  · exact hInv.neg.smul hCross
  · exact hSource

/-- On the active interval, the material derivative of the actual curl
correction plus the label pressure gradient is the authors' slow relay.
Only active smoothness, transversality, pressure normalization and momentum
are used; neither a full-slab extension nor values before activation enter. -/
theorem material_curlCorrection_eq_relay
    {T t₀ D lam : ℝ} {U : Velocity} {X : ℝ → Velocity} {pU : Pressure} {k : Vec3}
    (hT : 0 < T) (hP : S5.Parent T U X pU D lam) (hL : S5.Launch T X k lam t₀)
    {V f : ℝ → Vec3 × ℝ → Vec3} {q : ℝ → Vec3 × ℝ → ℝ}
    (hV : Profile t₀ T k V) (hf : Profile t₀ T k f) (hq : Profile t₀ T k q)
    (htrans : ∀ t ∈ Icc t₀ T, ∀ a s, ⟪S5.waveVector X k t a, V t (a, s)⟫_ℝ = 0)
    (hqMean : ∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => q t (a, s)) = 0)
    (hMom : ∀ t ∈ Icc t₀ T, ∀ a s,
      material t₀ T U X V t (a, s) + phaseGradient X k q t (a, s) = f t (a, s))
    {t : ℝ} (ht : t ∈ Icc t₀ T) (x : Vec3 × ℝ) :
    material t₀ T U X (curlCorrection X k V) t x + labelGradient X q t x =
      hierarchyLinearRelayAt (fderiv ℝ (X t 0) (X 0 t x.1)) (S5.strainField U X t x.1)
        (relayPotentialProfile (S5.waveVector X k t) (V t))
        (relayPotentialTimeProfile (S5.strainField U X t) (S5.waveVector X k t) (V t) (f t))
        (relayPhasePressureProfile (S5.strainField U X t) (S5.waveVector X k t) (V t) (f t)) x := by
  have hsub : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
  let Q (r : ℝ) := relayPotentialProfile (S5.waveVector X k r) (V r)
  let Qt := relayPotentialTimeProfile (S5.strainField U X t) (S5.waveVector X k t) (V t) (f t)
  let P := relayPhasePressureProfile (S5.strainField U X t) (S5.waveVector X k t) (V t) (f t)
  let G (r : ℝ) := fderiv ℝ (X r 0) (X 0 r x.1)
  have hQ : ContDiffOn ℝ ∞ (Function.uncurry Q) (Icc t₀ T ×ˢ univ) :=
    contDiffOn_relayPotentialProfile (κ := S5.waveVector X k) hL.start_lt
      ((Bridge.Parent.waveVector_smooth (k := k) hT hP).mono (prod_mono hsub subset_rfl)) hV.1
      (fun r hr a => Bridge.Parent.waveVector_ne_zero hT hP hL.carrier_ne_zero (hsub hr) a)
  have hJ := hasDerivWithinAt_relayLabelJet_of_activeSmooth hL.start_lt ht hQ
    (fun y => potential_time_of_momentum hT hP hL hV hf hMom ht y.1 y.2) x
  have hG : HasDerivWithinAt G (-((G t).comp (S5.strainField U X t x.1))) (Icc t₀ T) t :=
    (hP.flow.hasDerivWithinAt_inverseLabelCoframe hT
      (hP.velocity_smooth.of_le (by simp)) hP.velocity_periodic
      ⟨le_rfl, hT.le⟩ (hsub ht) x.1).mono hsub
  have hC (r : ℝ) (hr : r ∈ Icc t₀ T) : curlCorrection X k V r x =
      curlOfDerivative ((hierarchyRelayLabelJet (Q r) x).comp (G r)) :=
    curlCorrection_eq_relayPotential hT hP hL hV hr x
  have hct := derivWithin_congr hC (hC t ht)
  have hPressure : q t = P :=
    funext fun y => phasePressure_value_of_momentum hT hP hL hV hq htrans hqMean hMom ht y.1 y.2
  have hpJet : fderiv ℝ (fun a => q t (a, x.2)) x.1 = hierarchyRelayLabelJet P x := by
    rw [← hPressure, relayLabelJet_eq_slice ((hq.smooth_slice ht).differentiable (by simp) x)]
  change derivWithin (fun r => curlCorrection X k V r x) (Icc t₀ T) t +
    S5.strainField U X t x.1 (curlCorrection X k V t x) +
      (G t).adjoint (gradient (fun a => q t (a, x.2)) x.1) = _
  rw [hct, hC t ht, gradient, hpJet]
  exact derivWithin_waveCompletion_add_pressure (uniqueDiffOn_Icc hL.start_lt t ht) hJ hG

end

end Adapted.ActiveRelay
