import Adapted.ActiveRelayCalculus
import TorusEuler.Paper.Proofs.S5a.Library.Leading
import TorusEuler.Paper.Proofs.S5Bridge.Operators

/-!
# The leading field on the active slab

The authors supply full-slab representatives for the particular leading
oscillation and pressure. Restricting their values and derivatives gives
exactly the raw periodized fields used in the active version of Lemma 5.5.
No extension assertion for an arbitrary input profile is made here.
-/

open Set Function
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper HierarchyTwistedProfile LocalizedAmplitude

noncomputable section

namespace Adapted.ActiveRelay

/-- Agreement with a full-slab twisted profile supplies precisely the
smoothness and translation laws on the active interval. -/
theorem profile_of_fullSlab_agreement {E : Type} [NormedAddCommGroup E]
    [NormedSpace ℝ E] {T t₀ : ℝ} {k : Vec3} (ht₀ : 0 ≤ t₀)
    (V : HierarchyTwistedProfile T k E) (v : ℝ → Vec3 × ℝ → E)
    (heq : ∀ t ∈ Icc t₀ T, ∀ p, V.val.val.val (t, p) = v t p) :
    Profile t₀ T k v := by
  have hI : Icc t₀ T ⊆ Icc 0 T := Icc_subset_Icc_left ht₀
  refine ⟨?_, ?_, ?_⟩
  · apply ((HierarchySmoothProfile.smooth V.val.val).mono (prod_mono hI subset_rfl)).congr
    intro z hz
    exact (heq z.1 hz.1 z.2).symm
  · intro t ht a s
    rw [← heq t ht (a, s + 1), ← heq t ht (a, s)]
    exact HierarchyPeriodicProfile.phasePeriodic V.val t a s
  · intro t ht a s z
    rw [← heq t ht (a + latticeVector z, s + ⟪k, latticeVector z⟫_ℝ),
      ← heq t ht (a, s)]
    exact twistedSlice V t a s z

set_option maxHeartbeats 2000000 in
/-- The raw periodized leading oscillation `A₁ = g a F_h` and its pressure
are smooth twisted active profiles, centered in phase and transverse, and
satisfy `(∂t+M)A₁ + κ ∂s p[A₁] = 0`. These are exactly the hypotheses
needed to apply the active relay estimate with source zero. -/
theorem leading_admissible {T : ℝ} (hT : 0 < T) {U : Velocity}
    {X : ℝ → Velocity} {pU : Pressure} {k : Vec3} {D lam t₀ : ℝ}
    {center : ℝ → Vec3} {amp : ℝ → Vec3 → Vec3}
    (d : ParentGeometry hT U X k) (hP : S5.Parent T U X pU D lam)
    (hL : S5.Launch T X k lam t₀) (hamp : S5.IsSeed U X k t₀ T center amp)
    {ℓ h : ℝ} (hℓ : 0 < ℓ) (hfit : 2 * ℓ < 1 / 2) (hh : 0 < h) (hh₁ : h ≤ 1) :
    let v : ℝ → Vec3 × ℝ → Vec3 := fun t p =>
      phaseTwistedPeriodizeCentered k (S5.leading ℓ h amp) t p.1 p.2
    let q : ℝ → Vec3 × ℝ → ℝ := fun t p =>
      phaseTwistedPeriodizeCentered k (S5.leadingPressure U X k ℓ h amp) t p.1 p.2
    Profile t₀ T k v ∧ Profile t₀ T k q ∧
      (∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => v t (a, s)) = 0) ∧
      (∀ t ∈ Icc t₀ T, ∀ a s, ⟪S5.waveVector X k t a, v t (a, s)⟫_ℝ = 0) ∧
      (∀ t ∈ Icc t₀ T, ∀ a, phaseMean (fun s => q t (a, s)) = 0) ∧
      ∀ t ∈ Icc t₀ T, ∀ a s,
        material t₀ T U X v t (a, s) + phaseGradient X k q t (a, s) = 0 := by
  intro v q
  have hI : Icc t₀ T ⊆ Icc 0 T := Bridge.Launch.active_subset hL
  obtain ⟨V, p, hVmean, hpMean, hEval⟩ :=
    Lib.S5a.exists_leading_representatives hP hL hamp hℓ hfit hh hh₁
  have hvRaw (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3 × ℝ) :
      V.val.val.val (t, x) = v t x := (hEval t ht x.1 x.2).1
  have hqRaw (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3 × ℝ) :
      p.val.val.val (t, x) = q t x := (hEval t ht x.1 x.2).2
  have hV (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3) (hx : x ∈ centeredCell) (s : ℝ) :
      V.val.val.val (t, x, s) = S5.leading ℓ h amp t x s := by
    rw [(hEval t ht x s).1]
    apply Lib.S5a.wrapped_eq_on_cell hx s hfit
    intro b hb r
    simp only [S5.leading, radialEnvelope_eq_zero hℓ hb, zero_mul, zero_smul]
  have hp (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3) (hx : x ∈ centeredCell) (s : ℝ) :
      p.val.val.val (t, x, s) = S5.leadingPressure U X k ℓ h amp t x s := by
    rw [(hEval t ht x s).2]
    apply Lib.S5a.wrapped_eq_on_cell hx s hfit
    intro b hb r
    simp only [S5.leadingPressure, wavePressureCoefficient, radialEnvelope_eq_zero hℓ hb,
      mul_zero, zero_mul, zero_div, neg_zero]
  let A := S5.ops d
  let R := A.material V + A.phaseGrad p
  have hCell (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3) (hx : x ∈ centeredCell) (s : ℝ) :
      ⟪d.covector.val.val.val (t, x, s), V.val.val.val (t, x, s)⟫_ℝ = 0 ∧
        R.val.val.val (t, x, s) = 0 := by
    have hz : (t, x, s) ∈ hierarchyProfileSlab T := ⟨hI ht, mem_univ _⟩
    have hlead := Lib.S5a.leading_homogeneous (ℓ := ℓ) hamp hL.start_lt hh hh₁ ht x s
    constructor
    · rw [d.covector_value _ hz, hV t ht x hx s]
      exact hlead.2.1
    · have hQ : (fun r => p.val.val.val (t, x, r)) = S5.leadingPressure U X k ℓ h amp t x :=
        funext (hp t ht x hx)
      have hv₀ := (HierarchySmoothProfile.hasDerivWithinAt_profileTime V.val.val (hI ht) x s).mono hI
      have hv := hv₀.derivWithin (uniqueDiffOn_Icc hL.start_lt t ht)
      have hVFun : EqOn (fun r => V.val.val.val (r, x, s)) (fun r => S5.leading ℓ h amp r x s)
          (Icc t₀ T) := fun r hr => hV r hr x hx s
      rw [derivWithin_congr hVFun (hVFun ht)] at hv
      have hp' := (HierarchySmoothProfile.hasDerivAt_profilePhase p.val.val (hI ht) x s).deriv
      rw [hQ] at hp'
      let ops := HierarchySmoothProfile.hierarchyConcreteOperators hT d.inverse.val.val
        d.strain.val.val d.covector.val.val
      change (ops.material V.val.val).val (t, x, s) +
        (HierarchySmoothProfile.phaseGradient hT d.covector.val.val p.val.val).val (t, x, s) = 0
      rw [HierarchySmoothProfile.hierarchyConcreteOperators_material_apply hT _ _ _ _ hz,
        HierarchySmoothProfile.phaseGradient_apply hT _ _ hz, ← hv, ← hp',
        d.covector_value _ hz, d.strain_value _ hz, hV t ht x hx s]
      exact hlead.1
  have hAll (t : ℝ) (ht : t ∈ Icc t₀ T) (x : Vec3) (s : ℝ) :
      ⟪d.covector.val.val.val (t, x, s), V.val.val.val (t, x, s)⟫_ℝ = 0 ∧
        R.val.val.val (t, x, s) = 0 := by
    obtain ⟨z, hz⟩ := exists_sub_latticeVector_mem_centeredCell x
    have hShift {E : Type} [NormedAddCommGroup E] [NormedSpace ℝ E]
        (W : HierarchyTwistedProfile T k E) : W.val.val.val (t, x, s) =
        W.val.val.val (t, x - latticeVector z, s - ⟪k, latticeVector z⟫_ℝ) := by
      simpa only [sub_add_cancel] using
        twistedSlice W t (x - latticeVector z) (s - ⟪k, latticeVector z⟫_ℝ) z
    rw [hShift d.covector, hShift V, hShift R]
    exact hCell t ht _ hz _
  refine ⟨profile_of_fullSlab_agreement hL.start_nonneg V v hvRaw,
    profile_of_fullSlab_agreement hL.start_nonneg p q hqRaw, ?_, ?_, ?_, ?_⟩
  · intro t ht x
    have hm := congrArg (fun W : HierarchyTwistedProfile T k Vec3 => W.val.val.val (t, x, 0)) hVmean
    change (HierarchySmoothProfile.profilePhaseAverage hT V.val.val).val (t, x, 0) = 0 at hm
    rw [HierarchySmoothProfile.profilePhaseAverage_apply hT _ ⟨hI ht, mem_univ _⟩] at hm
    have heq : (fun s => V.val.val.val (t, x, s)) = fun s => v t (x, s) :=
      funext fun s => hvRaw t ht (x, s)
    rwa [heq] at hm
  · intro t ht x s
    have heq := (hAll t ht x s).1
    rw [d.covector_value (t, x, s) ⟨hI ht, mem_univ _⟩, hvRaw t ht (x, s)] at heq
    exact heq
  · intro t ht x
    have heq : (fun s => p.val.val.val (t, x, s)) = fun s => q t (x, s) :=
      funext fun s => hqRaw t ht (x, s)
    simpa only [heq] using hpMean t (hI ht) x
  · intro t ht x s
    have hz : (t, x, s) ∈ hierarchyProfileSlab T := ⟨hI ht, mem_univ _⟩
    have htV := (HierarchySmoothProfile.hasDerivWithinAt_profileTime V.val.val (hI ht) x s).mono hI
    have hdV := htV.derivWithin (uniqueDiffOn_Icc hL.start_lt t ht)
    have hveq : EqOn (fun r => V.val.val.val (r, x, s)) (fun r => v r (x, s)) (Icc t₀ T) :=
      fun r hr => hvRaw r hr (x, s)
    rw [derivWithin_congr hveq (hveq ht)] at hdV
    have hqeq : (fun r => p.val.val.val (t, x, r)) = fun r => q t (x, r) :=
      funext fun r => hqRaw t ht (x, r)
    have hdq := (HierarchySmoothProfile.hasDerivAt_profilePhase p.val.val (hI ht) x s).deriv
    rw [hqeq] at hdq
    have heq := (hAll t ht x s).2
    let ops := HierarchySmoothProfile.hierarchyConcreteOperators hT d.inverse.val.val
      d.strain.val.val d.covector.val.val
    change (ops.material V.val.val).val (t, x, s) +
      (HierarchySmoothProfile.phaseGradient hT d.covector.val.val p.val.val).val (t, x, s) = 0 at heq
    rw [HierarchySmoothProfile.hierarchyConcreteOperators_material_apply hT _ _ _ _ hz,
      HierarchySmoothProfile.phaseGradient_apply hT _ _ hz, ← hdV, ← hdq,
      d.covector_value _ hz, d.strain_value _ hz, hvRaw t ht (x, s)] at heq
    exact heq

end Adapted.ActiveRelay
