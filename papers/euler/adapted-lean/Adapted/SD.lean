import TorusEuler.Paper.Proofs.SBD.EqD2
import TorusEuler.Paper.Proofs.SBD.LemmaD1
import TorusEuler.Paper.Proofs.SBD.LemmaD2
import TorusEuler.Paper.Proofs.SBD.LemmaD3
import Adapted.Norms
import Adapted.RealPowers

/-! # Appendix D: finite norms and coefficient estimates

The coordinate words and the weighted supremum norms are the authors'
definitions. Half-Hölder norms use the paper's sum convention, supplied by
`Adapted.Norms`. Real coefficient exponents are retained without rounding.
The time index `I` can be any closed subinterval of the interval in the paper.
-/

open Set TorusEuler TorusEuler.Paper TorusEuler.Paper.AppendixD
open Adapted.Norms Adapted.RealPowers
open scoped ContDiff

namespace Adapted.SD

/-- **Display (D.2).** Passing from supremum bounds to the half-Hölder
finite norm costs one derivative and a factor `ℓ^(-1/2)`:
`ℓ^m |c|_(m,1/2) ≤ C ℓ^(-1/2)(ℓ^m |c|_m + ℓ^(m+1) |c|_(m+1))` and
`‖c‖_[n] ≤ ‖c‖_[n],1/2 ≤ C ℓ^(-1/2) ‖c‖_[n+1]`.
One absolute constant works for every order, coefficient and time interval.
The displayed half-Hölder norm is the sum convention of the paper. -/
theorem eq_D_2 :
    ∃ C : ℝ, 0 ≤ C ∧
    ∀ (I E : Type) [NormedAddCommGroup E] [NormedSpace ℝ E] (ℓ : ℝ),
      0 < ℓ → ℓ ≤ 1 → ∀ c : I → Vec3 → E,
      (∀ m : ℕ, CoefficientNormFinite (m + 1) c →
        ℓ ^ m * paperHolderOrderNorm m c ≤
          C * (Real.sqrt ℓ)⁻¹ * (ℓ ^ m * coefficientOrderNorm m c +
            ℓ ^ (m + 1) * coefficientOrderNorm (m + 1) c)) ∧
      (∀ n : ℕ, CoefficientNormFinite (n + 1) c →
        HolderFieldNormFinite ℓ n c ∧
        coefficientNorm ℓ n c ≤ paperHolderFieldNorm ℓ n c ∧
        paperHolderFieldNorm ℓ n c ≤
          C * (Real.sqrt ℓ)⁻¹ * coefficientNorm ℓ (n + 1) c) := by
  refine ⟨8, by norm_num, ?_⟩
  intro I E _ _ ℓ hℓ hℓ1 c
  obtain ⟨horder, hfinite⟩ := TorusEuler.Paper.Proof.Text.eq_D_2 I E ℓ hℓ hℓ1 c
  constructor
  · intro m hc
    obtain ⟨hb, h⟩ := horder m hc
    have hcomp := (paperHolderOrderNorm_comparison m c hb).2
    have hscale := mul_le_mul_of_nonneg_left hcomp (pow_nonneg hℓ.le m)
    nlinarith [mul_le_mul_of_nonneg_left h (show (0 : ℝ) ≤ 2 by norm_num)]
  · intro n hc
    obtain ⟨hb, hlow, hhigh⟩ := hfinite n hc
    obtain ⟨hleft, hright⟩ := paperHolderFieldNorm_comparison hb
    refine ⟨hb, hlow.trans hleft, ?_⟩
    nlinarith

/-- **Lemma D.1.** The finite norms obey the label and phase derivative
bounds (D.3), the product inequality (D.4), and the phase-average,
mean-zero projection and zero-mean primitive bounds (D.5). For
phase-independent fields the product inequality also holds in the
half-Hölder norm, with its sum convention. Constants are chosen before the
time domain, scales, weight and fields; the product constants depend only
on the order and the norm of the fixed bilinear multiplication. -/
theorem lemma_D_1 :
  ∃ (Cder Cprim : ℝ) (Cprod CHolder : ℕ → ℝ),
    0 ≤ Cder ∧ 0 ≤ Cprim ∧ (∀ n, 0 ≤ Cprod n) ∧ (∀ n, 0 ≤ CHolder n) ∧
∀ (I : Type) (ℓ h : ℝ), 0 < ℓ → 0 < h → ∀ γ : I → ℝ, (∀ t, 0 < γ t) → ∀ n : ℕ,
    -- (D.3)
    (∀ (E : Type) [NormedAddCommGroup E] [NormedSpace ℝ E] (f : I → Vec3 × ℝ → E),
      FieldNormFinite ℓ h (n + 1) (weighted γ f) →
      (∀ i : Fin 3, FieldNormFinite ℓ h n (weighted γ (labelPartial i f))) ∧
        FieldNormFinite ℓ h n (weighted γ (phasePartial f)) ∧
        (∑ i : Fin 3, weightedFieldNorm ℓ h γ n (labelPartial i f)) ≤
          Cder * ℓ⁻¹ * weightedFieldNorm ℓ h γ (n + 1) f ∧
        weightedFieldNorm ℓ h γ n (phasePartial f) ≤ h⁻¹ * weightedFieldNorm ℓ h γ (n + 1) f) ∧
    -- (D.4)
    (∀ (E F G : Type) [NormedAddCommGroup E] [NormedSpace ℝ E]
      [NormedAddCommGroup F] [NormedSpace ℝ F] [NormedAddCommGroup G] [NormedSpace ℝ G]
      (B : E →L[ℝ] F →L[ℝ] G) (f : I → Vec3 × ℝ → E) (g : I → Vec3 × ℝ → F),
      FieldNormFinite ℓ h n f → FieldNormFinite ℓ h n (weighted γ g) →
      FieldNormFinite ℓ h n (weighted γ (fun t x => B (f t x) (g t x))) ∧
        weightedFieldNorm ℓ h γ n (fun t x => B (f t x) (g t x)) ≤
          (Cprod n * ‖B‖) *
            fieldNorm ℓ h n f * weightedFieldNorm ℓ h γ n g) ∧
    -- (D.5)
    (∀ (E : Type) [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
      (f : I → Vec3 × ℝ → E),
      FieldNormFinite ℓ h n (weighted γ f) →
      (∀ t a, Function.Periodic (fun s => f t (a, s)) 1) →
      FieldNormFinite ℓ h n (weighted γ (phaseAverage f)) ∧
        FieldNormFinite ℓ h n (weighted γ (f - phaseAverage f)) ∧
        weightedFieldNorm ℓ h γ n (phaseAverage f) ≤ weightedFieldNorm ℓ h γ n f ∧
        weightedFieldNorm ℓ h γ n (f - phaseAverage f) ≤ 2 * weightedFieldNorm ℓ h γ n f ∧
        ((∀ t a, phaseMean (fun s => f t (a, s)) = 0) →
          FieldNormFinite ℓ h n (weighted γ (phaseInverse f)) ∧
            weightedFieldNorm ℓ h γ n (phaseInverse f) ≤ Cprim * weightedFieldNorm ℓ h γ n f)) ∧
    -- (D.4) for phase-independent fields in `‖·‖_{[n],1/2}` with `γ ≡ 1`
    (∀ (E F G : Type) [NormedAddCommGroup E] [NormedSpace ℝ E]
      [NormedAddCommGroup F] [NormedSpace ℝ F] [NormedAddCommGroup G] [NormedSpace ℝ G]
      (B : E →L[ℝ] F →L[ℝ] G) (c : I → Vec3 → E) (d : I → Vec3 → F),
      HolderFieldNormFinite ℓ n c → HolderFieldNormFinite ℓ n d →
      HolderFieldNormFinite ℓ n (fun t x => B (c t x) (d t x)) ∧
        paperHolderFieldNorm ℓ n (fun t x => B (c t x) (d t x)) ≤
          (CHolder n * ‖B‖) *
            paperHolderFieldNorm ℓ n c * paperHolderFieldNorm ℓ n d) := by
  let Cprod (n : ℕ) : ℝ :=
    (hierarchyAdmissibleWords (Fin 4) n).card * (2 : ℝ) ^ n * 2
  let CHolder (n : ℕ) : ℝ :=
    (hierarchyAdmissibleWords (Fin 3) n).card * (2 : ℝ) ^ n * 4
  refine ⟨3, 2, Cprod, CHolder, by norm_num, by norm_num,
    (fun n => by dsimp [Cprod]; positivity),
    (fun n => by dsimp [CHolder]; positivity), ?_⟩
  intro I ℓ h hℓ hh γ hγ n
  obtain ⟨hder, hprod, hphase, hholder⟩ :=
    TorusEuler.Paper.Proof.lemma_D_1 I ℓ h hℓ hh γ hγ n
  refine ⟨hder, ?_, hphase, ?_⟩
  · intro E F G _ _ _ _ _ _ B f g hf hg
    obtain ⟨hb, hbound⟩ := hprod E F G B f g hf hg
    refine ⟨hb, ?_⟩
    simpa only [Cprod, mul_assoc, mul_left_comm, mul_comm] using hbound
  · intro E F G _ _ _ _ _ _ B c d hc hd
    obtain ⟨hb, hbound⟩ := hholder E F G B c d hc hd
    refine ⟨hb, ?_⟩
    let K : ℝ := (hierarchyAdmissibleWords (Fin 3) n).card * (2 : ℝ) ^ n * (2 * ‖B‖)
    have hK : 0 ≤ K := by dsimp [K]; positivity
    have hbound' : holderFieldNorm ℓ n (fun t x => B (c t x) (d t x)) ≤
        K * holderFieldNorm ℓ n c * holderFieldNorm ℓ n d := hbound
    obtain ⟨hc1, hc2⟩ := paperHolderFieldNorm_comparison hc
    obtain ⟨hd1, hd2⟩ := paperHolderFieldNorm_comparison hd
    have hmul : holderFieldNorm ℓ n c * holderFieldNorm ℓ n d ≤
        paperHolderFieldNorm ℓ n c * paperHolderFieldNorm ℓ n d :=
      mul_le_mul hc1 hd1 (holderFieldNorm_nonneg hd)
        ((holderFieldNorm_nonneg hc).trans hc1)
    have hscaled := mul_le_mul_of_nonneg_left hmul (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hK)
    have hout := (paperHolderFieldNorm_comparison hb).2
    calc
      paperHolderFieldNorm ℓ n (fun t x => B (c t x) (d t x)) ≤
          (2 * K) * paperHolderFieldNorm ℓ n c * paperHolderFieldNorm ℓ n d := by
        nlinarith
      _ = _ := by dsimp [K, CHolder]; ring

/-- **Lemma D.2.** Products preserve the derivative power bounds (D.6).
An invertible coefficient whose inverse has a fixed power bound at order
zero has such bounds at every order. If `ℓ ≤ D^(-a)` for the exponent `a`
in the original bound, then `‖c‖_[n] ≤ C_n D^a` and
`ℓ^m |c|_m ≤ C_m D^(2a) ℓ` for `m ≥ 1`.

All exponents here are real. The absolute exponents and fixed-order
constants are nonnegative, as for the positive constants of the paper.
Output constants are chosen before the time domain, `D`, `ℓ` and the fields.
Matrix multiplication is represented by a bilinear map of norm at most one;
inverses are in a complete real normed algebra, including square matrices. -/
theorem lemma_D_2 :
    (∀ (X Y Z : Type) [NormedAddCommGroup X] [NormedSpace ℝ X]
        [NormedAddCommGroup Y] [NormedSpace ℝ Y]
        [NormedAddCommGroup Z] [NormedSpace ℝ Z]
        (C C' : ℕ → ℝ) (a b : ℝ),
      (∀ m, 0 ≤ C m) → (∀ m, 0 ≤ C' m) → 0 ≤ a → 0 ≤ b →
      ∃ (e : ℝ) (C'' : ℕ → ℝ), 0 ≤ e ∧ (∀ m, 0 ≤ C'' m) ∧
      ∀ B : X →L[ℝ] Y →L[ℝ] Z, ‖B‖ ≤ 1 →
      ∀ (I : Type) (D : ℝ), 1 ≤ D →
      ∀ (c : I → Vec3 → X) (d : I → Vec3 → Y),
        CoefficientPowerReal C D a c → CoefficientPowerReal C' D b d →
        CoefficientPowerReal C'' D e (fun t x => B (c t x) (d t x))) ∧
    (∀ (A : Type) [NormedRing A] [NormedAlgebra ℝ A] [CompleteSpace A]
        (C : ℕ → ℝ) (a e : ℝ),
      (∀ m, 0 ≤ C m) → 0 ≤ a → 0 ≤ e →
      ∃ (d : ℝ) (C' : ℕ → ℝ), 0 ≤ d ∧ (∀ m, 0 ≤ C' m) ∧
      ∀ (I : Type) (D : ℝ), 1 ≤ D → ∀ c : I → Vec3 → A,
        CoefficientPowerReal C D a c → (∀ t x, IsUnit (c t x)) →
        (∀ t x, ‖Ring.inverse (c t x)‖ ≤ D ^ e) →
        CoefficientPowerReal C' D d (fun t x => Ring.inverse (c t x))) ∧
    (∀ (X : Type) [NormedAddCommGroup X] [NormedSpace ℝ X]
        (C : ℕ → ℝ) (a : ℝ), 0 ≤ a →
      ∃ C' : ℕ → ℝ, (∀ m, 0 ≤ C' m) ∧
      ∀ (I : Type) (D ℓ : ℝ), 1 ≤ D → 0 < ℓ → ℓ ≤ D ^ (-a) →
      ∀ c : I → Vec3 → X, CoefficientPowerReal C D a c →
        (∀ n, coefficientNorm ℓ n c ≤ C' n * D ^ a) ∧
        ∀ m, 1 ≤ m → ℓ ^ m * coefficientOrderNorm m c ≤ C' m * D ^ (2 * a) * ℓ) := by
  obtain ⟨hproduct, hinverse, hweighted⟩ := TorusEuler.Paper.Proof.lemma_D_2
  refine ⟨?_, ?_, ?_⟩
  · intro X Y Z _ _ _ _ _ _ C C' a b hC hC' ha hb
    obtain ⟨C'', hC'', h⟩ := hproduct X Y Z C C' 1 1
    refine ⟨2 * max a b, C'', by positivity, hC'', ?_⟩
    intro B hB I D hD c d hc hd
    have hD0 : 0 ≤ D := zero_le_one.trans hD
    have ha' : 0 ≤ max a b := ha.trans (le_max_left _ _)
    have hc' : CoefficientPower C (D ^ max a b) 1 c :=
      (coefficientPower_rescale hD0 1 c).mpr (by
        simpa only [Nat.cast_one, mul_one] using
          coefficientPowerReal_mono hc hC hD (le_max_left a b))
    have hd' : CoefficientPower C' (D ^ max a b) 1 d :=
      (coefficientPower_rescale hD0 1 d).mpr (by
        simpa only [Nat.cast_one, mul_one] using
          coefficientPowerReal_mono hd hC' hD (le_max_right a b))
    have hout : CoefficientPower C'' (D ^ max a b) 2
        (fun t x => B (c t x) (d t x)) := by
      simpa using h B hB I (D ^ max a b) (Real.one_le_rpow hD ha') c d hc' hd'
    have hout' := (coefficientPower_rescale hD0 2 (fun t x => B (c t x) (d t x))).mp hout
    simpa only [Nat.cast_ofNat, mul_comm (max a b) 2] using hout'
  · intro A _ _ _ C a e hC ha he
    obtain ⟨C', hC', h⟩ := hinverse A C 1 1
    refine ⟨3 * max a e, C', by positivity, hC', ?_⟩
    intro I D hD c hc hunit hinv
    have hD0 : 0 ≤ D := zero_le_one.trans hD
    have ha' : 0 ≤ max a e := ha.trans (le_max_left _ _)
    have hc' : CoefficientPower C (D ^ max a e) 1 c :=
      (coefficientPower_rescale hD0 1 c).mpr (by
        simpa only [Nat.cast_one, mul_one] using
          coefficientPowerReal_mono hc hC hD (le_max_left a e))
    have hi : ∀ t x, ‖Ring.inverse (c t x)‖ ≤ (D ^ max a e) ^ (1 : ℕ) := by
      intro t x
      simpa only [pow_one] using (hinv t x).trans
        (Real.rpow_le_rpow_of_exponent_le hD (le_max_right a e))
    have hout : CoefficientPower C' (D ^ max a e) 3
        (fun t x => Ring.inverse (c t x)) := by
      simpa using h I (D ^ max a e) (Real.one_le_rpow hD ha') c hc' hunit hi
    have hout' := (coefficientPower_rescale hD0 3 (fun t x => Ring.inverse (c t x))).mp hout
    simpa only [Nat.cast_ofNat, mul_comm (max a e) 3] using hout'
  · intro X _ _ C a ha
    obtain ⟨C', hC', h⟩ := hweighted X C 1
    refine ⟨C', hC', ?_⟩
    intro I D ℓ hD hℓ hscale c hc
    have hD0 : 0 ≤ D := zero_le_one.trans hD
    have hc' : CoefficientPower C (D ^ a) 1 c :=
      (coefficientPower_rescale hD0 1 c).mpr (by
        simpa only [Nat.cast_one, mul_one] using hc)
    have hscale' : ℓ ≤ ((D ^ a) ^ (1 : ℕ))⁻¹ := by
      simpa only [pow_one, Real.rpow_neg hD0] using hscale
    obtain ⟨hn, hm⟩ := h I (D ^ a) ℓ (Real.one_le_rpow hD ha) hℓ hscale' c hc'
    have hsquare : (D ^ a) ^ (2 : ℕ) = D ^ (2 * a) := by
      rw [← Real.rpow_mul_natCast hD0]
      congr 1
      norm_num
      ring
    refine ⟨?_, ?_⟩
    · intro n
      simpa only [pow_one] using hn n
    · intro m hm1
      simpa only [Nat.mul_one, hsquare] using hm m hm1

/-- **Lemma D.3.** A zero-order inverse estimate for every admissible
source lifts to `‖v‖_[n],γ ≤ C_n C_low ‖f‖_[n],γ` if
`C_low ∑_ν b_ν ℓ^m |c_ν|_m ≤ C_m` for every `m ≥ 1`.
The same assertion holds in the half-Hölder norms for phase-independent
fields. Constants are chosen before the equation, coefficients and solution.
Only the finite list of bounds through order `n` precedes the choice of
`Cn`. The complete sequence `Cm`, including its unrestricted higher-order
values, is quantified afterward and must agree with that list through `n`.

The linear spaces include the homogeneous constraints; the forcing space
includes the prescribed data and may be a quotient by the subspace of
permitted errors. `DE`, `DF`, `DA` are the weighted derivatives, and the
Leibniz identity states their compatibility with coefficient multiplication.
The zero-order seminorms can be the supremum or the sum-convention
half-Hölder seminorms. The full hypothesis (D.7), at every positive order,
is retained although the reduction needs it only through order `n`. -/
theorem lemma_D_3 :
∀ (Idx : Type) [Fintype Idx] [LinearOrder Idx] (n : ℕ) (prefixBounds : Fin (n + 1) → ℝ),
  ∃ Cn : ℝ, 0 ≤ Cn ∧ ∀ Cm : ℕ → ℝ,
    (∀ (m : ℕ) (hm : m ≤ n), Cm m = prefixBounds ⟨m, Nat.lt_succ_of_le hm⟩) →
    ∀ (J A E F : Type) [Fintype J] [AddCommGroup A] [Module ℝ A]
      [AddCommGroup E] [Module ℝ E] [AddCommGroup F] [Module ℝ F]
      (DA : Idx → A →ₗ[ℝ] A) (DE : Idx → E →ₗ[ℝ] E) (DF : Idx → F →ₗ[ℝ] F)
      (pA : Seminorm ℝ A) (pE : Seminorm ℝ E) (pF : Seminorm ℝ F)
      (L₀ : E →ₗ[ℝ] F) (T : J → A →ₗ[ℝ] E →ₗ[ℝ] F) (c : J → A) (b : J → ℝ) (Clow : ℝ),
    -- `ℒ₀` commutes with the derivatives
    (∀ i u, DF i (L₀ u) = L₀ (DE i u)) →
    -- `T_ν` commutes with the derivatives, and Leibniz' rule for `c_ν v`
    (∀ j i a u, DF i (T j a u) = T j (DA i a) u + T j a (DE i u)) →
    -- the derivatives commute on solution, forcing, and coefficient spaces
    (∀ i i' u, DE i (DE i' u) = DE i' (DE i u)) →
    (∀ i i' g, DF i (DF i' g) = DF i' (DF i g)) →
    (∀ i i' a, DA i (DA i' a) = DA i' (DA i a)) →
    -- `b_ν` bounds `T_ν(a u)` from the zero-order norms
    (∀ j, 0 ≤ b j) → (∀ j a u, pF (T j a u) ≤ b j * pA a * pE u) →
    -- the zero-order estimate for every admissible source
    0 ≤ Clow → (∀ u, pE u ≤ Clow * pF (L₀ u + ∑ j, T j (c j) u)) →
    -- (D.7)
    (∀ m, 1 ≤ m →
      Clow * ∑ j, b j * appendixExactOrderDerivativeNorm pA DA m (c j) ≤ Cm m) →
    ∀ (v : E) (f : F), L₀ v + ∑ j, T j (c j) v = f →
      appendixFiniteDerivativeNorm pE DE n v ≤ Cn * Clow * appendixFiniteDerivativeNorm pF DF n f := by
  intro Idx _ _ n prefixBounds
  let truncated : ℕ → ℝ := fun m =>
    if hm : m ≤ n then prefixBounds ⟨m, Nat.lt_succ_of_le hm⟩ else 0
  obtain ⟨Cn, hCn, h⟩ := TorusEuler.Paper.Proof.lemma_D_3 Idx n truncated
  refine ⟨Cn, hCn, ?_⟩
  intro Cm hprefix J A E F _ _ _ _ _ _ _ DA DE DF pA pE pF L₀ T c b Clow
    hL hT hDE hDF hDA hb hmult hClow hlow hslow v f heq
  exact h J A E F DA DE DF pA pE pF L₀ T c b Clow hL hT hDF hDA hb hmult
    hClow hlow (fun m hm hmn => by
      calc
        Clow * ∑ j, b j * appendixExactOrderDerivativeNorm pA DA m (c j) ≤ Cm m :=
          hslow m hm
        _ = truncated m := by
          simp only [truncated, dite_eq_left hmn, hprefix m hmn]) v f heq

end Adapted.SD
