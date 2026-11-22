import TorusEuler.Paper.Spine

/-! # Section 2. The wave and its amplification

The physical interval is exactly `[t₀, t₀ + T/r]`. Consequently the four
suprema defining `δ` are over the interval in the paper. The older matrix
`B` is smooth, while the error `E_c` need only be continuous.

The notation `C * T ^ p` separates the two absolute constants denoted by
`C` in `CT^C`; their choices precede `C₀` and every physical configuration.
The norm of a three-vector is Euclidean. Physical matrix norms are the
corresponding operator norms; the two-component equation uses the maximum
norm. These fix the otherwise unspecified finite-dimensional norm conventions.
-/

open Set
open scoped ContDiff InnerProductSpace
open TorusEuler TorusEuler.Paper TorusEuler.MovingWaveVector

namespace Adapted.S2

noncomputable section

/-- The prescribed interval of Subsection 2.2.1: physical time runs from
`t₀` to `t₀ + T/r`, and the older matrix `B` is smooth on that interval. -/
def PaperWindow {I : Set ℝ} {t₀ : ℝ}
    (w : PhysicalAmplification I t₀) (T : ℝ) : Prop :=
  I = w.activeSlab T ∧ ContDiffOn ℝ ∞ w.B I

/-- The change of time `t = t₀ + τ/r` sends `[0,T]` into the prescribed
physical interval. -/
theorem paperWindow_mapsTo {I : Set ℝ} {t₀ T : ℝ}
    {w : PhysicalAmplification I t₀} (h : PaperWindow w T) :
    MapsTo w.clock (Icc 0 T) I := by
  intro τ hτ
  exact (Set.ext_iff.mp h.1 (w.clock τ)).mpr
    (TorusEuler.Paper.Lib.S2b.clock_mem_slab w hτ)

/-- Lemma 2.1. Let the nonzero wave vector and the amplitude satisfy (2.1)
over a smooth trace-free `D` with `D' + D²` symmetric. Then
`Dx + a F(k·x)` is divergence free and solves Euler on `ℝ³` with the
stated pressure. Nonzero perpendicular initial vectors remain nonzero
and perpendicular for every later time in the interval of existence.
The standing profile is smooth, odd, one-periodic, has `F'(0)=1`, and
its primitive has zero phase average. -/
theorem lemma_2_1 :
  ∀ {J : Set ℝ}, J.OrdConnected → UniqueDiffOn ℝ J →
  ∀ {F P : ℝ → ℝ}, ContDiff ℝ ∞ F → Function.Odd F →
    Function.Periodic F 1 → deriv F 0 = 1 → phaseMean P = 0 →
    (∀ z, HasDerivAt P (F z) z) →
  ∀ {D D' : ℝ → Vec3 →L[ℝ] Vec3} {k a : ℝ → Vec3},
    ContDiffOn ℝ ∞ D J →
    (∀ t ∈ J, HasDerivWithinAt D (D' t) J t) →
    (∀ t ∈ J, IsSelfAdjoint (D' t + (D t).comp (D t))) →
    (∀ t ∈ J, LinearMap.trace ℝ Vec3 (D t).toLinearMap = 0) →
    WaveOn J D k a →
    ((∀ t ∈ J, k t ≠ 0) → (∀ t ∈ J, ⟪k t, a t⟫_ℝ = 0) → ∀ t ∈ J, ∀ x : Vec3,
      let u := affineWaveVelocity F D k a
      let p := affineWavePressure P (D' t + (D t).comp (D t))
        (affineWavePressureCoeff (D t) (k t) (a t)) (k t)
      DifferentiableWithinAt ℝ (fun r => u r x) J t ∧ DifferentiableAt ℝ (u t) x ∧
        DifferentiableAt ℝ p x ∧
        derivWithin (fun r => u r x) J t + fderiv ℝ (u t) x (u t x) + gradient p x = 0 ∧
        divergence (u t) x = 0) ∧
    (∀ ⦃t₀ : ℝ⦄, t₀ ∈ J → k t₀ ≠ 0 → a t₀ ≠ 0 → ⟪k t₀, a t₀⟫_ℝ = 0 →
      ∀ t ∈ J, t₀ ≤ t → k t ≠ 0 ∧ a t ≠ 0 ∧ ⟪k t, a t⟫_ℝ = 0) := by
  intro J hJ hUnique F P hF _hOdd _hPeriod _hSlope _hMean hP D D' k a _hDsm hD hSym hTr hWave
  have h := TorusEuler.Paper.lemma_2_1 hJ hUnique
    (hF.differentiable (by simp)) hP hD hSym hTr hWave
  constructor
  · intro _hNonzero hPerp
    exact h.1 hPerp
  · intro t₀ ht₀ hk ha hPerp t ht _hLater
    exact h.2 ht₀ hk ha hPerp t ht

/-- Lemma 2.2. For the nonzero perpendicular wave vectors over a smooth
trace-free background, the orthonormal frame `E₁ = k/|k|`,
`E₂ = a/|a|`, `E₃ = E₁ × E₂` satisfies the three frame equations and
`(log σ)' = B₃₃` in (2.2). Frame indices in Lean are `0,1,2`. -/
theorem lemma_2_2 :
  ∀ {J : Set ℝ} {B : ℝ → Vec3 →L[ℝ] Vec3} {k a : ℝ → Vec3},
    J.OrdConnected → UniqueDiffOn ℝ J → ContDiffOn ℝ ∞ B J →
    (∀ t ∈ J, LinearMap.trace ℝ Vec3 (B t).toLinearMap = 0) →
    WaveOn J B k a →
    (∀ t ∈ J, k t ≠ 0 ∧ a t ≠ 0 ∧ ⟪k t, a t⟫_ℝ = 0) →
    ∀ t ∈ J,
      let E := frame k a
      let ν := entry (E t) (B t) 0 1
      let η := entry (E t) (B t) 2 1
      Orthonormal ℝ (E t) ∧
        HasDerivWithinAt (fun u => E u 0) (-ν • E t 1 - entry (E t) (B t) 0 2 • E t 2) J t ∧
        HasDerivWithinAt (fun u => E u 1) (ν • E t 0 - η • E t 2) J t ∧
        HasDerivWithinAt (fun u => E u 2) (entry (E t) (B t) 0 2 • E t 0 + η • E t 1) J t ∧
        HasDerivWithinAt (fun u => Real.log (‖k u‖ * ‖a u‖)) (entry (E t) (B t) 2 2) J t := by
  intro J B k a _hInterval _hUnique _hSmooth hTrace hWave hData
  exact TorusEuler.Paper.lemma_2_2 hTrace hWave hData

/-- Lemma 2.3. In the model case the preceding strength is constant;
the scaled wave vector and amplitude obey the displayed equations.
With `ε,T` fixed, their coefficient matrices and the scaled wave vector
converge uniformly on `[0,T]` as `S → ∞`. The equations for the first two
amplitude components are asserted where `ζ₃ ≠ 0`. -/
theorem lemma_2_3 :
  (∀ {I : Set ℝ} {t₀ T lam : ℝ} (w : PhysicalAmplification I t₀) {k : ℝ → Vec3},
    2 ≤ T → PaperWindow w T → ModelCase w T → NewWaveVector w lam k →
    let S := w.shear
    let ε := w.ratio
    let ζ := zeta w lam k
    (∀ τ ∈ Icc 0 T, ‖w.kp (w.clock τ)‖ * ‖w.ap (w.clock τ)‖ = w.initialStrength) ∧
    (∀ τ ∈ Icc 0 T,
      HasDerivWithinAt (fun s => ζ s 0) (-(1 + 1 / (2 * S ^ 2)) * ζ τ 1) (Icc 0 T) τ ∧
      HasDerivWithinAt (fun s => ζ s 1) (-(ε * ζ τ 2)) (Icc 0 T) τ ∧
      HasDerivWithinAt (fun s => ζ s 2) (ε / (2 * S ^ 2) * ζ τ 1) (Icc 0 T) τ) ∧
    (∀ a : ℝ → Vec3, AmplitudeVector w k a → ∀ τ ∈ Icc 0 T, ζ τ 2 ≠ 0 →
      let α := alpha w a
      let Pm := strongShearPressure S ε (ζ τ) (α τ 0) (α τ 1)
      HasDerivWithinAt (fun s => α s 0) (-α τ 1 + ζ τ 0 * Pm) (Icc 0 T) τ ∧
      HasDerivWithinAt (fun s => α s 1)
        (-(1 - 1 / (2 * S ^ 2)) * α τ 0 +
          ε / (2 * S ^ 2) * ((ζ τ 0 * α τ 0 + ζ τ 1 * α τ 1) / ζ τ 2) +
          ζ τ 1 / S ^ 2 * Pm) (Icc 0 T) τ)) ∧
  (∀ ε T : ℝ, 2 ≤ T → ∀ tol : ℝ, 0 < tol → ∃ S₀ : ℝ,
    ∀ {I : Set ℝ} {t₀ lam : ℝ} (w : PhysicalAmplification I t₀) {k : ℝ → Vec3},
      PaperWindow w T → ModelCase w T → NewWaveVector w lam k →
      w.ratio = ε → S₀ ≤ w.shear →
      ∀ τ ∈ Icc 0 T,
        ‖zeta w lam k τ - zetaRef ε τ‖ ≤ tol ∧
        ∀ i j, |strongShearMatrix w.shear ε (zeta w lam k τ) i j -
          referenceSystemMatrix ε τ i j| ≤ tol) := by
  constructor
  · intro I t₀ T lam w k hT hWindow hModel hWave
    exact TorusEuler.Paper.lemma_2_3.1 w hT (paperWindow_mapsTo hWindow) hModel hWave
  · intro ε T hT tol htol
    obtain ⟨S₀, hS₀⟩ := TorusEuler.Paper.lemma_2_3.2 ε T hT tol htol
    refine ⟨S₀, ?_⟩
    intro I t₀ lam w k hWindow hModel hWave hRatio hShear τ hτ
    have h := hS₀ w (paperWindow_mapsTo hWindow) hModel hWave hRatio hShear τ hτ
    exact ⟨h.1, h.2.2⟩

/-- Lemma 2.4. Under (2.7), the two errors in (2.10) are bounded
by an absolute polynomial times `δ`, at most `1/2`; (2.11) follows.
Every amplitude obeys the same two-component linear system, with one
matrix error bounded by that polynomial. The extra continuity assertion
and preceding-strength bound in the authors' declaration are projected out. -/
theorem lemma_2_4 :
  ∃ (C : ℝ) (p N : ℕ), ∀ {C₀ : ℕ}, N ≤ C₀ →
  ∀ {I : Set ℝ} {t₀ T lam : ℝ} (w : PhysicalAmplification I t₀) {k : ℝ → Vec3},
    2 ≤ T → PaperWindow w T → FiniteSmallness w T C₀ → NewWaveVector w lam k →
    let ε := w.ratio
    let δ := w.errorSize
    let ζ := zeta w lam k
    C * T ^ p * δ ≤ 1 / 2 ∧
    (∀ τ ∈ Icc 0 T, ‖ζ τ - zetaRef ε τ‖ ≤ C * T ^ p * δ) ∧
    (∀ τ ∈ Icc 0 T,
      |‖k (w.clock τ)‖ ^ 2 * Real.cos (referenceAngle ε τ) ^ 2 / lam ^ 2 - 1| ≤
        C * T ^ p * δ) ∧
    (∀ τ ∈ Icc 0 T, 1 / 2 ≤ ζ τ 2 ∧ ζ τ 2 ≤ 3 / 2 ∧ ‖ζ τ‖ ≤ 3 * T ^ 2) ∧
    (∃ ℰ : ℝ → (ℝ × ℝ) →L[ℝ] (ℝ × ℝ),
      (∀ τ ∈ Icc 0 T, ‖ℰ τ‖ ≤ C * T ^ p * δ) ∧
      (∀ a : ℝ → Vec3, AmplitudeVector w k a → ∀ τ ∈ Icc 0 T,
        HasDerivWithinAt (fun s => (alpha w a s 0, alpha w a s 1))
          (MovingAmplitude.pairOperator (referenceSystemMatrix ε τ)
              (alpha w a τ 0, alpha w a τ 1) + ℰ τ (alpha w a τ 0, alpha w a τ 1))
          (Icc 0 T) τ)) := by
  obtain ⟨C, p, N, h⟩ := TorusEuler.Paper.lemma_2_4
  refine ⟨C, p, N, ?_⟩
  intro C₀ hN I t₀ T lam w k hT hWindow hSmall hWave
  obtain ⟨hHalf, hZeta, hLength, hBounds, hError, _hStrength⟩ :=
    h hN w hT (paperWindow_mapsTo hWindow) hSmall hWave
  obtain ⟨E, hE, hEquation, _hContinuous⟩ := hError
  exact ⟨hHalf, hZeta, hLength, hBounds, E, hE, hEquation⟩

/-- Lemma 2.5. For `0 < ε ≤ 1`, the reference Riccati solution exists
on the whole half-line, satisfies `|Y| ≤ 1` and (2.13)–(2.14), and has
exactly one zero `τm`, with `2 ≤ ετm ≤ 3`. The reference amplitude is
largest there and `log a_ref(τm) ≥ ε^(-1/2) - 1`. One common function
`e`, with `0 ≤ e ≤ ε/8`, occurs in both formulae. -/
theorem lemma_2_5 :
  ∀ {ε : ℝ}, 0 < ε → ε ≤ 1 →
    (∃ Y : ℝ → ℝ, ReferenceSlope ε Y) ∧
    ∀ Y : ℝ → ℝ, ReferenceSlope ε Y →
      (∀ Z : ℝ → ℝ, ReferenceSlope ε Z → EqOn Y Z (Ici 0)) ∧
      (∀ τ ∈ Ici (0 : ℝ), |Y τ| ≤ 1) ∧
      ∃ e : ℝ → ℝ, (∀ τ ∈ Ici (0 : ℝ), 0 ≤ e τ ∧ e τ ≤ ε / 8) ∧
        (∀ τ ∈ Ici (0 : ℝ), Y τ = (1 + e τ) * Real.cos (referenceAngle ε τ) -
          ε * τ * Real.sin (2 * referenceAngle ε τ) / 4) ∧
        (∀ τ ∈ Ici (0 : ℝ), referenceAmplitude Y τ =
          Real.sqrt (Real.cos (referenceAngle ε τ)) *
            Real.exp (∫ s in (0 : ℝ)..τ, (1 + e s) * Real.cos (referenceAngle ε s))) ∧
        ∃ τm : ℝ, (∀ τ ∈ Ici (0 : ℝ), Y τ = 0 ↔ τ = τm) ∧ 2 ≤ ε * τm ∧ ε * τm ≤ 3 ∧
          (∀ τ ∈ Ico 0 τm, 0 < Y τ) ∧ (∀ τ ∈ Ioi τm, Y τ < 0) ∧
          (∀ τ ∈ Ici (0 : ℝ), referenceAmplitude Y τ ≤ referenceAmplitude Y τm) ∧
          (Real.sqrt ε)⁻¹ - 1 ≤ Real.log (referenceAmplitude Y τm) := by
  exact TorusEuler.Paper.lemma_2_5

/-- Lemma 2.6. Under (2.7), the growing amplitude has `α₂ > 0`,
satisfies (2.17)–(2.18), and its transverse propagator has norm at most
an absolute constant times `S |a(τ₂)|/|a(τ₁)|`. The propagator maps
`k(τ₁)⊥` onto `k(τ₂)⊥`. The absolute propagator constant is existential;
the reduction uses the authors' value `252 exp(1)`. -/
theorem lemma_2_6 :
  ∃ (C CΦ : ℝ) (p N : ℕ), 0 < CΦ ∧ ∀ {C₀ : ℕ}, N ≤ C₀ →
  ∀ {I : Set ℝ} {t₀ T lam : ℝ} (w : PhysicalAmplification I t₀) {k a : ℝ → Vec3},
    2 ≤ T → PaperWindow w T → FiniteSmallness w T C₀ → NewWaveVector w lam k →
    AmplitudeVector w k a → a t₀ = (-w.shear⁻¹) • w.basis t₀ 0 + w.basis t₀ 1 →
    let ε := w.ratio
    let δ := w.errorSize
    let α := alpha w a
    (∀ τ ∈ Icc 0 T, 0 < α τ 1) ∧
    (∀ Y : ℝ → ℝ, ReferenceSlope ε Y →
      ∀ τ ∈ Icc 0 T, |α τ 0 / α τ 1 + Y τ| ≤ C * T ^ p * δ) ∧
    (∀ τ ∈ Icc 0 T,
      α τ 1 ≤ ‖a (w.clock τ)‖ ∧ ‖a (w.clock τ)‖ ≤ (1 + C * T ^ p * δ) * α τ 1) ∧
    (∀ Y : ℝ → ℝ, ReferenceSlope ε Y →
      ∀ τ ∈ Icc 0 T, |Real.log (‖a (w.clock τ)‖ / referenceAmplitude Y τ)| ≤ ε) ∧
    (∀ τ₁ τ₂ : ℝ, 0 ≤ τ₁ → τ₁ ≤ τ₂ → τ₂ ≤ T →
      ∃ Φ : transversePlane (k (w.clock τ₁)) ≃L[ℝ] transversePlane (k (w.clock τ₂)),
        (∀ b : ℝ → Vec3, AmplitudeVector w k b →
          ∀ v : transversePlane (k (w.clock τ₁)), (v : Vec3) = b (w.clock τ₁) →
            (Φ v : Vec3) = b (w.clock τ₂)) ∧
        ‖Φ.toContinuousLinearMap‖ ≤
          CΦ * w.shear * (‖a (w.clock τ₂)‖ / ‖a (w.clock τ₁)‖)) := by
  obtain ⟨C, p, N, h⟩ := TorusEuler.Paper.lemma_2_6
  refine ⟨C, 252 * Real.exp 1, p, N, by positivity, ?_⟩
  intro C₀ hN I t₀ T lam w k a hT hWindow hSmall hk ha hInitial
  exact h hN w hT (paperWindow_mapsTo hWindow) hSmall hk ha hInitial

/-- Lemma 2.7. Under (2.7), the new first coupling obeys
`ν₊ ≥ εν/2`; on `√2/ε ≤ τ ≤ T` its two coupling ratios satisfy (2.19),
with the fixed tolerances `ε` and `1/2`. The reference angle is the
angle defined in (2.4). -/
theorem lemma_2_7 :
  ∃ N : ℕ, ∀ {C₀ : ℕ}, N ≤ C₀ →
  ∀ {I : Set ℝ} {t₀ T lam : ℝ} (w : PhysicalAmplification I t₀) {k a : ℝ → Vec3},
    2 ≤ T → PaperWindow w T → FiniteSmallness w T C₀ → NewWaveVector w lam k →
    AmplitudeVector w k a → a t₀ = (-w.shear⁻¹) • w.basis t₀ 0 + w.basis t₀ 1 →
    let ε := w.ratio
    let ν := w.firstCoupling
    let νplus := fun τ => w.physicalNu k a (w.clock τ)
    let ηplus := fun τ => w.physicalEta k a (w.clock τ)
    (∀ τ ∈ Icc 0 T, ε * ν / 2 ≤ νplus τ) ∧
    (∀ τ ∈ Icc 0 T, Real.sqrt 2 / ε ≤ τ →
      |νplus τ / ν - 1| ≤ ε ∧
        |ηplus τ / νplus τ / Real.cos (referenceAngle ε τ) - 1| ≤ 1 / 2) := by
  obtain ⟨N, h⟩ := TorusEuler.Paper.lemma_2_7
  refine ⟨N, ?_⟩
  intro C₀ hN I t₀ T lam w k a hT hWindow hSmall hk ha hInitial
  exact h hN w hT (paperWindow_mapsTo hWindow) hSmall hk ha hInitial

/-- Proposition 2.8. If `0 < ε₊ ≤ ε/32` and
`T ≥ 2(εε₊)^(-1/2)`, a crossing occurs between the reference turning
time and that endpoint. At every crossing the normalized strength is
between `C⁻¹(εε₊)^(-1/2)` and `C(εε₊)^(-1/2)` for one absolute
positive `C`, and the early amplitude satisfies (2.24). -/
theorem proposition_2_8 :
  ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, ∀ {C₀ : ℕ}, N ≤ C₀ →
  ∀ {I : Set ℝ} {t₀ T lam εplus : ℝ} (w : PhysicalAmplification I t₀) {k a : ℝ → Vec3},
    2 ≤ T → PaperWindow w T → FiniteSmallness w T C₀ → NewWaveVector w lam k →
    AmplitudeVector w k a → a t₀ = (-w.shear⁻¹) • w.basis t₀ 0 + w.basis t₀ 1 →
    0 < εplus → εplus ≤ w.ratio / 32 → 2 / Real.sqrt (w.ratio * εplus) ≤ T →
    let ε := w.ratio
    let H := 2 / Real.sqrt (ε * εplus)
    let ratioPlus := fun τ => w.physicalEta k a (w.clock τ) / w.physicalNu k a (w.clock τ)
    let σplus := fun τ => ‖a (w.clock τ)‖ * ‖k (w.clock τ)‖
    ∃ τm : ℝ, (∀ Y : ℝ → ℝ, ReferenceSlope ε Y → ∀ τ ∈ Ici (0 : ℝ), Y τ = 0 ↔ τ = τm) ∧
      2 / ε ≤ τm ∧
      (∃ τ ∈ Icc τm H, ratioPlus τ = εplus) ∧
      ∃ peak : ℝ, IsGreatest ((fun τ => ‖a (w.clock τ)‖) '' Icc 0 T) peak ∧
        (∀ τ ∈ Icc τm H, ratioPlus τ = εplus →
          C⁻¹ * (Real.sqrt (ε * εplus))⁻¹ ≤ σplus τ / (lam * peak) ∧
          σplus τ / (lam * peak) ≤ C * (Real.sqrt (ε * εplus))⁻¹) ∧
        (∀ τ ∈ Icc (0 : ℝ) 1, ‖a (w.clock τ)‖ ≤ Real.exp (3 - (Real.sqrt ε)⁻¹) * peak) := by
  obtain ⟨N, h⟩ := TorusEuler.Paper.proposition_2_8
  let lo : ℝ := Real.exp (-1) / 4
  let hi : ℝ := 18 * Real.exp 3
  let C : ℝ := lo⁻¹ + hi
  have hlo : 0 < lo := by dsimp [lo]; positivity
  have hhi : 0 < hi := by dsimp [hi]; positivity
  have hC : 0 < C := by dsimp [C]; positivity
  have hLower : C⁻¹ ≤ lo := by
    have hle : lo⁻¹ ≤ C := by dsimp [C]; linarith
    have hinv := one_div_le_one_div_of_le (inv_pos.mpr hlo) hle
    simpa only [one_div, inv_inv] using hinv
  have hUpper : hi ≤ C := by
    dsimp [C]
    exact le_add_of_nonneg_left (inv_nonneg.mpr hlo.le)
  refine ⟨C, hC, N, ?_⟩
  intro C₀ hN I t₀ T lam εplus w k a hT hWindow hSmall hk ha hInitial hεpos hεle hH
  obtain ⟨τm, hZero, hTurning, hCross, peak, hPeak, hStrength, hEarly⟩ :=
    h hN w hT (paperWindow_mapsTo hWindow) hSmall hk ha hInitial hεpos hεle hH
  refine ⟨τm, hZero, hTurning, hCross, peak, hPeak, ?_, hEarly⟩
  intro τ hτ hCrossing
  obtain ⟨hl, hu⟩ := hStrength τ hτ hCrossing
  constructor
  · exact (mul_le_mul_of_nonneg_right hLower (by positivity)).trans hl
  · exact hu.trans (mul_le_mul_of_nonneg_right hUpper (by positivity))

end

end Adapted.S2
