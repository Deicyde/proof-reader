/-!
# Degenerate witness audit probes

STATUS: NOT COMPILED.
Reviewed source: Alpöge–Buckmaster ad53419de079eb8f95f60313473374624a348546.
Expected toolchain: leanprover/lean4:v4.33.1.
Expected Mathlib: 0df444a360eaa60ab8c11dca51a86af692955474.

This file contains original proposed regression lemmas and local relaxed-premise
witnesses. It does not construct a complete certificate or prove either breakdown
endpoint. It imports actual library modules, not the challenge theorem stubs.
There was no Lean/Lake/Elan executable in the review environment. A successful
Python arithmetic check is not evidence that this Lean file elaborates.

Run the supplied run_lean_probes.py against an already built pinned package.
All theorem axiom diagnostics are printed at the end. Retain the actual log.
-/
import Breakdown.Defs
import Breakdown.Weak.ZeroGradient
import Breakdown.Cert.ExtendedStatement
import Breakdown.Cert.ExtendedAdjointPairing
import Breakdown.Cert.ExtendedCoerciveDefs
import Breakdown.CertCell.ShapeSupportRadius
import Breakdown.CertCell.StatementDefs
import Mathlib
import Breakdown.CellReduction.CellLayerBreakdownCompose

set_option autoImplicit false
noncomputable section

/- ===== Endpoint ===== -/
/-
Endpoint degeneracy regression lemmas for the review of ad53419.
STATUS: NOT COMPILED. Neither lean nor lake is installed in this workspace.
These are proposed checks, not evidence of Lean acceptance.

Run in the authors' pinned lean package:
  lake env lean /absolute/path/EndpointGuards.lean

Imports the real library definitions, not Challenge's intentional theorem stubs.
No assertion of BreakdownOnSpace or BreakdownOnTorus is made here.
-/

open scoped ContDiff
open MeasureTheory

namespace DegenerateWitnessAudit.Endpoint
open Breakdown

/-- Any spatially and temporally constant velocity solves the unforced equation. -/
theorem constant_smooth_solution (ν : ℝ) (c : Space) :
    IsSmoothSolution ν (fun _ => c) (fun _ _ => c) (fun _ _ => 0) := by
  refine ⟨contDiff_const.contDiffOn, contDiff_const.contDiffOn, ?_, ?_, ?_⟩
  · intro x
    rfl
  · intro t ht x
    simp [advectionAt, sumSecondPartialsAt, gradientAt,
      iteratedFDeriv_const_of_ne (by decide : (2 : ℕ) ≠ 0)]
  · intro t ht x
    simp [divergenceAt]

/-- Zero initial data cannot witness the space endpoint's nonexistence clause. -/
theorem zero_datum_has_bounded_solution (ν : ℝ) :
    ∃ (u : ℝ → Space → Space) (p : ℝ → Space → ℝ),
      IsSmoothSolution ν (fun _ => 0) u p ∧
      ∃ C : ℝ, ∀ t ≥ 0,
        ∫⁻ x, ENNReal.ofReal (‖u t x‖ ^ 2) ≤ ENNReal.ofReal C := by
  refine ⟨fun _ _ => 0, fun _ _ => 0, constant_smooth_solution ν 0, 0, ?_⟩
  intro t ht
  simp

/-- Every constant datum, including every nonzero constant, has a periodic solution. -/
theorem constant_datum_has_periodic_solution (ν : ℝ) (c : Space) :
    ∃ (u : ℝ → Space → Space) (p : ℝ → Space → ℝ),
      IsSmoothSolution ν (fun _ => c) u p ∧
      ∀ t ≥ 0, ∀ i x, u t (x + unitVector i) = u t x := by
  exact ⟨fun _ _ => c, fun _ _ => 0, constant_smooth_solution ν c,
    fun _ _ _ _ => rfl⟩

/-- No `ENNReal.toReal` is involved in the endpoint energy contract. -/
theorem endpoint_energy_lt_top {u : ℝ → Space → Space} {C : ℝ}
    (hC : ∀ t ≥ 0,
      ∫⁻ x, ENNReal.ofReal (‖u t x‖ ^ 2) ≤ ENNReal.ofReal C)
    (t : ℝ) (ht : 0 ≤ t) :
    (∫⁻ x, ENNReal.ofReal (‖u t x‖ ^ 2)) < ⊤ := by
  exact (hC t ht).trans_lt ENNReal.ofReal_lt_top

/-- The periodicity steps have unit length; the coordinate family is not empty. -/
theorem periodic_step_norm (i : Fin 3) : ‖unitVector i‖ = 1 := by
  simp [unitVector]

theorem periodic_step_ne_zero (i : Fin 3) : unitVector i ≠ 0 := by
  intro hz
  have h := periodic_step_norm i
  rw [hz, norm_zero] at h
  norm_num at h

/-- The positive-viscosity premise cannot be made globally vacuous. -/
theorem positive_viscosity_not_empty : ¬ (∀ ν : ℝ, 0 < ν → False) := by
  intro h
  exact h 1 (by norm_num)


end DegenerateWitnessAudit.Endpoint

/- ===== Profiles ===== -/
/-
STATUS: NOT COMPILED in this review environment.

Original audit probes for the Alpöge–Buckmaster package at
ad53419de079eb8f95f60313473374624a348546, Lean v4.33.1.
No new axioms or sorry terms are introduced. These import the real library
definitions, not the Challenge module containing theorem stubs.

The first three probes use only the definition module and Mathlib. The last
one reuses an existing source theorem about zero weak gradients; it is an
interface check, not an independent reconstruction of that theorem.
-/

open MeasureTheory
open scoped ContDiff

namespace DegenerateWitnessAudit

open Breakdown

/-- A null-supported perturbation is still the zero equivalence class. -/
theorem null_support_is_ae_zero
    (W : ℝ → Space → Space) (N : Set (ℝ × Space))
    (hN : (volume : Measure (ℝ × Space)) N = 0)
    (hW : ∀ z : ℝ × Space, z ∉ N → W z.1 z.2 = 0) :
    ∀ᵐ z : ℝ × Space, W z.1 z.2 = 0 := by
  have hNae : ∀ᵐ z : ℝ × Space, z ∉ N := by
    rw [ae_iff]
    simpa only [not_not, Set.setOf_mem_eq] using hN
  filter_upwards [hNae] with z hz
  exact hW z hz

/-- For smooth velocity, pointwise nontriviality already implies a.e. nontriviality. -/
theorem smooth_nonzero_is_ae_nonzero
    (W : ℝ → Space → Space)
    (hW : ContDiff ℝ ∞ (fun z : ℝ × Space => W z.1 z.2))
    (hne : ∃ s y, W s y ≠ 0) :
    ¬ (∀ᵐ z : ℝ × Space, W z.1 z.2 = 0) := by
  intro hae
  have heq : (fun z : ℝ × Space => W z.1 z.2) = fun _ => (0 : Space) :=
    (Continuous.ae_eq_iff_eq volume hW.continuous continuous_const).1 hae
  obtain ⟨s, y, hsy⟩ := hne
  exact hsy (congrFun heq (s, y))

/-- A zero or negative real decay constant cannot hide a nonzero strong profile. -/
theorem strong_decay_constant_positive
    (W : ℝ → Space → Space) (C : ℝ)
    (hdecay : ∀ s y, ∀ j ≤ 2,
      ‖iteratedFDeriv ℝ j (W s) y‖ ≤ C / (1 + ‖y‖) ^ (j + 1))
    (hne : ∃ s y, W s y ≠ 0) : 0 < C := by
  obtain ⟨s, y, hsy⟩ := hne
  have hb := hdecay s y 0 (by norm_num)
  rw [norm_iteratedFDeriv_zero] at hb
  simp only [Nat.zero_add, pow_one] at hb
  have hd : 0 < 1 + ‖y‖ := by positivity
  have hc : 0 < C / (1 + ‖y‖) := (norm_pos_iff.mpr hsy).trans_le hb
  have := (lt_div_iff₀ hd).mp hc
  simpa using this

/-- The supplied gradient cannot be zero for a nonzero L6 equivalence class. -/
theorem zero_weak_gradient_forces_zero_velocity
    (v : Space → Space) (G : Space → (Space →L[ℝ] Space))
    (hv : MemLp v 6 volume) (hw : IsWeakGradient v G)
    (hG : ∀ᵐ y : Space, G y = 0) :
    v =ᵐ[volume] 0 := by
  apply Breakdown.WeakProfile.zeroGradientSix_holds v hv
  intro φ hφ j
  have hid := hw.2.2 φ hφ j
  have hleft : (∫ y, φ y • G y (unitVector j)) = 0 := by
    apply integral_eq_zero_of_ae
    filter_upwards [hG] with y hy
    simp [hy]
  rw [hleft] at hid
  exact neg_eq_zero.mp hid.symm


end DegenerateWitnessAudit

/- ===== Extended certificate ===== -/
/-!
Round-three degeneracy regression probes — NOT COMPILED.

The workspace has no Lean, Lake or Elan executable. These are proposed
proofs to replay at the packet's Lean v4.33.1 / Mathlib pin. They import the
authors' library definitions and an existing zero-perturbation lemma,
not the challenge files containing placeholder theorem bodies.

No theorem below claims to construct a certificate. There are no new
axioms or `sorry` proof placeholders in these probes.
-/

open Breakdown MeasureTheory
open scoped ENNReal

namespace R3DegenerateWitness.Extended

variable {k : ℕ} {d : ExtendedCertificateData k}

theorem zero_mem_params (hd : IsExtendedCertificate d) :
    (0 : Fin k → ℝ) ∈ d.params := by
  constructor
  · intro j hj
    simpa using hd.radius_nonneg j hj
  · simpa using (sq_nonneg d.stiffRadius)

theorem fin_zero_parameter_exists : Nonempty (Fin 0 → ℝ) := ⟨0⟩

theorem fin_zero_parameters_equal (p q : Fin 0 → ℝ) : p = q :=
  Subsingleton.elim _ _

/-- A zero-dimensional matrix ring really has 0=1. This does not empty params. -/
theorem fin_zero_matrix_zero_eq_one :
    (0 : Matrix (Fin 0) (Fin 0) ℝ) = 1 := Subsingleton.elim _ _

def profileGradientEnergy (d : ExtendedCertificateData k) (q : Fin k → ℝ) : ℝ≥0∞ :=
  periodLIntegral (fun σ y => matSq (fderiv ℝ (d.profile q σ) y))

theorem profileGradientEnergy_pos (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) :
    0 < (profileGradientEnergy d q).toReal := by
  exact lt_of_le_of_lt
    (div_nonneg (mul_nonneg (by norm_num) (sq_nonneg _)) hd.weight_pos.le)
    (hd.nontrivial q hq)

theorem profileGradientEnergy_ne_zero (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) :
    profileGradientEnergy d q ≠ 0 := by
  intro hz
  have hp := profileGradientEnergy_pos hd hq
  simpa [hz] using hp

theorem profileGradientEnergy_ne_top (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) :
    profileGradientEnergy d q ≠ ⊤ := by
  intro ht
  have hp := profileGradientEnergy_pos hd hq
  simpa [ht] using hp

theorem profile_ne_zero_at_parameter (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) : d.profile q ≠ 0 := by
  intro hz
  apply profileGradientEnergy_ne_zero hd hq
  simp [profileGradientEnergy, hz, periodLIntegral, matSq]

theorem profile_at_zero_ne_zero (hd : IsExtendedCertificate d) :
    d.profile 0 ≠ 0 := profile_ne_zero_at_parameter hd (zero_mem_params hd)

/-- The missing explicit positive decay field is supplied by nontriviality. -/
theorem decay_pos (hd : IsExtendedCertificate d) : 0 < d.decay := by
  by_contra hn
  have hdecay : d.decay ≤ 0 := le_of_not_gt hn
  apply profile_at_zero_ne_zero hd
  funext σ y
  apply norm_eq_zero.mp
  apply le_antisymm _ (norm_nonneg _)
  exact (hd.profile_decay 0 (zero_mem_params hd) σ y).1.trans
    (div_nonpos_of_nonpos_of_nonneg hdecay (by positivity))

theorem periodMax_pos (hd : IsExtendedCertificate d) : 0 < d.periodMax :=
  lt_of_lt_of_le (hd.period_pos 0 (zero_mem_params hd))
    (hd.period_le 0 (zero_mem_params hd))

theorem weightMax_pos (hd : IsExtendedCertificate d) : 0 < d.weightMax :=
  lt_of_lt_of_le hd.weight_pos ((hd.weightFn_lower 0).trans (hd.weightFn_upper 0))

theorem formBound_nonneg (hd : IsExtendedCertificate d) : 0 ≤ d.formBound :=
  (add_nonneg hd.modelFormBound_nonneg hd.formShift_nonneg).trans hd.formBound_ge

theorem defectMax_nonneg (hd : IsExtendedCertificate d) : 0 ≤ d.defectMax :=
  (hd.defect_nonneg 0 (zero_mem_params hd)).1.trans
    (hd.defect_le 0 (zero_mem_params hd))

theorem transfer_denominator_pos (hd : IsExtendedCertificate d) :
    0 < 1 - d.transferLoss := sub_pos.mpr hd.transfer_lt

theorem defect_energy_finite (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) :
    periodLIntegral (fun σ y => ‖d.defect q σ y‖ ^ 2) < ⊤ :=
  lt_of_le_of_lt (hd.defect_l2 q hq) ENNReal.ofReal_lt_top

theorem rowField_ne_zero (hd : IsExtendedCertificate d) (a : Fin d.rowCount) :
    d.rowField a ≠ 0 := by
  intro hz
  have hdiag := hd.rowField_orthonormal a a
  norm_num [hz, periodPairing] at hdiag

theorem adjointOffset_nonneg (hd : IsExtendedCertificate d)
    {j : Fin k} (hj : j ∈ d.adjointSet) : 0 ≤ d.adjointOffset j :=
  (abs_nonneg _).trans (hd.adjoint_offset j hj 0 (zero_mem_params hd))

theorem stiffOffset_nonneg (hd : IsExtendedCertificate d) : 0 ≤ d.stiffOffset :=
  (Real.sqrt_nonneg _).trans (hd.stiff_offset 0 (zero_mem_params hd))

theorem zero_stiffRadius_forces_zero_offset (hd : IsExtendedCertificate d)
    (hr : d.stiffRadius = 0) : d.stiffOffset = 0 := by
  have ht : 0 ≤ 2 * d.sizeBound * d.stiffNorm / d.multiplierWeight :=
    div_nonneg (mul_nonneg (mul_nonneg (by norm_num) hd.sizeBound_nonneg)
      hd.stiffNorm_nonneg) hd.multiplierWeight_pos.le
  have hi := hd.stiff_inclusion
  rw [hr] at hi
  exact le_antisymm (by linarith) (stiffOffset_nonneg hd)

theorem zero_stiffRadius_forces_zero_product (hd : IsExtendedCertificate d)
    (hr : d.stiffRadius = 0) : d.sizeBound * d.stiffNorm = 0 := by
  have hi := hd.stiff_inclusion
  rw [hr, zero_stiffRadius_forces_zero_offset hd hr, add_zero] at hi
  have hnum : 2 * d.sizeBound * d.stiffNorm ≤ 0 := by
    simpa using (div_le_iff₀ hd.multiplierWeight_pos).mp hi
  have hp : 0 ≤ d.sizeBound * d.stiffNorm :=
    mul_nonneg hd.sizeBound_nonneg hd.stiffNorm_nonneg
  nlinarith

/-- With zero adjoint radius, even the offset bound must be exact. -/
theorem zero_adjointRadius_forces_zero_offset (hd : IsExtendedCertificate d)
    {j : Fin k} (hj : j ∈ d.adjointSet) (hr : d.radius j = 0) :
    d.adjointOffset j = 0 := by
  have hi := hd.adjoint_inclusion j hj 0 (zero_mem_params hd)
  have hq : 0 ≤ d.adjointQuad j * (2 * d.sizeBound) ^ 2 :=
    mul_nonneg (hd.adjointQuad_nonneg j hj) (sq_nonneg _)
  have hs : 0 ≤ 2 * d.sizeBound * Real.sqrt (d.adjointDefect j ^ 2 +
      (vecNorm (d.actuatorAdjointError 0 j) / d.multiplierWeight) ^ 2) :=
    mul_nonneg (mul_nonneg (by norm_num) hd.sizeBound_nonneg) (Real.sqrt_nonneg _)
  rw [hr, mul_zero] at hi
  exact le_antisymm (by linarith) (adjointOffset_nonneg hd hj)

/-- No nonzero auxiliary force vector can vanish modulo gradients.
This uses only the coercive clause, a parameter, and positive multiplier weight. -/
theorem multiplier_zero_of_zero_rhs_of_coercive
    (hCoer : CoerciveWeak.ExtendedCoerciveClause d)
    (hweight : 0 < d.multiplierWeight)
    {q : Fin k → ℝ} (hq : q ∈ d.params) (κ : Fin k → ℝ)
    (hR : IsRightSide (d.model q) d.actuator κ 0 0 0 0) : κ = 0 := by
  have hc := hCoer q hq 0 0 0 0
    (Breakdown.Cert.Internal.ExtendedAdjointPairing.zero_isPerturbation _ _)
    κ 0 (by exact aestronglyMeasurable_const)
    (by intro σ y; rfl) (by simp [periodLIntegral]) hR
  have hroot : Real.sqrt (d.multiplierWeight ^ 2 * ∑ i, κ i ^ 2) ≤ 0 := by
    simpa [weightedEnergy, periodLIntegral, secondDerivTrace, matSq, periodNorm,
      ExtendedCertificateData.rows, rowNorm, periodPairing, pinValue, matInner,
      vecNorm] using hc
  have hn : 0 ≤ d.multiplierWeight ^ 2 * ∑ i, κ i ^ 2 :=
    mul_nonneg (sq_nonneg _) (Finset.sum_nonneg fun i _ => sq_nonneg (κ i))
  have hzroot : Real.sqrt (d.multiplierWeight ^ 2 * ∑ i, κ i ^ 2) = 0 :=
    le_antisymm hroot (Real.sqrt_nonneg _)
  have hzprod : d.multiplierWeight ^ 2 * ∑ i, κ i ^ 2 = 0 := by
    have hs := Real.sq_sqrt hn
    rw [hzroot] at hs
    simpa using hs.symm
  have hsum : ∑ i, κ i ^ 2 = 0 :=
    (mul_eq_zero.mp hzprod).resolve_left (pow_ne_zero 2 hweight.ne')
  funext i
  have hle : κ i ^ 2 ≤ ∑ j, κ j ^ 2 :=
    Finset.single_le_sum (fun j _ => sq_nonneg (κ j)) (Finset.mem_univ i)
  rw [hsum] at hle
  exact (pow_eq_zero_iff two_ne_zero).mp (le_antisymm hle (sq_nonneg _))

theorem multiplier_zero_of_zero_rhs (hd : IsExtendedCertificate d)
    {q : Fin k → ℝ} (hq : q ∈ d.params) (κ : Fin k → ℝ)
    (hR : IsRightSide (d.model q) d.actuator κ 0 0 0 0) : κ = 0 :=
  multiplier_zero_of_zero_rhs_of_coercive hd.coercive hd.multiplierWeight_pos hq κ hR

theorem no_pointwise_actuator_relation_of_coercive
    (hCoer : CoerciveWeak.ExtendedCoerciveClause d)
    (hweight : 0 < d.multiplierWeight)
    {q : Fin k → ℝ} (hq : q ∈ d.params) (κ : Fin k → ℝ)
    (hforce : ∀ σ y, ∑ i, κ i • d.actuator i σ y = 0) : κ = 0 := by
  apply multiplier_zero_of_zero_rhs_of_coercive hCoer hweight hq κ
  intro φ hφ
  simp [hforce, matInner]

theorem zero_actuators_force_zero_dimension
    (hCoer : CoerciveWeak.ExtendedCoerciveClause d)
    (hweight : 0 < d.multiplierWeight)
    {q : Fin k → ℝ} (hq : q ∈ d.params)
    (hact : ∀ i σ y, d.actuator i σ y = 0) : k = 0 := by
  by_contra hn
  have hk : 0 < k := Nat.pos_of_ne_zero hn
  have hz := no_pointwise_actuator_relation_of_coercive hCoer hweight hq (fun _ => 1)
    (by intro σ y; simp [hact])
  have hi := congrFun hz (⟨0, hk⟩ : Fin k)
  norm_num at hi

theorem no_pointwise_actuator_relation (hd : IsExtendedCertificate d)
    (κ : Fin k → ℝ)
    (hforce : ∀ σ y, ∑ i, κ i • d.actuator i σ y = 0) : κ = 0 := by
  apply multiplier_zero_of_zero_rhs hd (zero_mem_params hd) κ
  intro φ hφ
  simp [hforce, matInner]

theorem no_all_zero_actuators (hk : 0 < k)
    (hact : ∀ i σ y, d.actuator i σ y = 0) : ¬IsExtendedCertificate d := by
  intro hd
  have hz := no_pointwise_actuator_relation hd (fun _ => 1)
    (by intro σ y; simp [hact])
  have hi := congrFun hz (⟨0, hk⟩ : Fin k)
  norm_num at hi

end R3DegenerateWitness.Extended

/- ===== Cell support ===== -/
/-
STATUS: NOT COMPILED. Neither lean nor lake is installed in this workspace.
Additional regression candidates for the empty-mesh attack.
These statements do not assert a complete certificate or any breakdown endpoint.
-/

namespace DegenerateWitnessAudit.CellMesh
open Breakdown Breakdown.CertCell

variable {k : ℕ} {C : Type} {nE nM : ℕ}

/-- Empty mesh and the stated coverage clause force a negative coverage bound. -/
theorem empty_mesh_bound_negative
    (D : CellLayerData k C nE nM) (F : GivenShape.GivenShapeEntry k) (H : ℝ)
    (h : GivenShape.ActuatorSupportFacts D F H) (hcount : D.mesh.count = 0) : H < 0 := by
  by_contra hnot
  have h0H : 0 ≤ H := le_of_not_gt hnot
  obtain ⟨K, _⟩ := h.mesh_covers (0, 0) ⟨⟨le_rfl, h0H⟩, ⟨le_rfl, h0H⟩⟩
  have hlt := K.isLt
  rw [hcount] at hlt
  omega

/-- A signed support bound below zero forces every actuator value to be zero. -/
theorem negative_bound_actuators_zero
    (D : CellLayerData k C nE nM) (F : GivenShape.GivenShapeEntry k) (H : ℝ)
    (h : GivenShape.ActuatorSupportFacts D F H) (hneg : H < 0) :
    ∀ i σ y, D.cert.actuator i σ y = 0 := by
  intro i σ y
  rw [h.actuator_eq i]
  exact GivenShape.compactFieldSupportRadius_holds _ _ _
    (h.actuatorParams_valid i) (h.actuators_valid i) (h.edge_break i) σ y
    ((h.radius_le i).trans_lt (hneg.trans_le (norm_nonneg y)))

/-- The existing support-in-cells theorem gives an even shorter empty-mesh argument. -/
theorem empty_mesh_actuators_zero
    (D : CellLayerData k C nE nM) (F : GivenShape.GivenShapeEntry k) (H : ℝ)
    (h : GivenShape.ActuatorSupportFacts D F H) (hcount : D.mesh.count = 0) :
    ∀ i σ y, D.cert.actuator i σ y = 0 := by
  have hs := GivenShape.actuatorSupportInCells_of_shape
    GivenShape.compactFieldSupportRadius_holds D F H h
  intro i σ y
  by_contra hne
  obtain ⟨K, _⟩ := hs i σ y hne
  have hlt := K.isLt
  rw [hcount] at hlt
  omega

/-- The coefficient-class type is inhabited before any certificate conditions. -/
def classWitness (D : CellLayerData k C nE nM) : C :=
  (D.pieces 0).classOf (0, 0)

/-- A TreeEntry already contains a node. -/
def nodeWitness {D : CellLayerData k C nE nM}
    {R : CellCalculus.CellCalculusEntry D} (T : TreeEntry D R) : T.Node := T.root

/-- The natural-number port selector inhabits Free even when k=0. -/
def freeWitness {D : CellLayerData k C nE nM}
    {R : CellCalculus.CellCalculusEntry D} {T : TreeEntry D R}
    (W : Assembly.RowEntry D R T) : T.Free := W.portRe 0

/-- Positive multiplier count inhabits Slaved through kappa. -/
def slavedWitness {D : CellLayerData k C nE nM}
    {R : CellCalculus.CellCalculusEntry D} {T : TreeEntry D R}
    (W : Assembly.RowEntry D R T) (hk : 0 < k) : T.Slaved := W.kappa ⟨0, hk⟩


end DegenerateWitnessAudit.CellMesh

/- ===== Scaled jet ===== -/
/-
STATUS: NOT COMPILED. Original local degeneracy probes for ad53419.
These prove a proposed local coefficient-conversion collision, not a certificate.
Only the authors' actual library definitions are imported.
-/

namespace DegenerateWitnessAudit.ScaledJet
open Breakdown.CertCell.GivenShape

def zeroScaleAxis : ScaledJetAxis where
  breaks := [0, 1]
  depth := 2
  bubbleCount := 0
  scale := [0, 0]
  bubbleConst := []

theorem zeroScaleAxis_symmetric : HasSymmetricScale zeroScaleAxis := by
  norm_num [HasSymmetricScale, zeroScaleAxis]

theorem zeroScaleAxis_valid_base : IsJetAxis zeroScaleAxis.base 0 1 := by
  constructor <;> norm_num [ScaledJetAxis.base, zeroScaleAxis]

theorem killed_node_is_active :
    JetDof.node 0 1 ∈ zeroScaleAxis.base.dofs := by
  norm_num [JetAxis.dofs, ScaledJetAxis.base, zeroScaleAxis,
    Breakdown.CellCert.GivenFields.cellCount]

theorem node_conversion_zero :
    zeroScaleAxis.convert (.node 0 1) (.node 0 1) = 0 := by
  norm_num [ScaledJetAxis.convert, zeroScaleAxis]

theorem positive_order_column_zero (d : JetDof) :
    zeroScaleAxis.convert d (.node 0 1) = 0 := by
  cases d with
  | node k p =>
      by_cases h : k = 0 ∧ p = 1
      · rcases h with ⟨rfl, rfl⟩
        norm_num [ScaledJetAxis.convert, zeroScaleAxis]
      · simp [ScaledJetAxis.convert, h]
  | bubble i s => simp [ScaledJetAxis.convert]

def missingBubbleAxis : ScaledJetAxis where
  breaks := [0, 1]
  depth := 1
  bubbleCount := 1
  scale := [1, 1]
  bubbleConst := []

theorem missingBubbleAxis_valid_base : IsJetAxis missingBubbleAxis.base 0 1 := by
  constructor <;> norm_num [ScaledJetAxis.base, missingBubbleAxis]

theorem missing_bubble_is_active :
    JetDof.bubble 0 0 ∈ missingBubbleAxis.base.dofs := by
  norm_num [JetAxis.dofs, ScaledJetAxis.base, missingBubbleAxis,
    Breakdown.CellCert.GivenFields.cellCount]

theorem missing_bubble_column_zero (d : JetDof) :
    missingBubbleAxis.convert d (.bubble 0 0) = 0 := by
  cases d <;> simp [ScaledJetAxis.convert, missingBubbleAxis]

-- The killed column is an active, positive-order degree of freedom.
-- A nonzero coefficient on it and zero coefficients everywhere else decode
-- to the same unscaled coefficient vector as the all-zero source vector.
-- This assertion concerns the explicit local conversion, not full entry validity.


end DegenerateWitnessAudit.ScaledJet

/- ===== Totalization ===== -/
/-
STATUS: NOT COMPILED. Local relaxed-premise witness, not a certificate.
This isolates the Dn < top guard in le_of_ennreal_bounds.
-/

open scoped ENNReal

namespace DegenerateWitnessAudit.Totalization

theorem infinite_parts_pass_only_relaxed_comparisons :
    ∃ (X Y : ℝ) (Dp Dn : ℝ≥0∞),
      Dp + ENNReal.ofReal (-X) ≤ ENNReal.ofReal X + Dn ∧
      ENNReal.ofReal Y + Dn ≤ Dp + ENNReal.ofReal (-Y) ∧
      ¬ Y ≤ X := by
  refine ⟨0, 1, ⊤, ⊤, ?_, ?_, ?_⟩ <;> norm_num


end DegenerateWitnessAudit.Totalization

/- ===== Cell composite ===== -/
/-
STATUS: NOT COMPILED. This is a section of the combined audit probe file.
It follows the Endpoint, Profile, Extended and CellMesh sections there.
-/

namespace DegenerateWitnessAudit.CellComposite
open Breakdown Breakdown.CertCell Breakdown.CellLayerSystem

variable {k : ℕ} {C : Type} {nE nM : ℕ}

/-- The known local support vacuity really does hold at zero parameter dimension. -/
theorem negative_support_at_zero_dimension
    (D : CellLayerData 0 C nE nM) (F : GivenShape.GivenShapeEntry 0) :
    GivenShape.ActuatorSupportFacts D F (-1) := by
  refine {
    actuator_eq := fun i => Fin.elim0 i
    actuatorParams_valid := fun i => Fin.elim0 i
    actuators_valid := fun i => Fin.elim0 i
    edge_break := fun i => Fin.elim0 i
    radius_le := fun i => Fin.elim0 i
    mesh_covers := ?_ }
  intro p hp
  have hbad : (0 : ℝ) ≤ -1 := hp.1.1.trans hp.1.2
  norm_num at hbad

/-- The complete cell condition cannot combine empty cells with positive k. -/
theorem empty_mesh_forces_zero_dimension
    {D : CellLayerData k C nE nM} {X : Instance.InstanceData k C nE nM}
    {R : CellCalculus.CellCalculusEntry D} {T : TreeEntry D R}
    {Y : CellLayerEntries D R T} {N : CoerciveNumbers} {B : ReductionEntries k}
    (h : CellSystemCondition D X R T Y N B) (hcount : D.mesh.count = 0) : k = 0 := by
  obtain ⟨F, S, H, hscaled, hs⟩ := h.cell.given_shape
  have hact := DegenerateWitnessAudit.CellMesh.empty_mesh_actuators_zero D F H hs hcount
  exact R3DegenerateWitness.Extended.zero_actuators_force_zero_dimension
    (CellLayerSystem.coerciveClause_of_parts h) h.certificate.multiplierWeight_pos
    (CoerciveWeak.zero_mem_params D.cert h.certificate.radius_nonneg) hact

/-- The range condition is never made empty by choosing zero row data. -/
theorem zero_in_row_range
    {D : CellLayerData k C nE nM} {R : CellCalculus.CellCalculusEntry D}
    {T : TreeEntry D R} (W : Assembly.RowEntry D R T) (K : Fin D.mesh.count) :
    Assembly.InRowRange W K 0 := by
  refine ⟨(fun _ => 0), (fun _ => 0), (fun _ => 0), ?_, ?_, ?_⟩
  · intro d hd
    simp [Assembly.RowEntry.rowValue]
  · intro i
    simp
  · intro i
    simp


end DegenerateWitnessAudit.CellComposite

/- Axiom diagnostics: no new theorem is accepted without checking this output. -/
#print axioms DegenerateWitnessAudit.Endpoint.constant_smooth_solution
#print axioms DegenerateWitnessAudit.Endpoint.zero_datum_has_bounded_solution
#print axioms DegenerateWitnessAudit.Endpoint.constant_datum_has_periodic_solution
#print axioms DegenerateWitnessAudit.Endpoint.endpoint_energy_lt_top
#print axioms DegenerateWitnessAudit.Endpoint.periodic_step_norm
#print axioms DegenerateWitnessAudit.Endpoint.periodic_step_ne_zero
#print axioms DegenerateWitnessAudit.Endpoint.positive_viscosity_not_empty
#print axioms DegenerateWitnessAudit.null_support_is_ae_zero
#print axioms DegenerateWitnessAudit.smooth_nonzero_is_ae_nonzero
#print axioms DegenerateWitnessAudit.strong_decay_constant_positive
#print axioms DegenerateWitnessAudit.zero_weak_gradient_forces_zero_velocity
#print axioms R3DegenerateWitness.Extended.zero_mem_params
#print axioms R3DegenerateWitness.Extended.fin_zero_parameter_exists
#print axioms R3DegenerateWitness.Extended.fin_zero_parameters_equal
#print axioms R3DegenerateWitness.Extended.fin_zero_matrix_zero_eq_one
#print axioms R3DegenerateWitness.Extended.profileGradientEnergy_pos
#print axioms R3DegenerateWitness.Extended.profileGradientEnergy_ne_zero
#print axioms R3DegenerateWitness.Extended.profileGradientEnergy_ne_top
#print axioms R3DegenerateWitness.Extended.profile_ne_zero_at_parameter
#print axioms R3DegenerateWitness.Extended.profile_at_zero_ne_zero
#print axioms R3DegenerateWitness.Extended.decay_pos
#print axioms R3DegenerateWitness.Extended.periodMax_pos
#print axioms R3DegenerateWitness.Extended.weightMax_pos
#print axioms R3DegenerateWitness.Extended.formBound_nonneg
#print axioms R3DegenerateWitness.Extended.defectMax_nonneg
#print axioms R3DegenerateWitness.Extended.transfer_denominator_pos
#print axioms R3DegenerateWitness.Extended.defect_energy_finite
#print axioms R3DegenerateWitness.Extended.rowField_ne_zero
#print axioms R3DegenerateWitness.Extended.adjointOffset_nonneg
#print axioms R3DegenerateWitness.Extended.stiffOffset_nonneg
#print axioms R3DegenerateWitness.Extended.zero_stiffRadius_forces_zero_offset
#print axioms R3DegenerateWitness.Extended.zero_stiffRadius_forces_zero_product
#print axioms R3DegenerateWitness.Extended.zero_adjointRadius_forces_zero_offset
#print axioms R3DegenerateWitness.Extended.multiplier_zero_of_zero_rhs_of_coercive
#print axioms R3DegenerateWitness.Extended.multiplier_zero_of_zero_rhs
#print axioms R3DegenerateWitness.Extended.no_pointwise_actuator_relation_of_coercive
#print axioms R3DegenerateWitness.Extended.zero_actuators_force_zero_dimension
#print axioms R3DegenerateWitness.Extended.no_pointwise_actuator_relation
#print axioms R3DegenerateWitness.Extended.no_all_zero_actuators
#print axioms DegenerateWitnessAudit.CellMesh.empty_mesh_bound_negative
#print axioms DegenerateWitnessAudit.CellMesh.negative_bound_actuators_zero
#print axioms DegenerateWitnessAudit.CellMesh.empty_mesh_actuators_zero
#print axioms DegenerateWitnessAudit.ScaledJet.zeroScaleAxis_symmetric
#print axioms DegenerateWitnessAudit.ScaledJet.zeroScaleAxis_valid_base
#print axioms DegenerateWitnessAudit.ScaledJet.killed_node_is_active
#print axioms DegenerateWitnessAudit.ScaledJet.node_conversion_zero
#print axioms DegenerateWitnessAudit.ScaledJet.positive_order_column_zero
#print axioms DegenerateWitnessAudit.ScaledJet.missingBubbleAxis_valid_base
#print axioms DegenerateWitnessAudit.ScaledJet.missing_bubble_is_active
#print axioms DegenerateWitnessAudit.ScaledJet.missing_bubble_column_zero
#print axioms DegenerateWitnessAudit.Totalization.infinite_parts_pass_only_relaxed_comparisons
#print axioms DegenerateWitnessAudit.CellComposite.negative_support_at_zero_dimension
#print axioms DegenerateWitnessAudit.CellComposite.empty_mesh_forces_zero_dimension
#print axioms DegenerateWitnessAudit.CellComposite.zero_in_row_range

end
