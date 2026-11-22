import TorusEuler.Paper.Spine

/-! # The extension used in Remark 1.2

The auxiliary note distinguishes an existence theorem for a selected
construction from stronger assertions for every construction and every
threshold satisfying stated estimates. This file exposes only the
proved existence conclusion, including the actual open neighborhood
and the extended field. It does not assert the broader universal
auxiliary statements.
-/

open TorusEuler TorusEuler.Paper Set
open scoped ContDiff

namespace Adapted.Auxiliary

/-- The solution of Theorem 1.1 may be chosen so that its restriction to
`[0,T_*) × (𝕋³ \ {0})` extends smoothly in space and time through `T_*`
away from the origin. All conclusions of Theorem 1.1 hold for that same
solution. No Euler equation is imposed on the extension after `T_*`.

The open set `O` contains the whole terminal slice away from the integer
lattice, and `g` is one periodic extension agreeing with `u` before the
terminal time. This is an existence theorem, not a statement about
every threshold function allowed by the auxiliary note. -/
theorem exists_smooth_terminal_extension :
    ∃ (u₀ : Vec3 → Vec3) (T : ℝ) (u : Velocity) (p : Pressure),
      EulerSingularityWitness u₀ T u p ∧
      (∀ (T' : ℝ) (v : Velocity) (q : Pressure),
        IsMaximalEulerSolution T' v q → v 0 = u₀ → T' = T ∧ EqOn v u (Ico 0 T)) ∧
      ∃ (O : Set (ℝ × Vec3)) (g : Velocity),
        IsOpen O ∧ ({T} : Set ℝ) ×ˢ offOrigin ⊆ O ∧
        ContDiffOn ℝ ∞ (Function.uncurry g) (Ico 0 T ×ˢ offOrigin ∪ O) ∧
        (∀ t : ℝ, SpatiallyPeriodic (g t)) ∧
        EqOn (Function.uncurry g) (Function.uncurry u) (Ico 0 T ×ˢ offOrigin) := by
  obtain ⟨u₀, T, u, p, hw, hunique, hext⟩ := TorusEuler.Paper.remark_1_2
  exact ⟨u₀, T, u, p, hw, hunique, hext⟩

end Adapted.Auxiliary
