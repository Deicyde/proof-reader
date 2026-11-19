# A minimum of the coupled spring potential

*The second-derivative test in a Lean file by Bjørn Kjos-Hanssen, written out.*

*Written by AI agents under Will Cook's direction, 17 November 2026, revised 19 November.
Neither the author of the Lean nor a physicist has reviewed it. Section 7 says who wrote what.*

## Abstract

In PhyslibAlpha, Bjørn Kjos-Hanssen proves in Lean that the coupled spring potential
$U(x_0,x_1)=x_0^2+x_0x_1+x_1^2$ has a local minimum at the origin. He does it by applying a
general second-derivative test, proved in a companion file, and describes the file as a proof
of concept for that test. The test has hypotheses only about the behaviour of a function near
the point, and for $U$ each of them can be checked by hand. Because $U$ is quadratic, completing
the square gives a second, shorter proof with a stronger conclusion, that the origin is the unique
global minimum. This page writes out both proofs, shows which Lean
statements carry each step, and explains what the second derivative of $U$ means for two
masses joined by springs. It is written for a reader who knows multivariable calculus and has
not read the Lean.

Lean declarations are cited [1] to [13] and other sources {1} to {5}, as in Physlib's API maps.
Both lists are at the end.

## 1. The potential and a spring system with this energy

The function

$$U(x_0,x_1)=x_0^2+x_0x_1+x_1^2$$

on $\mathbb R^2$ is called the coupled spring potential in PhyslibAlpha {1}. In that file
Bjørn Kjos-Hanssen proves in Lean that $U$ has a local minimum at the origin [6]. The file
names no particular physical system [1]. The system below is one reading of $U$, chosen for this
page.

Two masses lie on a line between two walls. Each mass is joined to the nearer wall by a spring,
and the two masses are joined by a third spring. All three springs have spring constant $k$ and
are at their natural lengths when both masses are at their equilibrium positions. Let $x_0$ and
$x_1$ be the displacements of the two masses from those positions, each measured positive
towards the other mass. Then the left spring is stretched by $x_0$, the right spring is stretched
by $x_1$, and the middle spring is shortened by $x_0+x_1$. Each stretch or shortening can be
negative. The energy stored in the three springs is

$$\tfrac12k\,x_0^2+\tfrac12k\,x_1^2+\tfrac12k\,(x_0+x_1)^2=k\,U(x_0,x_1).$$

So $U$ is the spring energy in units of $k$. The sign of the cross term comes from the choice of
directions. If both displacements are measured positive to the right, the middle spring changes
length by $x_1-x_0$ and the energy is $k(x_0^2-x_0x_1+x_1^2)$, which is $kU$ with $x_1$ replaced
by $-x_1$.

## 2. The second-derivative test

For a function $f$ on a real inner product space $V$, write $Df(a)$ for its derivative at $a$, a
linear map $V\to\mathbb R$, and $D^2f(a)$ for its second derivative at $a$, a bilinear map
$V\times V\to\mathbb R$.

**Theorem 2.1 (second-derivative test).** Let $V$ be a finite-dimensional real inner product
space, let $f:V\to\mathbb R$ and let $a\in V$. Suppose that $f$ is analytic at $a$, that the
gradient of $f$ at $a$ is zero, and that the second derivative of $f$ at $a$ is positive definite:
$D^2f(a)(y,y)>0$ for every $y\neq0$. Then $f$ has a local minimum at $a$: there is a neighbourhood
of $a$ on which $f(a)\le f(x)$. [7][8]

The hypotheses are sufficient and not necessary. Section 6 gives a function with a minimum whose
second derivative is not positive definite.

The companion file proves the theorem in four steps.

First, $y\mapsto D^2f(a)(y,y)$ is packaged as a quadratic map on $V$, so that "positive definite"
has its usual meaning [8].

Second, a positive definite form is bounded below by a multiple of the squared norm: there is
$C>0$ with $D^2f(a)(y,y)\ge C\lVert y\rVert^2$ for every $y$. [9] If $V=\{0\}$ there is nothing to
prove, and the file treats that case on its own. Otherwise the unit sphere of $V$ is compact,
because $V$ is finite-dimensional, so the continuous map $y\mapsto D^2f(a)(y,y)$ attains a
minimum $C$ on it, and $C>0$. Scaling a unit vector by $t$ multiplies the form by $t^2$, which
gives the bound for every $y$. In an infinite-dimensional space a form can be positive in every
direction and have no such $C$.

Third, the second-order Taylor polynomial of $f$ at $a$ approximates $f$ with an error smaller than
any fixed multiple of $\lVert x-a\rVert^2$ once $x$ is close enough to $a$. [10] The file proves
this estimate from the power series of $f$ at $a$, which is the first use of analyticity.

Fourth, the two estimates are compared. [11] With the gradient zero, the Taylor polynomial is
$f(a)+\tfrac12D^2f(a)(x-a,x-a)$. Choosing the neighbourhood so that the error is at most
$\tfrac12C\lVert x-a\rVert^2$ gives, for every $x$ in it,

$$f(x)-f(a)\ \ge\ \tfrac12C\lVert x-a\rVert^2-\tfrac12C\lVert x-a\rVert^2\ =\ 0 .$$

Analyticity is assumed for two reasons: the error estimate, and the symmetry of the second
derivative, which the file proves from analyticity at $a$. Any $f$ with those two properties at $a$
would do, for example one that is twice
continuously differentiable near $a$, as in the usual statement of the test {5}. The Lean theorem
is stated for analytic $f$.

Choosing the error at most $\tfrac14C\lVert x-a\rVert^2$ instead gives
$f(x)-f(a)\ge\tfrac14C\lVert x-a\rVert^2>0$ for every $x\neq a$ near $a$, a strict local minimum.
That follows from the same estimates, but the Lean theorem states only the weak inequality.

## 3. The hypotheses for the potential

**Analytic.** $U$ is a polynomial in the two coordinates, so it is analytic at every point. [2]

**Zero gradient.** For every $x$ and $h$ in $\mathbb R^2$, expanding the squares gives

$$U(x+h)=U(x)+(2x_0+x_1)h_0+(x_0+2x_1)h_1+U(h).$$

The two middle terms are linear in $h$, and $U(h)\le\tfrac32\lVert h\rVert^2$, so the derivative
of $U$ at $x$ is

$$DU(x)(h)=(2x_0+x_1)h_0+(x_0+2x_1)h_1 .$$

At the origin both coefficients are zero, so the gradient of $U$ at the origin is zero. [3]

**Second derivative.** Differentiating the two coefficients gives, at every point $x$ and for every
$y$ and $h$,

$$D^2U(x)(y,h)=2y_0h_0+y_0h_1+y_1h_0+2y_1h_1 .$$

[4] This is the same bilinear map at every point, with matrix

$$K=\begin{pmatrix}2&1\\1&2\end{pmatrix}.$$

Because $U$ is quadratic, its Taylor expansion at the origin ends at second order:
$U(x)=\tfrac12D^2U(0)(x,x)$ exactly, with no error term.

**Positive definite.** Setting $h=y$,

$$D^2U(0)(y,y)=2U(y)=y_0^2+y_1^2+(y_0+y_1)^2 .$$

So the second derivative at the origin is positive definite. [5] Dropping the last square gives
$D^2U(0)(y,y)\ge\lVert y\rVert^2$, so the constant of the second step is $C=1$. On the unit circle
the minimum is attained at $y=(1,-1)/\sqrt2$, where the last square is zero.

**Theorem 3.1 (Kjos-Hanssen, proved in Lean).** The coupled spring potential $U$ has a local
minimum at the origin. [6]

*Proof.* Apply Theorem 2.1 with $V=\mathbb R^2$, $f=U$ and $a=0$. The three hypotheses are the
first, second and fourth paragraphs of this section. $\qquad\blacksquare$

## 4. The second proof, by completing the square

Completing the square in $x_0$ gives

$$U(x)=\left(x_0+\tfrac12x_1\right)^2+\tfrac34x_1^2$$

for every $x$. [12]

**Proposition 4.1.** For every $x\neq0$ in $\mathbb R^2$ we have $U(x)>U(0)$. In particular the
origin is the unique global minimum of $U$. [13]

*Proof.* Both terms of the identity are squares, so $U(x)\ge0=U(0)$. If $U(x)=0$ then both terms
are zero, so $x_1=0$ and then $x_0=0$. $\qquad\blacksquare$

The proof by completing the square depends on an identity that holds on the whole plane because
$U$ is a quadratic form, and its conclusion is a strict inequality everywhere. The hypotheses of the
second-derivative test concern only $f$ near the point, and its conclusion is only local. In return
it applies to every analytic function whose second derivative is positive definite at a critical
point, including functions with no identity of this kind, such as $W$ in Section 6. For $U$ the
test proves less than the identity does. That suits a proof of concept: each hypothesis can be
checked by hand, and the conclusion can be compared with the global argument.

## 5. What the minimum means for the masses

This section is about the spring system of Section 1 and is not in the Lean. It assumes point
masses $m$ that move along the line without friction, ideal springs that obey Hooke's law and have
no mass, and Newton's laws. It ignores the walls and collisions, so the masses can be anywhere in
$\mathbb R^2$; a real system allows only displacements smaller than the gaps.

The force on each mass, measured in that mass's own positive direction, is $-k$ times the partial
derivative of $U$: $-k(2x_0+x_1)$ on the left mass and $-k(x_0+2x_1)$ on the right mass. For
example, move the left mass a distance $d$ towards the right mass and hold the right mass at its
equilibrium position. The left mass then feels $-2kd$: both springs push it back. The right mass
feels $-kd$ in its own positive direction, that is, the shortened middle spring pushes it towards
its wall. The zero gradient at the origin says that both forces vanish there.

The kinetic energy is $\tfrac12m(\dot x_0^2+\dot x_1^2)$, so the equations of motion are
$m\ddot x=-kKx$. Since the mass matrix is $m$ times the identity, the normal modes are the
eigenvectors of $K$ {3}. In the coordinates

$$q_-=\tfrac1{\sqrt2}(x_0-x_1),\qquad q_+=\tfrac1{\sqrt2}(x_0+x_1),$$

the energy is $kU=\tfrac12k\,(q_-^2+3q_+^2)$, and each coordinate oscillates on its own:
$q_-$ with angular frequency $\sqrt{k/m}$ and $q_+$ with angular frequency $\sqrt{3k/m}$. In the
first mode the two masses move the same distance in the same direction, so the middle spring keeps
its length. In the second they move in opposite directions, so the middle spring is alternately
shortened and stretched and adds to the restoring force.

Because the second derivative is positive definite, the equilibrium is stable. The total energy
$\tfrac12m(\dot x_0^2+\dot x_1^2)+kU(x)$ is conserved, and $kU(x)\ge\tfrac12k\lVert x\rVert^2$
by Section 3, so a motion that starts near equilibrium with little energy stays near it. Without
friction the masses keep oscillating and do not return to rest.

## 6. Changed cases

**Question 1.** Replace $U$ by $U_c(x)=x_0^2+c\,x_0x_1+x_1^2$ for a real number $c$. For which
$c$ is the origin a minimum, and for which does Theorem 2.1 apply?

**Question 2.** Replace $U$ by $W(x)=U(x)+x_0^3$. Which of Theorem 3.1 and Proposition 4.1 hold
for $W$?

**Answer 1.** The gradient of $U_c$ at the origin is zero for every $c$, and

$$D^2U_c(0)(y,y)=2y_0^2+2c\,y_0y_1+2y_1^2 .$$

Completing the square in $y_0$,

$$D^2U_c(0)(y,y)=2\left(y_0+\tfrac c2y_1\right)^2+\left(2-\tfrac{c^2}2\right)y_1^2 .$$

| $c$ | At the origin |
| --- | --- |
| $\lvert c\rvert<2$ | The unique global minimum, and Theorem 2.1 applies |
| $c=2$ or $c=-2$ | A global minimum that is not unique, and Theorem 2.1 does not apply |
| $\lvert c\rvert>2$ | Not a local minimum |

For $\lvert c\rvert<2$ both coefficients are positive, so the second derivative is positive
definite, and since $U_c(x)=\tfrac12D^2U_c(0)(x,x)$ the same identity shows that $U_c(x)>0$ for
$x\neq0$. At $c=2$ we have $U_2(x)=(x_0+x_1)^2$, which is zero on the whole line $x_0=-x_1$, and at
$c=-2$ we have $U_{-2}(x)=(x_0-x_1)^2$, which is zero on the line $x_0=x_1$. In both cases the
origin is a global minimum, the second derivative is zero in one direction, and Theorem 2.1 does
not apply. For $c>2$, $U_c(t,-t)=(2-c)t^2<0$ for every $t\neq0$, and for $c<-2$,
$U_c(t,t)=(2+c)t^2<0$, so the origin is not a local minimum.

In the spring system, give the wall springs constants $k_1$ and $k_2$ and the middle spring constant
$k$. In the coordinates of Section 1 the energy is
$\tfrac12(k_1+k)x_0^2+\tfrac12(k_2+k)x_1^2+k\,x_0x_1$, and its second derivative is positive
definite exactly when $k^2<(k_1+k)(k_2+k)$, that is, when $k_1k_2+k(k_1+k_2)>0$. With all three
constants positive this always holds. It fails when both wall springs are removed: then the
energy is zero along $x_0=-x_1$, where the two masses slide together and the middle spring keeps
its length. This is the case $c=2$. Springs with positive constants never give $c>2$, which would
need a negative spring constant.

**Answer 2.** The term $x_0^3$ has first derivative $3x_0^2$ and second derivative $6x_0$ in the
direction of $x_0$, and both are zero at the origin. So $W$ is analytic and has the same gradient
and the same second derivative at the origin as $U$, and Theorem 2.1 gives a local minimum of $W$
at the origin. Proposition 4.1 fails for $W$: $W(-2,0)=-4<W(0)$, and $W(t,0)=t^2+t^3$ is unbounded
below as $t\to-\infty$. So for $W$ the test gives a local minimum that is not a global one.

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
