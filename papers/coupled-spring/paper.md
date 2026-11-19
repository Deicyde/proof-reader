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

## Abstract

The coupled spring potential $U(x_0,x_1)=x_0^2+x_0x_1+x_1^2$ is, for example, the energy of
two masses held between two walls by three equal springs. In PhyslibAlpha it is proved in Lean that
$U$ has a local minimum at the origin, by applying a general second-derivative test that
is proved in a companion file, and the file is described there as a proof of concept for
that test. For this quadratic the conclusion also follows from completing the square,
which gives the stronger statement that the origin is the unique global minimum. This page
writes out the Lean argument, says what the second derivative of $U$ means for the springs,
and compares what the general test proves with what the quadratic allows.

## Content

### 1. The potential and its spring system

The function

$$U(x_0,x_1)=x_0^2+x_0x_1+x_1^2$$

on $\mathbb R^2$ is called the coupled spring potential in PhyslibAlpha {1}. In that file
Bjørn Kjos-Hanssen proves in Lean that $U$ has a local minimum at the origin [6]. The file
gives no particular physical system [1].

One system with this energy is the following. Two masses lie on a line between two walls.
Each mass is joined to the nearer wall by a spring, and the masses are joined to each other
by a third spring. All three springs have spring constant $1$ and are at their natural
length when both masses are at rest. Let $x_0$ and $x_1$ be the displacements of the two
masses, each measured positive towards the other mass. The left wall spring then changes
length by $x_0$, the right wall spring by $x_1$, and the middle spring by $x_0+x_1$, and the
energy stored in the three springs is

$$\tfrac12x_0^2+\tfrac12x_1^2+\tfrac12(x_0+x_1)^2=U(x_0,x_1).$$

The sign of the cross term comes from this choice of coordinates. If both displacements are
measured positive to the right, the middle spring changes length by $x_1-x_0$ and the energy
is $x_0^2-x_0x_1+x_1^2$, which is $U$ with $x_1$ replaced by $-x_1$. The force on the masses
is $-\nabla U$, so the origin, where both masses are at their rest positions, is where the force vanishes.

### 2. Why prove a minimum of a quadratic with a general theorem

Completing the square in $x_0$ gives

$$U(x)=\left(x_0+\tfrac12x_1\right)^2+\tfrac34x_1^2,$$

so $U(x)>0$ for every $x\neq0$. This is a stronger statement than a local minimum, and its
proof uses no derivative. The file instead proves the local minimum with a second-derivative
test that applies to any analytic function on a finite-dimensional real inner product space
{2}. The potential $U$ is an example on which every hypothesis of that test can be checked
by hand, which is what a proof of concept for the test needs. Section 5 compares the two
proofs.

### 3. The second-derivative test

For a function $f$ on a real inner product space $V$, write $Df(a)$ for its derivative at
$a$, a linear map $V\to\mathbb R$, and $D^2f(a)$ for its second derivative at $a$, a
bilinear map $V\times V\to\mathbb R$.

**Theorem 3.1 (second-derivative test).** Let $V$ be a finite-dimensional real inner product
space, let $f:V\to\mathbb R$ and let $a\in V$. Suppose that $f$ is analytic at $a$, that the
gradient of $f$ at $a$ is zero, and that the second derivative of $f$ at $a$ is positive
definite: $D^2f(a)(y,y)>0$ for every $y\neq0$. Then $f$ has a local minimum at $a$: there is
a neighbourhood of $a$ on which $f(a)\le f(x)$. [7][8]

The proof has two steps, and each uses one hypothesis that the conclusion needs.

The first step turns positivity in every direction into a single bound. The map
$y\mapsto D^2f(a)(y,y)$ is continuous and positive on the unit sphere of $V$, and the unit
sphere is compact because $V$ is finite-dimensional, so the map has a positive minimum $C$ on
it. Scaling gives $D^2f(a)(y,y)\ge C\lVert y\rVert^2$ for every $y$. [9] In an
infinite-dimensional space a form can be positive in every direction with no such $C$.

The second step controls everything beyond second order. Since $f$ is analytic at $a$, its
power series at $a$ shows that its second-order Taylor polynomial approximates it with an
error smaller than any fixed multiple of $\lVert x-a\rVert^2$ once $x$ is close enough to
$a$. [10] With the gradient zero, the Taylor polynomial is $f(a)+\tfrac12D^2f(a)(x-a,x-a)$.
Taking the error at most $\tfrac12C\lVert x-a\rVert^2$ gives, for every $x$ near $a$, [11]

$$f(x)-f(a)\ \ge\ \tfrac12C\lVert x-a\rVert^2-\tfrac12C\lVert x-a\rVert^2\ =\ 0 .$$

Taking the error at most $\tfrac14C\lVert x-a\rVert^2$ instead gives
$f(x)-f(a)\ge\tfrac14C\lVert x-a\rVert^2>0$ for $x\neq a$ near $a$, a strict local minimum.
The Lean theorem states the weak form. [TODO]

In this proof, analyticity supplies the Taylor approximation. The usual second-derivative
test {3} assumes less, that $f$ has continuous second partial derivatives, and that version is
not proved in the file. [TODO]

### 4. The hypotheses for the potential, and what the second derivative means

**Analytic.** The potential $U$ is a polynomial in the two coordinates. So $U$ is analytic at
every point. [2]

**Zero gradient.** For every $x$ and $h$ in $\mathbb R^2$, expanding the squares gives

$$U(x+h)=U(x)+(2x_0+x_1)h_0+(x_0+2x_1)h_1+U(h).$$

The two middle terms are linear in $h$, and $U(h)\le\tfrac32\lVert h\rVert^2$, so the
derivative of $U$ at $x$ is the linear map

$$DU(x)(h)=(2x_0+x_1)h_0+(x_0+2x_1)h_1 .$$

At the origin both coefficients are zero, so the gradient of $U$ at the origin is zero. [3]

**Second derivative.** Differentiating the coefficients again gives, at every point $z$ and
for every $a$ and $b$ in $\mathbb R^2$,

$$D^2U(z)(a,b)=2a_0b_0+a_0b_1+a_1b_0+2a_1b_1 .$$

[4] This is the same bilinear map at every point, with matrix

$$K=\begin{pmatrix}2&1\\1&2\end{pmatrix}.$$

Because $U$ is quadratic, its Taylor expansion at the origin ends at second order:
$U(x)=\tfrac12D^2U(0)(x,x)$ exactly, with no error term.

**Positive definite.** Setting $a=b=y$,

$$D^2U(0)(y,y)=2U(y)=y_0^2+y_1^2+(y_0+y_1)^2 .$$

So the second derivative at the origin is positive definite [5], and dropping the last square
gives $D^2U(0)(y,y)\ge\lVert y\rVert^2$. For $U$ the constant of Section 3 is therefore
$C=1$, and it is attained at $y=(1,-1)$, where the last square is zero.

For the springs, $K$ is the stiffness matrix: the force on the masses at displacement $x$ is
$-Kx$. Its eigenvectors are $(1,-1)$, with eigenvalue $1$, and $(1,1)$, with eigenvalue $3$.
In the coordinates of Section 1, $(1,-1)$ moves both masses the same distance in the same
direction, so the middle spring keeps its length and only the wall springs resist.
$(1,1)$ moves the masses towards each other, so the middle spring is compressed as well and
the motion is three times as stiff. With both masses equal to $1$, these are the two normal
modes of the system, with angular frequencies $1$ and $\sqrt3$ {4}. [TODO] The Lean file is
about the energy only: it contains no masses, equations of motion or oscillation, and the
local minimum says that the rest position is a minimum of the energy.

### 5. The local minimum, and the global minimum

**Theorem 5.1 (Kjos-Hanssen, proved in Lean).** The coupled spring potential $U$ has a local
minimum at the origin. [6]

*Proof.* Apply Theorem 3.1 with $V=\mathbb R^2$, $f=U$ and $a=0$. The three hypotheses are the
first, second and fourth paragraphs of Section 4. $\qquad\blacksquare$

**Proposition 5.2.** For every $x\neq0$ in $\mathbb R^2$ we have $U(x)>U(0)$. In particular the
origin is the unique global minimum of $U$.

*Proof.* By the identity of Section 2, $U(x)=\left(x_0+\tfrac12x_1\right)^2+\tfrac34x_1^2$
for every $x$ [12], and $U(0)=0$ [12]. Both terms are squares, so $U(x)\ge0$, and if $U(x)=0$
then $x_1=0$ and then $x_0=0$. [13] $\qquad\blacksquare$

The Lean files [12] and [13] were written for this page and are not part of Physlib. Lean
accepts their four statements against the two Physlib files: the identity, $U(0)=0$,
$U(0)\le U(x)$ for every $x$, and $0<U(x)$ for $x\neq0$. Proposition 5.2 is the last two
together with $U(0)=0$.

Proposition 5.2 says more than Theorem 5.1. It holds on all of $\mathbb R^2$, and its
inequality is strict. It depends on an identity that exists because $U$ is a quadratic form.
Theorem 3.1 uses analyticity near the point, a zero gradient there and a positive definite
second derivative at that point. It gives only a local conclusion, and in return it applies to
analytic potentials that are not quadratic, as in Question 2 of Section 6.

### 6. Changed cases

**Question 1.** Replace $U$ by $U_c(x)=x_0^2+c\,x_0x_1+x_1^2$ for a real number $c$. For which
$c$ does the argument of Section 4 apply? What happens at $c=\pm2$ and at $c=3$?

**Question 2.** Replace $U$ by $W(x)=U(x)+x_0^3$. Which of Theorem 5.1 and Proposition 5.2 hold
for $W$?

**Answer 1.** The gradient of $U_c$ at the origin is zero for every $c$, and

$$D^2U_c(0)(y,y)=2y_0^2+2c\,y_0y_1+2y_1^2=2\left(y_0+\tfrac c2y_1\right)^2+2\left(1-\tfrac{c^2}4\right)y_1^2 .$$

| $c$ | At the origin |
| --- | --- |
| $\lvert c\rvert<2$ | Positive definite second derivative, and the unique global minimum |
| $c=\pm2$ | A global minimum that is not unique, and Theorem 3.1 does not apply |
| $\lvert c\rvert>2$ | Not a local minimum |

For $\lvert c\rvert<2$ the second derivative is positive definite, Theorem 3.1 gives a local
minimum, and completing the square as in Section 2 gives the unique global minimum. At $c=2$
we have $U_2(x)=(x_0+x_1)^2$, which is zero on the whole line $x_0=-x_1$, and at $c=-2$ we have
$U_{-2}(x)=(x_0-x_1)^2$, which is zero on the line $x_0=x_1$. In both cases the origin is a
global minimum, the second derivative is zero in one direction, and Theorem 3.1 does not apply,
so the conclusion of the test can hold when one of its hypotheses does not. At $c=3$ we have
$U_3(t,-t)=-t^2<0$ for every $t\neq0$, so the origin is not a local minimum of $U_3$.

In the spring system, $c$ cannot be changed on its own. With wall springs of constants $k_1$
and $k_2$ and a middle spring of constant $k$, the energy is
$\tfrac12(k_1+k)x_0^2+\tfrac12(k_2+k)x_1^2+k\,x_0x_1$. After rescaling each coordinate so that
the two square terms have coefficient $1$, this is $U_c$ with

$$c=\frac{2k}{\sqrt{(k_1+k)(k_2+k)}} .$$

For positive spring constants, $c<2$, and $c=2$ only when both wall springs are removed. Then
the flat line $x_0=-x_1$ is the motion of both masses together in one direction, which no spring
resists. A value of $c$ above $2$ needs a negative spring constant. The value $c=-2$ is the
same free pair in the coordinates of Section 1 with both displacements measured to the right.

**Answer 2.** The term $x_0^3$ has first derivative $3x_0^2$ and second derivative $6x_0$ in
the direction of $x_0$, and both are zero at the origin. So $W$ is analytic and has the same
gradient and the same second derivative at the origin as $U$, and Theorem 3.1 gives a local
minimum of $W$ at the origin. Proposition 5.2 fails for $W$: $W(-2,0)=-4<W(0)$, and
$W(t,0)=t^2+t^3$ is unbounded below as $t\to-\infty$. A cubic term of this kind is the usual
correction for a spring that stops obeying Hooke's law at larger extensions, and it describes the
spring only near its rest length. Near the rest position, where the correction applies, $W$ still
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
