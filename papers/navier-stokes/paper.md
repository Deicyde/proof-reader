# Finite-time blow-up for Navier–Stokes: what the Lean states

**Review snapshot: 20 November 2026, commit
[`ad53419`](https://github.com/tristanbuckmaster/navier-stokes/tree/ad53419de079eb8f95f60313473374624a348546).**

Levent Alpöge and Tristan Buckmaster's paper presents a construction of
finite-time blow-up for the three-dimensional **unforced** Navier–Stokes
equations, from smooth compactly supported divergence-free data on
$\mathbb R^3$ and smooth periodic data on $\mathbb T^3$. Its theorem gives a
blow-up rate $(T-t)^{-1/4}$ in $\dot H^1(\mathbb R^3)$, respectively
$H^1(\mathbb T^3)$, together with a description of the limiting profile. The
surrounding analysis gives stability after adjusting finitely many directions
in the initial data.

The public Lean sources supply **conditional reductions**: an appropriate
profile, or data satisfying a precise certificate condition, imply the
specified breakdown conclusions. The reviewed snapshot does not contain the
concrete numerical certificate or the program reported to validate it with
128-bit Arb arithmetic. The paper supplies its SHA-256 and says it will be
released (§§1.1, 1.5). We have not independently verified that final premise.
The root README also says the latest cell-layer patch had not been rebuilt
when this snapshot was assembled.

This page compares statements and records the limits of the available
evidence. It was prepared by AI agents under Will Cook's direction and has
not been reviewed by the authors. Source inspection, a successful proof
replay, and validation of numerical data are separate results. No completed
Lean or Comparator run is claimed by this review.

## 1. The equations and the Clay conclusions

The statement file `Challenge.lean` uses Mathlib derivatives on
`EuclideanSpace ℝ (Fin 3)`. `IsSmoothSolution` asks for joint smoothness on
$[0,\infty)\times\mathbb R^3$, the prescribed initial value, and

$$
\partial_tu+(u\cdot\nabla)u=\nu\Delta u-\nabla p,\qquad
\operatorname{div}u=0
$$

at every positive time. The coordinate trace of the second Fréchet
derivative is the Laplacian. Smoothness on the positive-time interior
prevents the derivative operators' default values from supplying an
elementary loophole.

**`BreakdownOnSpace`.** For each $\nu>0$, there is a smooth compactly
supported divergence-free datum for which no global smooth solution has
$\int_{\mathbb R^3}|u(t,x)|^2\,dx$ bounded uniformly for $t\geq0$.
The nonnegative lower Lebesgue integral (`lintegral`) and finite real bound
give the intended energy restriction; an infinite integral cannot satisfy it.

**`BreakdownOnTorus`.** For each $\nu>0$, there is a smooth divergence-free
datum of period one in each coordinate for which no global smooth solution
has periodic velocity. The pressure may be any smooth pressure.

These propositions imply Fefferman's (C) and (D) by taking the force to be
zero. Smooth compactly supported data have all the required rapid-decay
bounds. Every solution in the official class satisfies the positive-time
equation used here. Excluding this larger candidate class is sufficient.
The official Clay PDF's **Errata explicitly adds pressure periodicity**;
the Lean torus conclusion excludes a larger pressure class and therefore
also excludes that corrected class. “Take $\nu>0$” in the official statement
already means arbitrary positive viscosity, so there is no additional
viscosity-quantifier advantage.

Sources: `Challenge.lean:10–45`;
[official Clay statement, (4)–(11), (C), (D), and Errata](https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf).
This implication is a mathematical interpretation of the definitions, not
a newly checked Lean translation of Fefferman.

## 2. A profile gives breakdown

`PeriodicSimilarityProfileExists` requires smooth $W(s,y)$ and $q(s,y)$,
a positive period $P$, a linear isometric equivalence $R$, and a finite
constant $C$, with

$$
\partial_sW+\tfrac12W+\tfrac12(y\cdot\nabla)W-\Delta W+
(W\cdot\nabla)W+\nabla q=0,\qquad \operatorname{div}W=0,
$$

$$
W(s+P,y)=R\,W(s,R^{-1}y),\qquad W\not\equiv0,
$$

and $|\nabla^jW|\leq C(1+|y|)^{-1-j}$ for $j=0,1,2$, together with
$|\nabla q|\leq C(1+|y|)^{-3}$. The equation and recurrence match (1.2).
The full Lean premise has additional written bounds relative to (1.3):
Remark 1.2 derives the higher velocity bound, and the README attributes the
pressure-gradient bound to standard analysis.

The definition explicitly excludes zero velocity and a zero or negative
period. Smoothness, an actual isometric equivalence and finite constants
also rule out the elementary derivative, singular-map and infinite-bound
degeneracies considered in this review. This is not a construction of a
profile or an exhaustive proof that every possible modeling error is absent.

For $\nu=1$, the substitution
$u(t,x)=(T-t)^{-1/2}W(-\log(T-t),x/\sqrt{T-t})$ gives the displayed
similarity equation. A constant shift of similarity time accounts for the
paper's choice $\log(T/(T-t))$. A profile stationary in $s$ is continuously
self-similar; a profile recurrent in $s$ permits discrete self-similarity.
The classical stationary-profile exclusions do not automatically exclude
this latter possibility.

| Lean theorem | Comparison with the paper |
|---|---|
| `breakdown_on_space` | Coarser formal output than Theorem 1.1: no global smooth solution with uniformly bounded energy. It omits the trajectory, rate and convergence. Its written premise has the extra bounds above. |
| `breakdown_on_torus` | Coarser formal output than Theorem 1.1, but excludes arbitrary smooth pressure. Relating the paper's solution class to this endpoint needs pressure normalization as well as uniqueness. |
| `breakdown_on_space_of_weak` | A different explicit weak-profile theorem. No separate paper theorem has precisely its hypothesis; Proposition 7.11 and Theorem 1.1 provide a related regularization-and-breakdown route. |

Passing from an exhibited singular trajectory to a nonexistence endpoint
requires that any hypothetical global solution agree with it and have
bounded enstrophy through the proposed blow-up time. The authors' README
explains the finite-energy and generalized Galilean routes using
[Tao (2013)](https://msp.org/apde/2013/6-1/apde-v6-n1-p02-s.pdf).
It is too compressed to call this merely “uniqueness of smooth solutions.”
Finite-codimension stability belongs to the paper's further analysis,
including Proposition 2.1, rather than these Lean conclusion types.

The weak profile requires a positive period and twisted recurrence, uniform
$L^6$ velocity and $L^2$ gradient bounds, square-integrable second derivatives
over a period, and the distributional equation against solenoidal tests.
It also requires that the field is **not almost everywhere zero** and that
each weak residual is integrable before its integral is set to zero.
The coefficients $-1$ and $-1/2$ in its weak drift terms follow by integration
by parts in three dimensions. A modification of zero on a null set is not
a witness.

Sources: `Challenge.lean:47–108`; `Solution.lean:17–24`;
`README.md:23–53`; paper Theorem 1.1, Remark 1.2, Proposition 2.1,
Proposition 7.11.

## 3. A certificate gives a profile

**`certificate_orbit` and `extended_certificate_orbit`.** Their stated
output is weaker than Theorem 7.1's output: they return abstract weak-profile
existence, without the prescribed nearby parameter, explicit closeness,
period/isometry and symmetries recorded in the paper. A blanket verdict
that the *whole theorem* is weaker would also require an established
comparison of the hypotheses. The two formal certificate structures differ,
and this audit has not proved the required implication between all their
conditions and those in the paper.

The authors' README describes thirteen differences as a reading comparison.
That is not an independently checked entailment. Nor should the weaker
exported output suggest that the library lacks a weak-to-smooth result:
`Breakdown/CertTorus/Main.lean:8–10` explicitly supplies
`WeakPeriodicSimilarityProfileExists → PeriodicSimilarityProfileExists`.

**The three `…_of_cell_system_condition` theorems.** Seven data/entry
arguments satisfying the fifteen fields of `CellSystemCondition` give
`BreakdownOnSpace`, `BreakdownOnTorus`, or their conjunction. Their paper
counterpart is the composite route through Appendix B, Proposition B.14,
Theorem 7.1 and Corollary 7.2. These theorem types supply an implication;
they do not supply concrete data satisfying the premise.

The expanded [cell-layer comparison](cell-layer-fidelity.md) records a
partial correspondence. Several earlier assertions needed correction:

- The cell instantiation forces `targetGap=0`. The generic extended
  certificate's allowance of a nonzero gap does not survive this specialization.
- The claimed local exclusion of an empty mesh was invalid. With no
  actuators, a negative existential support radius makes that coverage
  clause vacuous. This does not satisfy the remaining full certificate.
- The active-harmonic filter has three users: `group_link`, `groups_cover`
  and `rows_groups_cover`.
- Condition 14 has an inspectable route to the regularity and decay in
  (B.51), although the paper does not supply its complete coefficient format.
- Direction-dependent exterior radii carry explicit measurability,
  homogeneity and uniform lower/upper-bound obligations. An arbitrary
  implementable choice need not satisfy them.

The azimuthal weight $(|m|+1/2)^2$ matches the displayed paper estimate.
Identifying the README's unnamed nonnegative cell constant with
`curlHessFloor_nonneg` remains a plausible inference pending a prepatch
diff. Neither finding replaces checking the patched proofs.

The comparator target `CellLayerTheorems.lean` imports
`Breakdown.CertCell.StatementDefs`, rather than the standalone
`CellLayerChallenge.lean` used for reading. Twenty critical declaration
blocks were compared in this review and agreed textually. A claimed
first-pass comparison of all 787 blocks was not independently reproduced.

Sources: `CellLayerChallenge.lean:3854,4832–4839,5193–5194,5752–5760,5814–5816,5890–5891,6042–6043,7007–7046`;
`CellLayerTheorems.lean:1–29`; paper Appendix B, especially (B.51)–(B.56)
and the closing qualification on omitted conditions.

## 4. The outstanding certificate bridge

The required implication is

$$
\text{CheckerAccepts(bytes)}
\;\Longrightarrow\;
\text{CellSystemCondition(decode(bytes))}
\;\Longrightarrow\;
\text{BreakdownOnSpace}\land\text{BreakdownOnTorus}.
$$

Exact equality between paper and Lean descriptions is unnecessary: an
external checker may establish stronger conditions that imply the Lean
premise. Matching many formulas is insufficient if a required field,
decoding convention, domain or tail bound is missing.

| Item | Evidence in the reviewed snapshot |
|---|---|
| Profile-to-breakdown and certificate-to-profile arguments | Paper exposition and Lean proof sources; narrower exported conclusions as described above. |
| Cell conditions imply the breakdown endpoints | Lean proof sources. Appendix B says Propositions B.1 and B.4 are proved in the formalization. |
| Concrete certificate satisfies the exact conditions | Authors' report of an external computation; neither certificate nor checker supplied. |
| Successful rebuild/replay of the patched package | No completed result established by this review. |

The hash identifies the intended certificate bytes once obtained. It does
not establish the inequalities or their interpretation. A useful future
receipt will map each of the fifteen fields to the actual decoded data,
checker source and verified bounds, including all cells and the exterior.

## 5. Checking workflow and status

The proposed corrected workflow builds at the authors' pinned commit with
Lean/Mathlib 4.33.1 and judges exports with Lake Comparator 4.36.0. It uses
the authors' three configurations, selecting **15 theorem statements**,
and explicitly configures Lean paranoid, nanoda, con-leche and con-ron in
addition to the built-in check. These are five checks, not five independent
implementations. The `PrintAxioms` step is a diagnostic for 27 named
declarations.

The earlier workflow did not enforce its build or Comparator exits and
did not explicitly build its added control module. The proposed replacement
fails an incomplete build, builds that module, and requires:

1. rejection of the control with exit 1 and the precise statement-mismatch
   diagnostic for `Breakdown.breakdown_on_space`;
2. exit 0 for all three intended positive comparisons.

It separates building and judging into jobs with independent time budgets
and requires the exact cache from the successful build. Source integrity and
input identities are recorded. This does not fully establish the provenance
of every compiled dependency or the semantic fidelity of shared definitions.
[The versioned Lake manual](https://lean-lang.org/doc/reference/4.36.0/Build-Tools-and-Distribution/Lake/)
explains that judging pre-existing exports does not connect them back to
workspace source files by itself.

**Build (Actions run 44774695098, 20 November 2026).** The package as
published, with the patch of 20 November, compiled on a GitHub-hosted
ubuntu-24.04 runner: `lake build` of every default target exited 0 after
7,735 seconds. Mathlib's compiled files came from its official cache. The
authors' script `scripts/PrintAxioms.lean` then reported that each of the 27
theorems it lists depends on the axioms `propext`, `Classical.choice` and
`Quot.sound` and on no others. That script prints diagnostics for those names;
it is not an enforcing audit of every theorem.

**Comparator.** Not yet established. Run 44796269901 compiled the package
again (exit 0 after 7,680 seconds) and wrote all five exports, but Comparator
judged nothing: each of the four calls stopped with exit code 2 because the
external checker `leanchecker-paranoid` was not on the runner's PATH. Lake
finds external checkers by a PATH lookup, and Lean v4.36.0 ships all four in
its toolchain directory, which elan does not put on PATH. That run's job still
showed green, because the earlier workflow wrote exit codes to files without
failing on them. The corrected workflow above puts the toolchain directory on
PATH, stops if any checker is missing, and fails unless the control is
rejected and the three statement files are accepted. Its run, 44817368429,
reuses the compiled files of run 44809248303, and its result is the one this
page will report.

## 6. Historical scope

This is an unforced smooth-data claim. The
[8 September 2026 announcement](https://openai.com/index/navier-stokes-solution/)
concerned forced Navier–Stokes; the
[11 September CMI statement](https://www.claymath.org/news/navier-stokes-announcement/)
does not validate this later construction. The distinction matters because
zero-force counterexamples would refute the unforced regularity alternatives
(A)/(B) as well as supply examples for (C)/(D).

[Bradshaw–Tsai's Open Problem 5.1](https://arxiv.org/html/1610.05680v1)
is a particularly direct antecedent for backward recurrent profiles.
[Pineau–Vicol's August 2026 version](https://arxiv.org/abs/2607.09619v2)
also belongs in the discussion: its exclusions concern specified parameter
regimes and do not constitute a blanket prohibition of these profiles.
Public announcement and reaction posts are not proof reviews.
