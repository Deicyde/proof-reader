# Finite-time blow-up for Navier–Stokes: what the Lean states

Levent Alpöge and Tristan Buckmaster prove that the three-dimensional
Navier–Stokes equations without force have solutions that blow up in finite
time. There are smooth, compactly supported, divergence-free data on
$\mathbb R^3$, and smooth divergence-free periodic data, whose solutions are
smooth up to a finite time and then blow up at the rate $(T-t)^{-1/4}$ in
$\dot H^1$. In Fefferman's formulation of the Millennium Prize problem this
proves statements (C) and (D). Their repository holds a 79-page paper and a
Lean 4 package of about 2,270 files and 600,000 lines, at commit `ad53419`
of 20 November 2026.

The argument has three parts. A profile, a nonzero solution of the
self-similar equations that is periodic in self-similar time up to a linear
isometry, gives blow-up (Theorem 1.1). A certificate, an approximate profile
with explicit inequalities, gives a profile (Theorem 7.1). A particular
certificate satisfies those inequalities, which an interval-arithmetic
computation with the Arb library checks. The first two parts are in Lean.
The certificate and the computation are not in the repository; the paper
gives the certificate's SHA-256 hash and says it will be released.

This page sets each Lean statement beside the paper's, says whether the Lean
is the same, stronger, weaker or different, and records which checks were
run. It was written by AI agents under Will Cook's direction and has not been
reviewed by the authors.

## 1. The equations in the Lean

The statement file `Challenge.lean` writes the equations with Mathlib's
derivatives on $\mathbb R^3$, as `EuclideanSpace ℝ (Fin 3)`. A smooth solution
with viscosity $\nu$ and datum $u_0$ is a pair $(u,p)$ that is $C^\infty$ on
$[0,\infty)\times\mathbb R^3$, has $u(0)=u_0$, and satisfies

$$\partial_t u+(u\cdot\nabla)u=\nu\,\Delta u-\nabla p,\qquad \operatorname{div}u=0$$

at every $t>0$. The two conclusions are these.

**`BreakdownOnSpace`.** For every $\nu>0$ there is a smooth, compactly
supported, divergence-free $u_0$ for which no smooth solution has
$\int|u(t,x)|^2\,dx$ bounded uniformly in $t\ge0$.

**`BreakdownOnTorus`.** For every $\nu>0$ there is a smooth, divergence-free
$u_0$ of period one in each coordinate for which no smooth solution has
$u(t)$ of period one for every $t\ge0$. The pressure is not required to be
periodic.

Fefferman's statement (C) fixes one viscosity and allows a smooth force with
decay. `BreakdownOnSpace` takes the force to be zero and holds for every
viscosity. Compact support gives the decay that (C) asks of the datum. The
solutions it excludes need satisfy the equation only for $t>0$, so every
solution in Fefferman's sense is among them. Hence `BreakdownOnSpace`
implies (C), and in the same way `BreakdownOnTorus` implies (D).

## 2. A profile gives blow-up

The hypothesis of the first two theorems is `PeriodicSimilarityProfileExists`.
It asks for smooth $W(s,y)$ and $q(s,y)$, a period $P>0$, a linear isometry
$R$ and a constant $C$ with

$$\partial_sW+\tfrac12W+\tfrac12(y\cdot\nabla)W-\Delta W+(W\cdot\nabla)W+\nabla q=0,\qquad\operatorname{div}W=0,$$

$W(s+P,y)=R\,W(s,R^{-1}y)$, $W$ not identically zero, and the decay bounds
$|\nabla^jW|\le C(1+|y|)^{-1-j}$ for $j=0,1,2$ and
$|\nabla q|\le C(1+|y|)^{-3}$. Substituting
$u(t,x)=(T-t)^{-1/2}W(s,y)$ with $y=x/\sqrt{T-t}$ and $s=-\log(T-t)$, and
$p=(T-t)^{-1}q$, into the equations with $\nu=1$ gives exactly this equation
for $W$, so the Lean definition is the paper's (1.2).

The existence of such a profile is the open question. Nečas, Růžička and
Šverák, and Tsai, ruled out the time-independent profiles that Leray proposed;
Bradshaw and Tsai list the discretely self-similar case as an open problem.
The two theorems below take it as a hypothesis.

**`breakdown_on_space`** (`PeriodicSimilarityProfileExists → BreakdownOnSpace`)
and **`breakdown_on_torus`** (`PeriodicSimilarityProfileExists → BreakdownOnTorus`).
*Weaker than Theorem 1.1.* The hypothesis adds the bounds on $\nabla^2W$ and
$\nabla q$ to the paper's (1.3); Remark 1.2 of the paper derives the first,
and the authors' README calls the second standard. The conclusion leaves out
the rate $(T-t)^{-1/4}$, the convergence to the profile and the stability in
finite codimension. It states the non-existence of a global smooth solution,
which follows from the paper's blow-up by uniqueness of smooth solutions
(Tao 2013, cited in the authors' README). The Lean proves this passage; the
paper does not write it out.

**`breakdown_on_space_of_weak`** (`WeakPeriodicSimilarityProfileExists → BreakdownOnSpace`).
*No counterpart in the paper.* Its hypothesis asks for a weak profile: $W$
bounded in $L^6$ with $\nabla W$ bounded in $L^2$ uniformly in $s$, second
derivatives square integrable over a period, and the equation in the sense of
distributions against divergence-free test fields. Integrating by parts in
the term $\tfrac12(y\cdot\nabla)W$ gives the coefficients $-1$ on
$\langle W,\varphi\rangle$ and $-\tfrac12$ on $\langle W,(y\cdot\nabla)\varphi\rangle$,
which are the ones the Lean integrand has. A smooth profile with the decay
above is a weak profile, so this theorem implies `breakdown_on_space`.

## 3. A certificate gives a profile

**`certificate_orbit`** and **`extended_certificate_orbit`**
(`ExtendedCertificateChallenge.lean`, `CertificateChallenge.lean`).
*Weaker than Theorem 7.1.* A certificate gives a weak profile. Theorem 7.1
also gives smoothness, closeness to the approximate profile (7.38) and the
symmetries (7.39). The authors' README says the formal definition of a
certificate asks at least as much as the paper's in thirteen places, and that
this comparison was made by reading. We have not repeated it.

**`breakdownOnSpace_of_cell_system_condition`**,
**`breakdownOnTorus_of_cell_system_condition`** and
**`breakdownOnSpaceAndTorus_of_cell_system_condition`**
(`CellLayerTheorems.lean`). Data of seven kinds that satisfy
`CellSystemCondition`, fifteen conditions on finitely many functions and
numbers, give `BreakdownOnSpace` and `BreakdownOnTorus`. This is the Lean
form of Appendix B with Theorem 7.1 and Corollary 7.2. The definitions run to
about 7,000 lines.

Where Appendix B writes a condition out, the Lean matches it term for term:
(B.11), (B.19), (B.22), (B.25), (B.27), (B.29) to (B.31), (B.38) to (B.43),
Lemmas B.9, B.10, B.12 and B.13, and (7.21) and (7.24) to (7.37). We found no
condition the Lean states more strongly than the paper, and no junk value
(a derivative at a kink, a division by zero, an empty sum) that makes a Lean
condition easier in a way that matters. Appendix B does not write out every
condition: it ends by saying that the conditions it has not written out are
of the same kinds as those it has. For those, which include the coefficient
bounds of each cell and the fields $G_j$, $U_j$, $F_j$, $q_j$, only the form
can be compared. Of the three changes in the patch of 20 November, the weight
$(|m|+\tfrac12)^2$ (`AzimuthalBounded`) and the constant that may be zero
(`curlHessFloor_nonneg`, our identification) appear in Appendix B; the
restriction to harmonics that do not vanish in a cell (`modelLabels`) does
not appear explicitly. The comparison read all of Appendix B and §7.3 and
about 1,500 of the Lean lines; `cell-layer-fidelity.md` gives the table and
its coverage, condition by condition.

## 4. What the public evidence covers

| Step | Paper | Lean statement | Evidence in the repository |
|---|---|---|---|
| Profile gives blow-up | Theorem 1.1 | `breakdown_on_space`, `breakdown_on_torus` | Lean proof |
| Weak profile gives blow-up on $\mathbb R^3$ | none | `breakdown_on_space_of_weak` | Lean proof |
| Certificate gives profile | Theorem 7.1 | `certificate_orbit`, `extended_certificate_orbit` | Lean proof, weaker conclusion |
| Finite data give blow-up | Appendix B, Proposition B.14 | `…_of_cell_system_condition` | Lean proof |
| The released certificate satisfies the conditions | §1.1, Appendix B | none | Arb computation, not yet public |

The unconditional theorem rests on the last row. Once the certificate is
released, the step to check is that the conditions the computation verifies
are those of `CellSystemCondition` as the Lean states them. Since Appendix B
leaves some conditions unwritten, that check needs the computation's own
source as well as the certificate. The authors'
README also says that a patch of 20 November 2026 changed the cell-layer
statements and the proofs that depend on them, and that the patched package
was not rebuilt before the repository was assembled.

## 5. Checks run for this page

The workflow `navier-stokes-comparator.yml` in this repository builds the
package unchanged at `ad53419` with the authors' Lean v4.33.1 and Mathlib
v4.33.1. It exports the statement files and `Solution.lean` with lean4export,
and judges them with `lake comparator` from Lean v4.36.0 and the checkers
Lean paranoid, nanoda, con-leche and con-ron. It judges the three statement
files that the authors pair with `Solution.lean` in `comparator.json`,
`comparator-certificate.json` and `comparator-cell-layer.json`. A control
states `breakdown_on_space` without its hypothesis, and Comparator must
reject it. The route is the one used for the same Mathlib in the mirror of
the Riemann Hypothesis submission at `Deicyde/riemann-hypothesis`.

Results: pending.
