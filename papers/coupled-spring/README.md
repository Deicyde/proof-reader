<!-- Written by tools/markdown_edition.py from paper.md, links.json and the Lean. Edit those, then run it again. -->

# A minimum of the coupled spring potential

*The second-derivative test in a Lean file by Bjørn Kjos-Hanssen, written out.*

*Written by AI agents under Will Cook's direction, 17 November 2026, revised 19 November.
Bjørn Kjos-Hanssen wrote the Lean file in PhyslibAlpha that this page explains, and the
statements cited [1] to [11] are his. The prose, the spring system of Section 1, the
comparisons with the Lean and the two Lean files cited [12] and [13] were written by AI
for this page. They are not part of Physlib, and neither he nor a physicist has reviewed
them. As in Physlib's API maps, [n] cites a Lean declaration listed under Lean References,
{n} cites a source listed under References, and [TODO] marks a statement that is not
formalised in Lean.*

[Read it with the Lean beside it](https://wcook04.github.io/proof-reader/#/coupled-spring) · [Lean source](https://github.com/leanprover-community/physlib/tree/be0a9eef7dac78da524bfbde91c812340b194610) · Each ▸ **Lean** under a paragraph opens the statements that paragraph is about.

## Abstract

The coupled spring potential U(x₀, x₁) = x₀² + x₀x₁ + x₁² is, for example, the energy of
two masses held between two walls by three equal springs. In PhyslibAlpha it is proved in Lean that
U has a local minimum at the origin, by applying a general second-derivative test that
is proved in a companion file, and the file is described there as a proof of concept for
that test. For this quadratic the conclusion also follows from completing the square,
which gives the stronger statement that the origin is the unique global minimum. This page
writes out the Lean argument, says what the second derivative of U means for the springs,
and compares what the general test proves with what the quadratic allows.

## Content

### 1. The potential and its spring system

The function

U(x₀, x₁) = x₀² + x₀x₁ + x₁²

on ℝ² is called the coupled spring potential in PhyslibAlpha {1}. In that file
Bjørn Kjos-Hanssen proves in Lean that U has a local minimum at the origin [6]. The file
gives no particular physical system [1].

<details>
<summary><b>Lean</b> · The coupled spring potential · <code>couplingPotential</code></summary>

```lean
/-- The potential energy of a pair of coupled springs. -/
noncomputable def couplingPotential (x : EuclideanSpace ℝ (Fin 2)) : ℝ :=
  (x 0) ^ 2 + x 0 * x 1 + (x 1) ^ 2
```

Copied whole from [CoupledSpringPotential.lean, lines 56–57][couplingPotential] in Physlib at be0a9ee.

</details>

One system with this energy is the following. Two masses lie on a line between two walls.
Each mass is joined to the nearer wall by a spring, and the masses are joined to each other
by a third spring. All three springs have spring constant 1 and are at their natural
length when both masses are at rest. Let x₀ and x₁ be the displacements of the two
masses, each measured positive towards the other mass. The left wall spring then changes
length by x₀, the right wall spring by x₁, and the middle spring by x₀ + x₁, and the
energy stored in the three springs is

½x₀² + ½x₁² + ½(x₀ + x₁)² = U(x₀, x₁).

The sign of the cross term comes from this choice of coordinates. If both displacements are
measured positive to the right, the middle spring changes length by x₁ − x₀ and the energy
is x₀² − x₀x₁ + x₁², which is U with x₁ replaced by −x₁. The force on the masses
is −∇U, so the origin, where both masses are at their rest positions, is where the force vanishes.

### 2. Why prove a minimum of a quadratic with a general theorem

Completing the square in x₀ gives

U(x) = (x₀ + ½x₁)² + ¾x₁²,

so U(x) > 0 for every x ≠ 0. This is a stronger statement than a local minimum, and its
proof uses no derivative. The file instead proves the local minimum with a second-derivative
test that applies to any analytic function on a finite-dimensional real inner product space
{2}. The potential U is an example on which every hypothesis of that test can be checked
by hand, which is what a proof of concept for the test needs. Section 5 compares the two
proofs.

### 3. The second-derivative test

For a function f on a real inner product space V, write Df(a) for its derivative at
a, a linear map V → ℝ, and D²f(a) for its second derivative at a, a
bilinear map V × V → ℝ.

**Theorem 3.1 (second-derivative test).** Let V be a finite-dimensional real inner product
space, let f: V → ℝ and let a ∈ V. Suppose that f is analytic at a, that the
gradient of f at a is zero, and that the second derivative of f at a is positive
definite: D²f(a)(y, y) > 0 for every y ≠ 0. Then f has a local minimum at a: there is
a neighbourhood of a on which f(a) ≤ f(x). [7][8]

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

**Comparison with the page, made by AI and not reviewed: same statement.** Theorem 3.1 and the Lean statement have the same hypotheses and the same conclusion: a finite-dimensional real inner product space, a function analytic at the point, zero gradient there, a positive definite second derivative there, and a local minimum with a weak inequality on a neighbourhood. In the Lean the second derivative enters as the quadratic map sending y to its value at (y, y).

**Second derivative as a quadratic map** · `iteratedFDerivQuadraticMap`

```lean
/-- The second iterated Frechét derivative as a quadratic map. -/
noncomputable def iteratedFDerivQuadraticMap {V : Type*} [NormedAddCommGroup V]
    [NormedSpace ℝ V] (f : V → ℝ) (x₀ : V) : QuadraticMap ℝ V ℝ := {
```

Statement copied from [PartialDerivativeTest.lean, lines 107–126][iteratedFDerivQuadraticMap] in Physlib at be0a9ee; the proof is at the link.

</details>

The proof has two steps, and each uses one hypothesis that the conclusion needs.

The first step turns positivity in every direction into a single bound. The map
y ↦ D²f(a)(y, y) is continuous and positive on the unit sphere of V, and the unit
sphere is compact because V is finite-dimensional, so the map has a positive minimum C on
it. Scaling gives D²f(a)(y, y) ≥ C‖y‖² for every y. [9] In an
infinite-dimensional space a form can be positive in every direction with no such C.

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

The second step controls everything beyond second order. Since f is analytic at a, its
power series at a shows that its second-order Taylor polynomial approximates it with an
error smaller than any fixed multiple of ‖x − a‖² once x is close enough to
a. [10] With the gradient zero, the Taylor polynomial is f(a) + ½D²f(a)(x − a, x − a).
Taking the error at most ½C‖x − a‖² gives, for every x near a, [11]

f(x) − f(a) ≥ ½C‖x − a‖² − ½C‖x − a‖² = 0.

<details>
<summary><b>Lean</b> · 2 statements: Taylor error from a power series; Comparison from the Taylor error</summary>

**Taylor error from a power series** · `littleO_of_powerseries`

```lean
/-- Having a power series implies quadratic approximation. -/
lemma littleO_of_powerseries {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V]
    {f : V → ℝ} {x₀ : V} {p : FormalMultilinearSeries ℝ V ℝ}
    {r : NNReal} (h : HasFPowerSeriesOnBall f p x₀ r) :
    (fun x => f x - p.partialSum 3 (x - x₀)) =o[nhds x₀] fun x => ‖x - x₀‖ ^ 2 := by
```

Statement copied from [PartialDerivativeTest.lean, lines 558–568][littleO_of_powerseries] in Physlib at be0a9ee; the proof is at the link.

**Comparison from the Taylor error** · `le_of_littleO`

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

Taking the error at most ¼C‖x − a‖² instead gives
f(x) − f(a) ≥ ¼C‖x − a‖² > 0 for x ≠ a near a, a strict local minimum.
The Lean theorem states the weak form. [TODO]

In this proof, analyticity supplies the Taylor approximation. The usual second-derivative
test {3} assumes less, that f has continuous second partial derivatives, and that version is
not proved in the file. [TODO]

### 4. The hypotheses for the potential, and what the second derivative means

**Analytic.** The potential U is a polynomial in the two coordinates. So U is analytic at
every point. [2]

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

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the potential is analytic at every point of the plane.

</details>

**Zero gradient.** For every x and h in ℝ², expanding the squares gives

U(x + h) = U(x) + (2x₀ + x₁)h₀ + (x₀ + 2x₁)h₁ + U(h).

The two middle terms are linear in h, and U(h) ≤ (3/2)‖h‖², so the
derivative of U at x is the linear map

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

**Comparison with the page, made by AI and not reviewed: same statement.** Both give the derivative at every point x as the linear map with coefficients 2x₀ + x₁ and x₀ + 2x₁. The Lean writes it as a combination of the two coordinate projections.

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

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the gradient of the potential at the origin is zero.

</details>

**Second derivative.** Differentiating the coefficients again gives, at every point z and
for every a and b in ℝ²,

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

**Comparison with the page, made by AI and not reviewed: same statement.** Both give the same formula for the second derivative at every point z and every pair of vectors a and b.

</details>

[4] This is the same bilinear map at every point, with matrix

K = [[2, 1], [1, 2]].

Because U is quadratic, its Taylor expansion at the origin ends at second order:
U(x) = ½D²U(0)(x, x) exactly, with no error term.

**Positive definite.** Setting a = b = y,

D²U(0)(y, y) = 2U(y) = y₀² + y₁² + (y₀ + y₁)².

So the second derivative at the origin is positive definite [5], and dropping the last square
gives D²U(0)(y, y) ≥ ‖y‖². For U the constant of Section 3 is therefore
C = 1, and it is attained at y = (1, −1), where the last square is zero.

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

**Comparison with the page, made by AI and not reviewed: same statement.** Both say that the second derivative at the origin is positive definite. The page also notes that the second derivative is the same at every point and gives the bound D²U(0)(y, y) ≥ ‖y‖²; the Lean statement is about positive definiteness at the origin only.

</details>

For the springs, K is the stiffness matrix: the force on the masses at displacement x is
−Kx. Its eigenvectors are (1, −1), with eigenvalue 1, and (1, 1), with eigenvalue 3.
In the coordinates of Section 1, (1, −1) moves both masses the same distance in the same
direction, so the middle spring keeps its length and only the wall springs resist.
(1, 1) moves the masses towards each other, so the middle spring is compressed as well and
the motion is three times as stiff. With both masses equal to 1, these are the two normal
modes of the system, with angular frequencies 1 and √3 {4}. [TODO] The Lean file is
about the energy only: it contains no masses, equations of motion or oscillation, and the
local minimum says that the rest position is a minimum of the energy.

### 5. The local minimum, and the global minimum

**Theorem 5.1 (Kjos-Hanssen, proved in Lean).** The coupled spring potential U has a local
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

**Comparison with the page, made by AI and not reviewed: same statement.** Theorem 5.1 and the Lean statement both say that the potential has a local minimum at the origin, with a weak inequality on a neighbourhood. Proposition 5.2 says more, a strict inequality at every other point of the plane. It is not in the author's files. The two Lean files written for this page and shown under it prove its parts.

</details>

*Proof.* Apply Theorem 3.1 with V = ℝ², f = U and a = 0. The three hypotheses are the
first, second and fourth paragraphs of Section 4. ∎

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

**Proposition 5.2.** For every x ≠ 0 in ℝ² we have U(x) > U(0). In particular the
origin is the unique global minimum of U.

<details>
<summary><b>Lean proof</b> · 2 statements: At every point the coupled spring potential is at least its value at the origin; Away from the origin the coupled spring potential is strictly positive</summary>

**At every point the coupled spring potential is at least its value at the origin** · `couplingPotential_origin_le`

```lean
/-- At every point the coupled spring potential is at least its value at the origin. -/
theorem couplingPotential_origin_le (x : EuclideanSpace ℝ (Fin 2)) :
    couplingPotential (!₂[0, 0] : EuclideanSpace ℝ (Fin 2)) ≤ couplingPotential x := by
  rw [couplingPotential_origin, couplingPotential_eq_sq_add_sq]
  positivity
```

Written by AI for this page and accepted by Lean against the two files: [checks/GlobalMinimum.lean, lines 16–20][couplingPotential_origin_le]. It is not in Physlib.

**Away from the origin the coupled spring potential is strictly positive** · `couplingPotential_pos`

```lean
/-- Away from the origin the coupled spring potential is strictly positive. -/
theorem couplingPotential_pos (x : EuclideanSpace ℝ (Fin 2)) (hx : x ≠ 0) :
    0 < couplingPotential x := by
  have hsq : couplingPotential x = (x 0 + x 1 / 2) ^ 2 + 3 / 4 * (x 1) ^ 2 := by
    unfold couplingPotential
    ring
  rw [hsq]
  by_contra h
  have hs : 0 ≤ (x 0 + x 1 / 2) ^ 2 := sq_nonneg _
  have ht : 0 ≤ (x 1) ^ 2 := sq_nonneg _
  have h1 : x 1 = 0 := by
    have h1sq : (x 1) ^ 2 = 0 := by linarith
    exact (pow_eq_zero_iff two_ne_zero).mp h1sq
  have h0 : x 0 = 0 := by
    have h0sq : (x 0 + x 1 / 2) ^ 2 = 0 := by linarith
    have h0lin : x 0 + x 1 / 2 = 0 := (pow_eq_zero_iff two_ne_zero).mp h0sq
    linarith
  apply hx
  ext i
  fin_cases i
  · first
      | simpa using h0
      | (simp; exact h0)
      | exact h0
  · first
      | simpa using h1
      | (simp; exact h1)
      | exact h1
```

Written by AI for this page and accepted by Lean against the two files: [checks/StrictMinimum.lean, lines 3–30][couplingPotential_pos]. It is not in Physlib.

</details>

*Proof.* By the identity of Section 2, U(x) = (x₀ + ½x₁)² + ¾x₁²
for every x [12], and U(0) = 0 [12]. Both terms are squares, so U(x) ≥ 0, and if U(x) = 0
then x₁ = 0 and then x₀ = 0. [13] ∎

The Lean files [12] and [13] were written for this page and are not part of Physlib. Lean
accepts their four statements against the two Physlib files: the identity, U(0) = 0,
U(0) ≤ U(x) for every x, and 0 < U(x) for x ≠ 0. Proposition 5.2 is the last two
together with U(0) = 0.

Proposition 5.2 says more than Theorem 5.1. It holds on all of ℝ², and its
inequality is strict. It depends on an identity that exists because U is a quadratic form.
Theorem 3.1 uses analyticity near the point, a zero gradient there and a positive definite
second derivative at that point. It gives only a local conclusion, and in return it applies to
analytic potentials that are not quadratic, as in Question 2 of Section 6.

### 6. Changed cases

**Question 1.** Replace U by U_c(x) = x₀² + c x₀x₁ + x₁² for a real number c. For which
c does the argument of Section 4 apply? What happens at c = ±2 and at c = 3?

**Question 2.** Replace U by W(x) = U(x) + x₀³. Which of Theorem 5.1 and Proposition 5.2 hold
for W?

**Answer 1.** The gradient of U_c at the origin is zero for every c, and

D²U_c(0)(y, y) = 2y₀² + 2c y₀y₁ + 2y₁² = 2(y₀ + (c/2)y₁)² + 2(1 − c²/4)y₁².

| c | At the origin |
| --- | --- |
| \|c\| < 2 | Positive definite second derivative, and the unique global minimum |
| c = ±2 | A global minimum that is not unique, and Theorem 3.1 does not apply |
| \|c\| > 2 | Not a local minimum |

For |c| < 2 the second derivative is positive definite, Theorem 3.1 gives a local
minimum, and completing the square as in Section 2 gives the unique global minimum. At c = 2
we have U₂(x) = (x₀ + x₁)², which is zero on the whole line x₀ = −x₁, and at c = −2 we have
U_(−2)(x) = (x₀ − x₁)², which is zero on the line x₀ = x₁. In both cases the origin is a
global minimum, the second derivative is zero in one direction, and Theorem 3.1 does not apply,
so the conclusion of the test can hold when one of its hypotheses does not. At c = 3 we have
U₃(t, −t) = −t² < 0 for every t ≠ 0, so the origin is not a local minimum of U₃.

In the spring system, c cannot be changed on its own. With wall springs of constants k₁
and k₂ and a middle spring of constant k, the energy is
½(k₁ + k)x₀² + ½(k₂ + k)x₁² + k x₀x₁. After rescaling each coordinate so that
the two square terms have coefficient 1, this is U_c with

c = 2k/√((k₁+k)(k₂+k)).

For positive spring constants, c < 2, and c = 2 only when both wall springs are removed. Then
the flat line x₀ = −x₁ is the motion of both masses together in one direction, which no spring
resists. A value of c above 2 needs a negative spring constant. The value c = −2 is the
same free pair in the coordinates of Section 1 with both displacements measured to the right.

**Answer 2.** The term x₀³ has first derivative 3x₀² and second derivative 6x₀ in
the direction of x₀, and both are zero at the origin. So W is analytic and has the same
gradient and the same second derivative at the origin as U, and Theorem 3.1 gives a local
minimum of W at the origin. Proposition 5.2 fails for W: W(−2, 0) = −4 < W(0), and
W(t, 0) = t² + t³ is unbounded below as t → −∞. A cubic term of this kind is the usual
correction for a spring that stops obeying Hooke's law at larger extensions, and it describes the
spring only near its rest length. Near the rest position, where the correction applies, W still
has a local minimum.

### 7. What has been checked

Lean 4.35.0 compiled the two Physlib files at commit be0a9ee. The statements [1] to [11] are
in them, including every statement of Section 4 that the proof of Theorem 5.1 uses, and
Theorem 3.1, which is proved in the companion file {2}.

Comparator {5} checked one further point about Theorem 5.1. Its Lean statement writes the
potential out in Mathlib's own terms. Comparator, run in a sandbox, confirmed that the proof
in Physlib proves exactly that statement, from a copy of it that imports only Mathlib, using
only Lean's three standard axioms. The same run rejected a copy with "local maximum" in place
of "local minimum". So the theorem proved in Physlib can be read using Mathlib's definitions
alone. Comparator does not check the spring system or any sentence of this page.

The links from this page's sentences to the Lean, and the comparisons of each statement with
its Lean, were made by AI. The building of this page checks that every linked sentence appears
in the text, but nobody has reviewed whether each sentence and its Lean say the same thing.

## Statements and comparisons

Each statement on this page that has a Lean declaration, with the comparison of the two. The comparisons were made by AI and have not been reviewed.

| Statement on this page | Lean | Comparison with the page |
| --- | --- | --- |
| The second-derivative test | [`second_derivative_test_analyticAt`][second_derivative_test_analyticAt] | Same statement |
| The potential is analytic | [`couplingPotential_analyticAt`][couplingPotential_analyticAt] | Same statement |
| Derivative of the potential | [`couplingPotential_hasFDerivAt`][couplingPotential_hasFDerivAt] | Same statement |
| Zero gradient at the origin | [`couplingPotential_gradient_zero`][couplingPotential_gradient_zero] | Same statement |
| Second derivative of the potential | [`couplingPotential_iteratedFDeriv_two`][couplingPotential_iteratedFDeriv_two] | Same statement |
| Positive definite at the origin | [`couplingPotential_posDef`][couplingPotential_posDef] | Same statement |
| Local minimum at the origin | [`coupled_spring_potential`][coupled_spring_potential] | Same statement |
| At every point the coupled spring potential is at least its value at the origin | [`couplingPotential_origin_le`][couplingPotential_origin_le] | Written by AI for this page; not in Physlib |
| Away from the origin the coupled spring potential is strictly positive | [`couplingPotential_pos`][couplingPotential_pos] | Written by AI for this page; not in Physlib |

## Lean References

1. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential`
2. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_analyticAt`
3. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_hasFDerivAt`,
   `couplingPotential_gradient_zero`
4. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_iteratedFDeriv_two`
5. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `couplingPotential_posDef`
6. PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean — `coupled_spring_potential`
7. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `second_derivative_test_analyticAt`
8. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `iteratedFDerivQuadraticMap`
9. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `coercive_of_posdef`
10. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `littleO_of_powerseries`
11. PhyslibAlpha/Mathematics/PartialDerivativeTest.lean — `le_of_littleO`
12. checks/GlobalMinimum.lean, written for this page — `couplingPotential_eq_sq_add_sq`,
    `couplingPotential_origin`, `couplingPotential_origin_le`
13. checks/StrictMinimum.lean, written for this page — `couplingPotential_pos`

## References

1. Bjørn Kjos-Hanssen, CoupledSpringPotential.lean, PhyslibAlpha, Physlib at commit be0a9ee,
   https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean
2. Bjørn Kjos-Hanssen, PartialDerivativeTest.lean, PhyslibAlpha, Physlib at commit be0a9ee,
   https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean
3. Wikipedia, Second partial derivative test,
   https://en.wikipedia.org/wiki/Second_partial_derivative_test
4. Wikipedia, Normal mode, section Coupled oscillators, https://en.wikipedia.org/wiki/Normal_mode
5. Comparator, https://github.com/leanprover/comparator

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
