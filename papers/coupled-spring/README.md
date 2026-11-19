<!-- Written by tools/markdown_edition.py from paper.md, links.json and the Lean. Edit those, then run it again. -->

# A minimum of the coupled spring potential

*The second-derivative test in a Lean file by Bjørn Kjos-Hanssen, written out.*

*Written by AI agents under Will Cook's direction, 17 November 2026, revised 19 November.
Neither the author of the Lean nor a physicist has reviewed it. Section 7 says who wrote what.*

[Read it with the Lean beside it](https://wcook04.github.io/proof-reader/#/coupled-spring) · [Lean source](https://github.com/leanprover-community/physlib/tree/be0a9eef7dac78da524bfbde91c812340b194610) · Each ▸ **Lean** under a paragraph opens the statements that paragraph is about.

## Abstract

In PhyslibAlpha, Bjørn Kjos-Hanssen proves in Lean that the coupled spring potential
U(x₀, x₁) = x₀² + x₀x₁ + x₁² has a local minimum at the origin. He does it by applying a
general second-derivative test, proved in a companion file, and describes the file as a proof
of concept for that test. The test has hypotheses only about the behaviour of a function near
the point, and for U each of them can be checked by hand. Because U is quadratic, completing
the square gives a second, shorter proof with a stronger conclusion, that the origin is the unique
global minimum. This page writes out both proofs, shows which Lean
statements carry each step, and explains what the second derivative of U means for two
masses joined by springs. It is written for a reader who knows multivariable calculus and has
not read the Lean.

Lean declarations are cited [1] to [13] and other sources {1} to {5}, as in Physlib's API maps.
Both lists are at the end.

## 1. The potential and a spring system with this energy

The function

U(x₀, x₁) = x₀² + x₀x₁ + x₁²

on ℝ² is called the coupled spring potential in PhyslibAlpha {1}. In that file
Bjørn Kjos-Hanssen proves in Lean that U has a local minimum at the origin [6]. The file
names no particular physical system [1]. The system below is one reading of U, chosen for this
page.

<details>
<summary><b>Lean</b> · The coupled spring potential · <code>couplingPotential</code></summary>

```lean
/-- The potential energy of a pair of coupled springs. -/
noncomputable def couplingPotential (x : EuclideanSpace ℝ (Fin 2)) : ℝ :=
  (x 0) ^ 2 + x 0 * x 1 + (x 1) ^ 2
```

Copied whole from [CoupledSpringPotential.lean, lines 56–57][couplingPotential] in Physlib at be0a9ee.

</details>

Two masses lie on a line between two walls. Each mass is joined to the nearer wall by a spring,
and the two masses are joined by a third spring. All three springs have spring constant k and
are at their natural lengths when both masses are at their equilibrium positions. Let x₀ and
x₁ be the displacements of the two masses from those positions, each measured positive
towards the other mass. Then the left spring is stretched by x₀, the right spring is stretched
by x₁, and the middle spring is shortened by x₀ + x₁. Each stretch or shortening can be
negative. The energy stored in the three springs is

½k x₀² + ½k x₁² + ½k (x₀ + x₁)² = k U(x₀, x₁).

So U is the spring energy in units of k. The sign of the cross term comes from the choice of
directions. If both displacements are measured positive to the right, the middle spring changes
length by x₁ − x₀ and the energy is k(x₀² − x₀x₁ + x₁²), which is kU with x₁ replaced
by −x₁.

## 2. The second-derivative test

For a function f on a real inner product space V, write Df(a) for its derivative at a, a
linear map V → ℝ, and D²f(a) for its second derivative at a, a bilinear map
V × V → ℝ.

**Theorem 2.1 (second-derivative test).** Let V be a finite-dimensional real inner product
space, let f: V → ℝ and let a ∈ V. Suppose that f is analytic at a, that the
gradient of f at a is zero, and that the second derivative of f at a is positive definite:
D²f(a)(y, y) > 0 for every y ≠ 0. Then f has a local minimum at a: there is a neighbourhood
of a on which f(a) ≤ f(x). [7][8]

<details>
<summary><b>Lean</b> · The second-derivative test · <code>second_derivative_test_analyticAt</code></summary>

```lean
/--
A more convenient form of the second partial derivative test: it suffices that `f`
is analytic at `x₀` (so that an explicit power series need not be produced by hand).
-/
theorem second_derivative_test_analyticAt {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℝ V] [FiniteDimensional ℝ V] {f : V → ℝ} {x₀ : V}
    (h₀ : gradient f x₀ = 0) (han : AnalyticAt ℝ f x₀)
    (hf : (iteratedFDerivQuadraticMap f x₀).PosDef) : IsLocalMin f x₀ := by
```

Statement copied from [PartialDerivativeTest.lean, lines 600–606][second_derivative_test_analyticAt] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Theorem 2.1 and the Lean statement have the same hypotheses and the same conclusion. Both ask for a finite-dimensional real inner product space, a function analytic at the point, a gradient equal to zero there and a positive definite second derivative there, and both conclude a local minimum with a weak inequality on a neighbourhood. In the Lean, positive definite is said of the quadratic map that sends y to the second derivative at (y, y), and the gradient condition is the equation gradient f x₀ = 0.

</details>

The hypotheses are sufficient and not necessary. Section 6 gives a function with a minimum whose
second derivative is not positive definite.

The companion file proves the theorem in four steps.

First, y ↦ D²f(a)(y, y) is packaged as a quadratic map on V, so that "positive definite"
has its usual meaning [8].

<details>
<summary><b>Lean</b> · Second derivative as a quadratic map · <code>iteratedFDerivQuadraticMap</code></summary>

```lean
/-- The second iterated Frechét derivative as a quadratic map. -/
noncomputable def iteratedFDerivQuadraticMap {V : Type*} [NormedAddCommGroup V]
    [NormedSpace ℝ V] (f : V → ℝ) (x₀ : V) : QuadraticMap ℝ V ℝ := {
  toFun := fun y => iteratedFDeriv ℝ 2 f x₀ ![y,y]
  exists_companion' := ⟨hessianBilinearCompanion f x₀, fun x y => by
    have ha (u v b) := (iteratedFDeriv ℝ 2 f x₀).map_update_add' ![u,v] b x y
    have ha₀ := ha x (x + y) 0
    have ha₁ (u) := ha u x 1
    simp only [update₀, MultilinearMap.toFun_eq_coe, coe_coe, update₁, hessianBilinearCompanion]
        at ha₀ ha₁ ha ⊢
    rw [ha₀, ha₁, ha₁, add_assoc, add_assoc]
    apply add_left_cancel_iff.mpr
    rw [← add_assoc, add_comm]
    simp⟩
  toFun_smul := fun u v => by
    have hsm (b c) := (iteratedFDeriv ℝ 2 f x₀).map_update_smul' ![b,v] c u v
    have hsm₀ := hsm v 0
    have hsm₁ := hsm (u • v) 1
    simp only [update₀, update₁, MultilinearMap.toFun_eq_coe, coe_coe, smul_eq_mul]
        at hsm₀ hsm₁ hsm
    rw [smul_eq_mul, mul_assoc, ← hsm₀, hsm₁]}
```

Copied whole from [PartialDerivativeTest.lean, lines 107–126][iteratedFDerivQuadraticMap] in Physlib at be0a9ee.

</details>

Second, a positive definite form is bounded below by a multiple of the squared norm: there is
C > 0 with D²f(a)(y, y) ≥ C‖y‖² for every y. [9] If V = {0} there is nothing to
prove, and the file treats that case on its own. Otherwise the unit sphere of V is compact,
because V is finite-dimensional, so the continuous map y ↦ D²f(a)(y, y) attains a
minimum C on it, and C > 0. Scaling a unit vector by t multiplies the form by t², which
gives the bound for every y. In an infinite-dimensional space a form can be positive in every
direction and have no such C.

<details>
<summary><b>Lean</b> · Positive definite gives a lower bound · <code>coercive_of_posdef</code></summary>

```lean
/-- Positive definiteness implies coercivity. -/
lemma coercive_of_posdef {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    [FiniteDimensional ℝ V] {f : V → ℝ} {x₀ : V}
    (hf' : (iteratedFDerivQuadraticMap f x₀).PosDef) :
    IsCoercive (continuousBilinearMapOfContinuousMultilinearMap
        (iteratedFDeriv ℝ 2 f x₀)) := by
```

Statement copied from [PartialDerivativeTest.lean, lines 455–505][coercive_of_posdef] in Physlib at be0a9ee; the proof is at the link.

</details>

Third, the second-order Taylor polynomial of f at a approximates f with an error smaller than
any fixed multiple of ‖x − a‖² once x is close enough to a. [10] The file proves
this estimate from the power series of f at a, which is the first use of analyticity.

<details>
<summary><b>Lean</b> · Taylor error from a power series · <code>littleO_of_powerseries</code></summary>

```lean
/-- Having a power series implies quadratic approximation. -/
lemma littleO_of_powerseries {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    {f : V → ℝ} {x₀ : V} {p : FormalMultilinearSeries ℝ V ℝ}
    {r : NNReal} (h : HasFPowerSeriesOnBall f p x₀ r) :
    (fun x => f x - p.partialSum 3 (x - x₀)) =o[nhds x₀] fun x => ‖x - x₀‖ ^ 2 := by
```

Statement copied from [PartialDerivativeTest.lean, lines 558–568][littleO_of_powerseries] in Physlib at be0a9ee; the proof is at the link.

</details>

Fourth, the two estimates are compared. [11] With the gradient zero, the Taylor polynomial is
f(a) + ½D²f(a)(x − a, x − a). Choosing the neighbourhood so that the error is at most
½C‖x − a‖² gives, for every x in it,

f(x) − f(a) ≥ ½C‖x − a‖² − ½C‖x − a‖² = 0.

<details>
<summary><b>Lean</b> · 2 statements: The test from a Taylor error bound; Comparison from the Taylor error</summary>

**The test from a Taylor error bound** · `isLocalMin_of_posDef_of_littleo`

```lean
/-- Second partial derivative test, "little oh" form. -/
theorem isLocalMin_of_posDef_of_littleo {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℝ V] [FiniteDimensional ℝ V] {f : V → ℝ} {x₀ : V}
    (h : (fun x => f x - ∑ i ∈ range 3, 1 / (i)! * iteratedFDeriv ℝ i f x₀ fun _ => x - x₀)
      =o[nhds x₀] fun x => ‖x - x₀‖ ^ 2) (h₀ : gradient f x₀ = 0) (hcd : ContDiffAt ℝ ⊤ f x₀)
    (hf : (iteratedFDerivQuadraticMap f x₀).PosDef) : IsLocalMin f x₀ := by
```

Statement copied from [PartialDerivativeTest.lean, lines 534–554][isLocalMin_of_posDef_of_littleo] in Physlib at be0a9ee; the proof is at the link.

**Comparison from the Taylor error** · `le_of_littleO`

```lean
theorem le_of_littleO {V : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    {f : V → ℝ} {x₀ x : V} {C : ℝ}
    (hx : C * (‖x - x₀‖ ^ 2) ≤ iteratedFDeriv ℝ 2 f x₀ fun _ ↦ x - x₀)
    (hx₀ : fderiv ℝ f x₀ x = fderiv ℝ f x₀ x₀)
    (h₁ : ‖f x - ∑ i ∈ range 3, 1 / ↑i ! * iteratedFDeriv ℝ i f x₀ fun _ ↦ x - x₀‖
      ≤ C / 2 * ‖x - x₀‖ ^ 2) :
  f x₀ ≤ f x := by
```

Statement copied from [PartialDerivativeTest.lean, lines 514–530][le_of_littleO] in Physlib at be0a9ee; the proof is at the link.

</details>

Analyticity is assumed for two reasons: the error estimate, and the symmetry of the second
derivative, which the file proves from analyticity at a. Any f with those two properties at a
would do, for example one that is twice
continuously differentiable near a, as in the usual statement of the test {5}. The Lean theorem
is stated for analytic f.

<details>
<summary><b>Lean</b> · The second derivative is symmetric · <code>iteratedFDeriv_two_swap</code></summary>

```lean
/--
Symmetry of the second iterated Fréchet derivative (Schwarz's theorem).
-/
lemma iteratedFDeriv_two_swap {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    {f : V → ℝ} {x₀ : V} (hf : ContDiffAt ℝ ⊤ f x₀) (x y : V) :
    iteratedFDeriv ℝ 2 f x₀ ![y, x] = iteratedFDeriv ℝ 2 f x₀ ![x, y] := by
```

Statement copied from [PartialDerivativeTest.lean, lines 415–425][iteratedFDeriv_two_swap] in Physlib at be0a9ee; the proof is at the link.

</details>

Choosing the error at most ¼C‖x − a‖² instead gives
f(x) − f(a) ≥ ¼C‖x − a‖² > 0 for every x ≠ a near a, a strict local minimum.
That follows from the same estimates, but the Lean theorem states only the weak inequality.

## 3. The hypotheses for the potential

**Analytic.** U is a polynomial in the two coordinates, so it is analytic at every point. [2]

<details>
<summary><b>Lean</b> · The potential is analytic · <code>couplingPotential_analyticAt</code></summary>

```lean
/-
The coupling potential is analytic everywhere (it is a polynomial).
-/
lemma couplingPotential_analyticAt (z : EuclideanSpace ℝ (Fin 2)) :
    AnalyticAt ℝ couplingPotential z := by
```

Statement copied from [CoupledSpringPotential.lean, lines 68–75][couplingPotential_analyticAt] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the potential is analytic at every point z of the plane. The Lean statement quantifies over z in EuclideanSpace ℝ (Fin 2), which is the plane with its usual inner product.

</details>

**Zero gradient.** For every x and h in ℝ², expanding the squares gives

U(x + h) = U(x) + (2x₀ + x₁)h₀ + (x₀ + 2x₁)h₁ + U(h).

The two middle terms are linear in h, and U(h) ≤ (3/2)‖h‖², so the derivative
of U at x is

DU(x)(h) = (2x₀ + x₁)h₀ + (x₀ + 2x₁)h₁.

<details>
<summary><b>Lean</b> · Derivative of the potential · <code>couplingPotential_hasFDerivAt</code></summary>

```lean
/-
The derivative of the coupling potential at any point, as an explicit
linear functional.
-/
lemma couplingPotential_hasFDerivAt (x : EuclideanSpace ℝ (Fin 2)) :
    HasFDerivAt couplingPotential
      ((2 * x 0 + x 1) • (EuclideanSpace.proj (𝕜 := ℝ) 0)
        + (x 0 + 2 * x 1) • (EuclideanSpace.proj (𝕜 := ℝ) 1)) x := by
```

Statement copied from [CoupledSpringPotential.lean, lines 81–92][couplingPotential_hasFDerivAt] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Both give the derivative at every point x as the linear map with coefficients 2x₀ + x₁ and x₀ + 2x₁. The Lean writes the map as a combination of the two coordinate projections.

</details>

At the origin both coefficients are zero, so the gradient of U at the origin is zero. [3]

<details>
<summary><b>Lean</b> · Zero gradient at the origin · <code>couplingPotential_gradient_zero</code></summary>

```lean
/-
The gradient of the coupling potential vanishes at the origin.
-/
lemma couplingPotential_gradient_zero :
    gradient couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) = 0 := by
```

Statement copied from [CoupledSpringPotential.lean, lines 97–101][couplingPotential_gradient_zero] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the gradient of the potential at the origin is zero. The Lean writes the origin as !₂[0, 0].

</details>

**Second derivative.** Differentiating the two coefficients gives, at every point x and for every
y and h,

D²U(x)(y, h) = 2y₀h₀ + y₀h₁ + y₁h₀ + 2y₁h₁.

<details>
<summary><b>Lean</b> · Second derivative of the potential · <code>couplingPotential_iteratedFDeriv_two</code></summary>

```lean
/-
The value of the second derivative quadratic map of the coupling potential.
-/
lemma couplingPotential_iteratedFDeriv_two (z : EuclideanSpace ℝ (Fin 2))
    (a b : EuclideanSpace ℝ (Fin 2)) :
    iteratedFDeriv ℝ 2 couplingPotential z ![a, b]
      = 2 * a 0 * b 0 + a 0 * b 1 + a 1 * b 0 + 2 * a 1 * b 1 := by
```

Statement copied from [CoupledSpringPotential.lean, lines 106–130][couplingPotential_iteratedFDeriv_two] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Both give 2y₀h₀ + y₀h₁ + y₁h₀ + 2y₁h₁ for the second derivative at every point, applied to two vectors. The Lean names the vectors a and b and the point z.

</details>

[4] This is the same bilinear map at every point, with matrix

K = [[2, 1], [1, 2]].

Because U is quadratic, its Taylor expansion at the origin ends at second order:
U(x) = ½D²U(0)(x, x) exactly, with no error term.

**Positive definite.** Setting h = y,

D²U(0)(y, y) = 2U(y) = y₀² + y₁² + (y₀ + y₁)².

So the second derivative at the origin is positive definite. [5] Dropping the last square gives
D²U(0)(y, y) ≥ ‖y‖², so the constant of the second step is C = 1. On the unit circle
the minimum is attained at y = (1, −1)/√2, where the last square is zero.

<details>
<summary><b>Lean</b> · Positive definite at the origin · <code>couplingPotential_posDef</code></summary>

```lean
/-
The second derivative quadratic map of the coupling potential is positive definite
at the origin.
-/
lemma couplingPotential_posDef :
    (iteratedFDerivQuadraticMap couplingPotential
    (!₂[0, 0] : EuclideanSpace ℝ (Fin 2))).PosDef := by
```

Statement copied from [CoupledSpringPotential.lean, lines 142–151][couplingPotential_posDef] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the second derivative at the origin is positive definite. The page also gives the identity D²U(0)(y, y) = 2U(y) and the bound D²U(0)(y, y) ≥ ‖y‖², which are not in the Lean statement.

</details>

**Theorem 3.1 (Kjos-Hanssen, proved in Lean).** The coupled spring potential U has a local
minimum at the origin. [6]

<details>
<summary><b>Lean</b> · Local minimum at the origin · <code>coupled_spring_potential</code></summary>

```lean
lemma coupled_spring_potential :
    let U := fun x : EuclideanSpace ℝ (Fin 2) => (x 0)^2 + x 0 * x 1 + (x 1)^2
    IsLocalMin U {
        ofLp := ![0,0]
    } := by
```

Statement copied from [CoupledSpringPotential.lean, lines 153–160][coupled_spring_potential] in Physlib at be0a9ee; the proof is at the link.

**Comparison with the page, made by AI and not reviewed: same statement.** Theorem 3.1 and the Lean statement both say that the potential has a local minimum at the origin, with a weak inequality on a neighbourhood. The Lean statement writes the potential out as a function on EuclideanSpace ℝ (Fin 2) instead of naming couplingPotential. Proposition 4.1 says more, a strict inequality at every other point of the plane. It is not in the author's files. The Lean statement of it written for this page is shown under it.

</details>

*Proof.* Apply Theorem 2.1 with V = ℝ², f = U and a = 0. The three hypotheses are the
first, second and fourth paragraphs of this section. ∎

<details>
<summary><b>Lean proof</b> · Local minimum at the origin · <code>coupled_spring_potential</code></summary>

```lean
lemma coupled_spring_potential :
    let U := fun x : EuclideanSpace ℝ (Fin 2) => (x 0)^2 + x 0 * x 1 + (x 1)^2
    IsLocalMin U {
        ofLp := ![0,0]
    } := by
  show IsLocalMin couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2))
  exact second_derivative_test_analyticAt couplingPotential_gradient_zero
    (couplingPotential_analyticAt _) couplingPotential_posDef
```

Copied whole from [CoupledSpringPotential.lean, lines 153–160][coupled_spring_potential] in Physlib at be0a9ee.

</details>

## 4. The second proof, by completing the square

Completing the square in x₀ gives

U(x) = (x₀ + ½x₁)² + ¾x₁²

for every x. [12]

**Proposition 4.1.** For every x ≠ 0 in ℝ² we have U(x) > U(0). In particular the
origin is the unique global minimum of U. [13]

<details>
<summary><b>Lean proof</b> · At every point other than the origin the coupled spring potential is larger than at the origin · <code>couplingPotential_origin_lt</code></summary>

```lean
/-- At every point other than the origin the coupled spring potential is larger than at the
origin. -/
theorem couplingPotential_origin_lt (x : EuclideanSpace ℝ (Fin 2)) (hx : x ≠ 0) :
    couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) < couplingPotential x := by
  have h0 : couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) = 0 := by
    first
      | simp [couplingPotential]
      | norm_num [couplingPotential]
  rw [h0]
  exact couplingPotential_pos x hx
```

Written by AI for this page and accepted by Lean against the two files: [checks/StrictMinimum.lean, lines 32–41][couplingPotential_origin_lt]. It is not in Physlib.

</details>

*Proof.* Both terms of the identity are squares, so U(x) ≥ 0 = U(0). If U(x) = 0 then both terms
are zero, so x₁ = 0 and then x₀ = 0. ∎

The proof by completing the square depends on an identity that holds on the whole plane because
U is a quadratic form, and its conclusion is a strict inequality everywhere. The hypotheses of the
second-derivative test concern only f near the point, and its conclusion is only local. In return
it applies to every analytic function whose second derivative is positive definite at a critical
point, including functions with no identity of this kind, such as W in Section 6. For U the
test proves less than the identity does. That suits a proof of concept: each hypothesis can be
checked by hand, and the conclusion can be compared with the global argument.

## 5. What the minimum means for the masses

This section is about the spring system of Section 1 and is not in the Lean. It assumes point
masses m that move along the line without friction, ideal springs that obey Hooke's law and have
no mass, and Newton's laws. It ignores the walls and collisions, so the masses can be anywhere in
ℝ²; a real system allows only displacements smaller than the gaps.

The force on each mass, measured in that mass's own positive direction, is −k times the partial
derivative of U: −k(2x₀ + x₁) on the left mass and −k(x₀ + 2x₁) on the right mass. For
example, move the left mass a distance d towards the right mass and hold the right mass at its
equilibrium position. The left mass then feels −2kd: both springs push it back. The right mass
feels −kd in its own positive direction, that is, the shortened middle spring pushes it towards
its wall. The zero gradient at the origin says that both forces vanish there.

The kinetic energy is ½m(ẋ₀² + ẋ₁²), so the equations of motion are
mẍ = −kKx. Since the mass matrix is m times the identity, the normal modes are the
eigenvectors of K {3}. In the coordinates

q₋ = (1/√2)(x₀ − x₁),  q₊ = (1/√2)(x₀ + x₁),

the energy is kU = ½k (q₋² + 3q₊²), and each coordinate oscillates on its own:
q₋ with angular frequency √(k/m) and q₊ with angular frequency √(3k/m). In the
first mode the two masses move the same distance in the same direction, so the middle spring keeps
its length. In the second they move in opposite directions, so the middle spring is alternately
shortened and stretched and adds to the restoring force.

Because the second derivative is positive definite, the equilibrium is stable. The total energy
½m(ẋ₀² + ẋ₁²) + kU(x) is conserved, and kU(x) ≥ ½k‖x‖²
by Section 3, so a motion that starts near equilibrium with little energy stays near it. Without
friction the masses keep oscillating and do not return to rest.

## 6. Changed cases

**Question 1.** Replace U by U_c(x) = x₀² + c x₀x₁ + x₁² for a real number c. For which
c is the origin a minimum, and for which does Theorem 2.1 apply?

**Question 2.** Replace U by W(x) = U(x) + x₀³. Which of Theorem 3.1 and Proposition 4.1 hold
for W?

**Answer 1.** The gradient of U_c at the origin is zero for every c, and

D²U_c(0)(y, y) = 2y₀² + 2c y₀y₁ + 2y₁².

Completing the square in y₀,

D²U_c(0)(y, y) = 2(y₀ + (c/2)y₁)² + (2 − c²/2)y₁².

| c | At the origin |
| --- | --- |
| \|c\| < 2 | The unique global minimum, and Theorem 2.1 applies |
| c = 2 or c = −2 | A global minimum that is not unique, and Theorem 2.1 does not apply |
| \|c\| > 2 | Not a local minimum |

For |c| < 2 both coefficients are positive, so the second derivative is positive
definite, and since U_c(x) = ½D²U_c(0)(x, x) the same identity shows that U_c(x) > 0 for
x ≠ 0. At c = 2 we have U₂(x) = (x₀ + x₁)², which is zero on the whole line x₀ = −x₁, and at
c = −2 we have U₋₂(x) = (x₀ − x₁)², which is zero on the line x₀ = x₁. In both cases the
origin is a global minimum, the second derivative is zero in one direction, and Theorem 2.1 does
not apply. For c > 2, U_c(t, −t) = (2 − c)t² < 0 for every t ≠ 0, and for c < −2,
U_c(t, t) = (2 + c)t² < 0, so the origin is not a local minimum.

In the spring system, give the wall springs constants k₁ and k₂ and the middle spring constant
k. In the coordinates of Section 1 the energy is
½(k₁ + k)x₀² + ½(k₂ + k)x₁² + k x₀x₁, and its second derivative is positive
definite exactly when k² < (k₁ + k)(k₂ + k), that is, when k₁k₂ + k(k₁ + k₂) > 0. With all three
constants positive this always holds. It fails when both wall springs are removed: then the
energy is zero along x₀ = −x₁, where the two masses slide together and the middle spring keeps
its length. This is the case c = 2. Springs with positive constants never give c > 2, which would
need a negative spring constant.

**Answer 2.** The term x₀³ has first derivative 3x₀² and second derivative 6x₀ in the
direction of x₀, and both are zero at the origin. So W is analytic and has the same gradient
and the same second derivative at the origin as U, and Theorem 2.1 gives a local minimum of W
at the origin. Proposition 4.1 fails for W: W(−2, 0) = −4 < W(0), and W(t, 0) = t² + t³ is unbounded
below as t → −∞. So for W the test gives a local minimum that is not a global one.

## 7. What has been checked, and who wrote what

Bjørn Kjos-Hanssen wrote the two Lean files in PhyslibAlpha {1}{2}. Lean 4.35.0 compiled them at
Physlib commit be0a9ee. The statements cited [1] to [11] are in them, including every statement of
Section 3 and Theorem 2.1.

Comparator {4} checked one further point about Theorem 3.1. The Lean statement writes the
potential out in Mathlib's own terms. In a sandbox, Comparator confirmed that the proof in Physlib
proves exactly that statement, using only Lean's three standard axioms, against a copy of the
statement that imports only Mathlib. The same run rejected a copy with "local maximum" in place of
"local minimum". So the theorem proved in Physlib can be read using Mathlib's definitions alone.
Comparator does not check the spring system or any sentence of this page.

AI agents wrote this page under Will Cook's direction: the prose, the spring system, Sections 5
and 6, the links from sentences to the Lean, the comparisons of each statement with its Lean, and
the two Lean files cited [12] and [13]. Lean accepts the statements in those two files against the
Physlib files. They are not part of Physlib. Building the page checks that every linked sentence
appears in the text. Nobody has checked whether each sentence and its Lean say the same thing, and
no physicist has reviewed Sections 1, 5 or 6.

## Statements and comparisons

The statements on this page that were compared with a Lean declaration, and the Lean statements written for this page. The comparisons were made by AI and have not been reviewed.

| Statement on this page | Lean | Comparison with the page |
| --- | --- | --- |
| The second-derivative test | [`second_derivative_test_analyticAt`][second_derivative_test_analyticAt] | Same statement |
| The potential is analytic | [`couplingPotential_analyticAt`][couplingPotential_analyticAt] | Same statement |
| Derivative of the potential | [`couplingPotential_hasFDerivAt`][couplingPotential_hasFDerivAt] | Same statement |
| Zero gradient at the origin | [`couplingPotential_gradient_zero`][couplingPotential_gradient_zero] | Same statement |
| Second derivative of the potential | [`couplingPotential_iteratedFDeriv_two`][couplingPotential_iteratedFDeriv_two] | Same statement |
| Positive definite at the origin | [`couplingPotential_posDef`][couplingPotential_posDef] | Same statement |
| Local minimum at the origin | [`coupled_spring_potential`][coupled_spring_potential] | Same statement |
| At every point other than the origin the coupled spring potential is larger than at the origin | [`couplingPotential_origin_lt`][couplingPotential_origin_lt] | Written by AI for this page; not in Physlib |

## Lean References

1. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential`
2. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_analyticAt`
3. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_hasFDerivAt`,
   `couplingPotential_gradient_zero`
4. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_iteratedFDeriv_two`
5. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_posDef`
6. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `coupled_spring_potential`
7. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `second_derivative_test_analyticAt`,
   `second_derivative_test`
8. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `iteratedFDerivQuadraticMap`
9. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `coercive_of_posdef`
10. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `littleO_of_powerseries`
11. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `isLocalMin_of_posDef_of_littleo`,
    `le_of_littleO`, `iteratedFDeriv_two_swap`
12. checks/GlobalMinimum.lean, written for this page — `couplingPotential_eq_sq_add_sq`
13. checks/StrictMinimum.lean, written for this page — `couplingPotential_origin_lt`

## References

1. Bjørn Kjos-Hanssen, CoupledSpringPotential.lean, PhyslibAlpha, Physlib at commit be0a9ee,
   https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean
2. Bjørn Kjos-Hanssen, PartialDerivativeTest.lean, PhyslibAlpha, Physlib at commit be0a9ee,
   https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean
3. Wikipedia, Normal mode, section Coupled oscillators, https://en.wikipedia.org/wiki/Normal_mode
4. Comparator, https://github.com/leanprover/comparator. The run for this page: challenge,
   configuration and receipt at
   https://github.com/wcook04/proof-reader/tree/f5f5e6f81251f766b0a705d46960e47e8b8a8962/papers/coupled-spring/comparator
5. Wikipedia, Second partial derivative test, https://en.wikipedia.org/wiki/Second_partial_derivative_test

[couplingPotential]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L56-L57
[second_derivative_test_analyticAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L600-L606
[iteratedFDerivQuadraticMap]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L107-L126
[coercive_of_posdef]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L455-L505
[littleO_of_powerseries]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L558-L568
[isLocalMin_of_posDef_of_littleo]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L534-L554
[le_of_littleO]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L514-L530
[iteratedFDeriv_two_swap]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L415-L425
[couplingPotential_analyticAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L68-L75
[couplingPotential_hasFDerivAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L81-L92
[couplingPotential_gradient_zero]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L97-L101
[couplingPotential_iteratedFDeriv_two]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L106-L130
[couplingPotential_posDef]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L142-L151
[coupled_spring_potential]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L153-L160
[couplingPotential_origin_lt]: https://github.com/wcook04/proof-reader/blob/main/papers/coupled-spring/checks/StrictMinimum.lean#L32-L41
