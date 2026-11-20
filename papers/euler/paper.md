# Finite-time singularity for the Euler equations on the torus: what the Lean states

**Review snapshot: 20 November 2026, commit
[`36d3961`](https://github.com/mcoiculescu/EulerBlowupPublic/tree/36d3961161f8e7bba9cc8f671e5d0c4a27281239).**

Levent Alpöge, Tristan Buckmaster and Matei P. Coiculescu construct smooth
initial data on the three-dimensional torus $\mathbb T^3$ whose solution of the
unforced incompressible Euler equations develops a singularity in finite time.
Their repository contains the manuscript and a Lean 4 formalization of the main
theorem. The Lean proof `TorusEuler.theorem11` has no hypotheses and no
external numerical certificate. So the question this page answers is whether
the Lean proposition `TorusEuler.Theorem11` says what Theorem 1.1 of the
manuscript says, and whether that is the usual meaning of finite-time
singularity.

This page compares statements and records the limits of the available
evidence. It was prepared by AI agents under Will Cook's direction and has not
been reviewed by the authors. Reading the source, building the project,
replaying the proof with independent kernels, and a referee's reading of the
mathematics are four different results. §5 says which of them have been
obtained.

## 1. Which manuscript the Lean follows

The repository holds two versions of the manuscript. The
[README](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/README.md#L32-L51)
says the Lean follows the frozen manuscript of 18 November 2026, in
`frozen-manuscript/`, and that the arXiv version in `manuscript/` revises
Section 2 (scaled components, the reference angle and a separate coupling
lemma) and edits the introduction. The revision renumbers Section 2: for
example, the crossing result that the frozen text calls Proposition 2.6 is
Proposition 2.8 in the revised text. The authors say a formalization matching
the arXiv numbering will follow.

Theorem 1.1 itself is word for word the same in both TeX sources:
[frozen](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/frozen-manuscript/sections/01_problem.tex#L60-L77),
[arXiv](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/manuscript/source/sections/01_problem.tex#L60-L77).
Every comparison below uses the frozen text.

## 2. Theorem 1.1 as the paper states it

The torus is the cube $[-1/2,1/2]^3$ with opposite faces identified, and the
equations are

$$
\partial_t u+(u\cdot\nabla)u+\nabla p=0,\qquad \operatorname{div}u=0
\quad\text{on }\mathbb T^3\times[0,T_*).
$$

**Theorem 1.1.** There is an odd divergence-free
$u_0\in C^\infty(\mathbb T^3;\mathbb R^3)$ whose maximal classical solution $u$
is smooth and odd on $\mathbb T^3\times[0,T_*)$ for a finite $T_*>0$, and

$$
\int_0^{T_*}\|\nabla u(t)\|_{L^\infty}\,dt=\infty,\qquad
\int_0^{T_*}\|\operatorname{curl}u(t)\|_{L^\infty}\,dt=\infty,
$$

$$
\sup_{0\le t<T_*}\|u(t)\|_{L^\infty}<\infty,\qquad
\lim_{t\uparrow T_*}|\operatorname{curl}u(t,0)|=\infty.
$$

For every compact $K\subset\mathbb T^3\setminus\{0\}$ and every integer
$m\ge 0$, both $u(t)$ and $\partial_t u(t)$ converge in $C^m(K)$ as
$t\uparrow T_*$.

By the Beale–Kato–Majda criterion, the divergence of the vorticity integral is
exactly what prevents a smooth continuation past $T_*$. The bounded velocity
and the off-origin convergence say the singularity is concentrated at one
point.

## 3. The Lean statement, clause by clause

All definitions are in
[`Statement.lean`](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean),
which imports only Mathlib. `Theorem11` (lines
[120–122](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L120-L122))
asserts that there exist $u_0$, $T$, $u$ and $p$ satisfying
`EulerSingularityWitness` (lines
[107–118](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L107-L118)).
Space is $\mathbb R^3$ as `EuclideanSpace ℝ (Fin 3)`, and fields are functions
of $(t,x)\in\mathbb R\times\mathbb R^3$.

| Paper | Lean | Verdict |
|---|---|---|
| Fields on $\mathbb T^3$ | Functions on $\mathbb R^3$ invariant under every integer translation, `SpatiallyPeriodic` ([L22–24](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L22-L24)), required of $u_0$, of $u(t)$ and of $p(t)$. | Same. Periodic lifts are the standard way to represent functions on the flat torus. |
| $u_0\in C^\infty$, odd, divergence-free | `ContDiff ℝ ∞ u₀`, `Function.Odd u₀`, and `divergence u₀ x = 0` for all $x$. With `open scoped ContDiff`, `∞` is infinite differentiability, not analyticity. | Same. |
| Unforced Euler equations | `IsEulerSolution` ([L50–61](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L50-L61)): for $t\in[0,T)$ and every $x$, $\partial_t u+Du\,u+\nabla p=0$ with no force term, and $\operatorname{div}u=0$. The time derivative is taken within $[0,T)$, so it is one-sided at $t=0$. | Same. |
| $u$ smooth on $\mathbb T^3\times[0,T_*)$ | Joint smoothness of $(t,x)\mapsto u(t,x)$ and of $p$ on $[0,T)\times\mathbb R^3$. | Same, and the pressure is also required to be smooth. |
| Pressure | Periodic, with mean zero over the cell $[-1/2,1/2]^3$ at each time. | Stronger in form, same in content. The paper leaves $p$ determined up to a function of time; fixing the mean is a normalization any smooth solution admits. |
| $u(0)=u_0$ | `u 0 = u₀`. | Same. |
| $u$ odd on $[0,T_*)$ | `Function.Odd (u t)` for every $t\in[0,T)$. | Same. |
| Finite $T_*>0$ | $T$ is a real number and `IsEulerSolution` requires $0<T$. | Same. |
| Maximal classical solution | `IsMaximalEulerSolution` ([L93–97](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L93-L97)): for no $S>T$ is there a smooth periodic Euler solution on $[0,S)$ whose velocity agrees with $u$ on $[0,T)$. | Same for smooth continuation. Weaker continuation classes are excluded anyway by the curl blow-up at the origin, which no $C^1$ continuation allows. |
| "the" maximal solution | The statement is existential and says nothing about uniqueness. Uniqueness is a separate theorem, `IsEulerSolution.velocity_eq_on_common_interval` ([PeriodicEulerUniqueness.lean L51–56](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/PeriodicEulerUniqueness.lean#L51-L56)): two smooth periodic solutions with the same initial velocity agree on their common interval. | Same once both are read together. `Theorem11` alone is the existence half; the uniqueness theorem is not part of the Comparator check in §5. |
| $\int_0^{T_*}\lVert\nabla u\rVert_{L^\infty}dt=\infty$ | Lower Lebesgue integral over $[0,T)$ of `torusLInf (fderiv ℝ (u t))` equals $\infty$. `torusLInf` ([L32–33](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L32-L33)) is the essential supremum over the cell, valued in $[0,\infty]$. The norm on `fderiv` is the operator norm. | Same. The norm choice changes $\lVert\nabla u\rVert$ by at most a constant factor, which does not affect divergence. |
| $\int_0^{T_*}\lVert\operatorname{curl}u\rVert_{L^\infty}dt=\infty$ | The same with `curl (u t)`. `curl` ([L38–45](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L38-L45)) takes components $(\partial_1u_2-\partial_2u_1,\ \partial_2u_0-\partial_0u_2,\ \partial_0u_1-\partial_1u_0)$. | Same. We checked the component formula against the usual curl. |
| $\sup_t\lVert u(t)\rVert_{L^\infty}<\infty$ | There is a real $C$ with `torusLInf (u t) ≤ ENNReal.ofReal C` for all $t\in[0,T)$. | Same. |
| $\lvert\operatorname{curl}u(t,0)\rvert\to\infty$ | `Tendsto (fun t => ‖curl (u t) 0‖)` along $t\to T$ within $[0,T)$, to `atTop`. | Same. The filter is the left limit at $T$ and is nontrivial because $T>0$ ([`terminalTime_neBot`, L88–91](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L88-L91)). |
| $u(t)$, $\partial_tu(t)$ converge in $C^m(K)$, $K\subset\mathbb T^3\setminus\{0\}$ compact | `HasOffOriginLimits` ([L99–105](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/Statement.lean#L99-L105)) for $u$ and for its time derivative: for every compact $K\subset\mathbb R^3$ avoiding the integer lattice and every $m$, there are an open $U\supseteq K$ avoiding the lattice and a $C^m$ function $g$ on $U$ such that the derivatives of order $j\le m$ converge uniformly on $K$ to those of $g$. | Same. Compact sets of the punctured torus lift to compact sets of $\mathbb R^3$ avoiding the lattice, and the Lean also names the limit and requires it to be $C^m$ near $K$, which convergence in $C^m$ on a slightly larger compact set gives. |

**Junk values.** Mathlib returns default values in degenerate cases: `fderiv`
of a non-differentiable function is $0$, the Bochner integral of a
non-integrable function is $0$, and `ENNReal.toReal ⊤ = 0`. None of these can
make a clause true by accident here. The fields are required to be smooth, so
every derivative is a real one. The pressure mean is the integral of a
continuous function over a compact cell. The divergent integrals are stated in
$[0,\infty]$ as lower integrals equal to $\infty$, with no conversion to real
numbers. A junk $0$ in a derivative would make the norms smaller, never
infinite.

**Non-vacuity checks by the authors.**
[`Verify.lean`](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/Verify.lean#L31-L45)
proves that the zero field solves `IsEulerSolution` on every $[0,T)$, that the
zero field is not maximal on $[0,T)$ (it continues to $[0,T+1)$), and that
curl blow-up at the origin implies maximality. These rule out definitions that
are satisfiable for trivial reasons, and confirm that maximality is not
automatic.

**Verdict on reading the source.** `TorusEuler.Theorem11` states the frozen
Theorem 1.1 with the same data class, the same domain, zero forcing, the same
notion of maximal smooth solution, and every quantitative conclusion. It
represents the torus by periodic lifts, fixes the pressure gauge, and leaves
uniqueness to a separate declaration. We found no clause that is weaker than
the paper. This is a reading of the statement, not a check of the proof; §5
reports the machine checks.

## 4. The auxiliary note and the remark

Remark 1.2 says the solution can be chosen to extend smoothly in space and
time through $T_*$ away from the origin, with the proof in an auxiliary note.
The Lean proves this as `TorusEuler.auxiliaryTerminalSmoothness`. Its statement
`AuxiliaryTerminalSmoothness`
([TerminalAuxiliaryAssembly.lean L18–28](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/TerminalAuxiliaryAssembly.lean#L18-L28))
produces a witness of the same `EulerSingularityWitness` together with
`HasSmoothOffOriginExtension`
([TerminalSeeleyExtension.lean L132–136](https://github.com/mcoiculescu/EulerBlowupPublic/blob/36d3961161f8e7bba9cc8f671e5d0c4a27281239/formalization/lean/TorusEuler/TerminalSeeleyExtension.lean#L132-L136)):
a smooth periodic field on all times and all points off the lattice that
agrees with $u$ before $T$. Its statement also refers to the internal
construction (schedules, thresholds and stage bounds), so it cannot be checked
against Mathlib definitions alone, and we did not give it to Comparator.

## 5. Checking workflow and status

The workflow
[`euler-comparator.yml`](../../.github/workflows/euler-comparator.yml) runs on
public GitHub Actions.

1. **Build.** It fetches the authors' repository at the pinned commit, takes
   Mathlib's compiled files from the official cache, and compiles the
   `TorusEuler` package with the project's own toolchain,
   `leanprover/lean4:v4.34.0-rc2`. It then checks that no tracked author file
   changed.
2. **Challenge files.** At run time, a short script
   ([`write_harness.py`](../../.github/euler/write_harness.py)) copies the
   pinned `Statement.lean` and adds one line, the theorem
   `TorusEuler.theorem11 : TorusEuler.Theorem11` with `sorry` for its proof.
   This challenge depends only on Mathlib and the statement definitions, never
   on the proof files. Nothing of the authors' is stored in this repository,
   which has no licence to copy it.
3. **Two negative controls,** which must be rejected. In the first, the same
   theorem name states the negation of `Theorem11`. In the second, the
   theorem line is unchanged but `EulerSingularityWitness` loses the
   convergence clause for $\partial_t u$. The second control tests that
   Comparator compares the definitions a statement unfolds to, not only the
   theorem's own text.
4. **Axioms.** `#print axioms` for `theorem11`, `auxiliaryTerminalSmoothness`
   and the uniqueness theorem, and the authors' `Verify.lean`, which restates
   the expected types apart from the proof files and scans every `TorusEuler`
   declaration for axioms other than `propext`, `Classical.choice` and
   `Quot.sound`. The authors' `VerifyPaper.lean` reads TeX at the paths of
   their private tree, which this public copy renamed, so its result is
   recorded but not gated.
5. **Judge.** On a fresh runner, the compiled files are restored and checked
   against the build job's hashes. Exports are written with
   [lean4export](https://github.com/leanprover/lean4export/tree/cacf989bd75f608700820f6afc595f32e7a99a4d)
   at the commit whose toolchain is the same `v4.34.0-rc2`. Lean v4.36.0's
   `lake comparator` then replays the solution in Lean's kernel and in four
   external kernels (Lean paranoid, nanoda, con-leche and con-ron), compares
   it with the challenge, and permits only the three standard axioms.

A pass requires the first control to be rejected with Comparator's
statement-mismatch message, the second to be rejected, and the challenge to
be accepted. An infrastructure failure, such as a timeout, is not a
mathematical refutation.

**Status at the snapshot.** Run
[44826207811](https://github.com/wcook04/proof-reader/actions/runs/44826207811)
is building. Its result will be recorded here.

What a pass would establish: the proof term `TorusEuler.theorem11`, checked by
five independent kernels with only the standard axioms, proves the
proposition built from the definitions in `Statement.lean`. Whether those
definitions mean what Theorem 1.1 means is the reading in §3. Neither is a
referee's reading of the mathematics.

## 6. Public discussion found

On 20 November 2026 Terence Tao
[discussed](https://terrytao.wordpress.com/2026/11/20/unforced-euler-singularity-unforced-navier-stokes-singularity-and-the-generalized-riemann-hypothesis/)
this result alongside two others, and Tristan Buckmaster
[announced](https://mastodon.social/@tristanbuckmaster/117649035783718539) it.
Alex Korbonits
[read the released Lean statement](https://korbonits.com/blog/2026-11-20-in-decreasing-order-of-digestion/#euler-the-digested-one)
against the paper and reports that he ran no build or kernel. In the sources
we checked, we found no public build, Comparator report or referee-level
review of this proof. The MathHelm entry on Euler blow-up concerns a separate
September result on $\mathbb R^3$ with compactly supported data.
