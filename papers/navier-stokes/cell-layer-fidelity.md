# Cell-layer fidelity: the Lean condition and Appendix B

**Snapshot reviewed:** the supplied Alpöge–Buckmaster repository at `ad53419de079eb8f95f60313473374624a348546`, dated 20 November 2026. References below use `lean/CellLayerChallenge.lean` unless another file is named and the printed pages/equation numbers of the supplied paper.

**Status:** a source comparison, not a completed proof-checking or numerical-verification result. The supplied snapshot contains no numerical certificate and no external checker. Its root README says the cell-layer patch was not rebuilt before the repository was assembled.

## What this comparison needs to establish

The Lean implication is that data satisfying `CellSystemCondition` give the two stated breakdown conclusions. A released external checker must establish enough facts about the decoded certificate to imply that exact condition. Literal identity between two descriptions is unnecessary: a checker may verify stronger conditions. Conversely, matching many displayed equations is insufficient when some data obligations are unstated in the paper.

Here “Lean hypothesis stronger” means it asks for more of the same data. This can obstruct the bridge from the external checker. “Lean hypothesis weaker” means it asks for less. That can be sufficient if the proof of the intended conclusion is successfully checked with permitted axioms, but the direction alone does not validate the proof, statement, decoding or checker.

Appendix B explicitly leaves part of its condition unwritten. Its opening says that Propositions B.1 and B.4 are described in the paper and proved in the formalization. Those propositions supply the multiplier inequality and the cell inequalities; the paper is not a separate completed proof of these two steps.

## The definition Comparator actually sees

`CellLayerTheorems.lean` imports `Breakdown.CertCell.StatementDefs`; this is the definition closure used by the cell Comparator configuration. Reading the standalone `CellLayerChallenge.lean` is not by itself a separate check of that closure.

This review compared 20 critical declaration blocks between those files and found textual agreement: the full cell-system structure, condition-14 structures, the profile/pressure structures, the three patch sites, the principal potential and row-functional conditions, and selected mesh/assembly conditions. The first pass reported agreement for all 787 declaration blocks; that full comparison was not independently reproduced in this pass. Text agreement at these sites does not replace checking every imported definition or the mathematical interpretation.

## Conditions 1 to 15

The earlier pass sampled approximately 1,500 of the standalone file's 7,086 lines and compared all of Appendix B. This pass extended the portions identified below. “Retained” marks a first-pass comparison which was not independently repeated term by term here. The locations and conclusions added in this pass are given explicitly.

| # | Lean field | Paper counterpart | Assessment and remaining obligation |
|---|---|---|---|
| 1 | `cell : CellHypothesis` | B.1–B.3; B.11, B.19, B.21–B.22, B.25–B.43 | Many explicit constants and inequalities correspond. The full coefficient, layout, row and error formats are not written out in the paper. The detailed subtable below separates these. |
| 2 | `shape_valueSets` | B.1–B.2, pp.50–54 | All seven fields read: positive period/weight, constant weight, closure of bounds harmonics under negation and flip, inclusion of zero and the reference-profile labels. They implement the stated harmonic set and symmetries (L3050–3057). |
| 3 | `entry_conditions` | B.26–B.34, B.43 and the omitted conditions named at the end of B.4 | Partial correspondence. The top-level B.26 inequality and B.43 upper bound are identifiable. Full matrix entries and global-row representations remain unmatched. Exterior radius regularity/boundedness is explicit in Lean but compressed in the paper. See below. |
| 4 | `enclosure_numbers` | B.19 | Retained first-pass match. The enclosure conditions are repeated with the particular constants in `N` (L7033–7034); this is consistent with the existential enclosure in condition 1. |
| 5 | `coerciveL2_ge` | B.22, first inequality | Retained first-pass algebraic match after substituting coercivity 3/50 and constant weight 39/50 (L7035–7036). |
| 6 | `coercivePin_ge` | B.22, second inequality | Retained first-pass match: the lower bound is `sqrt(1000·50/3)` (L7037 with L5200–5201). |
| 7 | `certificate` | B.4's explicit list: 7.21, 7.24–7.28, 7.35–7.37 | The first-pass formula comparisons are retained. Corrected specialization: although the generic extended certificate allows a nonzero target gap, this cell system forces it to zero through condition 8. The conclusion that this path is more general because of `targetGap` was wrong. |
| 8 | `instantiation` | B.6–B.9 and pressure/adjoint data in B.1 | Extended reading found the profile formulas, affine phase dependence, spline joins, origin/axis factors, pressure exponents, pressure-gradient correction and adjoint decay in the stated form. L2783–2903 and L3799–3920. The joins are essential to interpret classical derivatives as weak derivatives without singular interface terms. |
| 9 | `offset_expansion` | Lemma B.13 and B.57–B.59 | Retained first-pass match of the expansion and far-field product bound. Open versus closed balls have the same integrals for the relevant measures; this does not remove the required measurability/integrability assumptions. |
| 10 | `shift_numbers` | Lemma B.9, B.47–B.48 | Retained comparison of the central and parameter-box errors and their combinations. Current source L6981–7000. |
| 11 | `frozen_form` | B.47–B.48 | Retained first-pass comparison of the lower frozen-form bound and error constants. |
| 12 | `adjoint_quadratic` | Lemma B.10 | Retained first-pass comparison of the two norm bounds. |
| 13 | `adjoint_links` | Setup of Lemma B.12 | Retained match of the field identifications and `fitted_empty`. This emptiness reduces the generic fitted/free decomposition to the paper's B.53 expression. |
| 14 | `potential_entries` | Potential data before Lemma B.12 and B.51 | **Partly comparable, with substantial extension.** The paper omits the precise coefficient format but states the analytic consequences. The formal shape conditions imply C¹/weak-derivative and decay properties sufficient for B.51. Full certificate-format equality cannot be established from the paper alone. L6720–6842, L6861–6890, L7007–7014 and the proof chain below. |
| 15 | `adjoint_defect` | Dual bound before Lemma B.11, B.50–B.53 | The first-pass numerical bound comparison is retained; this pass explains the B.52 signs, the matrix transpose and the skew pin-flux expression. Equality is interpreted in the weak/a.e. sense relevant to spline fields. |

### Detail for condition 1

| Part | Comparison |
|---|---|
| Row fields and weights | The first pass matched divergence-free polynomial rows, axis regularity, positive definite Gram blocks, conjugate closure and B.11/B.22's row weight. It did not run an independent construction of the Gram matrix. |
| Symmetry and constants | `azimuth_ge` requires κ≥3 (L5197), `mode_class` records the generators of Γ (L5202), and the weight/coercivity/pinning constants are 39/50, 3/50 and 1000 (L5199–5201), as in B.1/B.21/B.22. |
| Mesh degrees | The mesh permits a preliminary skeleton degree ≥−1; `IsCellModeLayouts` requires degree ≥1 on resolved harmonics (L4342–4347). Tested modes require ≥2 and volume degree ≥skeleton+2. Only azimuthal order zero is resolved on axis cells (L4681), as stated on p.57. |
| Support coverage | `ActuatorSupportFacts` L4832–4839 matches the intended cover of the forcing support when the chosen radius is nonnegative. It does **not** itself prohibit an empty mesh: at k=0 an existential radius −1 gives an empty square. This is a local observation, not a witness for the complete condition. |
| Enclosures, symmetries, weights | The first-pass comparison with B.19 and the classes of piecewise-polynomial weights is retained. The full coefficient lower-bound rules in `CoefficientConditions` have no fully written paper counterpart. |
| Leaf inequalities | L4381–4400 imposes I₂>0, I′₂≥0, lower bounds on both coefficients, bounded measurable Hermitian matrices and two quadratic inequalities. These correspond to the prose on p.58 and B.25. The latter lower bound excludes the axis, where the cylindrical form is used only a.e.; zero denominators at the axis must not be treated as pointwise identities. |
| Cell calculus/model split | L4456–4490 and L4680–4702 separate the polynomial approximation, higher-degree orthogonal part, distant harmonics, bounds on residuals, conjugate closure, and regularity. The first-pass degree and tail-factor comparison is retained. The paper describes these roles but omits their full data conditions. |
| Tree | The first-pass B.38–B.40 and pivot-count comparisons are retained. A matrix-tree pass would check the chosen data; matching the abstract induction alone does not supply that data. |
| Pairing surrogates and rectangle credits | Their purpose agrees with the prose after B.43 and the rectangle construction on p.58. Their detailed formulas remain outside the paper's explicit specification. |
| Reference/forcing shape | B.6–B.8 and the spline orders are represented explicitly by `reducedComps` and `IsTimeFieldData` (L2823–2903); compact fields have vanishing amplitudes and zero axis coefficient (L2905–2916). The first-pass Hermite data and support construction are extended by this formula reading. |
| Uniform parameter dependence | `IsBoxUniform` L5011–5020 freezes the model and weight data across the parameter box, with the intended rotation-frame exception, consistent with B.1–B.2. |

## New details that resolve earlier uncertainties

### The zero target gap is enforced

`targetGap` is `target − pinValue(profile gradient)` in `ExtendedCertificateChallenge.lean:84–85`. `IsProfileShapeEntry.target_eq` (L3854) sets those two terms equal, so condition 8 forces `targetGap=0`. The proof already records this cancellation at `Breakdown/CellReduction/InstOffsetClause.lean:321–323`. The use of a more general structure does not mean this specialized path permits every value that structure could hold.

### B.26 is visible in the assembly condition

`EliminationConditions.residual_value_le` (L5486–5488) compares `cellForm−energyLeafForm` with `potentialKept+pairingKept−top+bandEliminated+rowsEliminated`. This is the organization of B.26. The hypothesis `InRowRange` restricts the vector to compatible cell rows, including permitted gauge/head directions; the paper instead writes `x=X_Qx_g`. The intended roles agree, but a full equivalence of these representations requires the row transport and pressure-blindness arguments, not just this line.

The eliminated-mode formula divides by `bandSlack`. L5492–5495 explicitly handles its allowed zero value by requiring the corresponding residual to vanish. The positive-definite row weight and `bandSlack<1` guard the other inverses. These safeguards need to be retained in any checker-level translation.

### What can be checked for the potential fields

The data map is:

| Lean field | Paper field | Relevant analytic behavior |
|---|---|---|
| `theta` | G_j | C¹; G_j decays as r⁻² and its gradient as r⁻³. |
| `phi` | U_j | C¹; U_j decays as r⁻¹ and its gradient as r⁻². |
| `flux` | F_jᵀ under the paper's matrix convention | Decays as r⁻²; has a weak divergence given by a function. |
| `pressure` | q_j | Decays as r⁻²; has a weak gradient with the required near/far bounds. |

`IsPotentialSeries` uses explicit factors or spline endpoint vanishing to obtain these orders. Its radial and polar flux conditions ensure continuity of the respective normal flux across radial and polar partition boundaries. Tangential jumps do not by themselves create a distributional divergence supported on the interface.

The source chain is `PotentialPartsClosed.potentialParts_holds` → `PotentialShape.potentialData_of_series` → `CellLayerBreakdownCompose.adjointPotentialFacts_of_parts`. The resulting `IsPotentialData` is in `Breakdown/CellReduction/AdjointEntryDefs.lean:72–89`. It is sufficient for B.51; some derivative estimates are stronger. The derivative identities are understood almost everywhere. For r>0, the two pressure bounds r|∇q|≤C and r³|∇q|≤C imply |∇q|≤4C/[r(1+r)²], by splitting r≤1 and r≥1. Quantitative flux and gradient bounds use `matSq`, the Frobenius norm squared, so transpose does not introduce a numerical factor there. This is a source-level correspondence awaiting a build/check receipt. The omitted coefficient format and actual certificate values remain unavailable.

### The B.52 signs and transpose

The paper defines `(∇v)_{jk}=∂_jv_k` (p.31), while Lean's continuous linear map places output coordinates in rows. With that convention stated, `matrixDivergence` has the paper's `div F_jᵀ` effect. Expanding `remainderField` gives the transport adjoint, `−Δψ`, `+∇q+ΔG+wΔU` and `−div Fᵀ` with the paper's signs.

The pin flux uses the skew matrix `Dg−Dg*`. Its divergence is `Δg−∇div g`. The B.6 generator fields are divergence-free, so this supplies the paper's `+ΣY_jl ΔΦ̃_l`. More generally the discrepancy is a gradient and is handled in the weak pairing with divergence-free perturbations. These statements are about the relevant weak operators; no pointwise identity at every spline seam is asserted.

## The 20 November patch

| Item | What is established | Limit |
|---|---|---|
| Azimuthal denominator | `AzimuthalBounded` L3576–3585 uses `(\|m\|+1/2)²`, with half weights for the first two complex components, matching the dual estimate before Lemma B.11. | The former denominator `m²+1/4` is smaller for nonzero m. The new numerical obligation is weaker, requiring the sharper analytic bound; the patched proof needs to be checked. |
| A cell constant may vanish | L4385 allows `curlHessFloor≥0`, while L4383 requires `hessFloor>0`, matching I′₂≥0 and I₂>0 on p.58. | Identifying this as the README's unnamed modified constant is an inference. The prepatch diff is not supplied. |
| Active model harmonics | L5752–5760 filters out labels whose four model fields all vanish throughout the cell. It is used at L5814, L5891 and L6043. | Appendix B does not write the filter or all three coverage conditions explicitly. The draft's “used only in group_link” statement was incorrect. |

## Limits on claims of fidelity and nonvacuity

There is no basis for the broad claim that no Lean hypothesis is stronger than the paper's prose. For example, `IsDirectionRadius` (L3456–3460) explicitly requires measurability, degree-zero homogeneity, a positive uniform lower bound and a finite upper bound; the paper compresses this as a radius depending on direction (p.59). Positive continuous data on the compact set of directions would satisfy such bounds, but an arbitrary implemented function need not. The concrete certificate must resolve this.

Nor has this audit excluded every degenerate index set. `k=0`, an empty mesh and a negative existential support radius make the support-cover subconditions vacuous. Other nontriviality/coercivity/exterior obligations remain. This is a correction to the prior argument and should not be presented as a counterexample to the theorem or as a full certificate.

Similarly, the zero value of a totalized derivative at a spline kink does not alone invalidate the intended weak derivative, but a claim of harmlessness requires the regularity and measure-zero interface arguments. Some source lemmas supply those arguments; this pass did not verify every one independently.

## What to check when the numerical material is released

For each decoded object, identify which exact field of `CellSystemCondition` is established by which checker operation. Include uniform parameter ranges, endpoints and strict inequalities, spline joining and axis conditions, all mode-coverage rules, exterior-radius bounds, matrix conventions, interval rounding and the treatment of equality/zero tests. Freeze the data hash, checker revision and formal definition revision together. A successful check of a stronger concrete condition is sufficient if the implication to the formal condition is established.

## Coverage

This second pass closely read conditions 1k, 2, selected assembly parts of 3, 8 and 14; B.6–B.9 shape formulas; the B.51/B.52 potential interface; the patch uses; and the target-gap and empty-mesh arguments. It compared 20 critical declaration blocks with the statement library and visually inspected printed pp.52 and 67 to resolve pressure exponents and potential formulas.

It did not compare every coefficient or matrix entry, verify all row/gauge transportation arguments, rebuild Lean, inspect all imported definitions, or execute a numerical checker. There is no new demonstrated contradiction in the full `CellSystemCondition` and no demonstrated witness satisfying it. The numerical certificate and its checker remain the decisive absent evidence for an unconditional verification claim.
