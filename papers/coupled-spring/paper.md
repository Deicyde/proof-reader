# A minimum of the coupled spring potential

## The second-derivative test in a Lean file by Bjørn Kjos-Hanssen, written out

*Explanatory reconstruction prepared by Will Cook with AI assistance · 17 November 2026.*

Lean formalization: Bjørn Kjos-Hanssen, in PhyslibAlpha.

## Introduction

The function

$$U(x_0,x_1)=x_0^2+x_0x_1+x_1^2$$

on $\mathbb R^2$ is called the coupled spring potential in
[PhyslibAlpha][file]. In that file Bjørn Kjos-Hanssen proves in Lean that
$U$ has a local minimum at the origin. The proof applies a
second-derivative test, which he proves in a [companion file][test], and
the file is described there as a proof of concept for the test.

These notes are for a reader who knows partial derivatives and has not
read the Lean. In Sections 1 to 4 we write out the argument of the file:
the potential, the test, its three hypotheses for $U$, and the
conclusion. In Section 5 we give a second argument, by completing the
square, which shows that the origin is the unique global minimum. That
argument is ours and does not appear in the file. In Section 6 we change
the potential and ask which conclusions still hold, and in Section 7 we
say which statements are proved in Lean.

## 1. The potential

Write $x=(x_0,x_1)$. Three values are

$$U(1,0)=1,\qquad U(1,1)=3,\qquad U(1,-1)=1.$$

Without the cross term $x_0x_1$ the last two values would both be $2$.
The cross term adds energy when the coordinates have the same sign and
removes energy when they have opposite signs.

In the file $U$ is described as the potential energy of a pair of coupled
springs, and no particular system is specified. One system with this
energy is the following. Two masses lie on a line between two walls. Each
mass is joined to the nearer wall by a spring, and the masses are joined
to each other by a third spring, all three with spring constant $1$. Let
$x_0$ and $x_1$ be the displacements of the two masses towards each
other. The two wall springs are stretched by $x_0$ and $x_1$ and store
$\tfrac12x_0^2$ and $\tfrac12x_1^2$. The middle spring is compressed by
$x_0+x_1$ and stores $\tfrac12(x_0+x_1)^2$. The sum of the three energies
is $U(x_0,x_1)$. This reading of $U$ is ours.

## 2. The second-derivative test

For a function $f$ on a real inner product space $V$, write $Df(a)$ for
its derivative at $a$, a linear map $V\to\mathbb R$, and $D^2f(a)$ for
its second derivative at $a$, a bilinear map $V\times V\to\mathbb R$.

**Theorem 2.1 (second-derivative test).** Let $V$ be a finite-dimensional
real inner product space, let $f:V\to\mathbb R$ and let $a\in V$. Suppose
that $f$ is analytic at $a$, that the gradient of $f$ at $a$ is zero, and
that the second derivative of $f$ at $a$ is positive definite:
$D^2f(a)(y,y)>0$ for every $y\neq0$. Then $f$ has a local minimum at $a$:
there is a neighbourhood of $a$ on which $f(a)\le f(x)$.

The proof in the companion file has two inputs. A positive definite
quadratic form on a finite-dimensional space is bounded below by a
multiple of the squared norm, so there is a constant $C>0$ with
$D^2f(a)(y,y)\ge C\lVert y\rVert^2$ for every $y$. Since $f$ is analytic
at $a$, its second-order Taylor polynomial at $a$ approximates it with an
error that is at most $\tfrac12C\lVert x-a\rVert^2$ for every $x$ near
$a$. With the gradient zero, the Taylor polynomial is
$f(a)+\tfrac12D^2f(a)(x-a,x-a)$, and therefore

$$f(x)-f(a)\ \ge\ \tfrac12C\lVert x-a\rVert^2-\tfrac12C\lVert x-a\rVert^2\ =\ 0 .$$

## 3. The three hypotheses for the potential

**Analytic.** Each coordinate map $x\mapsto x_i$ is linear and hence
analytic, and $U$ is a sum of products of the two coordinate maps. So $U$
is analytic at every point.

**Zero gradient.** For every $x$ and $h$ in $\mathbb R^2$, expanding the
squares gives

$$U(x+h)=U(x)+(2x_0+x_1)h_0+(x_0+2x_1)h_1+U(h).$$

The two middle terms are linear in $h$, and $U(h)\le\tfrac32\lVert
h\rVert^2$. So the derivative of $U$ at $x$ is the linear map

$$DU(x)(h)=(2x_0+x_1)h_0+(x_0+2x_1)h_1 .$$

At $x=(1,0)$ this is $2h_0+h_1$. At the origin both coefficients are
zero, so the gradient of $U$ at the origin is zero.

**Second derivative.** The coefficients $2x_0+x_1$ and $x_0+2x_1$ are
linear in $x$. Differentiating them gives, at every point $z$ and for
every $a$ and $b$ in $\mathbb R^2$,

$$D^2U(z)(a,b)=2a_0b_0+a_0b_1+a_1b_0+2a_1b_1 .$$

The second derivative of $U$ is the same bilinear map at every point,
with matrix $\begin{pmatrix}2&1\\1&2\end{pmatrix}$.

**Positive definite.** Setting $a=b=y$ at the origin,

$$D^2U(0)(y,y)=2y_0^2+2y_0y_1+2y_1^2=y_0^2+y_1^2+(y_0+y_1)^2 .$$

The right-hand side is a sum of three squares, and it is zero only when
$y_0=y_1=0$. So the second derivative of $U$ at the origin is positive
definite. For $y=(1,-1)$ the value is $2$ and for $y=(1,1)$ it is $6$.

## 4. The local minimum

**Theorem 4.1 (Kjos-Hanssen, proved in Lean).** The coupled spring
potential $U$ has a local minimum at the origin.

*Proof.* Apply Theorem 2.1 with $V=\mathbb R^2$, $f=U$ and $a=0$. The
three hypotheses are the first, second and fourth paragraphs of
Section 3. $\qquad\blacksquare$

## 5. A global minimum, by completing the square

The argument of this section does not appear in the file. Completing the
square in $x_0$ gives, for every $x$ in $\mathbb R^2$,

$$U(x)=\left(x_0+\tfrac12x_1\right)^2+\tfrac34x_1^2 .$$

At $x=(1,1)$ the two terms are $\tfrac94$ and $\tfrac34$, with sum $3$.
Both terms are squares, so $U(x)\ge0=U(0)$. If $U(x)=0$ then both terms
are zero, so $x_1=0$ and then $x_0=0$.

**Proposition 5.1.** For every $x\neq0$ in $\mathbb R^2$ we have
$U(x)>U(0)$. In particular the origin is the unique global minimum of
$U$.

Proposition 5.1 says more than Theorem 4.1 in two ways. It holds on all
of $\mathbb R^2$, where Theorem 4.1 gives a neighbourhood of the origin,
and its inequality is strict. Its proof uses no derivative. It depends on
an identity that is available because $U$ is a quadratic form. Theorem
2.1 uses only the first two derivatives of $f$ at one point, so it also
applies to potentials for which no such identity is available, as in the
second question of Section 6.

## 6. Changed cases

**Question 1.** Replace $U$ by $U_c(x)=x_0^2+c\,x_0x_1+x_1^2$ for a real
number $c$. For which $c$ does the argument of Section 3 apply? What
happens at $c=2$ and at $c=3$?

**Question 2.** Replace $U$ by $W(x)=U(x)+x_0^3$. Which of Theorem 4.1
and Proposition 5.1 hold for $W$?

**Answer 1.** The gradient of $U_c$ at the origin is zero for every $c$,
and

$$D^2U_c(0)(y,y)=2y_0^2+2c\,y_0y_1+2y_1^2=2\left(y_0+\tfrac c2y_1\right)^2+2\left(1-\tfrac{c^2}4\right)y_1^2 .$$

This is positive definite exactly when $\lvert c\rvert<2$, and for those
$c$ Theorem 2.1 gives a local minimum at the origin. At $c=2$ we have
$U_2(x)=(x_0+x_1)^2\ge0$, so the origin is a global minimum of $U_2$,
although $D^2U_2(0)(y,y)=0$ at $y=(1,-1)$ and Theorem 2.1 does not apply.
So the conclusion of the test can hold when one of its hypotheses does
not. At $c=3$ we
have $U_3(t,-t)=-t^2<0$ for every $t\neq0$, so the origin is not a local
minimum of $U_3$.

**Answer 2.** The term $x_0^3$ has first derivative $3x_0^2$ and second
derivative $6x_0$ in the direction of $x_0$, and both are zero at the
origin. So $W$ is analytic and has the same gradient and the same second
derivative at the origin as $U$, and Theorem 2.1 gives a local minimum of
$W$ at the origin. Proposition 5.1 fails for $W$: for example
$W(-2,0)=4-8=-4<W(0)$, and $W(t,0)=t^2+t^3$ is unbounded below as
$t\to-\infty$. A local minimum and a global minimum are different
statements, and $U$ satisfies both.

## 7. What is proved in Lean

Theorem 4.1 is the final statement of the Lean file. The file also proves
the statements of Section 3 that the proof uses: that $U$ is analytic at
every point, the formula for $DU(x)$ at every point, that the gradient at
the origin is zero, the formula for $D^2U(z)$ at every point, and that
the second derivative at the origin is positive definite. Theorem 2.1 is
proved in the companion file. The spring system of Section 1, the answers
of Section 6 and the proof sketch after Theorem 2.1 are explanations
written for this page.

Proposition 5.1 is in neither file. A Lean proof of it written for this
page, which Lean accepted against the two files, is shown on this page
with the comparison for Theorem 4.1.

[file]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/ClassicalMechanics/CoupledSpringPotential.lean
[test]: https://github.com/leanprover-community/physlib/blob/be0a9eef7dac78da524bfbde91c812340b194610/PhyslibAlpha/Mathematics/PartialDerivativeTest.lean
