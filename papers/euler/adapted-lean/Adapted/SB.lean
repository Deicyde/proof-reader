import TorusEuler.Paper.Proofs.SBD.LemmaB1
import TorusEuler.Paper.S5.Vocabulary
import TorusEuler.PaperAppendixBLInfinityReal

/-! # Appendix B. The frequency cutoff

The symbol is radial and the scale satisfies `Λ ≥ 1`, as in the paper.
`cutoff` is one operator on real velocity fields, including arbitrary
strongly measurable essentially bounded representatives. On a continuous
input it is definitionally the authors' `realVectorFourierCutoff`.

Spatial and time differentiation are given by their first-order identities;
these apply successively to the derivatives of a smooth field. The spatial
Hölder norm is the authors' `spatialHolderHalfNorm`, the sum over derivative
orders of the uniform tensor norm and half-Hölder seminorm. The Bernstein
sum uses one nondecreasing coordinate word for each multi-index, as printed.
The difference `s-M` in (B.2) is an integer, so negative powers are retained.
-/

open MeasureTheory Set UnitAddTorus
open scoped ContDiff ENNReal
open TorusEuler TorusEuler.Paper

namespace Adapted.SB

noncomputable section

local notation "Labels" => UnitAddTorus (Fin 3)

/-- The cutoff `S_Λ` on a real torus velocity field. For the radial
symbol fixed in Appendix B, it multiplies frequency `ξ` by `ψ(ξ/Λ)`.
Finite Fourier synthesis gives a
continuous output even when the input is only essentially bounded. -/
def cutoff (ψ : Vec3 → ℝ) (Λ : ℝ) (g : Labels → Vec3) : C(Labels, Vec3) :=
  ⟨realVectorFourierCutoffOfFunction ψ Λ g,
    continuous_realVectorFourierCutoffOfFunction ψ Λ g⟩

/-- On continuous inputs this is the same cutoff used by the authors'
spatial differentiation and Hölder estimates. -/
theorem cutoff_eq_on_continuous (ψ : Vec3 → ℝ) (Λ : ℝ) (g : C(Labels, Vec3)) :
    (cutoff ψ Λ g : Labels → Vec3) = realVectorFourierCutoff ψ Λ g := rfl

/-- Either sign of parity is preserved on arbitrary representatives;
no continuity of the input is needed for the Fourier identity. -/
theorem cutoff_parity {ψ : Vec3 → ℝ} (heven : Function.Even ψ)
    (Λ c : ℝ) (g : Labels → Vec3) (hg : ∀ z, g (-z) = c • g z) :
    ∀ z, cutoff ψ Λ g (-z) = c • cutoff ψ Λ g z := by
  have hc (z : Labels) : (periodicComplexifyVector ∘ g) (-z) =
      c • (periodicComplexifyVector ∘ g) z := by
    change periodicComplexifyVector (g (-z)) = c • periodicComplexifyVector (g z)
    rw [hg, map_smul]
  intro z
  change periodicRealPartVector (smoothFourierCutoff ψ Λ (periodicComplexifyVector ∘ g) (-z)) =
    c • periodicRealPartVector (smoothFourierCutoff ψ Λ (periodicComplexifyVector ∘ g) z)
  rw [smoothFourierCutoff_neg_arg heven Λ c hc, map_smul]

/-- Every integrable real input has output frequencies at most `2Λ`.
Testing by each continuous real linear functional gives exactly the scalar
multiplier, so the assertion also applies to measurable `L∞` inputs. -/
theorem cutoff_frequency_support {ψ : Vec3 → ℝ} (heven : Function.Even ψ)
    (Λ : ℝ) (g : Labels → Vec3) (hg : Integrable g unitTorusMeasure) :
    RealNormedTorusFourierBand (2 * Λ) (cutoff ψ Λ g) := by
  intro l k hk
  have hscalar : (realFourierScalarization l (cutoff ψ Λ g) : Labels → ℂ) =
      smoothFourierCutoff ψ Λ (fun z => (l (g z) : ℂ)) := by
    funext z
    change (l (realVectorFourierCutoffOfFunction ψ Λ g z) : ℂ) = _
    rw [← realBanachFourierCutoff_vec_eq ψ Λ g hg]
    exact realBanachFourierCutoff_scalarization heven Λ g hg l z
  change mFourierCoeff (realFourierScalarization l (cutoff ψ Λ g)) k = 0
  rw [hscalar]
  exact mFourierCoeff_smoothFourierCutoff_eq_zero ψ Λ _ hk

/-- Lemma B.1. The cutoff commutes with derivatives, preserves parity
and divergence freeness, and has frequencies at most `2Λ`. Its operator
norms on `L∞` and `C^{0,1/2}` depend only on `ψ`. For every real
normed-space-valued field with frequencies at most `4Λ`, Bernstein's
inequality (B.1) holds. For `0 ≤ s ≤ M`, the tail satisfies (B.2).

`Cinf` and `Cholder` are the two operator bounds; `Cb m` and `Ct M` are the
constants in (B.1) and (B.2). All are chosen before `Λ`, the derivative
orders, the value space, and the input fields. The `L∞` assertion is for
all measurable essentially bounded real velocities, not just continuous ones. -/
theorem lemma_B_1 :
  ∀ ψ : Vec3 → ℝ, TorusEuler.Paper.S5.CutoffSymbol ψ →
  ∃ (Cinf Cholder : ℝ) (Cb Ct : ℕ → ℝ),
    0 ≤ Cinf ∧ 0 ≤ Cholder ∧ (∀ m, 0 ≤ Cb m) ∧ (∀ M, 0 ≤ Ct M) ∧
  ∀ Λ : ℝ, 1 ≤ Λ →
    (∀ (g d : C(Labels, Vec3)) (i : Fin 3),
      ContDiff ℝ 1 (fun x => g (toUnitTorus x)) →
      (∀ x, d (toUnitTorus x) =
        fderiv ℝ (fun y => g (toUnitTorus y)) x (EuclideanSpace.single i 1)) →
      ∀ x, fderiv ℝ (fun y => cutoff ψ Λ g (toUnitTorus y)) x
        (EuclideanSpace.single i 1) = cutoff ψ Λ d (toUnitTorus x)) ∧
    (∀ (a b : ℝ), a < b → ∀ V : Velocity,
      ContDiffOn ℝ ∞ (Function.uncurry V) (Icc a b ×ˢ (univ : Set Vec3)) →
      ∀ g gt : ℝ → C(Labels, Vec3),
      (∀ t ∈ Icc a b, ∀ x, g t (toUnitTorus x) = V t x) →
      (∀ t ∈ Icc a b, ∀ x, gt t (toUnitTorus x) =
        derivWithin (fun r => V r x) (Icc a b) t) →
      ∀ t ∈ Icc a b, ∀ x,
        HasDerivWithinAt (fun r => cutoff ψ Λ (g r) (toUnitTorus x))
          (cutoff ψ Λ (gt t) (toUnitTorus x)) (Icc a b) t) ∧
    (∀ g : Labels → Vec3, Function.Even g → Function.Even (cutoff ψ Λ g)) ∧
    (∀ g : Labels → Vec3, Function.Odd g → Function.Odd (cutoff ψ Λ g)) ∧
    (∀ g : C(Labels, Vec3), ContDiff ℝ ∞ (fun x => g (toUnitTorus x)) →
      (∀ x, divergence (fun y => g (toUnitTorus y)) x = 0) →
      ∀ x, divergence (fun y => cutoff ψ Λ g (toUnitTorus y)) x = 0) ∧
    (∀ g : Labels → Vec3, MemLp g ∞ unitTorusMeasure →
      RealNormedTorusFourierBand (2 * Λ) (cutoff ψ Λ g)) ∧
    (∀ g : Labels → Vec3, MemLp g ∞ unitTorusMeasure →
      eLpNormEssSup (cutoff ψ Λ g) unitTorusMeasure ≤
        ENNReal.ofReal Cinf * eLpNormEssSup g unitTorusMeasure) ∧
    (∀ g : C(Labels, Vec3), SpatialHolderHalf 0 (fun x => g (toUnitTorus x)) →
      SpatialHolderHalf 0 (fun x => cutoff ψ Λ g (toUnitTorus x)) ∧
        spatialHolderHalfNorm 0 (fun x => cutoff ψ Λ g (toUnitTorus x)) ≤
          Cholder * spatialHolderHalfNorm 0 (fun x => g (toUnitTorus x))) ∧
    (∀ (M s : ℕ), s ≤ M → ∀ g : C(Labels, Vec3),
      SpatialHolderHalf M (fun x => g (toUnitTorus x)) →
      SpatialHolderHalf s (fun x => g (toUnitTorus x) - cutoff ψ Λ g (toUnitTorus x)) ∧
        spatialHolderHalfNorm s (fun x => g (toUnitTorus x) - cutoff ψ Λ g (toUnitTorus x)) ≤
          Ct M * Λ ^ ((s : ℤ) - M) * spatialHolderHalfNorm M (fun x => g (toUnitTorus x))) ∧
    (∀ (m : ℕ) (V : Type) [NormedAddCommGroup V] [NormedSpace ℝ V] (g : C(Labels, V)),
      RealNormedTorusFourierBand (4 * Λ) g →
      (∀ β : Fin m → Fin 3, BddAbove (range fun x : Vec3 =>
        ‖iteratedFDeriv ℝ m (fun z => g (toUnitTorus z)) x
          (fun i => EuclideanSpace.single (β i) 1)‖)) ∧
      (∑ β ∈ Finset.univ.filter (fun β : Fin m → Fin 3 => Monotone β), ⨆ x : Vec3,
        ‖iteratedFDeriv ℝ m (fun z => g (toUnitTorus z)) x
          (fun i => EuclideanSpace.single (β i) 1)‖) ≤ Cb m * Λ ^ m * ‖g‖) := by
  intro ψ hψ
  have hSymbol : AppendixB.CutoffSymbol ψ :=
    AppendixB.CutoffSymbol.of_radial hψ.smooth hψ.radial
      (fun ξ => (hψ.range ξ).1) (fun ξ => (hψ.range ξ).2) hψ.unit hψ.support
  obtain ⟨Cop, Cb, Ct, hCop, hCb, hCt, h⟩ := TorusEuler.Paper.Proof.lemma_B_1 ψ hSymbol
  let Cinf : ℝ := ∫ y, ‖(cutoffSchwartzKernel hψ.support hψ.smooth : Vec3 → ℂ) y‖
  have hCinf : 0 ≤ Cinf := integral_nonneg fun _ => norm_nonneg _
  refine ⟨Cinf, Cop, Cb, Ct, hCinf, hCop, hCb, hCt, ?_⟩
  intro Λ hΛ
  have hΛpos : 0 < Λ := zero_lt_one.trans_le hΛ
  obtain ⟨_hComplex, hReal, hBernstein⟩ := h Λ hΛpos
  obtain ⟨_hMultiplier, hSpatial, hTime, _hParity, hDiv, _hFrequency,
    _hUniform, hHolder, hTail⟩ := hReal
  refine ⟨hSpatial, hTime, ?_, ?_, hDiv, ?_, ?_, hHolder, hTail, hBernstein⟩
  · intro g hg
    simpa only [Function.Even, one_smul] using
      cutoff_parity hSymbol.even Λ 1 g (by simpa only [Function.Even, one_smul] using hg)
  · intro g hg
    simpa only [Function.Odd, neg_one_smul] using
      cutoff_parity hSymbol.even Λ (-1) g (by simpa only [Function.Odd, neg_one_smul] using hg)
  · intro g hg
    exact cutoff_frequency_support hSymbol.even Λ g (hg.integrable (by simp))
  · intro g hg
    exact paperLemmaB1_realCutoff_LInfinity hψ.support hψ.smooth hΛpos g hg

end

end Adapted.SB
