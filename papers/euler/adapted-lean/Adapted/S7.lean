import TorusEuler.Paper.Spine
import TorusEuler.TerminalScheduledNormContinuity

/-! # Section 7. A common sequence of approximate solutions

The numbered target at the end of this file is open. It requires the
central waves in the estimates to be the waves used in the localized
expansions, including the specified first wave. The exported theorem
does not record all these identifications.

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

open TorusEuler TorusEuler.Paper TorusEuler.HierarchyTwistedProfile Filter Set
open scoped ContDiff InnerProductSpace Topology

namespace Adapted.S7

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

/-- **Theorem 7.1 — open target.** For every sufficiently large `N`
there are fields `U_j` and times `0 = t₁ = t₂ < t₃ < ⋯` satisfying
(T1)–(T4), converging to a positive finite `T∞ < S_j`, with the
localized oscillations and bounds (7.4).

The fixed cutoff symbol comes first. The construction constants
`b`, `a` and `F` are chosen before the admissible threshold function
`B`, which is chosen before `N`. The absolute constant in (7.3) is
the authors' valid choice `18 exp 3`. This statement fixes one
sufficient envelope exponent; it makes no assertion about every
sufficiently large exponent.

Missing reduction: `Paper.theorem_7_1` exports the estimates and the
Section 5 step data, but omits the covector identification in
`IdentifiedSteps` and the first-wave identification above. The
temporal continuity in (7.4) follows from the exported step smoothness
and the existing slab norm-continuity results; it is recorded explicitly
in this target. The local construction proofs contain more data than
their exported existential statements retain. A reduction recovering
both central-wave identifications for one common construction is not
supplied here. This definition asserts
no proof and introduces no assumption into any proved statement. -/
def theorem_7_1 : Prop :=
  ∀ ψ : Vec3 → ℝ, S5.CutoffSymbol ψ →
    ∃ (b a : ℕ) (F : ℕ → ℝ), 1 ≤ b ∧
      ∀ B : ℕ → ℝ, AdmissibleThreshold b F B →
        ∃ N₁ : ℝ, ∀ N : ℝ, N₁ ≤ N →
          ∃ (P : InductiveEulerParameters) (c : InductiveEulerConstruction P) (T : ℝ),
            P.exponentParameter = b ∧ P.threshold = B ∧ P.frequency 0 = N ∧
            SequenceEstimates c (18 * Real.exp 3) T ∧
            IdentifiedSteps c a ψ ∧ FirstWaveIdentification c ∧
            IncrementBounds c ∧ IncrementContinuity c

end

end Adapted.S7
