import TorusEuler.Paper.SBD.Vocabulary

/-! # The sum convention for the half-Hölder norms in Appendix D

The paper uses the supremum norm plus the half-Hölder seminorm. The authors'
`holderFieldNorm` uses their maximum. These definitions retain the sum, and
the comparison below supplies the factor two needed when applying their
estimates. The two quantities in each sum are taken at the same time.
-/

open Set TorusEuler TorusEuler.Paper.AppendixD
open scoped ContDiff

namespace Adapted.Norms

noncomputable section

variable {I E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Values whose supremum is the time supremum of the sum of the spatial
supremum norm and half-Hölder seminorm of one derivative. The extra zero
makes the definition valid also for an empty time domain. -/
def holderSumValues (D : Fin 3 → Vec3 → Vec3) (w : List (Fin 3))
    (f : I → Vec3 → E) : Set ℝ :=
  {r | r = 0 ∨ ∃ t x y z,
    ‖phaseOperatorWord D w (f t) x‖ +
      ‖phaseOperatorWord D w (f t) y - phaseOperatorWord D w (f t) z‖ /
        Real.sqrt (dist y z) = r}

/-- For one spatial derivative, the sum convention lies between the
maximum convention and twice that convention; all suprema are finite. -/
theorem holderSumWord_comparison (D : Fin 3 → Vec3 → Vec3) (w : List (Fin 3))
    (f : I → Vec3 → E) (hb : BddAbove (hierarchyJetValues True D w f)) :
    BddAbove (holderSumValues D w f) ∧
      sSup (hierarchyJetValues True D w f) ≤ sSup (holderSumValues D w f) ∧
      sSup (holderSumValues D w f) ≤ 2 * sSup (hierarchyJetValues True D w f) := by
  let M := sSup (hierarchyJetValues True D w f)
  have hM : 0 ≤ M := le_csSup hb (Or.inl rfl)
  have hvalue (t : I) (x : Vec3) : ‖phaseOperatorWord D w (f t) x‖ ≤ M :=
    le_csSup hb (Or.inr (Or.inl ⟨t, x, rfl⟩))
  have hquot (t : I) (y z : Vec3) :
      ‖phaseOperatorWord D w (f t) y - phaseOperatorWord D w (f t) z‖ /
        Real.sqrt (dist y z) ≤ M :=
    le_csSup hb (Or.inr (Or.inr ⟨True.intro, t, y, z, rfl⟩))
  have hupper : ∀ r ∈ holderSumValues D w f, r ≤ 2 * M := by
    rintro r (rfl | ⟨t, x, y, z, rfl⟩)
    · linarith
    · linarith [hvalue t x, hquot t y z]
  have hsum : BddAbove (holderSumValues D w f) := ⟨2 * M, hupper⟩
  refine ⟨hsum, ?_, csSup_le ⟨0, Or.inl rfl⟩ hupper⟩
  refine csSup_le (s := hierarchyJetValues True D w f) ⟨0, Or.inl rfl⟩ ?_
  rintro r (rfl | ⟨t, x, rfl⟩ | ⟨_, t, y, z, rfl⟩)
  · exact le_csSup hsum (Or.inl rfl)
  · apply le_csSup hsum
    exact Or.inr ⟨t, x, 0, 0, by simp⟩
  · have h := le_csSup hsum (show
        ‖phaseOperatorWord D w (f t) 0‖ +
          ‖phaseOperatorWord D w (f t) y - phaseOperatorWord D w (f t) z‖ /
            Real.sqrt (dist y z) ∈ holderSumValues D w f from
          Or.inr ⟨t, 0, y, z, rfl⟩)
    exact (le_add_of_nonneg_left (norm_nonneg _)).trans h

/-- The paper's `‖c‖_[n],1/2`: sum over spatial multi-indices of order at
most `n`, with weight `ℓ^|β|`, of the time supremum of
`‖∂^β c(t)‖∞ + [∂^β c(t)]₁/₂`. Each sorted word represents one multi-index. -/
def paperHolderFieldNorm (ℓ : ℝ) (n : ℕ) (c : I → Vec3 → E) : ℝ :=
  ∑ w ∈ hierarchyAdmissibleWords (Fin 3) n,
    sSup (holderSumValues (hierarchyLabelDirection ℓ) w c)

/-- The paper's exact-order quantity `|c|_(m,1/2)`, using the sum of the
supremum norm and the half-Hölder seminorm, before the envelope weight. -/
def paperHolderOrderNorm (m : ℕ) (c : I → Vec3 → E) : ℝ :=
  ∑ w ∈ appendixCoefficientOrderWords m,
    sSup (holderSumValues (hierarchyLabelDirection 1) w c)

/-- The finite half-Hölder norm in the sum convention lies between the
authors' maximum convention and twice that convention. -/
theorem paperHolderFieldNorm_comparison {ℓ : ℝ} {n : ℕ} {c : I → Vec3 → E}
    (hc : HolderFieldNormFinite ℓ n c) :
    holderFieldNorm ℓ n c ≤ paperHolderFieldNorm ℓ n c ∧
      paperHolderFieldNorm ℓ n c ≤ 2 * holderFieldNorm ℓ n c := by
  constructor
  · exact Finset.sum_le_sum fun w hw =>
      (holderSumWord_comparison _ w c (hc.2 w hw)).2.1
  · change (∑ w ∈ hierarchyAdmissibleWords (Fin 3) n, _) ≤
      2 * (∑ w ∈ hierarchyAdmissibleWords (Fin 3) n, _)
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun w hw =>
      (holderSumWord_comparison _ w c (hc.2 w hw)).2.2

/-- The exact-order half-Hölder norm in the sum convention lies between
the authors' maximum convention and twice that convention. -/
theorem paperHolderOrderNorm_comparison (m : ℕ) (c : I → Vec3 → E)
    (hc : ∀ w ∈ appendixCoefficientOrderWords m,
      BddAbove (hierarchyJetValues True (hierarchyLabelDirection 1) w c)) :
    holderOrderNorm m c ≤ paperHolderOrderNorm m c ∧
      paperHolderOrderNorm m c ≤ 2 * holderOrderNorm m c := by
  constructor
  · exact Finset.sum_le_sum fun w hw =>
      (holderSumWord_comparison _ w c (hc w hw)).2.1
  · change (∑ w ∈ appendixCoefficientOrderWords m, _) ≤
      2 * (∑ w ∈ appendixCoefficientOrderWords m, _)
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun w hw =>
      (holderSumWord_comparison _ w c (hc w hw)).2.2

/-- The half-Hölder norm of a field is nonnegative whenever its jets are bounded. -/
theorem holderFieldNorm_nonneg {ℓ : ℝ} {n : ℕ} {c : I → Vec3 → E}
    (hc : HolderFieldNormFinite ℓ n c) : 0 ≤ holderFieldNorm ℓ n c :=
  Finset.sum_nonneg fun w hw => le_csSup (hc.2 w hw) (Or.inl rfl)

end
end Adapted.Norms
