<!-- Written by tools/markdown_edition.py from paper.md, links.json and the Lean. Edit those, then run it again. -->

# A minimum of the coupled spring potential

## The second-derivative test in a Lean file by Bjørn Kjos-Hanssen, written out

*Explanatory reconstruction prepared by Will Cook with AI assistance · 17 November 2026.*

Lean formalization: Bjørn Kjos-Hanssen, in PhyslibAlpha.

[Read it with the Lean beside it](https://wcook04.github.io/proof-reader/#/coupled-spring) · [Lean source](https://github.com/leanprover-community/physlib/tree/be0a9eef7dac78da524bfbde91c812340b194610) · Each ▸ **Lean** under a paragraph opens the statements that paragraph is about.

| Statement on this page | Lean | Comparison with the page |
| --- | --- | --- |
| The second-derivative test | [`second_derivative_test_analyticAt`][second_derivative_test_analyticAt] | Same statement |
| The potential is analytic | [`couplingPotential_analyticAt`][couplingPotential_analyticAt] | Same statement |
| Derivative of the potential | [`couplingPotential_hasFDerivAt`][couplingPotential_hasFDerivAt] | Same statement |
| Zero gradient at the origin | [`couplingPotential_gradient_zero`][couplingPotential_gradient_zero] | Same statement |
| Second derivative of the potential | [`couplingPotential_iteratedFDeriv_two`][couplingPotential_iteratedFDeriv_two] | Same statement |
| Positive definite at the origin | [`couplingPotential_posDef`][couplingPotential_posDef] | Same statement |
| Local minimum at the origin | [`coupled_spring_potential`][coupled_spring_potential] | Same statement |
| At every point the coupled spring potential is at least its value at the origin | [`couplingPotential_origin_le`][couplingPotential_origin_le] | Written for this page; not in Physlib |
| Away from the origin the coupled spring potential is strictly positive | [`couplingPotential_pos`][couplingPotential_pos] | Written for this page; not in Physlib |

## Introduction

The function

U(x₀, x₁) = x₀² + x₀x₁ + x₁²

<details>
<summary><b>Lean</b> · The coupled spring potential · <code>couplingPotential</code></summary>

```lean
/-- The potential energy of a pair of coupled springs. -/
noncomputable def couplingPotential (x : EuclideanSpace ℝ (Fin 2)) : ℝ :=
```

Statement copied from [CoupledSpringPotential.lean, lines 56–57][couplingPotential] in Physlib at be0a9ee; the proof is at the link.

</details>

on ℝ² is called the coupled spring potential in
[PhyslibAlpha][file]. In that file Bjørn Kjos-Hanssen proves in Lean that
U has a local minimum at the origin. The proof applies a
second-derivative test, which he proves in a [companion file][test], and
the file is described there as a proof of concept for the test.

These notes are for a reader who knows partial derivatives and has not
read the Lean. In Sections 1 to 4 we write out the argument of the file:
the potential, the test, its three hypotheses for U, and the
conclusion. In Section 5 we give a second argument, by completing the
square, which shows that the origin is the unique global minimum. That
argument is ours and does not appear in the file. In Section 6 we change
the potential and ask which conclusions still hold, and in Section 7 we
say which statements are proved in Lean.

## 1. The potential

Write x = (x₀, x₁). Three values are

U(1, 0) = 1,  U(1, 1) = 3,  U(1, −1) = 1.

Without the cross term x₀x₁ the last two values would both be 2.
The cross term adds energy when the coordinates have the same sign and
removes energy when they have opposite signs.

In the file U is described as the potential energy of a pair of coupled
springs, and no particular system is specified. One system with this
energy is the following. Two masses lie on a line between two walls. Each
mass is joined to the nearer wall by a spring, and the masses are joined
to each other by a third spring, all three with spring constant 1. Let
x₀ and x₁ be the displacements of the two masses towards each
other. The two wall springs are stretched by x₀ and x₁ and store
½x₀² and ½x₁². The middle spring is compressed by
x₀ + x₁ and stores ½(x₀ + x₁)². The sum of the three energies
is U(x₀, x₁). This reading of U is ours.

## 2. The second-derivative test

For a function f on a real inner product space V, write Df(a) for
its derivative at a, a linear map V → ℝ, and D²f(a) for
its second derivative at a, a bilinear map V × V → ℝ.

**Theorem 2.1 (second-derivative test).** Let V be a finite-dimensional
real inner product space, let f: V → ℝ and let a ∈ V. Suppose
that f is analytic at a, that the gradient of f at a is zero, and
that the second derivative of f at a is positive definite:
D²f(a)(y, y) > 0 for every y ≠ 0. Then f has a local minimum at a:
there is a neighbourhood of a on which f(a) ≤ f(x).

<details>
<summary><b>Lean</b> · 2 statements: The second-derivative test; Second derivative as a quadratic map</summary>

**The second-derivative test** · `second_derivative_test_analyticAt`

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

**Comparison with the page: same statement.** Theorem 2.1 and the Lean statement have the same hypotheses and the same conclusion: a finite-dimensional real inner product space, a function analytic at the point, zero gradient there, a positive definite second derivative there, and a local minimum with a weak inequality on a neighbourhood. In the Lean the second derivative enters as the quadratic map sending y to its value at (y, y).

**Second derivative as a quadratic map** · `iteratedFDerivQuadraticMap`

```lean
/-- The second iterated Frechét derivative as a quadratic map. -/
noncomputable def iteratedFDerivQuadraticMap {V : Type*} [NormedAddCommGroup V]
    [NormedSpace ℝ V] (f : V → ℝ) (x₀ : V) : QuadraticMap ℝ V ℝ := {
```

Statement copied from [PartialDerivativeTest.lean, lines 107–126][iteratedFDerivQuadraticMap] in Physlib at be0a9ee; the proof is at the link.

</details>

The proof in the companion file has two inputs. A positive definite
quadratic form on a finite-dimensional space is bounded below by a
multiple of the squared norm, so there is a constant C > 0 with
D²f(a)(y, y) ≥ C‖y‖² for every y. Since f is analytic
at a, its second-order Taylor polynomial at a approximates it with an
error that is at most ½C‖x − a‖² for every x near
a. With the gradient zero, the Taylor polynomial is
f(a) + ½D²f(a)(x − a, x − a), and therefore

<details>
<summary><b>Lean</b> · 2 statements: Positive definite gives a lower bound; Taylor error from a power series</summary>

**Positive definite gives a lower bound** · `coercive_of_posdef`

```lean
/-- Positive definiteness implies coercivity. -/
lemma coercive_of_posdef {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    [FiniteDimensional ℝ V] {f : V → ℝ} {x₀ : V}
    (hf' : (iteratedFDerivQuadraticMap f x₀).PosDef) :
    IsCoercive (continuousBilinearMapOfContinuousMultilinearMap
        (iteratedFDeriv ℝ 2 f x₀)) := by
```

Statement copied from [PartialDerivativeTest.lean, lines 455–505][coercive_of_posdef] in Physlib at be0a9ee; the proof is at the link.

**Taylor error from a power series** · `littleO_of_powerseries`

```lean
/-- Having a power series implies quadratic approximation. -/
lemma littleO_of_powerseries {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    {f : V → ℝ} {x₀ : V} {p : FormalMultilinearSeries ℝ V ℝ}
    {r : NNReal} (h : HasFPowerSeriesOnBall f p x₀ r) :
    (fun x => f x - p.partialSum 3 (x - x₀)) =o[nhds x₀] fun x => ‖x - x₀‖ ^ 2 := by
```

Statement copied from [PartialDerivativeTest.lean, lines 558–568][littleO_of_powerseries] in Physlib at be0a9ee; the proof is at the link.

</details>

f(x) − f(a) ≥ ½C‖x − a‖² − ½C‖x − a‖² = 0.

<details>
<summary><b>Lean</b> · Comparison from the Taylor error · <code>le_of_littleO</code></summary>

```lean
/-- . -/
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

## 3. The three hypotheses for the potential

**Analytic.** Each coordinate map x ↦ xᵢ is linear and hence
analytic, and U is a sum of products of the two coordinate maps. So U
is analytic at every point.

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

**Comparison with the page: same statement.** Both say that the potential is analytic at every point of the plane.

</details>

**Zero gradient.** For every x and h in ℝ², expanding the
squares gives

U(x + h) = U(x) + (2x₀ + x₁)h₀ + (x₀ + 2x₁)h₁ + U(h).

The two middle terms are linear in h, and U(h) ≤ (3/2)‖h‖². So the derivative of U at x is the linear map

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

**Comparison with the page: same statement.** Both give the derivative at every point x as the linear map with coefficients 2x₀ + x₁ and x₀ + 2x₁. The Lean writes it as a combination of the two coordinate projections.

</details>

At x = (1, 0) this is 2h₀ + h₁. At the origin both coefficients are
zero, so the gradient of U at the origin is zero.

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

**Comparison with the page: same statement.** Both say that the gradient of the potential at the origin is zero.

</details>

**Second derivative.** The coefficients 2x₀ + x₁ and x₀ + 2x₁ are
linear in x. Differentiating them gives, at every point z and for
every a and b in ℝ²,

D²U(z)(a, b) = 2a₀b₀ + a₀b₁ + a₁b₀ + 2a₁b₁.

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

**Comparison with the page: same statement.** Both give the same formula for the second derivative at every point z and every pair of vectors a and b.

</details>

The second derivative of U is the same bilinear map at every point,
with matrix [[2, 1], [1, 2]].

**Positive definite.** Setting a = b = y at the origin,

D²U(0)(y, y) = 2y₀² + 2y₀y₁ + 2y₁² = y₀² + y₁² + (y₀ + y₁)².

The right-hand side is a sum of three squares, and it is zero only when
y₀ = y₁ = 0. So the second derivative of U at the origin is positive
definite. For y = (1, −1) the value is 2 and for y = (1, 1) it is 6.

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

**Comparison with the page: same statement.** Both say that the second derivative at the origin is positive definite. The page also notes that the second derivative is the same at every point; the Lean statement is about the origin only.

</details>

## 4. The local minimum

**Theorem 4.1 (Kjos-Hanssen, proved in Lean).** The coupled spring
potential U has a local minimum at the origin.

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

**Comparison with the page: same statement.** Theorem 4.1 and the Lean statement both say that the potential has a local minimum at the origin, with a weak inequality on a neighbourhood. Proposition 5.1 on the page says more than this Lean statement: a strict inequality at every other point of the plane. It is not in the author's files, and the two Lean proofs shown here, written for this page, prove it.

</details>

*Proof.* Apply Theorem 2.1 with V = ℝ², f = U and a = 0. The
three hypotheses are the first, second and fourth paragraphs of
Section 3. ∎

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

## 5. A global minimum, by completing the square

The argument of this section does not appear in the file. Completing the
square in x₀ gives, for every x in ℝ²,

U(x) = (x₀ + ½x₁)² + ¾x₁².

At x = (1, 1) the two terms are 9/4 and ¾, with sum 3.
Both terms are squares, so U(x) ≥ 0 = U(0). If U(x) = 0 then both terms
are zero, so x₁ = 0 and then x₀ = 0.

**Proposition 5.1.** For every x ≠ 0 in ℝ² we have
U(x) > U(0). In particular the origin is the unique global minimum of
U.

<details>
<summary><b>Lean</b> · 2 statements: At every point the coupled spring potential is at least its value at the origin; Away from the origin the coupled spring potential is strictly positive</summary>

**At every point the coupled spring potential is at least its value at the origin** · `couplingPotential_origin_le`

```lean
/-- At every point the coupled spring potential is at least its value at the origin. -/
theorem couplingPotential_origin_le (x : EuclideanSpace ℝ (Fin 2)) :
    couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) ≤ couplingPotential x := by
```

Written for this page and accepted by Lean against the two files: [checks/GlobalMinimum.lean, lines 16–20][couplingPotential_origin_le]. It is not in Physlib.

**Away from the origin the coupled spring potential is strictly positive** · `couplingPotential_pos`

```lean
/-- Away from the origin the coupled spring potential is strictly positive. -/
theorem couplingPotential_pos (x : EuclideanSpace ℝ (Fin 2)) (hx : x ≠ 0) :
    0 < couplingPotential x := by
```

Written for this page and accepted by Lean against the two files: [checks/StrictMinimum.lean, lines 3–30][couplingPotential_pos]. It is not in Physlib.

</details>

Proposition 5.1 says more than Theorem 4.1 in two ways. It holds on all
of ℝ², where Theorem 4.1 gives a neighbourhood of the origin,
and its inequality is strict. Its proof uses no derivative. It depends on
an identity that is available because U is a quadratic form. Theorem
2.1 uses only the first two derivatives of f at one point, so it also
applies to potentials for which no such identity is available, as in the
second question of Section 6.

## 6. Changed cases

**Question 1.** Replace U by U_c(x) = x₀² + c x₀x₁ + x₁² for a real
number c. For which c does the argument of Section 3 apply? What
happens at c = 2 and at c = 3?

**Question 2.** Replace U by W(x) = U(x) + x₀³. Which of Theorem 4.1
and Proposition 5.1 hold for W?

**Answer 1.** The gradient of U_c at the origin is zero for every c,
and

D²U_c(0)(y, y) = 2y₀² + 2c y₀y₁ + 2y₁² = 2(y₀ + (c/2)y₁)² + 2(1 − c²/4)y₁².

This is positive definite exactly when |c| < 2, and for those
c Theorem 2.1 gives a local minimum at the origin. At c = 2 we have
U₂(x) = (x₀ + x₁)² ≥ 0, so the origin is a global minimum of U₂,
although D²U₂(0)(y, y) = 0 at y = (1, −1) and Theorem 2.1 does not apply.
So the conclusion of the test can hold when one of its hypotheses does
not. At c = 3 we
have U₃(t, −t) = −t² < 0 for every t ≠ 0, so the origin is not a local
minimum of U₃.

**Answer 2.** The term x₀³ has first derivative 3x₀² and second
derivative 6x₀ in the direction of x₀, and both are zero at the
origin. So W is analytic and has the same gradient and the same second
derivative at the origin as U, and Theorem 2.1 gives a local minimum of
W at the origin. Proposition 5.1 fails for W: for example
W(−2, 0) = 4 − 8 = −4 < W(0), and W(t, 0) = t² + t³ is unbounded below as
t → −∞. A local minimum and a global minimum are different
statements, and U satisfies both.

## 7. What is proved in Lean

Theorem 4.1 is the final statement of the Lean file. The file also proves
the statements of Section 3 that the proof uses: that U is analytic at
every point, the formula for DU(x) at every point, that the gradient at
the origin is zero, the formula for D²U(z) at every point, and that
the second derivative at the origin is positive definite. Theorem 2.1 is
proved in the companion file. Comparator, run in its sandbox, accepted
the proof of Theorem 4.1 against a copy of its statement that imports
only Mathlib, so no definition from Physlib enters that statement. The spring system of Section 1, the answers
of Section 6 and the proof sketch after Theorem 2.1 are explanations
written for this page.

Proposition 5.1 is in neither file. A Lean proof of it written for this
page, which Lean accepted against the two files, is shown on this page
with the comparison for Theorem 4.1.

[file]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean
[test]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean
[couplingPotential]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L56-L57
[second_derivative_test_analyticAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L600-L606
[iteratedFDerivQuadraticMap]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L107-L126
[coercive_of_posdef]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L455-L505
[littleO_of_powerseries]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L558-L568
[le_of_littleO]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean#L514-L530
[couplingPotential_analyticAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L68-L75
[couplingPotential_hasFDerivAt]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L81-L92
[couplingPotential_gradient_zero]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L97-L101
[couplingPotential_iteratedFDeriv_two]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L106-L130
[couplingPotential_posDef]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L142-L151
[coupled_spring_potential]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean#L153-L160
[couplingPotential_origin_le]: https://github.com/wcook04/proof-reader/blob/main/papers/coupled-spring/checks/GlobalMinimum.lean#L16-L20
[couplingPotential_pos]: https://github.com/wcook04/proof-reader/blob/main/papers/coupled-spring/checks/StrictMinimum.lean#L3-L30
