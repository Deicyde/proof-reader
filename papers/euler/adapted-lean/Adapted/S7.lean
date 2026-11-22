import TorusEuler.Paper.Spine
import TorusEuler.TerminalScheduledNormContinuity

/-! # Section 7. A common sequence of approximate solutions

The numbered result at the end of this file, `theorem_7_1`, is proved. It
requires the central waves in the estimates to be the waves used in the
localized expansions, including the specified first wave. The authors'
exported theorem does not record these identifications, so the proof reruns
the authors' construction with their own lemmas and keeps the two equalities
that their local proofs establish (section "Proof of Theorem 7.1" below).

`SequenceEstimates` displays (T1)–(T4) and the localization properties. It omits the two
comparison estimates exported from the proof solely for later proofs.
`available_estimates` shows that these displayed estimates follow from
the authors' existing conclusion predicate. `IdentifiedSteps` and
`FirstWaveIdentification` state the additional equalities explicitly.
`IncrementBounds` retains the coefficient one in the spatial Hölder norm
used throughout this layer: the sum of the supremum and half-Hölder
seminorms of the derivative tensors through the specified order.
The paper does not fix a different formula for this general norm.
-/

namespace Adapted.S7

open TorusEuler TorusEuler.Paper TorusEuler.HierarchyTwistedProfile Filter Set
open scoped ContDiff InnerProductSpace Topology

noncomputable section

/-- The estimates in **Theorem 7.1**: the stationary shear, the activation
times, (T1)–(T4), their positive finite accumulation time and localization.
Here `U_j = c.stages.velocity j`,
`t_j = c.stages.activation j`, `S_j = c.stages.slab j` and
`λ_j = P.frequency j`. The bounds (7.4) are stated separately in
`IncrementBounds`, with time continuity in `IncrementContinuity`.

The Fourier support and all spatial quantities use the periodic lift.
The sum in (T3) is reindexed from `1 ≤ i ≤ j` to `0 ≤ i < j`. -/
structure SequenceEstimates {P : InductiveEulerParameters}
    (c : InductiveEulerConstruction P) (C T : ℝ) : Prop where
  shear : ∀ t : ℝ, c.stages.velocity 0 t = stationaryShear (Schedule.ε P.frequency 1)
  first_times : c.stages.activation 1 = 0 ∧ c.stages.activation 2 = 0
  times_increase : ∀ j : ℕ, 2 ≤ j → c.stages.activation j < c.stages.activation (j + 1)
  final_times : c.stages.slab 0 = 1 ∧
    ∀ j : ℕ, 1 ≤ j → c.stages.slab j = c.stages.activation j + 2 * Schedule.τ P.frequency j
  T1 : ∀ j : ℕ,
    ContDiffOn ℝ ∞ (Function.uncurry (c.stages.velocity j))
        (Icc 0 (c.stages.slab j) ×ˢ (univ : Set Vec3)) ∧
      ∀ t ∈ Icc 0 (c.stages.slab j), SpatiallyPeriodic (c.stages.velocity j t) ∧
        Function.Odd (c.stages.velocity j t) ∧ (∀ x, divergence (c.stages.velocity j t) x = 0) ∧
        RealTorusFourierBand (2 * P.frequency j ^ 5) (c.stages.torusVelocity j t)
  T2 : ∀ j : ℕ,
    (∀ t ∈ Icc 0 (c.stages.slab j), ∀ x, ‖c.stages.velocity j t x‖ ≤ P.frequency j) ∧
      ChildFlow.DeformationOn (c.stages.velocity j) (c.stage j).flow (c.stages.slab j)
        (P.frequency j) ∧
      ∀ t ∈ Icc 0 (c.stages.slab j), ∀ x, ‖c.stages.residual j t x‖ ≤ (P.frequency (j + 1))⁻¹ ^ 3
  T3 : ∀ j : ℕ, ∀ t ∈ Icc 0 (c.stages.slab j), ∀ x v : Vec3,
    ⟪v, fderiv ℝ (gradient ((c.stage j).pressure t)) x v⟫_ℝ ≤
      (∑ i ∈ Finset.range j, (P.frequency i)⁻¹) * ‖v‖ ^ 2
  T4_gradient : ∀ j : ℕ, 1 ≤ j → ∀ t ∈ Icc (c.stages.activation j) (c.stages.slab j),
    fderiv ℝ (c.stages.velocity j t) 0 =
        fderiv ℝ (c.stages.velocity (j - 1) t) 0 +
          c.centralWaves.cutoff j t •
            (innerSL ℝ (c.centralWaves.waveVector j t)).smulRight (c.centralWaves.amplitude j t) +
          c.centralWaves.error j t ∧
      ‖c.centralWaves.error j t‖ ≤ P.frequency j ^ (-1 / 4 : ℝ)
  T4_times : ∀ j : ℕ, 1 ≤ j →
    0 ≤ c.stages.activation (j + 1) - c.stages.activation j ∧
      c.stages.activation (j + 1) - c.stages.activation j ≤ Schedule.τ P.frequency j ∧
      ∀ t ∈ Icc (c.stages.activation (j + 1)) (c.stages.slab j), c.centralWaves.cutoff j t = 1
  strength_constant : 2 ≤ C
  T4_late_values : ∀ j : ℕ, 1 ≤ j →
    let t := c.stages.activation (j + 1)
    let E := MovingWaveVector.frame (c.centralWaves.waveVector j) (c.centralWaves.amplitude j) t
    let M := fderiv ℝ (c.stages.velocity (j - 1) t) 0
    let ν := MovingWaveVector.entry E M 0 1
    let η := MovingWaveVector.entry E M 2 1
    let σ := ‖c.centralWaves.amplitude j t‖ * ‖c.centralWaves.waveVector j t‖
    η / ν = Schedule.ε P.frequency j ∧ Real.pi ≤ ν ∧ ν ≤ 4 * Real.pi ∧
      C⁻¹ * P.frequency j ^ (1 / 4 : ℝ) ≤ σ ∧
      σ ≤ C * P.frequency j ^ (1 / 4 : ℝ) * Schedule.L P.frequency (j + 1) ^ 2
  first_cutoff : ∀ t : ℝ, c.centralWaves.cutoff 1 t = 1
  later_cutoff : ∀ j : ℕ, 2 ≤ j → ∀ t : ℝ,
    let t₀ := c.stages.activation j
    let σ := ‖c.centralWaves.amplitude (j - 1) t₀‖ * ‖c.centralWaves.waveVector (j - 1) t₀‖
    let ν := MovingWaveVector.entry
      (MovingWaveVector.frame (c.centralWaves.waveVector (j - 1))
        (c.centralWaves.amplitude (j - 1)) t₀)
      (fderiv ℝ (c.stages.velocity (j - 2) t₀) 0) 0 1
    let r := Real.sqrt (2 * σ * ν)
    c.centralWaves.cutoff j t = if t < t₀ then 0 else 1 - envelopeCutoff (1 + r * (t - t₀))
  lifetime : 0 < T ∧ Tendsto c.stages.activation atTop (𝓝 T) ∧ ∀ j : ℕ, T < c.stages.slab j
  oscillation_support : ∀ j : ℕ, 1 ≤ j → ∀ t ∈ Icc 0 (c.stages.slab j), ∀ x : Vec3,
    c.stages.oscillation j t x ≠ 0 →
      ∃ n : Fin 3 → ℤ, dist (latticeVector n) x ≤ (P.frequency (j - 1))⁻¹
  oscillation_vanishes : ∀ j : ℕ, 2 ≤ j → ∀ t ∈ Icc 0 (c.stages.activation j),
    c.stages.oscillation j t = 0

/-- The geometric estimates (T1)–(T4), the activation limit and the
localization properties of Theorem 7.1 are present in the authors'
conclusion predicate. This projection does not add the missing central
identifications or the time-continuity clause in (7.4). -/
theorem available_estimates {P : InductiveEulerParameters}
    {c : InductiveEulerConstruction P} {C T : ℝ}
    (h : Theorem71Conclusions c C T) : SequenceEstimates c C T := by
  exact ⟨h.shear, h.first_times, h.times_increase, h.final_times,
    h.T1, h.T2, h.T3, h.T4_gradient, h.T4_times, h.strength_constant,
    h.T4_late_values, h.first_cutoff, h.later_cutoff, h.lifetime,
    h.oscillation_support, h.oscillation_vanishes⟩

/-- The spatial `C^(m,1/2)` norm: the sum, over derivative orders
through `m`, of the uniform operator norm and half-Hölder seminorm of
the derivative tensor. This is the same convention used in Appendix B
and Section 8; the paper does not fix a different formula for its
general spatial Hölder norm. -/
abbrev paperSpatialHolderNorm (m : ℕ) (f : Vec3 → Vec3) : ℝ :=
  spatialHolderHalfNorm m f

/-- The two bounds (7.4), including their literal coefficient one:
`‖O_j‖ ≤ λ_j⁻¹` and `‖U_j-U_{j-1}-O_j‖_(C^(m,1/2)) ≤ λ_j⁻¹`
for `0 ≤ m ≤ q_j`, at every time of `[0,S_j]`. The spatial norm is
the derivative-tensor norm declared above. Finiteness is recorded
so that real suprema have their intended meaning. -/
def IncrementBounds {P : InductiveEulerParameters}
    (c : InductiveEulerConstruction P) : Prop :=
  ∀ j : ℕ, 1 ≤ j → ∀ t ∈ Icc 0 (c.stages.slab j),
    (∀ x, ‖c.stages.oscillation j t x‖ ≤ (P.frequency j)⁻¹) ∧
    ∀ m : ℕ, m ≤ P.order j →
      SpatialHolderHalf m
        (c.stages.velocity j t - c.stages.velocity (j - 1) t - c.stages.oscillation j t) ∧
      paperSpatialHolderNorm m
        (c.stages.velocity j t - c.stages.velocity (j - 1) t - c.stages.oscillation j t) ≤
        (P.frequency j)⁻¹

/-- The wave data in (7.1) belong to the very same step that constructs
`U_j` and `O_j`: the central covector equals `(D_a X_{j-1})^(-T) k_*`
at the origin on `[t_j,S_j]`. The authors' step predicate already
identifies the central seed, the expansion, the truncation and the
oscillation; the last conjunct supplies the omitted covector equality.

Both predicates concern the same existential step witnesses. Separate
existence of a suitable covector and a suitable expansion would not
establish their identification. -/
def IdentifiedSteps {P : InductiveEulerParameters}
    (c : InductiveEulerConstruction P) (a : ℕ) (ψ : Vec3 → ℝ) : Prop :=
  ∀ j : ℕ, 1 ≤ j →
    ∃ (hT : 0 < c.stages.slab j) (k : Vec3) (center : ℝ → Vec3) (amp : ℝ → Vec3 → Vec3)
      (d : ParentGeometry hT (c.stages.velocity (j - 1)) (c.stage (j - 1)).flow k)
      (χ : PaperWaveCutoff (c.stages.activation j) (c.stages.slab j))
      (R S : HierarchyTwistedProfile (c.stages.slab j) k Vec3)
      (u : HierarchyProfiles (HierarchyTwistedProfile (c.stages.slab j) k Vec3)
        (HierarchyTwistedProfile (c.stages.slab j) k ℝ)),
      Theorem71StepData c a ψ j k center amp d χ R S u ∧
      ∀ t ∈ Icc (c.stages.activation j) (c.stages.slab j),
        S5.waveVector (c.stage (j - 1)).flow k t 0 = c.centralWaves.waveVector j t

/-- The first central wave is the first wave of (6.3): its covector is
initially `λ₁e₁`, its amplitude initially has direction `e₂` with a
positive scale, and its maximum amplitude on `[0,S₁]` is exactly
`λ₁^(-3/4)`. The equality identifies these data with the pair used in
the central estimates, rather than merely asserting that some first
wave exists. -/
def FirstWaveIdentification {P : InductiveEulerParameters}
    (c : InductiveEulerConstruction P) : Prop :=
  ∃ w : FirstWaveOrigin (Schedule.ε P.frequency 1) (c.stages.slab 1) (P.frequency 1),
    EqOn w.covector (c.centralWaves.waveVector 1) (Icc 0 (c.stages.slab 1)) ∧
    EqOn w.amplitude (c.centralWaves.amplitude 1) (Icc 0 (c.stages.slab 1))

/-- Membership in the time-continuous normed spaces in (7.4): the
oscillation is continuous on `[0,S_j]` in the supremum norm, and the
corrected increment is continuous there in every `C^(m,1/2)` norm
with `m ≤ q_j`. Its norm bounds are in `IncrementBounds`. -/
def IncrementContinuity {P : InductiveEulerParameters}
    (c : InductiveEulerConstruction P) : Prop :=
  ∀ j : ℕ, 1 ≤ j →
    ContinuousOnSlabInSpatialNorm (c.stages.slab j) spatialSupNorm (c.stages.oscillation j) ∧
    ∀ m : ℕ, m ≤ P.order j →
      ContinuousOnSlabInSpatialNorm (c.stages.slab j) (paperSpatialHolderNorm m)
        (fun t => c.stages.velocity j t - c.stages.velocity (j - 1) t - c.stages.oscillation j t)

/-- The bounds (7.4) are the clause `increment` of the authors' conclusion predicate
(`paperSpatialHolderNorm` is an abbreviation of `spatialHolderHalfNorm`). -/
theorem increment_bounds {P : InductiveEulerParameters}
    {c : InductiveEulerConstruction P} {C T : ℝ}
    (h : Theorem71Conclusions c C T) : IncrementBounds c := by
  intro j hj t ht
  exact h.increment j hj t ht

end

end Adapted.S7

/-! ## Proof of Theorem 7.1 from the authors' concrete construction

The authors' theorem `Paper.theorem_7_1` exports the construction only through an
existential, so its step witnesses cannot be compared with the central waves afterwards.
The declarations below rerun the authors' proof of Theorem 7.1 (with the authors' own lemmas)
and keep two facts that the authors' local proofs establish and then discard:

* in the step (`Lib.S678a.exists_step_of_section5`, Library/StepBuild.lean:35), the transported
  covector of the carrier `tip.laterCarrier d` equals `d.crossing.waveVector` on `[t_j,S_j]`
  (`hTr`, from `transport_launch_covector`), and the constructed wave has wave vector
  `d.crossing.waveVector` by definition (`InductiveEulerStep.ofPhysicalHierarchyCutoff'`);
* in the base (`Lib.S678a.exists_base_of_section5`, Library/Base.lean:97), the first wave is
  built with `waveVector := w.covector` and `amplitude := w.amplitude` for the first wave
  `w : FirstWaveOrigin` of Lemma 6.1, and the transported covector of its carrier equals
  `w.covector` (`hkv`, from `Bridge.waveVector_origin_eq_of_covector`).

The copies are textual copies of the authors' proofs; only their conclusions are extended by
these facts. They live in a namespace below `TorusEuler.Paper.Lib.S678a` so that every name
resolves exactly as in the authors' files. Nothing in `TorusEuler` is modified. -/

namespace TorusEuler.Paper.Lib.S678a.AdaptedS7

section LocalData

open Set UnitAddTorus
open scoped ContDiff InnerProductSpace
open TorusEuler HierarchyTwistedProfile

noncomputable section

/-- Copy of `Lib.S678a.LocalStep` (Paper/Proofs/S678a/Library/LocalStep.lean:41) with one
added last clause: the central wave vector of `wave` is the transported covector
`(D_aX)^(-T)k` of the same carrier `k`, at the origin, on `[t,S]`. -/
def IdLocalStep {P : InductiveEulerParameters} {n : ℕ} {tOld t next : ℝ}
    (parent : InductiveEulerStage P n tOld) (child : InductiveEulerStage P (n + 1) t)
    (wave : InductiveEulerWave P n parent child next) (a : ℕ) (ψ : Vec3 → ℝ) : Prop :=
  ∃ (hT : 0 < P.slab (n + 1) t) (k : Vec3) (center : ℝ → Vec3) (amp : ℝ → Vec3 → Vec3)
    (d : ParentGeometry hT parent.velocity parent.flow k)
    (χ : PaperWaveCutoff t (P.slab (n + 1) t))
    (R S : HierarchyTwistedProfile (P.slab (n + 1) t) k Vec3)
    (u : HierarchyProfiles (HierarchyTwistedProfile (P.slab (n + 1) t) k Vec3)
      (HierarchyTwistedProfile (P.slab (n + 1) t) k ℝ)),
    S5.Parent (P.slab (n + 1) t) parent.velocity parent.flow parent.pressure
      (P.frequency n ^ 9) (P.frequency (n + 1)) ∧
    S5.Launch (P.slab (n + 1) t) parent.flow k (P.frequency (n + 1)) t ∧
    S5.Origin (P.slab (n + 1) t) parent.velocity parent.flow k (P.frequency n ^ 9)
      (P.frequency (n + 1)) t center ∧
    (∀ r ∈ Icc t (P.slab (n + 1) t), center r = wave.amplitude r) ∧
    S5.IsSeed parent.velocity parent.flow k t (P.slab (n + 1) t) center amp ∧
    (∀ r ∈ Icc 0 (P.slab (n + 1) t), χ.value r = wave.cutoff r) ∧
    S5.IsExpansion d parent.pressure χ (S5.radius (P.frequency n ^ 9) a)
      (S5.width (P.frequency (n + 1))) amp
      (6 * frequencyExponent P.exponentParameter (P.order (n + 2))) R S u ∧
    ApproxClause d parent.pressure S u
      (6 * frequencyExponent P.exponentParameter (P.order (n + 2))) ∧
    S5.IsTruncation (P.slab (n + 1) t) ψ (P.frequency (n + 1) ^ 5)
      (parent.velocity + graphRead (fun r => parent.flow r 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 2)))))
      child.velocity child.pressure ∧
    (∀ r ∈ Icc 0 (P.slab (n + 1) t), wave.oscillation r =
      graphRead (fun r => parent.flow r 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 2))) -
          (S5.ops d).average
            (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 2))))) r) ∧
    ∀ r ∈ Icc t (P.slab (n + 1) t), S5.waveVector parent.flow k r 0 = wave.waveVector r

/-- Copy of `Lib.S678a.steps_of_local` (Library/LocalStep.lean:76) for `IdLocalStep`. -/
theorem identified_steps_of_local {P : InductiveEulerParameters} (c : InductiveEulerConstruction P)
    (a : ℕ) (ψ : Vec3 → ℝ)
    (hbase : IdLocalStep c.base.stationary c.base.first c.base.wave a ψ)
    (hstep : ∀ n, IdLocalStep (c.tip n).parent (c.selectedStep n).child (c.selectedStep n).wave a ψ) :
    Adapted.S7.IdentifiedSteps c a ψ := by
  intro j hj
  match j, hj with
  | 1, _ =>
    obtain ⟨hT, k, center, amp, d, χ, R, S, u, hP, hL, hO, hc, hs, hcut, hexp, happ,
      htr, hosc, hk⟩ := hbase
    exact ⟨hT, k, center, amp, d, χ, R, S, u,
      ⟨hP, hL, hO, hc, hs, hcut, hexp, happ, htr, hosc⟩, hk⟩
  | n + 2, _ =>
    obtain ⟨hT, k, center, amp, d, χ, R, S, u, hP, hL, hO, hc, hs, hcut, hexp, happ,
      htr, hosc, hk⟩ := hstep n
    exact ⟨hT, k, center, amp, d, χ, R, S, u,
      ⟨hP, hL, hO, hc, hs, hcut, hexp, happ, htr, hosc⟩, hk⟩

end

end LocalData

section Continuity

open Filter Set
open scoped ContDiff Topology
open TorusEuler InductiveEulerStages HierarchyTwistedProfile

/-- The time continuity in (7.4). The proof copies the regularity part of
`Lib.Aux.mixedIncrementBound_of_stage` (Paper/Proofs/Auxiliary/Library/TimeSteps.lean:140):
`O_j = W_osc^♮` is jointly smooth and periodic on `[0,S_j]` by the step data, hence so is
`U_j - U_{j-1} - O_j`, and `slabTimeJet_normContinuity` at time order `0` gives continuity in
the supremum norm and in every `C^(m,1/2)` norm. -/
theorem increment_continuity {P : InductiveEulerParameters} {c : InductiveEulerConstruction P}
    {C T : ℝ} {a : ℕ} {ψ : Vec3 → ℝ}
    (h71 : Theorem71Conclusions c C T) (hId : Adapted.S7.IdentifiedSteps c a ψ) :
    Adapted.S7.IncrementContinuity c := by
  intro j hj
  obtain ⟨hT, k, center, amp, d, χ, R, S, u, hd, -⟩ := hId j hj
  let Sj := c.stages.slab j
  let X := (c.stage (j - 1)).flow
  let Wosc := S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (j + 1))) -
    (S5.ops d).average (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (j + 1))))
  have hX := hd.parent.flow
  have hU := hd.parent.velocity_smooth
  have hUper := hd.parent.velocity_periodic
  have hY : ContDiffOn ℝ ∞ (fun z : ℝ × Vec3 => X z.1 0 z.2) (Icc 0 Sj ×ˢ (univ : Set Vec3)) :=
    hX.contDiffOn_inverseLabelFlow hT hU hUper
  have hO : ContDiffOn ℝ ∞ (Function.uncurry (c.stages.oscillation j))
      (Icc 0 Sj ×ˢ (univ : Set Vec3)) := by
    refine (HierarchySmoothProfile.contDiffOn_graphRead (A := fun t => X t 0) k Wosc.val.val
      hY).congr fun z hz => ?_
    exact congrFun (hd.oscillation z.1 hz.1) z.2
  have hOper : ∀ t ∈ Icc 0 Sj, SpatiallyPeriodic (c.stages.oscillation j t) := by
    intro t ht
    rw [hd.oscillation t ht]
    exact spatiallyPeriodic_inverseParentGraphRead hT hX hU hUper Wosc ht
  let f : Velocity := fun r x =>
    c.stages.velocity j r x - c.stages.velocity (j - 1) r x - c.stages.oscillation j r x
  have hf : ContDiffOn ℝ ∞ (Function.uncurry f) (Icc 0 Sj ×ˢ (univ : Set Vec3)) :=
    ((h71.T1 j).1.sub hU).sub hO
  have hfper : ∀ t ∈ Icc 0 Sj, SpatiallyPeriodic (f t) := by
    intro t ht n x
    simp only [f, ((h71.T1 j).2 t ht).1 n x, hUper t ht n x, hOper t ht n x]
  refine ⟨?_, fun m _ => ?_⟩
  · have h := (slabTimeJet_normContinuity hT hO hOper 0 0).1
    rw [slabTimeJet_zero] at h
    exact h
  · have h := (slabTimeJet_normContinuity hT hf hfper 0 m).2
    rw [slabTimeJet_zero] at h
    exact h

end Continuity

section Step

open Set UnitAddTorus
open scoped ContDiff InnerProductSpace
open TorusEuler HierarchyTwistedProfile MovingWaveVector MovingWaveVector.PhysicalAmplification

noncomputable section

set_option maxHeartbeats 6400000 in
/-- **One step of the induction from Section 5** (items 2 and 4 of the proof of Theorem 7.1): for
the selected wave `d` over a certified prefix, there is a step of the construction whose
parent, child and wave carry the local data of `Theorem71StepData`. Uses `h5_4` (seed, expansion,
vanishing and support, through `h54`), `h5_8`-`h5_11` (through `exists_child_of_section5`) and
the parent hypotheses of Subsection 5.1 (`hParent`). -/
theorem exists_step_identified
    {P : InductiveEulerParameters} {hLife : P.LifetimeBounds} {n : ℕ} {tip : InductiveEulerTip P n}
    (pre : InductiveEulerPrefix P hLife n tip)
    (w : tip.LaterWindow) (d : tip.LaterSelection w)
    {ψ : Vec3 → ℝ} {a : ℕ} {Γ : ℕ → ℝ} {K58 : ℕ → ℕ → ℝ} {C11 Cc : ℝ} {K11 Ct : ℕ → ℝ}
    {Cparent Cstep Cmean : ℝ}
    (h54 : Body54 a) (h58 : Body58 a P.exponentParameter Γ K58)
    (h59 : Body59 a P.exponentParameter Γ) (h510 : Body510 a P.exponentParameter Γ)
    (h511 : Body511 ψ a P.exponentParameter Γ C11 K11)
    (hTail : TailBounds ψ Ct)
    (hParent : ∀ {m : ℕ} {act T : ℝ} (s : InductiveEulerStage P m act), 0 < T →
      T ≤ P.slab m act → T ≤ 1 →
      S5.Parent T s.velocity s.flow s.pressure (P.frequency m ^ 9) (P.frequency (m + 1)))
    (ha : 3 ≤ a) (hLarge : Real.exp 4 ≤ P.frequency 0) (hConst : 18 * Real.exp 3 ≤ P.strengthConstant)
    (hC11 : C11 ≤ Cc)
    (hNum : StepNumbers P (n + 1) Γ K58 Cc K11 Ct Cparent Cstep Cmean)
    (hJets : ∀ t ∈ Icc 0 (P.slab (n + 1 + 1) tip.nextActivation),
      PhaseJetBound (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2)) + 1)
        (Cparent * P.frequency (n + 1) ^ (5 * (6 * frequencyExponent P.exponentParameter
          (P.order (n + 1 + 2)) + 1) + 1)) (tip.parent.velocity t))
    (hSwitch : ∀ t, |deriv (waveSwitch tip.nextActivation w.physical.rate) t| *
      |S5.weight (P.frequency (n + 1 + 1)) d.crossing.amplitude t| ≤
        P.frequency (n + 1) * P.frequency (n + 1 + 2) ^ (-4 : ℝ)) :
    ∃ step : InductiveEulerStep tip, IdLocalStep tip.parent step.child step.wave a ψ ∧
      step.wave.cutoff = waveSwitch tip.nextActivation step.physical.rate := by
  classical
  have h2e : (2 : ℝ) ≤ Real.exp 4 := by linarith [Real.add_one_le_exp (4 : ℝ)]
  have hInitial : 2 ≤ P.frequency 0 := h2e.trans hLarge
  have hMono := frequencySchedule_frequency_mono P.exponentParameter P.order P.frequency
    P.exponentParameter_ge (one_le_two.trans hInitial) P.frequency_step
  obtain ⟨hμ2, -, hDepth⟩ := physicalWave_schedule (P := P) (n := n + 1) hInitial
  have hdep2 : 2 ≤ 6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2)) :=
    (le_max_left _ _).trans hDepth
  have hT : 0 < P.slab (n + 1 + 1) tip.nextActivation := tip.next_slab_pos hLife
  have hTold : P.slab (n + 1 + 1) tip.nextActivation ≤ P.slab (n + 1) tip.activation :=
    (tip.next_slab_lt hLife).le
  have hT₁ : P.slab (n + 1 + 1) tip.nextActivation ≤ 1 := hTold.trans pre.tip_parent_slab_le_one
  have ht₀ : 0 ≤ tip.nextActivation := tip.next_activation_nonnegative
  have ht₀T : tip.nextActivation < P.slab (n + 1 + 1) tip.nextActivation := by
    change tip.nextActivation < tip.nextActivation + 2 * inductionHalfLength P.frequency (n + 1)
    linarith only [(hLife.step (n + 1)).1]
  have hpar := hParent tip.parent hT hTold hT₁
  have hsub : Icc 0 (P.slab (n + 1 + 1) tip.nextActivation) ⊆ Icc 0 (P.slab (n + 1) tip.activation) :=
    Icc_subset_Icc_right hTold
  have hX : IsLabelFlowOn tip.parent.velocity tip.parent.flow (Icc 0 (P.slab (n + 1 + 1) tip.nextActivation)) :=
    tip.parent.deformation.flow.mono hsub
  have hU : ContDiffOn ℝ ∞ (Function.uncurry tip.parent.velocity)
      (Icc 0 (P.slab (n + 1 + 1) tip.nextActivation) ×ˢ (univ : Set Vec3)) :=
    tip.parent.smooth_velocity.mono (prod_mono_left hsub)
  have hper (t : ℝ) (_ : t ∈ Icc 0 (P.slab (n + 1 + 1) tip.nextActivation)) :
      SpatiallyPeriodic (tip.parent.velocity t) := tip.parent.periodic_velocity t
  have hodd (t : ℝ) (ht : t ∈ Icc 0 (P.slab (n + 1 + 1) tip.nextActivation)) :
      Function.Odd (tip.parent.velocity t) := tip.parent.odd_velocity t (hsub ht)
  have hfp : 0 < P.frequency (n + 1 + 1) :=
    zero_lt_one.trans_le ((one_le_two.trans hInitial).trans (hMono (Nat.zero_le _)))
  have hLaunch := d.crossing.launch_geometry hfp
  have hKexpr : tip.laterCarrier d = P.frequency (n + 1 + 1) •
      (fderiv ℝ (tip.parent.flow 0 tip.nextActivation) (0 : Vec3)).adjoint
        (w.physical.basis tip.nextActivation 2) := by
    simp only [InductiveEulerTip.laterCarrier, hLaunch.1, map_smul]
  have hTransport := d.crossing.transport_launch_covector hX hT (hU.of_le (by simp)) hper hodd
    ⟨ht₀, ht₀T.le⟩ d.clock_eq w.parent_gradient_eq
  dsimp only at hTransport
  rw [← hKexpr] at hTransport
  obtain ⟨hk, hTr⟩ := hTransport
  have hl : S5.Launch (P.slab (n + 1 + 1) tip.nextActivation) tip.parent.flow (tip.laterCarrier d)
      (P.frequency (n + 1 + 1)) tip.nextActivation :=
    Bridge.launch_of_carrier ht₀ ht₀T hk (by
      show ‖labelWaveVector tip.parent.flow 0 0 (tip.laterCarrier d) tip.nextActivation‖ = _
      rw [hTr ⟨le_rfl, ht₀T.le⟩]
      exact hLaunch.2.1)
  have hActive : w.physical.activeSlab d.window = Icc tip.nextActivation
      (P.slab (n + 1 + 1) tip.nextActivation) := by
    unfold PhysicalAmplification.activeSlab
    rw [d.clock_eq]
  have hnorm : ∀ t ∈ Icc tip.nextActivation (P.slab (n + 1 + 1) tip.nextActivation),
      P.frequency (n + 1 + 1) ^ (3 / 4 : ℝ) * ‖d.crossing.amplitude t‖ ≤ 1 := by
    intro t ht
    have hp := d.crossing.peak.2 (mem_image_of_mem _ (hActive ▸ ht))
    calc P.frequency (n + 1 + 1) ^ (3 / 4 : ℝ) * ‖d.crossing.amplitude t‖
        ≤ P.frequency (n + 1 + 1) ^ (3 / 4 : ℝ) * P.frequency (n + 1 + 1) ^ (-3 / 4 : ℝ) :=
          mul_le_mul_of_nonneg_left hp (Real.rpow_nonneg hfp.le _)
      _ = 1 := by
        rw [← Real.rpow_add hfp]
        norm_num
  have ho : S5.Origin (P.slab (n + 1 + 1) tip.nextActivation) tip.parent.velocity tip.parent.flow
      (tip.laterCarrier d) (P.frequency (n + 1) ^ 9) (P.frequency (n + 1 + 1)) tip.nextActivation
      d.crossing.amplitude :=
    Bridge.origin_of_centerWaveOn hpar hl d.center (fun t ht => hTr ht) hnorm
  obtain ⟨dg, -⟩ := Bridge.exists_truncatedHierarchyParent hT hpar hk
  have hrate : 0 < w.physical.rate := w.physical.rate_pos
  let χ : PaperWaveCutoff tip.nextActivation (P.slab (n + 1 + 1) tip.nextActivation) :=
    paperCutoffOfWaveSwitch tip.nextActivation w.physical.rate _ hrate.le
  have hχ : χ.value tip.nextActivation = 0 := waveSwitch_eq_zero_of_le hrate.le le_rfl
  obtain ⟨⟨amp, hamp⟩, h4a⟩ := h54 hT dg χ hpar hl ho
  obtain ⟨⟨R, S, u, hu⟩, -, hid⟩ := h4a amp hamp
    (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))) hdep2
  obtain ⟨-, -, -, hsum, hsupp, -, hvan, -⟩ := hid R S u hu
  -- the derivative of the cutoff
  have hdS : χ.derivativeSize (S5.weight (P.frequency (n + 1 + 1)) d.crossing.amplitude) ≤
      P.frequency (n + 1) * P.frequency (n + 1 + 2) ^ (-4 : ℝ) :=
    derivativeSize_paperCutoffOfWaveSwitch_le hrate.le hT ht₀ ht₀T.le _
      (fun t _ => mul_nonneg (Real.rpow_nonneg hfp.le _) (norm_nonneg _)) hSwitch
  have hRVn := hNum.residual _ hdS
  -- the child
  obtain ⟨s, child, hv, hp, hosc, hcorr, happ, htr, hT1, hT2, hT3, h550⟩ :=
    exists_child_of_section5 (parent := tip.parent) h58 h59 h510 h511 hTail hT dg χ hpar hl ho
      hamp hu ha hInitial hTold hNum.flow_small hRVn hNum.ct_nonneg hNum.ct_le hC11 hNum.cc_nonneg
      hNum.k11_le hNum.large hJets hNum.jets_le hNum.parent_nonneg hNum.osc_le hNum.step0
      hNum.stepΓ hNum.step32 hNum.mean_le hNum.mean_mu
  -- vanishing and support of the oscillation
  have hVanish : ∀ t ∈ Icc 0 tip.nextActivation, graphRead (fun r => tip.parent.flow r 0)
      (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))) -
        (S5.ops dg).average (S5.expansion u (6 * frequencyExponent P.exponentParameter
          (P.order (n + 1 + 2))))) t = 0 := by
    intro t ht
    have hz := osc_profile_vanishes (d := dg) (χ := χ) ht₀ ht₀T.le hχ hu hsum
      (fun i hi t ht hlt x s => ((hvan t ht hlt x s).1 i hi).1) t ht
    funext x
    exact hz _ _
  have hSupport : ∀ t ∈ Icc 0 (P.slab (n + 1 + 1) tip.nextActivation), ∀ x,
      graphRead (fun r => tip.parent.flow r 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))) -
          (S5.ops dg).average (S5.expansion u (6 * frequencyExponent P.exponentParameter
            (P.order (n + 1 + 2))))) t x ≠ 0 →
      ∃ z : Fin 3 → ℤ, dist (latticeVector z) x ≤ (P.frequency (n + 1))⁻¹ := by
    have hD : 1 ≤ P.frequency (n + 1) ^ 9 :=
      one_le_pow₀ (one_le_two.trans (hμ2))
    exact osc_support tip.parent hT hTold
      (inv_pos.mpr (pow_pos (zero_lt_one.trans_le hD) a)) hμ2
      (inv_anti₀ (pow_pos (zero_lt_one.trans_le hD) 3) (pow_le_pow_right₀ hD ha)) _ hsupp
  have hApprox : ∀ t ∈ Icc tip.nextActivation (P.slab (n + 1 + 1) tip.nextActivation),
      fderiv ℝ ((tip.parent.velocity + graphRead (fun r => tip.parent.flow r 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))))) t) 0 =
        fderiv ℝ (tip.parent.velocity t) 0 +
          waveSwitch tip.nextActivation w.physical.rate t •
            InnerProductSpace.rankOne ℝ (d.crossing.amplitude t) (d.crossing.waveVector t) +
          (fderiv ℝ ((tip.parent.velocity + graphRead (fun r => tip.parent.flow r 0)
            (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))))) t) 0 -
            fderiv ℝ (tip.parent.velocity t) 0 -
            waveSwitch tip.nextActivation w.physical.rate t •
              InnerProductSpace.rankOne ℝ (d.crossing.amplitude t) (d.crossing.waveVector t)) ∧
        ‖fderiv ℝ ((tip.parent.velocity + graphRead (fun r => tip.parent.flow r 0)
            (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order (n + 1 + 2))))) t) 0 -
            fderiv ℝ (tip.parent.velocity t) 0 -
            waveSwitch tip.nextActivation w.physical.rate t •
              InnerProductSpace.rankOne ℝ (d.crossing.amplitude t) (d.crossing.waveVector t)‖ ≤
          P.frequency (n + 1 + 1) ^ (-1 / 3 : ℝ) := by
    intro t ht
    refine ⟨by abel, ?_⟩
    have h := h550 t ht
    have hw : S5.waveVector tip.parent.flow (tip.laterCarrier d) t 0 = d.crossing.waveVector t :=
      hTr ht
    rw [hw] at h
    exact h
  refine ⟨InductiveEulerStep.ofPhysicalHierarchyCutoff' pre w d s child hv hLarge hConst hosc hcorr
    (fun t ht => hVanish t ht) hSupport hT1 hT2 hdep2 hT3 happ.1.1 hApprox, ?_, rfl⟩
  exact ⟨hT, tip.laterCarrier d, d.crossing.amplitude, amp, dg, χ, R, S, u, hpar, hl, ho,
      fun r _ => rfl, hamp, fun r _ => rfl, hu, happ, htr, fun r _ => rfl, fun r hr => hTr hr⟩

end

end Step

section Base

open Set UnitAddTorus
open scoped ContDiff InnerProductSpace
open TorusEuler HierarchyTwistedProfile LocalizedAmplitude
open TorusEuler.MovingWaveVector (frame entry)

noncomputable section

set_option maxHeartbeats 6400000 in
/-- **The base of the induction from Section 5** (the base, sections/08b_induction.tex:252-256, and item 2 for `j = 1`, :285-291, of the proof of Theorem 7.1;
the central gradient is item 6, :473-479): the stationary base, the first child and the first wave carry
the local data of `Theorem71StepData` (step `j = 1`), the base velocity is the shear (6.1) at the
scheduled tilt and the first cutoff is `1`. Uses `h6_1` (first wave, (5.5), strength),
`h5_4`, `h5_8`-`h5_11` (through `exists_child_of_section5`). -/
theorem exists_base_identified {P : InductiveEulerParameters} (hLife : P.LifetimeBounds)
    (h6_1 : Statement.lemma_6_1)
    {ψ : Vec3 → ℝ} {a : ℕ} {Γ : ℕ → ℝ} {K58 : ℕ → ℕ → ℝ} {C11 Cc : ℝ} {K11 Ct Cj : ℕ → ℝ}
    {Cstep Cmean : ℝ}
    (h54 : Body54 a) (h58 : Body58 a P.exponentParameter Γ K58)
    (h59 : Body59 a P.exponentParameter Γ) (h510 : Body510 a P.exponentParameter Γ)
    (h511 : Body511 ψ a P.exponentParameter Γ C11 K11)
    (hTail : TailBounds ψ Ct)
    (hParent : ∀ {m : ℕ} {act T : ℝ} (s : InductiveEulerStage P m act), 0 < T →
      T ≤ P.slab m act → T ≤ 1 →
      S5.Parent T s.velocity s.flow s.pressure (P.frequency m ^ 9) (P.frequency (m + 1)))
    (hJets : ∀ {m : ℕ} {act : ℝ} (s : InductiveEulerStage P m act), 1 ≤ P.frequency m → ∀ N : ℕ,
      ∀ t ∈ Icc 0 (P.slab m act),
        PhaseJetBound (N + 1) (Cj N * P.frequency m ^ (5 * (N + 1) + 1)) (s.velocity t))
    (ha : 3 ≤ a) (hN : (64 * Real.pi) ^ (16 : ℕ) ≤ P.frequency 0) (hExp : Real.exp 1 ≤ P.frequency 0)
    (hC11 : C11 ≤ Cc)
    (hNum : StepNumbers P 0 Γ K58 Cc K11 Ct
      (Cj (6 * frequencyExponent P.exponentParameter (P.order 2))) Cstep Cmean) :
    ∃ b : InductiveEulerBase P, IdLocalStep b.stationary b.first b.wave a ψ ∧
      b.stationary.velocity =
        (fun _ => stationaryShear (couplingRatioOfGain (4 * Real.log (P.frequency 3)))) ∧
      b.wave.cutoff = (fun _ => 1) ∧
      ∃ w : FirstWaveOrigin (couplingRatioOfGain (4 * Real.log (P.frequency 3))) (P.slab 1 0)
          (P.frequency 1),
        b.wave.waveVector = w.covector ∧ b.wave.amplitude = w.amplitude := by
  classical
  have hπ : 3 < Real.pi := Real.pi_gt_three
  have h64 : 1 ≤ 64 * Real.pi := by linarith
  have hBase : 1 + 4 * Real.pi ≤ P.frequency 0 :=
    (by linarith : 1 + 4 * Real.pi ≤ 64 * Real.pi).trans
      ((le_self_pow₀ h64 (by norm_num : (16 : ℕ) ≠ 0)).trans hN)
  have hInitial : 2 ≤ P.frequency 0 := by linarith
  have hMono := frequencySchedule_frequency_mono P.exponentParameter P.order P.frequency
    P.exponentParameter_ge (by linarith) P.frequency_step
  have hGain : 1 ≤ 4 * Real.log (P.frequency 3) := by
    have hg := Real.log_le_log (Real.exp_pos 1) (hExp.trans (hMono (Nat.zero_le 3)))
    rw [Real.log_exp] at hg
    linarith
  have hTilt : |couplingRatioOfGain (4 * Real.log (P.frequency 3))| ≤ 1 := by
    rw [couplingRatioOfGain, abs_of_nonneg (inv_nonneg.mpr (sq_nonneg _))]
    exact (inv_le_one₀ (sq_pos_of_pos (zero_lt_one.trans_le hGain))).2 (one_le_pow₀ hGain)
  have hTiltPos : 0 < couplingRatioOfGain (4 * Real.log (P.frequency 3)) :=
    inv_pos.mpr (sq_pos_of_pos (zero_lt_one.trans_le hGain))
  have hTime : P.slab 1 0 = 2 * inductionHalfLength P.frequency 0 := by
    rw [P.slab_succ, zero_add]
  have hT : 0 < P.slab 1 0 := by
    rw [hTime]
    exact mul_pos zero_lt_two (hLife.step 0).1
  have hT₁ : P.slab 1 0 ≤ 1 := by
    rw [hTime]
    linarith only [hLife.first]
  have hSmall := firstWave_stationaryShear_window_small hTilt hT.le hTime.le (hLife.step 0).2.1 hN
  have hf1 : 1 ≤ P.frequency 1 := (by linarith : (1 : ℝ) ≤ P.frequency 0).trans (hMono (Nat.zero_le 1))
  have hfpos : 0 < P.frequency 1 := zero_lt_one.trans_le hf1
  let parent : InductiveEulerStage P 0 0 := stationaryInductiveEulerStage P hTilt hBase
  have hPv : parent.velocity = fun _ => stationaryShear (couplingRatioOfGain (4 * Real.log (P.frequency 3))) :=
    funext fun t => funext fun x => stationaryInductiveEulerStage_velocity P hTilt hBase t x
  obtain ⟨⟨w⟩, hall⟩ := h6_1 (couplingRatioOfGain (4 * Real.log (P.frequency 3))) (P.slab 1 0)
    (P.frequency 1) hTiltPos (abs_le.mp hTilt).2 hf1 hT hSmall
  have hc := hall w
  have hpar := hParent parent hT (by rw [P.slab_zero]; exact hT₁) hT₁
  have ht₀ : (0 : ℝ) ∈ Icc 0 (P.slab 1 0) := ⟨le_rfl, hT.le⟩
  have hκ : ∀ t ∈ Icc 0 (P.slab 1 0), HasDerivWithinAt w.covector
      (-((fderiv ℝ (parent.velocity t) (0 : Vec3)).adjoint (w.covector t))) (Icc 0 (P.slab 1 0)) t := by
    intro t ht
    have := w.covector_equation t ht
    simpa only [hPv, stationaryShearGradient_origin] using this
  obtain ⟨hkne, hkv⟩ := Bridge.waveVector_origin_eq_of_covector (X := parent.flow) hT hpar ht₀ hκ
  have hk : (fderiv ℝ (parent.flow 0 0) (0 : Vec3)).adjoint (w.covector 0) ≠ 0 :=
    hkne (w.transverse 0 ht₀).1
  have hl : S5.Launch (P.slab 1 0) parent.flow ((fderiv ℝ (parent.flow 0 0) (0 : Vec3)).adjoint (w.covector 0))
      (P.frequency 1) 0 :=
    Bridge.launch_of_carrier le_rfl hT hk (by
      rw [hkv 0 ht₀, w.covector_initial]
      simp [EuclideanSpace.single, norm_smul, PiLp.norm_single, abs_of_pos hfpos])
  have hcw : CenterWaveOn (fun _ => fderiv ℝ (stationaryShear (couplingRatioOfGain
      (4 * Real.log (P.frequency 3)))) 0) w.covector w.amplitude 0 (P.slab 1 0) (P.frequency 0 ^ 9) :=
    (centerWaveOn_of_lemma61 w hc hfpos (by
      have : (2 : ℝ) ≤ P.frequency 0 ^ 9 :=
        hInitial.trans (le_self_pow₀ (one_le_two.trans hInitial) (by norm_num))
      exact this)).congr_gradient (fun _ _ => (stationaryShearGradient_origin _).symm)
  have hcwU : CenterWaveOn (fun t => fderiv ℝ (parent.velocity t) 0) w.covector w.amplitude 0
      (P.slab 1 0) (P.frequency 0 ^ 9) := by
    rw [hPv]
    exact hcw
  have hnorm : ∀ t ∈ Icc 0 (P.slab 1 0), P.frequency 1 ^ (3 / 4 : ℝ) * ‖w.amplitude t‖ ≤ 1 := by
    intro t ht
    calc P.frequency 1 ^ (3 / 4 : ℝ) * ‖w.amplitude t‖
        ≤ P.frequency 1 ^ (3 / 4 : ℝ) * P.frequency 1 ^ (-(3 / 4) : ℝ) :=
          mul_le_mul_of_nonneg_left (w.norm_le_peak t ht) (Real.rpow_nonneg hfpos.le _)
      _ = 1 := by
        rw [← Real.rpow_add hfpos]
        norm_num
  have ho : S5.Origin (P.slab 1 0) parent.velocity parent.flow
      ((fderiv ℝ (parent.flow 0 0) (0 : Vec3)).adjoint (w.covector 0)) (P.frequency 0 ^ 9)
      (P.frequency 1) 0 w.amplitude :=
    Bridge.origin_of_centerWaveOn hpar hl hcwU (fun t ht => hkv t ht) hnorm
  obtain ⟨dg, -⟩ := Bridge.exists_truncatedHierarchyParent hT hpar hk
  let χ : PaperWaveCutoff 0 (P.slab 1 0) := PaperWaveCutoff.first (P.slab 1 0)
  obtain ⟨hμ2, -, hDepth⟩ := physicalWave_schedule (P := P) (n := 0) hInitial
  have hdep2 : 2 ≤ 6 * frequencyExponent P.exponentParameter (P.order 2) :=
    (le_max_left _ _).trans hDepth
  obtain ⟨⟨amp, hamp⟩, h4a⟩ := h54 hT dg χ hpar hl ho
  obtain ⟨⟨R, S, u, hu⟩, -, hid⟩ := h4a amp hamp
    (6 * frequencyExponent P.exponentParameter (P.order 2)) hdep2
  obtain ⟨-, -, -, hsum, hsupp, -, hvan, -⟩ := hid R S u hu
  have hds : χ.derivativeSize (S5.weight (P.frequency 1) w.amplitude) = 0 := by
    have : Nonempty (Icc (0 : ℝ) (P.slab 1 0)) := ⟨⟨0, ht₀⟩⟩
    unfold PaperWaveCutoff.derivativeSize
    simp [χ, PaperWaveCutoff.derivative_first]
  have hRVn := hNum.residual (χ.derivativeSize (S5.weight (P.frequency 1) w.amplitude)) (by
    rw [hds]
    have h0 : 0 ≤ P.frequency 0 := by linarith
    have h2 : 0 ≤ P.frequency 2 := by linarith [hMono (Nat.zero_le 2)]
    positivity)
  obtain ⟨s, child, hv, hp, hosc, hcorr, happ, htr, hT1, hT2, hT3, h550⟩ :=
    exists_child_of_section5 (parent := parent) h58 h59 h510 h511 hTail hT dg χ hpar hl ho
      hamp hu ha hInitial (by rw [P.slab_zero]; exact hT₁) hNum.flow_small hRVn hNum.ct_nonneg
      hNum.ct_le hC11 hNum.cc_nonneg hNum.k11_le hNum.large
      (fun t ht => hJets parent (by linarith) _ t ⟨ht.1, ht.2.trans hT₁⟩) hNum.jets_le
      hNum.parent_nonneg hNum.osc_le hNum.step0 hNum.stepΓ hNum.step32 hNum.mean_le hNum.mean_mu
  -- the oscillation and the center
  have hSupport : ∀ t ∈ Icc 0 (P.slab 1 0), ∀ x, graphRead (fun r => parent.flow r 0)
      (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2)) -
        (S5.ops dg).average (S5.expansion u (6 * frequencyExponent P.exponentParameter
          (P.order 2)))) t x ≠ 0 →
      ∃ z : Fin 3 → ℤ, dist (latticeVector z) x ≤ (P.frequency 0)⁻¹ := by
    have hD : 1 ≤ P.frequency 0 ^ 9 := one_le_pow₀ (by linarith)
    exact osc_support parent hT (by rw [P.slab_zero]; exact hT₁)
      (inv_pos.mpr (pow_pos (zero_lt_one.trans_le hD) a)) hμ2
      (inv_anti₀ (pow_pos (zero_lt_one.trans_le hD) 3) (pow_le_pow_right₀ hD ha)) _ hsupp
  have hExponent : 12 ≤ frequencyExponent P.exponentParameter (P.order 1) := by
    rw [P.initial_order]
    unfold frequencyExponent
    have h := Nat.mul_le_mul_left 320 P.exponentParameter_ge
    omega
  have hFreq : (2 : ℝ) ^ (12 : ℕ) ≤ P.frequency 1 := by
    rw [P.frequency_step 0]
    exact (pow_le_pow_left₀ zero_le_two hInitial _).trans
      (pow_le_pow_right₀ (one_le_two.trans hInitial) hExponent)
  have hnext : P.frequency 1 ≤ P.frequency 2 := hMono (by decide)
  have hVsm := happ.1.1
  have hVslice : ∀ r ∈ Icc 0 (P.slab 1 0), DifferentiableAt ℝ
      ((parent.velocity + graphRead (fun t => parent.flow t 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2)))) r) 0 := by
    intro r hr
    have hs := hVsm.comp (contDiff_const.prodMk contDiff_id).contDiffOn
      (fun x (_ : x ∈ (univ : Set Vec3)) => mem_prod.mpr ⟨hr, mem_univ x⟩)
    exact ((contDiffOn_univ.mp hs).differentiable (by simp)) 0
  have hgs := base_gradient_split (U := parent.velocity) (C := child.velocity) (Sv := s.velocity)
    (V := parent.velocity + graphRead (fun t => parent.flow t 0)
      (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2))))
    (κ := w.covector) (a := w.amplitude) (T := P.slab 1 0) (freq := P.frequency 1)
    (next := P.frequency 2) hv hVslice (fun r hr => (hT1 2 hdep2 r hr).1)
    (fun r hr => (hT2 r hr).trans (hT3 r hr))
    (fun r hr => by
      have h := h550 r hr
      rw [hkv r hr] at h
      exact h) hFreq hnext
  have hν : entry (frame w.covector w.amplitude 0) (fderiv ℝ (parent.velocity 0) 0) 0 1 = 2 * Real.pi := by
    rw [hPv, stationaryShearGradient_origin]
    exact (w.initial_couplings hfpos).1
  have hη : entry (frame w.covector w.amplitude 0) (fderiv ℝ (parent.velocity 0) 0) 2 1 =
      2 * Real.pi * couplingRatioOfGain (4 * Real.log (P.frequency 3)) := by
    rw [hPv, stationaryShearGradient_origin]
    exact (w.initial_couplings hfpos).2
  have hStr := hc.initial_strength
  have hL1 : (1 : ℝ) ≤ (4 * Real.log (P.frequency 3)) ^ 2 := one_le_pow₀ hGain
  have hf14 : 0 ≤ P.frequency 1 ^ (1 / 4 : ℝ) := Real.rpow_nonneg hfpos.le _
  have hC2 := P.strengthConstant_ge
  have hS1 : P.strengthConstant⁻¹ * P.frequency 1 ^ (1 / 4 : ℝ) ≤ ‖w.covector 0‖ * ‖w.amplitude 0‖ := by
    have hh : P.strengthConstant⁻¹ ≤ 1 / 2 := by
      rw [one_div]
      exact inv_anti₀ (by norm_num) hC2
    calc P.strengthConstant⁻¹ * P.frequency 1 ^ (1 / 4 : ℝ)
        ≤ (1 / 2) * P.frequency 1 ^ (1 / 4 : ℝ) := mul_le_mul_of_nonneg_right hh hf14
      _ = P.frequency 1 ^ (1 / 4 : ℝ) / 2 := by ring
      _ ≤ ‖w.amplitude 0‖ * ‖w.covector 0‖ := hStr.1
      _ = ‖w.covector 0‖ * ‖w.amplitude 0‖ := mul_comm _ _
  have hS2 : ‖w.covector 0‖ * ‖w.amplitude 0‖ ≤ P.strengthConstant * P.frequency 1 ^ (1 / 4 : ℝ) *
      (4 * Real.log (P.frequency 3)) ^ 2 := by
    have h1 : (1 : ℝ) ≤ P.strengthConstant * (4 * Real.log (P.frequency 3)) ^ 2 :=
      one_le_mul_of_one_le_of_one_le (by linarith) hL1
    calc ‖w.covector 0‖ * ‖w.amplitude 0‖ = ‖w.amplitude 0‖ * ‖w.covector 0‖ := mul_comm _ _
      _ ≤ P.frequency 1 ^ (1 / 4 : ℝ) := hStr.2
      _ = 1 * P.frequency 1 ^ (1 / 4 : ℝ) := (one_mul _).symm
      _ ≤ (P.strengthConstant * (4 * Real.log (P.frequency 3)) ^ 2) * P.frequency 1 ^ (1 / 4 : ℝ) :=
          mul_le_mul_of_nonneg_right h1 hf14
      _ = _ := by ring
  refine ⟨{
    stationary := parent
    first := child
    wave := {
      oscillation := graphRead (fun r => parent.flow r 0)
        (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2)) -
          (S5.ops dg).average (S5.expansion u (6 * frequencyExponent P.exponentParameter
            (P.order 2))))
      waveVector := w.covector
      amplitude := w.amplitude
      cutoff := fun _ => 1
      error := fun r => (fderiv ℝ ((parent.velocity + graphRead (fun t => parent.flow t 0)
            (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2)))) r) 0 -
          fderiv ℝ (parent.velocity r) 0 -
          (1 : ℝ) • InnerProductSpace.rankOne ℝ (w.amplitude r) (w.covector r)) +
          fderiv ℝ (s.velocity r - (parent.velocity + graphRead (fun t => parent.flow t 0)
            (S5.expansion u (6 * frequencyExponent P.exponentParameter (P.order 2)))) r) 0
      center := hcwU
      activation_step := ⟨by norm_num, by
        have := (hLife.step 0).1.le
        norm_num
        exact this⟩
      oscillation_bound := hosc
      correction_bound := hcorr
      oscillation_vanishes := fun hnone => absurd hnone (by omega)
      oscillation_support := hSupport
      gradient_split := fun r hr => by
        have := (hgs r hr).1
        simpa only [InnerProductSpace.rankOne_def, one_smul] using this
      error_bound := fun r hr => (hgs r hr).2
      cutoff_complete := fun _ _ => rfl
      strength_at_crossing := ⟨hS1, hS2⟩
      coupling_at_crossing := by
        dsimp only
        rw [hν]
        exact ⟨by linarith, by linarith⟩
      ratio_at_crossing := by
        dsimp only
        rw [hν, hη, mul_div_cancel_left₀ _ (by positivity)] }
    initial_coupling := hν }, ?_, hPv, rfl, w, rfl, rfl⟩
  exact ⟨hT, _, w.amplitude, amp, dg, χ, R, S, u, hpar, hl, ho, fun r _ => rfl, hamp,
    fun r _ => rfl, hu, happ, htr, fun r _ => rfl, fun r hr => hkv r hr⟩

end

end Base

section Construction

open Set
open TorusEuler MovingWaveVector MovingWaveVector.PhysicalAmplification

noncomputable section

/-- Copy of `Lib.S678a.exists_construction_of_local` (Library/LaterWaveTip.lean:86) for the
strengthened local data `IdLocalStep`; it yields `Adapted.S7.IdentifiedSteps`. -/
theorem exists_construction_identified {P : InductiveEulerParameters} (hLife : P.LifetimeBounds)
    (a : ℕ) (ψ : Vec3 → ℝ) (b : InductiveEulerBase P)
    (hb : IdLocalStep b.stationary b.first b.wave a ψ)
    (hStep : ∀ (n : ℕ) (tip : InductiveEulerTip P n), InductiveEulerPrefix P hLife n tip →
      ∃ step : InductiveEulerStep tip, IdLocalStep tip.parent step.child step.wave a ψ ∧
        step.wave.cutoff = waveSwitch tip.nextActivation step.physical.rate) :
    ∃ c : InductiveEulerConstruction P, c.base = b ∧ Adapted.S7.IdentifiedSteps c a ψ ∧
      ∀ i : ℕ, c.centralWaves.cutoff (i + 2) =
        waveSwitch (c.stages.activation (i + 2)) (c.centralWaves.physical i).rate := by
  classical
  let c : InductiveEulerConstruction P :=
    ⟨hLife, b, fun n tip pre => Classical.choose (hStep n tip pre)⟩
  refine ⟨c, rfl, identified_steps_of_local c a ψ hb (fun n =>
    (Classical.choose_spec (hStep n (c.trace n).1 (c.trace n).2)).1), fun i => ?_⟩
  exact (Classical.choose_spec (hStep i (c.trace i).1 (c.trace i).2)).2


end

end Construction

section Main

open Set Filter
open scoped Topology
open TorusEuler TorusEuler.InductiveEulerParameters TorusEuler.Paper.Lib.S678a

noncomputable section

set_option maxHeartbeats 6400000 in
/-- **Theorem 7.1, with the central identifications.** A copy of the authors' proof
`Proof.theorem_7_1_of` (Paper/Proofs/S678a/Theorem71.lean:46), with the cited results taken
from the spine (Paper/Spine.lean) and with the base and step constructions replaced by
`exists_base_identified` and `exists_step_identified`, which keep the covector and first-wave
equalities that the authors' existential conclusions drop. The envelope-exponent floor
`a₀` of `Statement.theorem_7_1` is not needed and the floor `0` is used. -/
theorem theorem71_identified :
    ∀ ψ : Vec3 → ℝ, S5.CutoffSymbol ψ →
    ∃ (b a : ℕ) (F : ℕ → ℝ), 1 ≤ b ∧
      ∀ B : ℕ → ℝ, AdmissibleThreshold b F B →
        ∃ N₁ : ℝ, ∀ N : ℝ, N₁ ≤ N →
          ∃ (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (T : ℝ),
            P.exponentParameter = b ∧ P.threshold = B ∧ P.frequency 0 = N ∧
            Adapted.S7.SequenceEstimates c (18 * Real.exp 3) T ∧
            Adapted.S7.IdentifiedSteps c a ψ ∧ Adapted.S7.FirstWaveIdentification c ∧
            Adapted.S7.IncrementBounds c ∧ Adapted.S7.IncrementContinuity c := by
  have h1_3 : Statement.lemma_1_3 := _root_.TorusEuler.Paper.lemma_1_3
  have h2_2 : Statement.lemma_2_2 := _root_.TorusEuler.Paper.lemma_2_2
  have h2_5 : Statement.lemma_2_5 := _root_.TorusEuler.Paper.lemma_2_5
  have h2_6 : Statement.lemma_2_6 := _root_.TorusEuler.Paper.lemma_2_6
  have h2_7 : Statement.lemma_2_7 := _root_.TorusEuler.Paper.lemma_2_7
  have h2_8 : Statement.proposition_2_8 := _root_.TorusEuler.Paper.proposition_2_8
  have h5_4 : Statement.proposition_5_4 := _root_.TorusEuler.Paper.proposition_5_4
  have h5_8 : Statement.lemma_5_8 := _root_.TorusEuler.Paper.lemma_5_8
  have h5_9 : Statement.lemma_5_9 := _root_.TorusEuler.Paper.lemma_5_9
  have h5_10 : Statement.lemma_5_10 := _root_.TorusEuler.Paper.lemma_5_10
  have h5_11 : Statement.proposition_5_11 := _root_.TorusEuler.Paper.proposition_5_11
  have h6_1 : Statement.lemma_6_1 := _root_.TorusEuler.Paper.lemma_6_1
  have hB_1 : Statement.lemma_B_1 := _root_.TorusEuler.Paper.lemma_B_1
  classical
  intro ψ hψ
  obtain ⟨a4, h4⟩ := split54 h5_4
  obtain ⟨a8, h8⟩ := split58 h5_8
  obtain ⟨a9, h9⟩ := split59 h5_9
  obtain ⟨a10, h10⟩ := split510 h5_10
  obtain ⟨a11, h11⟩ := split511 h5_11 ψ hψ
  let a : ℕ := max (max (max a4 a8) (max a9 a10)) (max a11 (max 0 3))
  have ha4 : a4 ≤ a := by omega
  have ha8 : a8 ≤ a := by omega
  have ha9 : a9 ≤ a := by omega
  have ha10 : a10 ≤ a := by omega
  have ha11 : a11 ≤ a := by omega
  have ha3 : 3 ≤ a := by omega
  obtain ⟨b8, Γ8, K58, hB8⟩ := h8 a ha8
  obtain ⟨b9, Γ9, hB9⟩ := h9 a ha9
  obtain ⟨b10, Γ10, hB10⟩ := h10 a ha10
  obtain ⟨b11, Γ11, C11, K11, hB11⟩ := h11 a ha11
  let Cc : ℝ := max C11 0
  have hC11 : C11 ≤ Cc := le_max_left _ _
  have hCc : 0 ≤ Cc := le_max_right _ _
  let Γ : ℕ → ℝ := fun p => max (max 1 (max (Γ8 p) (Γ9 p))) (max (max (Γ10 p) (Γ11 p)) (K58 0 p))
  obtain ⟨Ct, hCt0, hCt⟩ := tails_of_lemma_B_1 hB_1 hψ
  have hTail : TailBounds ψ Ct := hCt
  obtain ⟨Cj, hCj0, hJets⟩ := exists_velocity_jets hB_1
  obtain ⟨Npar, hNpar4, hParentAll⟩ := stage_parent hB_1
  let cost : StepCosts Unit :=
    { analytic := fun _ _ p => 3 * ((p : ℝ) + 1) * Cj p
      cutoffTail := fun p => max (Ct p) |K11 p|
      step := Γ
      mean := fun m p => |K58 m p| }
  have hΓ1 : ∀ q, 1 ≤ cost.step q := fun q => (le_max_left _ _).trans' (le_max_left _ _)
  let b : ℕ := max (max (max b8 b9) (max b10 b11)) (max (stepExponentFloor a 0 0 0) 1)
  refine ⟨b, a, fixedOrderThreshold b cost.table, le_max_right _ _ |>.trans' (le_max_right _ _),
    ?_⟩
  intro B hB
  have hC : (2 : ℝ) ≤ 18 * Real.exp 3 := by linarith [Real.add_one_le_exp (3 : ℝ)]
  obtain ⟨C₀, Nw, hC₀, hNw, hWave⟩ :=
    exists_inductiveEulerTip_laterWaveV_threshold hB_1 h1_3 h2_2 h2_5 h2_6 h2_7 h2_8 _ hC
  obtain ⟨Ns, hNs, hSw⟩ :=
    exists_inductiveEulerTip_scheduled_switch_bound_of_lemma13 h1_3 (18 * Real.exp 3) hC
  let Nfloor : ℝ := max (max (max (Real.exp 4) ((64 * Real.pi) ^ (16 : ℕ))) (max (Real.exp 1) Nw))
    (max (max Npar Ns) (max (max 2 ((2 * Cc) ^ (2 : ℕ))) ((4 : ℝ) ^ (16 : ℕ))))
  have hb1 : 1 ≤ b := le_max_right _ _ |>.trans' (le_max_right _ _)
  obtain ⟨N₁, hN₁⟩ := exists_parameters_of_threshold h1_3 b C₀ (18 * Real.exp 3) Nfloor B hb1 hC₀ hC
    hB.pos hB.floor
  refine ⟨N₁, fun N hN => ?_⟩
  obtain ⟨P, hPb, hPC₀, hPstr, hPth, hPfreq, hPfloor, hLife⟩ := hN₁ N hN
  refine ⟨P, ?_⟩
  -- the floors
  obtain ⟨hA1, hA2⟩ := max_le_iff.mp hPfloor
  obtain ⟨hA11, hA12⟩ := max_le_iff.mp hA1
  obtain ⟨hF1, hF2⟩ := max_le_iff.mp hA11
  obtain ⟨hF3, hF4⟩ := max_le_iff.mp hA12
  obtain ⟨hA21, hA22⟩ := max_le_iff.mp hA2
  obtain ⟨hF5, hF6⟩ := max_le_iff.mp hA21
  obtain ⟨hA221, hF9⟩ := max_le_iff.mp hA22
  obtain ⟨hF7, hF8⟩ := max_le_iff.mp hA221
  have hexp4 : (2 : ℝ) ≤ Real.exp 4 := by linarith [Real.add_one_le_exp (4 : ℝ)]
  have hZero : max 2 ((2 * Cc) ^ (2 : ℕ)) ≤ P.frequency 0 := max_le hF7 hF8
  have hb8 : b8 ≤ P.exponentParameter := by rw [hPb]; omega
  have hb9 : b9 ≤ P.exponentParameter := by rw [hPb]; omega
  have hb10 : b10 ≤ P.exponentParameter := by rw [hPb]; omega
  have hb11 : b11 ≤ P.exponentParameter := by rw [hPb]; omega
  have hbfloor : stepExponentFloor a 0 0 0 ≤ P.exponentParameter := by rw [hPb]; omega
  have hΓ1' : ∀ q, 1 ≤ cost.step q := fun q => le_max_of_le_left (le_max_left _ _)
  have h54' : Body54 a := h4 a ha4
  have h58' : Body58 a P.exponentParameter Γ K58 :=
    hB8 P.exponentParameter hb8 Γ (fun p => le_max_of_le_left (le_max_of_le_right (le_max_left _ _)))
  have h59' : Body59 a P.exponentParameter Γ :=
    hB9 P.exponentParameter hb9 Γ (fun p => le_max_of_le_left (le_max_of_le_right (le_max_right _ _)))
  have h510' : Body510 a P.exponentParameter Γ :=
    hB10 P.exponentParameter hb10 Γ (fun p => le_max_of_le_right (le_max_of_le_left (le_max_left _ _)))
  have h511' : Body511 ψ a P.exponentParameter Γ C11 K11 :=
    hB11 P.exponentParameter hb11 Γ (fun p => le_max_of_le_right (le_max_of_le_left (le_max_right _ _)))
  have hTh : ∀ s, 1 ≤ s → fixedOrderThreshold P.exponentParameter cost.table s ≤ P.threshold s := by
    rw [hPb, hPth]
    exact fun s hs => hB.bounds_constants s hs
  have num : ∀ i, P.StepNumericalBudget i a 0 0 0 Cc cost := fun i =>
    stepNumericalBudget_of_threshold_le P cost Cc hTh hbfloor hZero hΓ1' i
  have nums : ∀ i, StepNumbers P i Γ K58 Cc K11 Ct (Cj (P.stepDepth i))
      (Γ (P.stepDepth i) * ((P.frequency i ^ 9) ^ P.exponentParameter)) (P.frequency i) :=
    fun i => stepNumbers_of_budget (num i) (fun _ => rfl) hΓ1' (fun _ _ => le_abs_self _)
      (fun q => le_max_of_le_right (le_max_right _ _)) (fun q => le_max_left _ _)
      (fun q => (le_abs_self _).trans (le_max_right _ _)) hCt0 (fun q => le_rfl) hCj0 hCc
  have hParent : ∀ {m : ℕ} {act T : ℝ} (s : InductiveEulerStage P m act), 0 < T →
      T ≤ P.slab m act → T ≤ 1 →
      S5.Parent T s.velocity s.flow s.pressure (P.frequency m ^ 9) (P.frequency (m + 1)) :=
    fun s h1 h2 h3 => hParentAll P hF5 s h1 h2 h3
  have hConst : 18 * Real.exp 3 ≤ P.strengthConstant := le_of_eq hPstr.symm
  -- every step
  have hStep : ∀ (n : ℕ) (tip : InductiveEulerTip P n), InductiveEulerPrefix P hLife n tip →
      ∃ step : InductiveEulerStep tip, IdLocalStep tip.parent step.child step.wave a ψ ∧
        step.wave.cutoff = waveSwitch tip.nextActivation step.physical.rate := by
    intro n tip pre
    obtain ⟨w, ⟨d⟩⟩ := hWave tip hLife hF4 hPstr hPC₀
    have hSwitch : ∀ t, |deriv (waveSwitch tip.nextActivation w.physical.rate) t| *
        |S5.weight (P.frequency (n + 1 + 1)) d.crossing.amplitude t| ≤
          P.frequency (n + 1) * P.frequency (n + 1 + 2) ^ (-4 : ℝ) :=
      hSw tip hF6 hPstr w d
    have hMono := frequencySchedule_frequency_mono P.exponentParameter P.order P.frequency
      P.exponentParameter_ge (by linarith : (1 : ℝ) ≤ P.frequency 0) P.frequency_step
    have hf1 : 1 ≤ P.frequency (n + 1) :=
      (by linarith : (1 : ℝ) ≤ P.frequency 0).trans (hMono (Nat.zero_le _))
    exact exists_step_identified pre w d h54' h58' h59' h510' h511' hTail hParent ha3 hF1
      hConst hC11 (nums (n + 1))
      (fun t ht => hJets tip.parent hf1 _ t ⟨ht.1, ht.2.trans (tip.next_slab_lt hLife).le⟩) hSwitch
  -- the base
  obtain ⟨bse, hbl, hbv, hbc, w₁, hbw, hba⟩ := exists_base_identified hLife h6_1 h54' h58' h59' h510' h511'
    hTail hParent (fun s hf N t ht => hJets s hf N t ht) ha3 hF2 hF3 hC11 (nums 0)
  obtain ⟨c, hcb, hsteps, hcut⟩ := exists_construction_identified hLife a ψ bse hbl hStep
  have hvel : c.base.stationary.velocity =
      fun _ => stationaryShear (couplingRatioOfGain (4 * Real.log (P.frequency 3))) := by
    rw [hcb]; exact hbv
  have hfirst : ∀ t : ℝ, c.centralWaves.cutoff 1 t = 1 := by
    intro t
    have : c.centralWaves.cutoff 1 = c.base.wave.cutoff := rfl
    rw [this, hcb, hbc]
  obtain ⟨T, hTc⟩ := conclusions_of_construction h1_3 h2_2 hB_1 c hF9 hvel hfirst hcut
  have hstr : c.centralWaves.strengthConstant = 18 * Real.exp 3 := hPstr
  rw [hstr] at hTc
  -- the first central pair is the first wave of (6.3) produced by Lemma 6.1
  have hFirst : Adapted.S7.FirstWaveIdentification c := by
    have hv1 : c.centralWaves.waveVector 1 = c.base.wave.waveVector := rfl
    have ha1 : c.centralWaves.amplitude 1 = c.base.wave.amplitude := rfl
    refine ⟨w₁, ?_, ?_⟩
    · intro t _
      rw [hv1, hcb, hbw]
    · intro t _
      rw [ha1, hcb, hba]
  exact ⟨c, T, hPb, hPth, hPfreq, Adapted.S7.available_estimates hTc, hsteps, hFirst,
    Adapted.S7.increment_bounds hTc, increment_continuity hTc hsteps⟩

end

end Main

end TorusEuler.Paper.Lib.S678a.AdaptedS7

namespace Adapted.S7

open TorusEuler TorusEuler.Paper TorusEuler.HierarchyTwistedProfile Filter Set
open scoped ContDiff InnerProductSpace Topology

/-- **Theorem 7.1.** For every sufficiently large `N` there are fields `U_j` and times
`0 = t₁ = t₂ < t₃ < ⋯` satisfying (T1)–(T4), converging to a positive finite `T∞ < S_j`, with
the localized oscillations and bounds (7.4).

The fixed cutoff symbol comes first. The construction constants
`b`, `a` and `F` are chosen before the admissible threshold function
`B`, which is chosen before `N`. The absolute constant in (7.3) is
the authors' valid choice `18 exp 3`. This statement fixes one
sufficient envelope exponent; it makes no assertion about every
sufficiently large exponent.

The central waves in the estimates are the waves of the localized steps
(`IdentifiedSteps`), and the first central pair is the first wave of (6.3)
(`FirstWaveIdentification`), for one common construction. The proof reruns
the authors' construction (`theorem71_identified` above) and keeps the
equalities that their exported existential statements omit. -/
theorem theorem_7_1 :
  ∀ ψ : Vec3 → ℝ, S5.CutoffSymbol ψ →
    ∃ (b a : ℕ) (F : ℕ → ℝ), 1 ≤ b ∧
      ∀ B : ℕ → ℝ, AdmissibleThreshold b F B →
        ∃ N₁ : ℝ, ∀ N : ℝ, N₁ ≤ N →
          ∃ (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (T : ℝ),
            P.exponentParameter = b ∧ P.threshold = B ∧ P.frequency 0 = N ∧
            SequenceEstimates c (18 * Real.exp 3) T ∧
            IdentifiedSteps c a ψ ∧ FirstWaveIdentification c ∧
            IncrementBounds c ∧ IncrementContinuity c :=
  TorusEuler.Paper.Lib.S678a.AdaptedS7.theorem71_identified

end Adapted.S7
