/-
# Guarded assembly of the physical full H¹ norm

Status: COMPILED with pinned Lean v4.33.1; see the exact-source receipt.

Mathlib-only bridge to the independent physical contract. This lemma
assembles explicit integrability guards and a finite sum of derivative
integrals; it does not construct a Navier--Stokes solution.
-/
import Theorem11Challenge
import Mathlib.MeasureTheory.Integral.IntegrableOn

open MeasureTheory Set

noncomputable section

namespace Theorem11

/-- Explicit integrability of the velocity square and every basis derivative
square gives the contract's finiteness guard and its full H¹ norm. The split
integral formula matches the periodic/local norm bridges without dropping
the velocity L² term or using a totalized divergent integral. -/
theorem finiteH1On_and_h1NormOn_eq_split {f : VectorField} {Ω : Set Space}
    (hvalue : IntegrableOn (fun x => ‖f x‖ ^ 2) Ω)
    (hgradient : ∀ i : Fin 3,
      IntegrableOn (fun x => ‖fderiv ℝ f x (unitVector i)‖ ^ 2) Ω) :
    FiniteH1On f Ω ∧
      h1NormOn f Ω = Real.sqrt ((∫ x in Ω, ‖f x‖ ^ 2) +
        ∑ i : Fin 3, ∫ x in Ω, ‖fderiv ℝ f x (unitVector i)‖ ^ 2) := by
  have hsum : Integrable (gradientSquare f) (volume.restrict Ω) :=
    integrable_finsetSum _ (fun i _ => hgradient i)
  refine ⟨hvalue.add hsum, ?_⟩
  unfold h1NormOn h1Square
  rw [integral_add hvalue hsum]
  unfold gradientSquare
  rw [integral_finsetSum _ (fun i _ => hgradient i)]

end Theorem11
