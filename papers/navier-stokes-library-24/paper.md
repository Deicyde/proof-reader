# Library guide 24: Breakdown/FracCert

**Navier–Stokes pages:** [the paper](../navier-stokes-paper/paper.pdf) · [proof routes](../navier-stokes-routes/paper.md) · [routes in detail](../navier-stokes-route-details/paper.md) · library guide: [1](../navier-stokes-library-01/paper.md) [2](../navier-stokes-library-02/paper.md) [3](../navier-stokes-library-03/paper.md) [4](../navier-stokes-library-04/paper.md) [5](../navier-stokes-library-05/paper.md) [6](../navier-stokes-library-06/paper.md) [7](../navier-stokes-library-07/paper.md) [8](../navier-stokes-library-08/paper.md) [9](../navier-stokes-library-09/paper.md) [10](../navier-stokes-library-10/paper.md) [11](../navier-stokes-library-11/paper.md) [12](../navier-stokes-library-12/paper.md) [13](../navier-stokes-library-13/paper.md) [14](../navier-stokes-library-14/paper.md) [15](../navier-stokes-library-15/paper.md) [16](../navier-stokes-library-16/paper.md) [17](../navier-stokes-library-17/paper.md) [18](../navier-stokes-library-18/paper.md) [19](../navier-stokes-library-19/paper.md) [20](../navier-stokes-library-20/paper.md) [21](../navier-stokes-library-21/paper.md) [22](../navier-stokes-library-22/paper.md) [23](../navier-stokes-library-23/paper.md) **24** [25](../navier-stokes-library-25/paper.md) [26](../navier-stokes-library-26/paper.md) [27](../navier-stokes-library-27/paper.md) [28](../navier-stokes-library-28/paper.md) [29](../navier-stokes-library-29/paper.md) [30](../navier-stokes-library-30/paper.md)

*A plain title and a sentence for each declaration in `Breakdown.FracCert.KernelDyadicPiece` to `Breakdown.FracCert.WeakToProfile` of Alpöge and Buckmaster's Lean at `ad53419de079eb8f95f60313473374624a348546`, in the authors' file order. Prepared with AI assistance. The authors have not reviewed it.*

Each paragraph names one declaration and says whether it is a definition, a proposition that the library defines (its name usually ends in `Holds` or `Statement`) or a proved result, then what it states. Click a paragraph to open its Lean on the right.

### Breakdown.FracCert.KernelDyadicPiece

Combines near-field and far-field estimates for each dyadic homogeneous multiplier kernel.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicPiece.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.KernelDyadicPiece`.

**Convolution integrates f(w)k(x−w).** Proved result `kernelConv_eq`: Kernel convolution at x equals ∫f(w)k(x−w) dw.

**Power bounds for near-field pieces.** Proved result `near_bound`: Under the stated hypotheses, near-field dyadic pieces have power bounds.

**Source namespace:** `Breakdown.FracCert`.

**Far bounds complete the piece estimate.** Proved result `dyadicPieceBound_of_far`: Under the stated assumptions, this establishes that for a nonnegative homogeneous degree d and a weighted smooth input of exponent 0<β<3, the nth derivative of each dyadic convolution obeys the stated near-region bound 2^((d+n+β)l) and the two explicit far-region power bounds for ‖x‖≥2.

### Breakdown.FracCert.KernelDyadicPieceFar

Establishes annular-symbol regularity and convolution estimates used for the far-field dyadic bound.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicPieceFar.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.KernelDyadicPieceFar`.

**Comparable radii have comparable weights.** Proved result `weight_shift`: Under the stated hypotheses, comparable radii have comparable weights.

**Convolution derivatives reach the kernel.** Proved result `conv_iteratedFDeriv`: Under the stated hypotheses, convolution derivatives act on the kernel.

**Inverse powers compare by scale.** Proved result `rpow_neg_four_le`: Under the stated hypotheses, inverse powers compare by scale.

**The annular cutoff vanishes near zero.** Proved result `ring_zero_small`: Under the stated hypotheses, the annular cutoff vanishes near zero.

**The annular cutoff vanishes far away.** Proved result `ring_zero_large`: Under the stated hypotheses, the annular cutoff vanishes far away.

**An annularly localized symbol is smooth.** Proved result `ring_symbol_contDiff`: Under the stated hypotheses, an annularly localized symbol is smooth.

**The localized symbol has compact support.** Proved result `ring_symbol_hasCompactSupport`: Under the stated hypotheses, the localized symbol has compact support.

**Annular symbol derivatives are bounded.** Proved result `ring_symbol_bound`: Under the stated hypotheses, annular symbol derivatives are bounded.

**Annular kernels and derivatives decay.** Proved result `ring_kernel_props`: Under the stated hypotheses, annular kernels and derivatives decay.

**Scaled kernels have derivative bounds.** Proved result `scaled_deriv_le`: Under the stated hypotheses, scaled kernels have derivative bounds.

**Radial convolution weights are L¹.** Proved result `near_integral`: Under the stated hypotheses, radial convolution weights are integrable.

**Source namespace:** `Breakdown.FracCert`.

**Far-field dyadic pieces satisfy a bound.** Proposition `FarPieceBoundStatement`: This proposition requires that for a nonnegative homogeneous symbol degree d, 0<β<3 and a ring cutoff, the nth derivative of each far-field dyadic convolution is bounded by C2^((d−1−⌈d⌉)l)‖x‖^(−1−β−⌈d⌉−n) when ‖x‖≥2 and 2^l‖x‖>1.

### Breakdown.FracCert.KernelDyadicPieceFarBound

Combines the inner and outer convolution estimates to close the far-field dyadic piece contract.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicPieceFarBound.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The far-field dyadic bound holds.** Proved result `farPieceBound`: Under the stated assumptions, this establishes that for a nonnegative homogeneous symbol degree d, 0<β<3 and a ring cutoff, the nth derivative of each far-field dyadic convolution is bounded by C2^((d−1−⌈d⌉)l)‖x‖^(−1−β−⌈d⌉−n) when ‖x‖≥2 and 2^l‖x‖>1.

### Breakdown.FracCert.KernelDyadicPieceFarParts

Splits a dyadic convolution into inner and outer regions, moving derivatives through Fourier factors to gain far-field decay.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicPieceFarParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.KernelDyadicPieceFarParts`.

**Finite derivative orders are bounded.** Proved result `natCast_le_infty`: Under the stated hypotheses, finite derivative orders are below infinity.

**A smooth cutoff with bounds exists.** Proved result `cutoff_exists`: Under the stated hypotheses, a smooth cutoff with bounds exists.

**Dyadic exponents combine exactly.** Proved result `exp_identity`: Under the stated hypotheses, dyadic exponents combine exactly.

**Localized symbols stay inside an annulus.** Proved result `ring_supp`: Under the stated hypotheses, localized symbols stay inside an annulus.

**inner convolution has the required decay.** Proved result `inner_est`: Under the stated hypotheses, the inner convolution has the required decay.

**Scaled kernel derivatives retain decay.** Proved result `scaled_kernel_decay`: Under the stated hypotheses, scaled kernel derivatives retain decay.

**Each dyadic kernel derivative decays.** Proved result `dyadic_kernel_decay`: Under the stated hypotheses, each dyadic kernel derivative decays.

**A decaying scalar times a kernel is L¹.** Proved result `integrable_smul_decay`: Under the stated hypotheses, a decaying scalar times a kernel is L¹.

**The reversed decaying product is L¹.** Proved result `integrable_decay_smul`: Under the stated hypotheses, the reversed decaying product is L¹.

**The Laplacian-divided annular symbol.** Definition `quotSymbol`: This defines the quotient symbol obtained by dividing a cutoff symbol by the Fourier factor for p applications of the Laplacian.

**The divided symbol is smooth.** Proved result `quot_contDiff`: Under the stated hypotheses, the divided symbol is smooth.

**The divided symbol stays in the annulus.** Proved result `quot_supp`: Under the stated hypotheses, the divided symbol stays in the annulus.

**The divided symbol has compact support.** Proved result `quot_hasCompactSupport`: Under the stated hypotheses, the divided symbol has compact support.

**divided symbol has bounded derivatives.** Proved result `quot_bound`: Under the stated hypotheses, the divided symbol has bounded derivatives.

**The divided inverse kernel decays.** Proved result `quot_kernel_props`: Under the stated hypotheses, the divided inverse kernel decays.

**Coordinate products expand radial powers.** Proved result `sum_prod_coord`: Under the stated hypotheses, coordinate products expand radial powers.

**Inverse derivatives have symbol formulas.** Proved result `deriv_eq_integral`: Under the stated hypotheses, inverse derivatives have Fourier formulas.

**Annular kernels split into derivatives.** Proved result `ring_factor`: Under the stated hypotheses, annular kernels split into derivatives.

**Convolution differentiates the field.** Proved result `conv_deriv_right`: Under the stated hypotheses, convolution derivatives move to the field.

**Iterating derivatives adds the orders.** Proved result `norm_iter_iter`: Under the stated hypotheses, iterating derivatives adds the orders.

**Derivative evaluations have a norm bound.** Proved result `apply_deriv`: Under the stated hypotheses, evaluating derivatives has a product bound.

**Dilation rescales evaluated derivatives.** Proved result `scale_apply`: Under the stated hypotheses, dilation rescales evaluated derivatives.

**The outer core has a derivative bound.** Proved result `outer_core`: Under the stated hypotheses, derivative transfer bounds the outer core.

**Cutoff powers simplify by scaling.** Proved result `cutoff_identity`: Under the stated hypotheses, cutoff powers simplify by scaling.

**Outer cutoff derivatives have decay.** Proved result `outer_cutoff`: Under the stated hypotheses, outer cutoff derivatives have decay.

**Outer dyadic exponents combine exactly.** Proved result `exp_identity_outer`: Under the stated hypotheses, outer dyadic exponents combine exactly.

**outer convolution has the required decay.** Proved result `outer_est`: Under the stated hypotheses, the outer convolution has the required decay.

### Breakdown.FracCert.KernelDyadicSplit

Reconstructs a homogeneous Fourier multiplier and its derivatives from annular dyadic convolution pieces.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicSplit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**nonzero scaled cutoff locates an annulus.** Proved result `cut_support`: Under the stated hypotheses, a nonzero scaled cutoff locates an annulus.

**The cutoff vanishes at the origin.** Proved result `cut_zero`: Under the stated hypotheses, the cutoff vanishes at the origin.

**A scaled localized symbol is smooth.** Proved result `cut_smooth`: Under the stated hypotheses, a scaled localized symbol is smooth.

**A scaled localized symbol is compact.** Proved result `cut_compact`: Under the stated hypotheses, a scaled localized symbol is compact.

**Convolution is inverse multiplication.** Proved result `conv_eq`: Under the stated hypotheses, convolution equals inverse multiplication.

**The dyadically rescaled cutoff.** Definition `scaledCut`: This defines the dyadic cutoff at index l by evaluating the base cutoff at 2^(−l)ξ.

**Dyadic kernels are localized inverses.** Proved result `kernel_eq`: Under the stated hypotheses, dyadic kernels are localized inverses.

**Bounded weights preserve moments.** Proved result `moments_mul`: Under the stated hypotheses, bounded weights preserve integrable moments.

**Reflection preserves integrable moments.** Proved result `moments_neg`: Under the stated hypotheses, reflection preserves integrable moments.

**Reflection preserves measurability.** Proved result `meas_neg`: Under the stated hypotheses, reflection preserves measurability.

**All moments give a smooth inverse.** Proved result `smooth_inv`: Under the stated hypotheses, all moments give a smooth inverse.

**Fourier formulas for inverse derivatives.** Proved result `iter_inv`: Under the stated hypotheses, inverse derivatives have integral formulas.

**Fourier differentiation respects weights.** Proved result `psr_smul`: Under the stated hypotheses, Fourier derivative factors respect weights.

**Dyadic pieces reconstruct the multiplier.** Proved result `dyadicSplit`: Under the stated assumptions, this establishes that under the homogeneous multiplier, ring cutoff, weighted smoothness and integrable symbol-moment hypotheses, the inverse multiplier transform is smooth and each derivative is the sum over all dyadic convolution derivatives.

### Breakdown.FracCert.KernelDyadicSum

Proves summability and radial bounds for dyadic power weights by shifting the spatial radius to unit scale.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDyadicSum.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.KernelDyadicSumInternal`.

**The model dyadic summand.** Definition `baseTerm`: This defines the model dyadic summand 2^(am)(1+2^m)^(−N).

**The dyadic summand is nonnegative.** Proved result `baseTerm_nonneg`: Under the stated hypotheses, the dyadic summand is nonnegative.

**The model dyadic series converges.** Proved result `baseTerm_summable`: Under the stated hypotheses, the model dyadic series converges.

**A dyadic shift normalizes the radius.** Proved result `term_le`: Under the stated hypotheses, a dyadic shift normalizes the radius.

**A unit-scale dyadic shift exists.** Proved result `exists_shift`: Under the stated hypotheses, a unit-scale dyadic shift exists.

**Source namespace:** `Breakdown.FracCert`.

**Dyadic power sums have radial decay.** Proved result `dyadicSum`: Under the stated assumptions, this establishes that for 0<a<N, the two-sided dyadic series ∑2^(al)(1+2^l r)^(−N) is summable and bounded by Cr^(−a) for every r>0.

### Breakdown.FracCert.KernelExports

Exports the closed estimate for a single dyadic homogeneous multiplier piece.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelExports.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The dyadic piece estimate is proved.** Proved result `dyadicPieceBound`: Under the stated assumptions, this establishes that for a nonnegative homogeneous degree d and a weighted smooth input of exponent 0<β<3, the nth derivative of each dyadic convolution obeys the stated near-region bound 2^((d+n+β)l) and the two explicit far-region power bounds for ‖x‖≥2.

### Breakdown.FracCert.KernelMultiplier

Sums the near- and far-scale bounds to obtain weighted spatial decay for a homogeneous Fourier multiplier.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelMultiplier.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.KernelMultiplier`.

**Far-scale powers fit a summable weight.** Proved result `far_le`: Under the stated hypotheses, far-scale powers fit a summable weight.

**Near-scale powers fit a summable weight.** Proved result `near_le`: Under the stated hypotheses, near-scale powers fit a summable weight.

**Three majorants control the whole sum.** Proved result `combine`: Under the stated hypotheses, three majorants control the whole sum.

**The piecewise bound has three majorants.** Proved result `pointwise`: Under the stated hypotheses, the piecewise bound has three majorants.

**Far-field dyadic sums have radial decay.** Proved result `far_sum`: Under the stated hypotheses, far-field dyadic sums have radial decay.

**Source namespace:** `Breakdown.FracCert`.

**Homogeneous multipliers preserve decay.** Proved result `homogeneousMultiplier_of`: Under the stated assumptions, this establishes that a Fourier multiplier smooth away from zero and homogeneous of degree d≥0 sends a weighted smooth input of exponent 0<β<3 to one of exponent β+d, provided its Fourier representation and all required L¹ moments exist.

### Breakdown.FracCert.KernelPiece

Uses compact support and derivative bounds of a Fourier symbol to obtain rapid decay of its transformed kernel.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelPiece.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.KernelPieceInternal`.

**Compact symbol derivatives have moments.** Proved result `moment_integrable`: Under the stated hypotheses, compact symbol derivatives have moments.

**Compact derivatives have moment bounds.** Proved result `moment_le`: Under the stated hypotheses, support and derivative bounds control moments.

**The kernel moment constant.** Definition `term`: This defines an explicit nonnegative derivative-bound constant from powers of 2π, derivative orders, finite sums and the volume of the radius-four ball.

**The kernel decay constant.** Definition `const`: This defines the kernel-bound constant as 2^N times the sum of the zeroth and Nth auxiliary derivative constants.

**The moment constant is nonnegative.** Proved result `term_nonneg`: Under the stated hypotheses, the moment constant is nonnegative.

**Fourier derivatives have weighted decay.** Proved result `transform_bound`: Under the stated hypotheses, Fourier derivatives have weighted decay.

**Source namespace:** `Breakdown.FracCert`.

**The localized kernel estimate holds.** Proved result `pieceKernel`: Under the stated assumptions, this establishes that a smooth symbol supported in the fixed annulus 1/4≤‖ξ‖≤4 with derivatives bounded through order N+j+4 has a smooth inverse transform whose jth derivative, weighted by (1+‖x‖)^N, is bounded by C times that derivative bound.

### Breakdown.FracCert.KernelRingCutoff

Constructs a smooth annular partition of unity from two radial cutoffs.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelRingCutoff.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The difference of two radial cutoffs.** Definition `ringProfile`: This defines an annular cutoff as the radius-one radial cutoff minus the radius-one-half cutoff.

**The ring cutoff has a transition formula.** Proved result `ringProfile_eq`: Under the stated hypotheses, the ring cutoff has a transition formula.

**The ring cutoff is smooth.** Proved result `ringProfile_contDiff`: Under the stated hypotheses, the ring cutoff is smooth.

**ring cutoff lies between zero and one.** Proved result `ringProfile_bounds`: Under the stated hypotheses, the ring cutoff lies between zero and one.

**Nonzero ring values lie in an annulus.** Proved result `ringProfile_support`: Under the stated hypotheses, nonzero ring values lie in an annulus.

**Ring cutoffs obey radial scaling.** Proved result `ringProfile_smul`: Under the stated hypotheses, ring cutoffs obey radial scaling.

**Negative dyadic powers are reciprocals.** Proved result `two_rpow_neg_int`: Under the stated hypotheses, negative dyadic powers are reciprocals.

**Dyadic ring cutoffs sum to one.** Proved result `ringProfile_hasSum`: Under the stated hypotheses, dyadic ring cutoffs sum to one.

**The annular partition exists.** Proved result `ringCutoff`: Under the stated assumptions, this establishes that a smooth annular cutoff satisfying the dyadic partition requirements exists.

### Breakdown.FracCert.KernelScaling

Records the spatial scaling and reality of the fractional projected heat-divergence kernel.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelScaling.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The heat symbol rescales its time.** Proved result `symbol_scale`: Under the stated hypotheses, the heat symbol rescales its time.

**The heat symbol has conjugate symmetry.** Proved result `symbol_neg`: Under the stated hypotheses, the heat symbol has conjugate symmetry.

**The heat kernel obeys spatial scaling.** Proved result `kernel_scale`: Under the stated hypotheses, the heat kernel obeys spatial scaling.

**The heat-divergence kernel is real.** Proved result `kernel_real`: Under the stated hypotheses, the heat-divergence kernel is real.

**Real powers commute with cubing.** Proved result `rpow_pow_three`: Under the stated hypotheses, real powers commute with cubing.

**The kernel scaling interface follows.** Proved result `kernelScaling_of`: Under the stated assumptions, this establishes that for α>0 and t>0, the projected kernel is real, integrable and in L³⁄², obeys the t^(−2/α) spatial rescaling, and has L¹ and L³⁄² norms scaling respectively by t^(−1/(2α)) and t^(−1/α).

### Breakdown.FracCert.LinearSolve

Uses the a priori estimate to show the bordered operator has trivial kernel, then obtains a solution by compact perturbation.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/LinearSolve.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.LinearSolveInternal`.

**Negatives of gradients are gradients.** Proved result `gradient_neg`: Under the stated hypotheses, negatives of gradients are gradients. Source: `Breakdown.FracCert.LinearSolve:14`.

**Almost-zero fields have zero L² norm.** Proved result `l2Norm_ae_zero`: Under the stated hypotheses, almost-zero fields have zero L² norm.

**Almost-zero fields have zero pairings.** Proved result `l2Pair_ae_zero`: Under the stated hypotheses, almost-zero fields have zero pairings.

**The matching gradient cancels the field.** Proved result `sub_ae_zero`: Under the stated hypotheses, subtracting the matching gradient vanishes.

**Gradients have zero projected norm.** Proved result `projectedNorm_zero`: Any field equal almost everywhere to a weak gradient field has projected norm zero.

**Gradients have zero row seminorm.** Proved result `rowSeminorm_zero`: Any field equal almost everywhere to a weak gradient field has row seminorm zero for every finite row family and every choice of row weights.

**Zero basis values give the zero map.** Proved result `clm_eq_zero`: Under the stated hypotheses, zero basis values give the zero map.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.LinearSolve:79`.

**Zero matrix energy gives the zero map.** Proved result `eq_zero_of_entrySq`: Under the stated hypotheses, zero matrix energy gives the zero map.

**Source namespace:** `Breakdown.SteadyCert`.

**The bordered kernel is trivial.** Proved result `linearKernel`: Assuming the a priori estimate and inverse-square bound interfaces, for 1<α<5/4 a valid fractional certificate at a parameter in its box forces a linear state with gradient bordered field and zero pins to have zero free residual almost everywhere and zero multiplier vector.

**Solve the bordered equation.** Proved result `linearSolve`: Assuming the twelve analytic interfaces for the a priori bound, free solution theory, compactness, solenoidal splitting, closure, orthogonality, Hardy control, symmetry, and weak-power differences, for 1<α<5/4 a valid fractional certificate solves every L² symmetry-class forcing at each parameter in its box modulo a weak gradient and with arbitrary prescribed pin values.

### Breakdown.FracCert.LinearSolveCore

Builds the free inverse, compact convection operator and finite-dimensional border on a closed solenoidal symmetry subspace of L².

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/LinearSolveCore.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Symmetric products preserve the class.** Proposition `ProductClassStatement`: This proposition requires that the symmetric convection product of a C¹ symmetry-class profile and a second-order field in that class remains in the same symmetry class.

**The bordered kernel is trivial.** Proposition `LinearKernelStatement`: This proposition requires that for a valid fractional certificate, if a linear state’s bordered field is a gradient and every pin vanishes, then its free residual vanishes almost everywhere and its multiplier vector is zero.

**Source namespace:** `Breakdown.SteadyCert.LinearSolveCore`.

**The discrete turn has three coordinates.** Proved result `turnStep_apply`: Under the stated hypotheses, the discrete turn has three coordinates.

**Reflection negates the third coordinate.** Proved result `mirror_apply`: Under the stated hypotheses, reflection negates the third coordinate. Source: `Breakdown.FracCert.LinearSolveCore:35`.

**The discrete turn as a linear map.** Definition `turnStepLinear`: This equips the discrete axial turn with its real linear map structure.

**Reflection as a linear map.** Definition `mirrorLinear`: This equips reflection of the third coordinate with its real linear map structure.

**The discrete turn preserves norms.** Proved result `norm_turnStep`: Under the stated hypotheses, the discrete turn preserves norms.

**Reflection preserves norms.** Proved result `norm_mirror`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.LinearSolveCore:65`.

**The discrete turn as an isometry.** Definition `turnStepIsometry`: This equips the discrete axial turn with its norm-preserving linear equivalence structure.

**Reflection as an isometry.** Definition `mirrorIsometry`: This equips reflection of the third coordinate with its norm-preserving linear equivalence structure.

**The discrete turn preserves volume.** Proved result `turnStep_measurePreserving`: Under the stated hypotheses, the discrete turn preserves volume.

**Reflection preserves volume.** Proved result `mirror_measurePreserving`: Under the stated hypotheses, reflection preserves volume.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg'`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.LinearSolveCore:87`.

**Basis images control linear-map action.** Proved result `norm_apply_le_entries`: Under the stated hypotheses, basis images control linear-map action.

**Derivative columns lie in L².** Proved result `entry_memLp`: Under the stated hypotheses, derivative columns lie in L².

**Decaying profile products lie in L².** Proved result `symProduct_memLp`: Under the stated hypotheses, decaying profile products lie in L².

**The real vector-field L² space.** Abbreviation `FieldL2`: This abbreviates the real Hilbert space L² of spatial vector fields.

**Test gradients are continuous.** Proved result `gradientAt_continuous`: Under the stated hypotheses, test gradients are continuous.

**Test gradients have compact support.** Proved result `gradientAt_hasCompactSupport`: Under the stated hypotheses, test gradients have compact support.

**Test gradients lie in L².** Proved result `gradientAt_memLp`: Under the stated hypotheses, test gradients lie in L².

**The pairing against a test gradient.** Definition `solPair`: This defines the continuous linear functional pairing an L² field with the gradient of a scalar test function.

**The defect of spatial equivariance.** Definition `classDefect`: This defines the symmetry defect as the difference between composing a field with an isometry and applying that isometry to its values.

**The solenoidal symmetry subspace.** Definition `solClass`: This defines the solenoidal symmetry subspace by intersecting the kernels of every scalar-gradient pairing with the kernels of the discrete-turn and reflection defects.

**The solenoidal class subspace is closed.** Proved result `solClass_isClosed`: Under the stated hypotheses, the solenoidal class subspace is closed.

**Kernel membership means zero pairing.** Proved result `mem_ker_solPair_iff`: Under the stated hypotheses, kernel membership means zero pairing.

**Zero class defect means equivariance.** Proved result `mem_ker_classDefect_iff`: Under the stated hypotheses, zero class defect means equivariance.

**Subspace means solenoidal and symmetric.** Proved result `mem_solClass_iff`: An L² field belongs to the constructed solution subspace exactly when it is solenoidal and belongs to the prescribed discrete rotation and reflection class.

**solenoidal class subspace is complete.** Instance `anonymous completeness instance`: This supplies completeness for the solenoidal symmetry subspace because it is a closed subspace of L².

**Negation preserves weak powers.** Proved result `weakPower_neg`: Under the stated hypotheses, negation preserves weak powers.

**Drift fields preserve differences.** Proved result `drift_sub`: Under the stated hypotheses, drift fields preserve differences. Source: `Breakdown.FracCert.LinearSolveCore:264`.

**Free states are unique almost everywhere.** Proved result `state_unique`: Under the stated hypotheses, free states are unique almost everywhere.

**Scaling preserves weak powers.** Proved result `weakPower_smul`: Under the stated hypotheses, scaling preserves weak powers.

**Addition preserves weak powers.** Proved result `weakPower_add`: Under the stated hypotheses, addition preserves weak powers.

**Drift respects linear combinations.** Proved result `drift_add_smul`: Under the stated hypotheses, drift respects linear combinations.

**Every class datum has a free state.** Proved result `freeState`: Under the stated hypotheses, every class datum has a free state.

**Free states respect linear combinations.** Proved result `state_lin`: Under the stated hypotheses, free states respect linear combinations.

**A free solution with its analytic data.** Structure `FreeSol`: This structure bundles a second-order velocity field, its weak fractional power and its L² drift together with the almost-everywhere free equation drift plus power equals the forcing.

**A chosen solution of the free equation.** Definition `freeSol`: Assuming the free-existence interface and the fractional exponent bounds, this chooses one bundled free solution for each forcing in the solenoidal symmetry subspace.

**The chosen free solution is linear.** Proved result `freeSol_lin`: Under the stated hypotheses, the chosen free solution is linear.

**Symmetric products respect linearity.** Proved result `symProduct_add_smul`: Under the stated hypotheses, symmetric products respect linearity.

**Zero data give zero fields.** Proved result `freeSol_zero`: Under the stated hypotheses, zero data have zero velocity and gradient.

**Convection after the free inverse.** Definition `prodMap`: Under the stated free-solution and uniqueness interfaces, this defines the linear map sending forcing to the symmetric convection product of its chosen free solution with the fixed profile.

**Profile decay bounds convection.** Proved result `symProduct_pointwise`: Under the stated hypotheses, profile decay controls convection pointwise.

**Derivative energy bounds convection.** Proved result `symProduct_sq_bound`: Under the stated hypotheses, derivative energy controls convection in L².

**L² norms square to integrals.** Proved result `fieldL2_norm_sq`: Under the stated hypotheses, L² norms square to integrals.

**Representative norms square to integrals.** Proved result `toLp_norm_sq`: Under the stated hypotheses, representative norms square to integrals.

**The bounded convection operator.** Definition `prodCLM`: Under the stated free bounds and profile decay, this equips the symmetric-product map with a continuous linear structure on the forcing subspace.

**A column of the free inverse gradient.** Definition `entryMap`: Under the stated free-solution and uniqueness interfaces, this defines the linear map sending forcing to one L² column of the free solution's gradient.

**The bounded gradient-column operator.** Definition `entryCLM`: Under the stated free bounds, this equips the map to a gradient column of the free solution with a continuous linear structure.

**Finite matrix energy gives L² columns.** Proved result `entry_memLp_of`: Under the stated hypotheses, finite matrix energy gives L² columns.

**The pinning functional on free solutions.** Definition `pinCLM`: This defines a continuous pin functional by summing the L² pairings of the free solution's gradient columns with the supplied pin field.

**The pin functional gives the stated pin.** Proved result `pinCLM_apply`: Under the stated hypotheses, the pin functional gives the stated pin.

**Sequential compactness gives compactness.** Proved result `isCompactOperator_of_seq`: Under the stated hypotheses, sequential compactness gives compactness.

**The convection operator is compact.** Proved result `prodCLM_compact`: Under the stated hypotheses, the convection operator is compact.

**The bordered perturbation is compact.** Proved result `compact_perturbation`: Under the stated hypotheses, the bordered perturbation is compact.

**Injectivity gives surjectivity.** Proved result `surj_of_inj`: Under the stated hypotheses, injectivity gives surjectivity.

**Symmetry respects almost equality.** Proved result `class_congr`: Under the stated hypotheses, symmetry respects almost equality.

**Solenoidality respects almost equality.** Proved result `sol_congr`: Under the stated hypotheses, solenoidality respects almost equality.

**Orthogonal projection leaves a gradient.** Proved result `proj_split`: Under the stated hypotheses, orthogonal projection leaves a gradient.

**The symmetry class is linear.** Proved result `class_comb`: Under the stated hypotheses, the symmetry class admits linear combinations.

**Actuator sums retain symmetry.** Proved result `class_sum`: Under the stated hypotheses, actuator sums retain symmetry.

**Negatives of gradients are gradients.** Proved result `gradient_neg'`: Under the stated hypotheses, negatives of gradients are gradients. Source: `Breakdown.FracCert.LinearSolveCore:833`.

**The finite-dimensional actuator map.** Definition `actMap`: For a finite family of L² actuator fields, this defines the linear map sending coefficients κ to the field ∑κᵢbᵢ.

**The actuator map sums κᵢbᵢ.** Proved result `actMap_ae`: For square-integrable actuator fields, the L² class produced by the actuator map equals the field ∑κᵢbᵢ almost everywhere.

**The full field splits into three parts.** Proved result `fullField_split`: Under the stated hypotheses, the full field splits into three parts.

**trivial kernel gives the linear inverse.** Proved result `linearSolve_of_kernel'`: Under the stated assumptions, this establishes that for a valid fractional certificate, every L² symmetry-class forcing and finite target pin vector admit a linear correction state and multiplier whose bordered field equals the forcing modulo a weak gradient and whose pins equal the target.

### Breakdown.FracCert.LinearStateClosed

Passes the linear state equations and pin constraints through strong energy limits, using closedness of the gradient subspace.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/LinearStateClosed.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Free drift plus power is solenoidal.** Proposition `DriftPowerSolenoidalStatement`: This proposition requires that for 1<α<5/4, the sum of the L² rotating drift and weak fractional power of a second-order field is solenoidal in L².

**L² limits preserve gradient fields.** Proposition `GradientClosedStatement`: This proposition requires that strong L² limits of square-integrable weak gradient fields are weak gradient fields.

**Source namespace:** `Breakdown.SteadyCert.LinearStateClosedInternal`.

**Almost every spatial point is nonzero.** Proved result `ae_ne_zero'`: Under the stated hypotheses, almost every spatial point is nonzero.

**Matrix-vector evaluation is measurable.** Proved result `app_meas`: Under the stated hypotheses, matrix-vector evaluation is measurable.

**Matrix energy controls squared action.** Proved result `clm_sq_le`: Under the stated hypotheses, matrix energy controls squared action.

**Matrix energy controls each column.** Proved result `entry_le`: Under the stated hypotheses, matrix energy controls each column. Source: `Breakdown.FracCert.LinearStateClosed:56`.

**Finite matrix energy gives L² columns.** Proved result `col_memLp`: Under the stated hypotheses, finite matrix energy gives L² columns. Source: `Breakdown.FracCert.LinearStateClosed:61`.

**Cauchy-Schwarz bounds the L² pairing.** Proved result `l2_pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds the L² pairing.

**L² norms square to integrals.** Proved result `sq_l2Norm`: Under the stated hypotheses, L² norms square to integrals.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.LinearStateClosed:83`.

**mean square is bounded by mean energy.** Proved result `half_sq`: Under the stated hypotheses, the mean square is bounded by mean energy.

**Vector sum squares have a two-term bound.** Proved result `add_sq_le_two`: Under the stated hypotheses, vector sum squares have a two-term bound.

**Strong L² limits preserve addition.** Proved result `l2_add`: Under the stated hypotheses, strong L² limits preserve addition.

**Strong L² limits preserve fixed scaling.** Proved result `l2_smul`: Under the stated hypotheses, strong L² limits preserve fixed scaling.

**Strong L² limits preserve negation.** Proved result `l2_neg`: Under the stated hypotheses, strong L² limits preserve negation.

**Converging scalars give L² convergence.** Proved result `l2_scal`: Under the stated hypotheses, converging scalars give L² convergence.

**Scaling preserves L² membership.** Proved result `smul_memLp`: Under the stated hypotheses, scaling preserves L² membership.

**Negation preserves L² membership.** Proved result `neg_memLp`: Under the stated hypotheses, negation preserves L² membership.

**Finite scalar sums converge in L².** Proved result `l2_sum`: Under the stated hypotheses, finite scalar sums converge in L².

**Lp limits give integral convergence.** Proved result `l2_of_lp`: Under the stated hypotheses, quotient convergence gives integral convergence.

**Integral limits give Lp convergence.** Proved result `lp_of_l2`: Under the stated hypotheses, integral convergence gives quotient convergence.

**Symmetric products preserve differences.** Proved result `sym_sub`: Under the stated hypotheses, symmetric products preserve differences.

**Energy controls the symmetric product.** Proved result `sym_bound`: Under the stated hypotheses, energy controls the symmetric product.

**Weighted energy controls gradient energy.** Proved result `entry_le_energy`: Under the stated hypotheses, weighted energy controls gradient energy.

**Weighted energy is nonnegative.** Proved result `energy_nonneg`: Under the stated hypotheses, weighted energy is nonnegative.

**Pins pass to strong energy limits.** Proved result `pin_tendsto`: Under the stated hypotheses, pins pass to strong energy limits.

**The full field has three terms.** Proved result `full_eq`: The full bordered field equals drift plus fractional power, plus twice the symmetric profile-correction convection, plus the multiplier-weighted actuator sum.

**Almost equality preserves L² convergence.** Proved result `l2_congr`: Under the stated hypotheses, almost equality preserves L² convergence.

**Squared bounds imply nonnegative bounds.** Proved result `sq_le_of`: Under the stated hypotheses, squared bounds imply nonnegative bounds.

**Source namespace:** `Breakdown.SteadyCert`.

**Linear states are closed under limits.** Proved result `linearStateClosed`: Under the stated assumptions, this establishes that at a fixed certificate parameter, linear states Cauchy in correction size with strongly convergent L² right sides modulo gradients have a limiting linear state with the limiting right side, convergent correction size, strong L⁶ velocity convergence and convergent pins.

### Breakdown.FracCert.Main

Supplies proved analytic interfaces to assemble the fractional certificate-to-profile implication; the certificate itself remains a hypothesis.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/Main.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.ChainInternal`.

**A free solution symbol exists.** Proved result `freeSymbolExists_holds`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

**Profile symbols realize L⁶ fields.** Proved result `profileSymbolSix_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the physical field realized by an admissible profile symbol belongs to L⁶.

**Symbols satisfy the physical equation.** Proved result `profileSymbolEquation_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, an admissible profile symbol solving the free frequency equation for nice data realizes an L² drift and the physical free equation almost everywhere.

**Nice data give free solutions.** Proved result `freeExistsNice_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, every nice solenoidal forcing in the prescribed symmetry class has a second-order free solution with weak fractional power and L² drift satisfying the free equation almost everywhere.

**Nice class fields are dense.** Proved result `niceClassDense_holds`: Under the stated assumptions, this establishes that every solenoidal L² field in the symmetry class can be approximated arbitrarily well in squared L² error by nice fields in that class.

**The free operator satisfies L² bounds.** Proved result `freeBounds_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a free solution with L² forcing has separate power and drift norms bounded by the forcing norm, the stated trace-pairing energy identity and a uniform bound on the sum of square-root gradient and trace energies.

**second symbol carries derivative energy.** Proved result `secondSymbolEnergy_holds`: Under the stated assumptions, this establishes that for a second-order field, the negative-second-trace Fourier symbol has integrable squared norm divided by (2π‖ξ‖)² equal to the gradient energy, while its unweighted squared norm gives both the full Hessian and trace energies.

**Gradient energy controls the L⁶ norm.** Proved result `sixthGradientBound_holds`: Under the stated assumptions, this establishes that a universal constant bounds the sixth-power integral of a measurable L⁶ field by the cube of its square-integrable weak-gradient energy.

**Completeness of second-order fields.** Proved result `secondOrderComplete_holds`: Under the stated assumptions, this establishes that a Cauchy sequence of second-order fields for a measurable weight bounded above and bounded away from zero has a second-order limit with weighted derivative-energy convergence and strong L⁶ convergence.

**Second-order fields admit linearity.** Proved result `secondOrderLinear_holds`: Under the stated assumptions, this establishes that linear combinations of second-order fields in the same symmetry class remain second-order fields with the corresponding combinations of their derivative fields.

**Weak powers admit rapid tests.** Proved result `rapidWeakPower_holds`: Under the stated assumptions, this establishes that for 1<α<3/2, the weak fractional-power pairing of a measurable L⁶ field extends to every Schwartz test field.

**Weak powers pair with band-limited tests.** Proved result `bandWeakPower_holds`: Under the stated assumptions, this establishes that for 1<α<3/2, the weak fractional-power pairing holds against physical fields whose smooth Fourier symbols are compactly supported away from zero and have real conjugation symmetry.

**Second derivatives pair with rapid tests.** Proved result `rapidSecondPair_holds`: Under the stated assumptions, this establishes that for a second-order field, pairing the velocity with the negative second derivative sum of a Schwartz test equals pairing the negative second trace with that test.

**Second derivatives pair with band tests.** Proved result `bandSecondPair_holds`: Under the stated assumptions, this establishes that pairing a second-order velocity with the negative second derivative sum of a band test equals the frequency pairing of its negative-second-trace symbol with the band symbol.

**Weak powers have Fourier symbols.** Proved result `weakPowerSymbol_holds`: Under the stated assumptions, this establishes that for 1<α<3/2, the Fourier symbol of the weak fractional power of a second-order field equals (2π‖ξ‖)^(2α−2) times its negative-second-trace symbol almost everywhere.

**Weak drift in frequency space.** Proved result `driftSymbolWeak_holds`: For 1<α<5/4, a second-order field with L² drift has drift-symbol pairing against each admissible frequency test equal to the pairing of its inverse-square-weighted negative-second-trace symbol with the flow adjoint of that test.

**The flow pairing is differentiable.** Proved result `flowDeriv_holds`: Under the stated assumptions, this establishes that for 1<α<5/4 and a field whose first frequency weight is in L², pairing with the transported test is differentiable in time and its derivative pairs the field with the flow adjoint of that test.

**The flow identity holds on tests.** Proved result `flowTest_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the transported increment of a weighted L² field with weak flow derivative D and the integrated flow of D have equal pairings against every frequency test.

**Weak drift integrates along the flow.** Proved result `flowIntegral_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a weighted L² field with weak flow derivative D has transported increment equal almost everywhere to the time integral of the L² flow applied to D.

**Energy pairing for the frequency flow.** Proved result `flowPairing_holds`: For 1<α<5/4, if D is the weak flow derivative of h and D, (2π‖ξ‖)h, and (2π‖ξ‖)^(2α)h lie in L², then the pairing of D with (2π‖ξ‖)^(2α)h equals (3/2−5/(4α)) times the integral of (2π‖ξ‖)^(2α)‖h‖².

**Drift pairing with the power symbol.** Proved result `driftPairSymbol_holds`: For 1<α<5/4, a second-order field whose drift and weighted second-trace symbol lie in L² has drift-symbol pairing with (2π‖ξ‖)^(2α−2) times the negative-second-trace symbol equal to (3/2−5/(4α)) times the integral of (2π‖ξ‖)^(2α−4) times that symbol's squared norm.

**Drift-power pairing identity.** Proved result `driftPower_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the pairing of an L² drift with the weak fractional power equals (3/2−5/(4α)) times the integral of (2π‖ξ‖)^(2α−4) times the squared negative-second-trace symbol, and that integral is finite.

**The free solution is unique.** Proved result `freeUnique_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a second-order field with weak fractional power, L² drift and zero free residual has velocity, both derivative fields and fractional power all zero almost everywhere.

**The inverse-square Hardy bound holds.** Proved result `inverseSquareBound_holds`: Under the stated assumptions, this establishes that a measurable L⁶ velocity with square-integrable weak gradient has integrable ‖v(y)‖²/‖y‖² and its integral is at most four times the gradient energy.

**Translations are bounded by the gradient.** Proved result `ballShift_holds`: For a measurable field with an integrable squared norm on the radius-(R+2) ball and a weak gradient of finite square energy, the integral of the squared translation difference over the closed radius-R ball is at most the squared translation length times global gradient energy whenever that length is at most one.

**Decaying profile products are compact.** Proved result `profileProductCompact_holds`: Under the stated assumptions, this establishes that a C¹ profile decaying like inverse radius with derivative decaying like inverse radius squared maps any uniformly energy-bounded sequence of second-order fields, through symmetric convection, to an L² sequence with a strongly convergent subsequence.

**Solenoidal and gradient decomposition.** Proved result `solenoidalSplit_holds`: Every L² field in the prescribed rotation-reflection symmetry class is almost everywhere the sum of a solenoidal L² field in that class and an L² weak gradient field.

**L² gradient-solenoidal orthogonality.** Proved result `gradientOrthogonal_holds`: Every L² weak gradient field has zero integral pairing with every solenoidal L² field.

**Symmetric products preserve the class.** Proved result `productClass_holds`: Under the stated assumptions, this establishes that the symmetric convection product of a C¹ symmetry-class profile and a second-order field in that class remains in the same symmetry class.

**Weak fractional powers admit differences.** Proved result `weakPowerDifference_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, subtracting two second-order fields and their weak fractional powers preserves the weak fractional-power relation.

**The drift has its energy identity.** Proved result `driftEnergy_holds`: Under the stated assumptions, this establishes that for 1<α<5/4 and an L² drift, its pairing with the negative second trace of a second-order field equals (1−3/(4α)) times the gradient energy.

**Three bounds for the split energy.** Proved result `splitFormBounds_holds`: For 1<α<5/4 and a valid certificate, a second-order field with weak fractional power satisfies the low-loss lower bound for its split pairing, nonnegativity after adding the reduced-coercivity correction, and the bound of its second-trace L² norm by the form scale times split energy.

**The negative second trace is solenoidal.** Proved result `secondTraceSolenoidal_holds`: The negative second trace of a second-order field is a solenoidal L² field and retains the same rotation-reflection symmetry class.

**Weak gradient fields admit sums.** Proved result `gradientAdd_holds`: Under the stated assumptions, this establishes that the sum of two weak gradient fields is a weak gradient field.

**The certificate gives an a priori bound.** Proved result `aprioriBound_holds`: Under the stated assumptions, this establishes that a valid fractional certificate bounds a linear correction state and its multipliers by the certificate function of its projected residual norm, gradient-insensitive row residuals and pin size.

**The bordered kernel is trivial.** Proved result `linearKernel_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate, if a linear state’s bordered field is a gradient and every pin vanishes, then its free residual vanishes almost everywhere and its multiplier vector is zero.

**Free drift plus power is solenoidal.** Proved result `driftPowerSolenoidal_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the sum of the L² rotating drift and weak fractional power of a second-order field is solenoidal in L².

**The L² gradient fields form a closed set.** Proved result `gradientClosed_holds`: Under the stated assumptions, this establishes that strong L² limits of square-integrable weak gradient fields are weak gradient fields.

**Strong closure of linear states.** Proved result `linearStateClosed_holds`: For 1<α<5/4 and a valid fractional certificate at a fixed parameter in its box, linear states whose bordered fields equal L² forcings modulo weak gradients, whose forcings converge strongly, and whose derivative-multiplier data are Cauchy in certificate size have a limiting linear state satisfying the limiting equation modulo a gradient, with convergence in size, strong L⁶ velocity convergence, and convergence of pins.

**Second-order convection is in L².** Proved result `quadraticSquareIntegrable_holds`: For every second-order field, applying its weak-gradient matrix to its velocity produces an L² vector field.

**Weak fractional powers admit differences.** Proved result `weakPowerSub_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, subtracting two L⁶ fields with weak fractional powers subtracts their weak fractional powers.

**The defect is an admissible right side.** Proved result `defectRightSide_holds`: Under the stated assumptions, this establishes that a valid fractional certificate makes its defect square integrable and makes minus that defect minus the correction convection an admissible symmetry-class forcing.

**Symmetric convection products lie in L².** Proved result `productSquare_holds`: Under the stated assumptions, this establishes that the symmetric convection product of two second-order fields in the same symmetry class belongs to L².

**Corrected convection products lie in L².** Proved result `heldQuadraticL2_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate, the full convection of the approximate profile plus any admissible second-order correction belongs to L².

**Profile data admit the weak embedding.** Proved result `profileEmbedData_holds`: Under the stated assumptions, this establishes that a valid certificate profile is measurable and in L⁶, has a measurable square-integrable weak gradient and has vanishing divergence almost everywhere.

**Weak powers preserve the symmetry class.** Proved result `weakPowerClass_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a measurable L⁶ field in the discrete rotation and reflection class has its weak fractional power in the same class.

**Weak gradients preserve class symmetry.** Proved result `gradientClass_holds`: Under the stated assumptions, this establishes that a measurable L⁶ field in the symmetry class with a measurable square-integrable weak gradient has that gradient equivariant almost everywhere under the discrete turn and reflection.

**Held residuals preserve class symmetry.** Proved result `heldResidualClass_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate, the held residual of every admissible linear correction state preserves the prescribed symmetry class.

**Held residuals are L² class fields.** Proved result `heldResidualSquare_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate and a linear correction state in the parameter box, every held residual belongs to L² and to the prescribed symmetry class.

**Weak held limits retain energy bounds.** Proved result `heldStateLimit_holds`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a linear-state subsequential limit with lower semicontinuous energy, weakly convergent gradients and convergent zero-multiplier residual pairings against solenoidal L² fields.

**Bounded held solutions have weak limits.** Proved result `heldWeakLimit_holds`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a subsequence with a limiting linear state, no larger size, convergent multipliers and pins, and convergent residual pairings against every solenoidal L² field.

**Bounded held solutions have a limit.** Proved result `heldLimit_holds`: For 1<α<5/4 and a valid fractional certificate, a sequence of held solutions within the certified radius at parameters converging inside the parameter box has a subsequence whose multipliers converge to those of a held solution at the limiting parameter with size within the same radius.

**test box lies inside the parameter box.** Proved result `testBoxSubset_holds`: Under the stated assumptions, this establishes that a valid fractional certificate places its test box inside its parameter box.

**Active multiplier enclosure.** Proved result `activeEnclosure_holds`: Under the stated assumptions, this establishes that for a held solution within the certified radius at a test-box parameter, each active coordinate of the transformed corrected multiplier differs from its slope times the parameter by at most the absolute slope times that coordinate radius.

**Stiff multiplier enclosure.** Proved result `stiffEnclosure_holds`: Under the stated assumptions, this establishes that for a held solution within the certified radius at a test-box parameter, the sum of squared inactive transformed multiplier errors is at most the squared ellipsoid radius.

**Embedding a weak field into energy space.** Proved result `embedWeak_holds`: A measurable L⁶ field with a measurable weak gradient of finite square energy and zero gradient trace almost everywhere has an energy-space representative whose velocity and three first derivatives agree almost everywhere with the supplied field and gradient columns.

**The corrected profile is nonzero.** Proved result `heldNonzero_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held correction within the certified radius cannot cancel the approximate profile almost everywhere.

**Cancelled held solutions give profiles.** Proved result `heldWeakProfile_holds`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held solution within the certified radius whose corrected multiplier is zero yields a nontrivial weak rotating fractional profile.

**The heat flow preserves nice test fields.** Proved result `niceHeat_holds`: Under the stated assumptions, this establishes that for α>1 and nonnegative heat time, fractional heat preserves nice test fields and transfers across velocity pairings with the energy-space heat operator.

**Nice tests detect a zero energy vector.** Proved result `niceAnnihilator_holds`: Under the stated assumptions, this establishes that an energy-space element whose velocity pairs to zero with every nice test field is zero.

**Bilinear terms have physical pairings.** Proved result `bilinPairing_holds`: Under the stated assumptions, this establishes that for α>1 and positive time, pairing the fractional bilinear Duhamel term with a nice test gives minus the trilinear pairing against the heat-evolved test.

**Fractional powers respect similarity.** Proved result `powerSimAdj_holds`: Under the stated assumptions, this establishes that for α>1 and positive scale μ, the fractional power of the similarity-adjoint test equals μ times the similarity adjoint applied to its fractional power.

**Similarity moves across pairings.** Proved result `simAdjPairing_holds`: Under the stated assumptions, this establishes that for α>1 and positive scale, similarity of an energy-space field transfers to the similarity adjoint in pairings with nice test fields.

**Similarity test pairings differentiate.** Proved result `simAdjDeriv_holds`: Under the stated assumptions, this establishes that for α>1 and t<1, the velocity pairing with a nice test at similarity scale 1−t has derivative equal to its pairing with the drift adjoint multiplied by (1−t)⁻¹.

**Similarity preserves nice test fields.** Proved result `niceSimAdjClosed_holds`: Under the stated assumptions, this establishes that for α>0 and positive scale, the similarity adjoint preserves nice test fields.

**Drift preserves nice test fields.** Proved result `niceDriftClosed_holds`: Under the stated assumptions, this establishes that for α>0, the drift adjoint preserves nice test fields.

**Similarity operators compose.** Proved result `simOpCompose_holds`: Under the stated assumptions, this establishes that for α>1, the similarity operator at scale one is the identity and composition at positive scales μ and ν equals the operator at scale μν.

**Weak profiles yield mild trajectories.** Proved result `mildOfWeakProfile_holds`: For 1<α<5/4, the backward similarity orbit of a weak rotating profile is a mild solution on every interval [0,t] with 0<t<1 in any concrete scaled mild framework.

**Mild trajectories gain regularity.** Proved result `mildFirstGain_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a mild solution in a concrete framework has uniformly bounded homogeneous squared norm of order α+1/2 on every closed time interval separated from zero.

**A regularity gain gives a uniform bound.** Proved result `supFromGain_holds`: Under the stated assumptions, this establishes that for s>3/2, finite fractional homogeneous energy of order s bounds the Fourier L¹ norm by a constant times the sum of the square roots of its first-order and sth-order energies.

**Mild solutions gain the next moment.** Proved result `mildMomentStep_holds`: Under the stated assumptions, this establishes that for 1<α<5/4 and k≥1, uniform Fourier L¹ and kth-moment energy bounds away from initial time for a mild solution imply uniform (k+1)st-moment energy bounds on the same type of intervals.

**Positive times have all Fourier moments.** Proved result `mildSmoothing_holds`: For 1<α<5/4, a mild trajectory in a concrete scaled framework on [0,t] with t>0 has all Fourier moments at every time in (0,t].

**Similarity rescales Fourier moments.** Proved result `simOpMoments_holds`: Under the stated assumptions, this establishes that for α>1 and positive scale, the similarity operator preserves the property of having all Fourier moments.

**Weak profiles have all Fourier moments.** Proved result `profileMoments_holds`: Every weak rotating profile with 1<α<5/4 has all Fourier moments.

**Fourier moments imply integrable symbols.** Proved result `symbolL1OfMoments_holds`: Under the stated assumptions, this establishes that an energy-space element with all Fourier moments has all L¹ symbol moments and its velocity equals the physical inverse-transform field almost everywhere.

**All moments give bounded derivatives.** Proved result `fieldSmoothOfMoments_holds`: A Fourier symbol with all integrable absolute moments and pointwise real conjugation symmetry realizes a smooth physical field with a global bound on each derivative order.

**Low-frequency cutoffs can be removed.** Proved result `lowFrequencyRemoval_holds`: Under the stated assumptions, this establishes that a continuous vector field with inverse-radius-weighted L² norm that annihilates all real-symmetric smooth frequency tests compactly supported away from zero must vanish everywhere.

**All moments give an L² pressure gradient.** Proved result `pressureGradientSquare_holds`: The canonical pressure associated with an energy-space field having all Fourier moments has a square-integrable gradient.

**The residual annihilates nice tests.** Proved result `residualNice_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the pressure-corrected residual of a weak rotating profile with all moments pairs to zero against every nice test field.

**The residual annihilates gradient tests.** Proved result `residualGradient_holds`: For 1<α<5/4, the residual of an energy-space field with all Fourier moments has zero pairing against every physical test whose smooth conjugation-symmetric Fourier symbol is longitudinal and compactly supported away from zero.

**A weak profile solves its equation.** Proved result `weakProfileRegular_holds`: For 1<α<5/4, a weak rotating profile with all Fourier moments realizes a smooth divergence-free velocity and admits a smooth scalar pressure satisfying the rotating profile equation pointwise.

**The heat-divergence kernel decays.** Proved result `kernelDecay_holds`: Under the stated assumptions, this establishes that for α>0, every positive-time projected heat-divergence kernel component is smooth and its nth derivative is bounded by C(t^(1/(2α))+‖x‖)^(−4−n).

**The heat kernel obeys its scaling law.** Proved result `kernelScaling_holds`: Under the stated assumptions, this establishes that for α>0 and t>0, the projected kernel is real, integrable and in L³⁄², obeys the t^(−2/α) spatial rescaling, and has L¹ and L³⁄² norms scaling respectively by t^(−1/(2α)) and t^(−1/α).

**Heat-divergence pointwise bounds.** Proved result `heatDivBound_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, 0≤β<3 and 0≤b≤β+1+j, weighted bounds A and B on a tensor and its jth derivative imply a weighted jth heat-divergence bound Ct^(−1/(2α))(A+B) for 0<t≤1.

**Heat-divergence preserves regularity.** Proved result `heatDivRegular_holds`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0≤β<3, a Cʲ tensor with bounded jth derivative and a β-weighted value bound has Cʲ heat-divergence convolutions, jointly continuous derivatives through order j and bounds Ct^(−1/(2α))(A+B) for 0<t≤1.

**Far-field terms satisfy decay bounds.** Proved result `farFieldBound_holds`: Under the stated assumptions, this establishes that under the stated fractional and tensor-decay assumptions with b≠2α−1+j, the far-field operator is Cʲ and its jth derivative decays with weight exponent min(b,2α−1+j).

**Velocity has weighted L² decay.** Proved result `velocityInverseWeight_holds`: An energy-space field with all Fourier moments has its physical velocity divided by one plus radius in L².

**Far-field velocity has weighted L² decay.** Proved result `farFieldWeighted_holds`: For 1<α<5/4 and an energy-space field with all Fourier moments, the far-field operator applied to its velocity tensor square, divided by one plus radius, lies in L².

**Mild profile identity against nice tests.** Proved result `profileMildForm_holds`: For 1<α<5/4, a weak rotating profile with all Fourier moments pairs against each nice test as minus the positive-time integral of its quadratic trilinear term tested against the heat-evolved similarity adjoint.

**Far-field pairing equals the mild term.** Proved result `farFieldPairing_holds`: For 1<α<5/4 and any energy-space field with all Fourier moments, pairing its tensor-square far-field output against a nice test equals minus the positive-time integral of the same quadratic trilinear term with the heat-evolved similarity adjoint test.

**The profile annihilates gradient tests.** Proved result `profileGradientFree_holds`: An energy-space field with all Fourier moments has physical velocity orthogonal to every test whose smooth conjugation-symmetric Fourier symbol is longitudinal and compactly supported away from zero.

**Far-field outputs kill gradient tests.** Proved result `farFieldGradientFree_holds`: For 1<α<5/4 and an energy-space field with all Fourier moments, its tensor-square far-field output has zero pairing against all tests with smooth conjugation-symmetric longitudinal Fourier symbols compactly supported away from zero.

**The fixed-point error kills band tests.** Proved result `fixedPointAnnulus_holds`: For 1<α<5/4, the difference between a weak rotating profile with all moments and its tensor-square far-field output pairs to zero against every smooth conjugation-symmetric Fourier test compactly supported away from zero.

**profile satisfies its fixed-point law.** Proved result `profileFixedPoint_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all Fourier moments is pointwise the far-field operator applied to its velocity tensor square.

**The profile has its initial decay.** Proved result `profileDecayBase_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all Fourier moments has velocity bounded by C(1+‖y‖)^(−(2α−1)).

**Derivative decay improves inductively.** Proved result `profileDecayStep_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, the expected decay bounds on all lower derivatives of a weak rotating profile with all moments imply the jth derivative bound C(1+‖y‖)^(−(2α−1+j)).

**A smooth annular partition exists.** Proved result `ringCutoff_holds`: Under the stated assumptions, this establishes that a smooth annular cutoff satisfying the dyadic partition requirements exists.

**Dyadic pieces reconstruct the multiplier.** Proved result `dyadicSplit_holds`: Under the stated assumptions, this establishes that under the homogeneous multiplier, ring cutoff, weighted smoothness and integrable symbol-moment hypotheses, the inverse multiplier transform is smooth and each derivative is the sum over all dyadic convolution derivatives.

**The dyadic piece estimate holds.** Proved result `dyadicPieceBound_holds`: Under the stated assumptions, this establishes that for a nonnegative homogeneous degree d and a weighted smooth input of exponent 0<β<3, the nth derivative of each dyadic convolution obeys the stated near-region bound 2^((d+n+β)l) and the two explicit far-region power bounds for ‖x‖≥2.

**Dyadic power sums have radial decay.** Proved result `dyadicSum_holds`: Under the stated assumptions, this establishes that for 0<a<N, the two-sided dyadic series ∑2^(al)(1+2^l r)^(−N) is summable and bounded by Cr^(−a) for every r>0.

**Homogeneous multipliers improve decay.** Proved result `homogeneousMultiplier_holds`: A smooth-away-from-zero homogeneous multiplier of degree d≥0 raises a weighted smooth decay exponent β to β+d when 0<β<3, the stated Fourier transform relation holds, and the multiplied symbol has all integrable absolute moments.

**Fractional powers have decay bounds.** Proved result `powerDecay_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments and profile decay has a smooth fractional power whose jth derivative is bounded by C(1+‖y‖)^(−(4α−1+j)).

**The canonical pressure solves Poisson.** Proved result `pressureTrace_holds`: For 1<α<5/4, a weak rotating profile with all moments and the prescribed profile decay has canonical pressure whose Laplacian equals minus the divergence of the velocity's convection pointwise.

**Weighted smoothness of profile products.** Proved result `productWeightedSmooth_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, each coordinate product of a weak rotating profile with all moments and profile decay is weighted smooth with base decay exponent 4α−2.

**Pressure from tensor Fourier multipliers.** Proved result `pressureRepresentation_holds`: For 1<α<5/4, a weak rotating profile with all moments and profile decay has Fourier transforms of its velocity-product entries whose pressure-multiplied symbols have all L¹ moments and whose inverse-transform real parts sum to its canonical pressure.

**Decay of canonical pressure derivatives.** Proved result `modelPressureDecay_holds`: For 1<α<5/4, a weak rotating profile with all moments and profile decay has its canonical pressure's derivative of order j+1 bounded by C(1+‖y‖)^(−(4α−1+j)) for each j.

**A decaying pressure model exists.** Proved result `pressureModel_holds`: For 1<α<5/4, a weak rotating profile with all moments and profile decay admits a smooth scalar potential whose Laplacian is minus the divergence of convection and whose derivative of every order j+1 is bounded by C(1+‖y‖)^(−(4α−1+j)).

**The fractional power is divergence free.** Proved result `powerDivergenceFree_holds`: For 1<α<5/4, a weak rotating profile with all moments and profile decay has pointwise zero divergence after applying the fractional-power operator to its velocity.

**A profile pressure satisfies Poisson.** Proved result `residualDivergence_holds`: For 1<α<5/4, if a smooth pressure solves the rotating equation for a weak profile with all moments and profile decay, its Laplacian equals minus the divergence of the velocity's convection at every point.

**A decaying harmonic gradient vanishes.** Proved result `decayingGradientVanishes_holds`: If a smooth real function is harmonic everywhere and its derivative is bounded by K(1+‖y‖)^(−s) for some positive s, then its derivative vanishes everywhere.

**The pressure has the required decay.** Proved result `pressureDecay_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**The resulting profile is nonzero.** Proved result `profileNonzero_holds`: Under the stated assumptions, this establishes that a nonzero energy-space element with all Fourier moments has a physical profile that is nonzero at some point.

**Source namespace:** `Breakdown.SteadyCert`.

**A fractional certificate gives a profile.** Proved result `fracCertificate_profile_chain`: Assuming the certificate-to-weak-profile implication and the weak-to-profile implication, together with 1<α<5/4 and the fractional certificate hypothesis, a nontrivial rotating fractional profile exists.

### Breakdown.FracCert.MildAnnihilator

Relates the energy-space inner product to physical Laplacian pairings so nice test fields detect a zero vector.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildAnnihilator.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.Internal.MildAnnihilator`.

**Energy pairings have a physical formula.** Proved result `inner_embed_nice`: Under the stated hypotheses, energy pairings have a physical formula.

**Source namespace:** `Breakdown.FracCert`.

**Nice tests detect a zero energy vector.** Proved result `niceAnnihilator`: Under the stated assumptions, this establishes that an energy-space element whose velocity pairs to zero with every nice test field is zero.

### Breakdown.FracCert.MildBilinPairing

Identifies the fractional bilinear term against nice test fields through inverse Laplacian symbols and the heat multiplier.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildBilinPairing.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Nice symbols vanish at the origin.** Proved result `nice_zero`: Under the stated hypotheses, nice symbols vanish at the origin.

**Laplacian factor is positive off zero.** Proved result `sqFactor_pos`: Under the stated hypotheses, the Laplacian factor is positive off zero.

**Inverse Laplacians preserve niceness.** Proved result `nice_inv`: Under the stated hypotheses, inverting the Laplacian preserves niceness.

**The inverse symbol cancels the Laplacian.** Proved result `secondOrder_inv`: Under the stated hypotheses, the inverse symbol cancels the Laplacian.

**Heat multipliers preserve nice symbols.** Proved result `nice_heat`: Under the stated hypotheses, heat multipliers preserve nice symbols.

**Nice heat fields have explicit symbols.** Proved result `heatField_nice`: Under the stated hypotheses, nice heat fields have explicit symbols.

**The inverse Laplacian cancels its factor.** Proved result `scalar_eq`: Under the stated hypotheses, the inverse Laplacian cancels its factor.

**The auxiliary heat map damps the symbol.** Proved result `phi_nice`: For α>1 and positive time, the auxiliary heat map applied to the inverse-second-factor embedding of a nice symbol equals almost everywhere the nice field with symbol exp(−τ(2π‖ξ‖)^(2α)) times that symbol.

**Energy pairings have a physical formula.** Proved result `nice_pairing`: Under the stated hypotheses, energy pairings have a physical formula.

**Bilinear terms have physical pairings.** Proved result `bilinPairing`: Under the stated assumptions, this establishes that for α>1 and positive time, pairing the fractional bilinear Duhamel term with a nice test gives minus the trilinear pairing against the heat-evolved test.

### Breakdown.FracCert.MildNiceHeat

Translates the fractional heat operator between energy-space vectors and nice physical Fourier fields.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildNiceHeat.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.MildNiceHeatInternal`.

**The fractional heat multiplier.** Definition `heatSym`: This defines the fractional heat multiplier exp(−τ(2π‖ξ‖)^(2α)).

**The inverse Laplacian multiplier.** Definition `traceInv`: This defines the reciprocal of the Fourier second-order factor.

**Heating preserves nice symbols.** Proved result `isNiceSymbol_heat`: Under the stated hypotheses, heating preserves nice symbols.

**Inverse Laplacians preserve nice symbols.** Proved result `isNiceSymbol_traceInv`: Under the stated hypotheses, inverse Laplacians preserve nice symbols.

**Inverse Laplacians cancel their trace.** Proved result `negTrace_traceInv`: Under the stated hypotheses, inverse Laplacians cancel their trace.

**Nice heat fields have explicit symbols.** Proved result `heatField_niceField`: Under the stated hypotheses, nice heat fields have explicit symbols.

**Energy pairings have a physical formula.** Proved result `pairing_nice`: Under the stated hypotheses, energy pairings have a physical formula.

**Heat evolution commutes with embedding.** Proved result `heat_embed`: Under the stated hypotheses, heat evolution commutes with embedding.

**Source namespace:** `Breakdown.FracCert`.

**The heat flow preserves nice test fields.** Proved result `niceHeat`: Under the stated assumptions, this establishes that for α>1 and nonnegative heat time, fractional heat preserves nice test fields and transfers across velocity pairings with the energy-space heat operator.

### Breakdown.FracCert.MildPowerSim

Proves that the weak fractional power transfers across the adjoint similarity transform on nice tests.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildPowerSim.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.MildPowerSimInternal`.

**Nice fields are twice differentiable.** Proved result `contDiff_two_of_nice`: Under the stated hypotheses, nice fields are twice differentiable.

**Source namespace:** `Breakdown.FracCert`.

**Fractional powers respect similarity.** Proved result `powerSimAdj`: Under the stated assumptions, this establishes that for α>1 and positive scale μ, the fractional power of the similarity-adjoint test equals μ times the similarity adjoint applied to its fractional power.

### Breakdown.FracCert.MildProfileMoments

Transfers Fourier moments gained by the mild orbit back to its underlying similarity profile.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildProfileMoments.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Weak profiles have all Fourier moments.** Proved result `profileMoments_of`: Under the stated assumptions, this establishes that for 1<α<5/4, every weak rotating fractional profile has all Fourier moments.

### Breakdown.FracCert.MildProfileOrbit

Builds the mild trajectory associated with a weak rotating profile and verifies the Duhamel identity against separating nice tests.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildProfileOrbit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.MildProfileOrbit`.

**The velocity pairing with a test field.** Definition `vpair`: This defines the integral pairing between the velocity represented by an energy-space element and a test field.

**Velocity pairings preserve scaling.** Proved result `vpair_smul`: Under the stated hypotheses, velocity pairings preserve scalar factors.

**Nice fields admit an inverse Laplacian.** Proved result `exists_negTrace_eq`: Under the stated hypotheses, nice fields admit an inverse Laplacian.

**Laplacian pairings equal energy pairings.** Proved result `vpair_negTrace`: Under the stated hypotheses, laplacian pairings equal energy pairings.

**Fractional tests have energy vectors.** Proved result `rep_frac`: Under the stated hypotheses, fractional test pairings have energy vectors.

**The fractional operator value is unique.** Proved result `isFracOf_unique`: Under the stated hypotheses, the fractional operator value is unique.

**Trilinear pairings preserve scaling.** Proved result `tri_smul`: Under the stated hypotheses, trilinear pairings preserve scalar factors.

**Trilinear pairings obey dilation.** Proved result `tri_dil`: Under the stated hypotheses, trilinear pairings obey dilation.

**Trilinear pairings obey similarity.** Proved result `tri_sim`: Under the stated hypotheses, trilinear pairings obey similarity.

**Similarity equals the frequency flow.** Proved result `simOp_coe`: Under the stated hypotheses, similarity agrees with the frequency flow.

**Similarity trajectories are continuous.** Proved result `simOp_cont`: Under the stated hypotheses, similarity trajectories are continuous.

**The scalar balance rearranges.** Proved result `alg_step`: Under the stated hypotheses, the scalar balance rearranges.

**The mild residual annihilates nice tests.** Proved result `mild_identity`: Under the stated hypotheses, the mild residual annihilates nice tests.

**Source namespace:** `Breakdown.FracCert`.

**Weak profiles generate mild trajectories.** Proved result `mildOfWeakProfile_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the shrinking similarity orbit of a weak rotating profile is a mild solution on every interval [0,t] with 0<t<1 in any concrete fractional mild framework.

### Breakdown.FracCert.MildSimCompose

Proves the composition law for the rotating similarity operators from the corresponding rotation and dilation laws.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildSimCompose.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FracInternal.SimCompose`.

**Complex rotations obey composition.** Proved result `rotC_comp`: Under the stated hypotheses, complex rotations obey composition.

**Energy-space rotations obey composition.** Proved result `rotX_comp`: Under the stated hypotheses, energy-space rotations obey composition.

**identity rotation fixes energy vectors.** Proved result `rotX_refl`: Under the stated hypotheses, the identity rotation fixes energy vectors.

**Source namespace:** `Breakdown.FracCert`.

**Similarity operators compose.** Proved result `simOpCompose`: Under the stated assumptions, this establishes that for α>1, the similarity operator at scale one is the identity and composition at positive scales μ and ν equals the operator at scale μν.

### Breakdown.FracCert.MildSimMoments

Computes how weighted Fourier moments scale under the rotating similarity operators.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/MildSimMoments.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FracInternal.SimMoments`.

**Similarity has its a.e. formula.** Proved result `simOp_ae`: Under the stated hypotheses, similarity has an almost-everywhere formula.

**Extended squared norms convert to reals.** Proved result `ofReal_mul_enorm_sq`: Under the stated hypotheses, extended squared norms convert to reals.

**Weighted scaling factors simplify.** Proved result `real_identity`: Under the stated hypotheses, weighted scaling factors simplify.

**Rotation and dilation change volume.** Proved result `lintegral_comp_rot_smul`: Under the stated hypotheses, rotation and dilation change volume.

**Source namespace:** `Breakdown.FracCert`.

**Similarity rescales Fourier moments.** Proved result `simOpMoments`: Under the stated assumptions, this establishes that for α>1 and positive scale, the similarity operator preserves the property of having all Fourier moments.

### Breakdown.FracCert.NiceClassDense

Approximates solenoidal symmetry-class fields by nice Fourier fields, then averages over rotations and reflection without increasing L² error.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/NiceClassDense.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Integral pairings equal L² pairings.** Proved result `integral_inner_eq`: Under the stated hypotheses, integral pairings equal L² pairings.

**Fields give solenoidal symbols.** Proved result `transform_mem_sig`: Under the stated hypotheses, solenoidal fields give solenoidal symbols.

**Nice symbols approximate in L².** Proved result `symbol_close`: Under the stated hypotheses, nice symbols approximate in L².

**Complexification preserves norms.** Proved result `norm_complexify_eq`: Under the stated hypotheses, complexification preserves norms.

**L² energy equals squared norm.** Proved result `integral_sq_eq`: Under the stated hypotheses, representative energy equals L² norm squared.

**Nice fields transform to their symbols.** Proved result `transform_field`: Under the stated hypotheses, nice fields transform to their symbols.

**Nice approximation of solenoidal fields.** Proved result `dense_of_mem_sig`: Under the stated hypotheses, solenoidal fields admit nice approximants.

**The explicit axial rotation.** Definition `turnFun`: This defines axial rotation on real vectors by its sine and cosine coordinate formula.

**Axial rotation has three coordinates.** Proved result `turnFun_apply`: Under the stated hypotheses, axial rotation has three coordinates.

**Reflection negates the third coordinate.** Proved result `mirror_apply`: Under the stated hypotheses, reflection negates the third coordinate. Source: `Breakdown.FracCert.NiceClassDense:208`.

**Coordinates determine spatial vectors.** Proved result `space_ext`: Under the stated hypotheses, coordinates determine spatial vectors. Source: `Breakdown.FracCert.NiceClassDense:211`.

**Rotation angles add under composition.** Proved result `turnFun_comp`: Under the stated hypotheses, rotation angles add under composition.

**Zero-angle rotation is the identity.** Proved result `turnFun_zero`: Under the stated hypotheses, zero-angle rotation is the identity.

**Full turns preserve the rotation.** Proved result `turnFun_period`: Under the stated hypotheses, full turns preserve the rotation.

**Axial rotations preserve norms.** Proved result `norm_turnFun`: Under the stated hypotheses, axial rotations preserve norms.

**Reflection preserves norms.** Proved result `norm_mirror`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.NiceClassDense:253`.

**Axial rotations preserve sums.** Proved result `turnFun_add`: Under the stated hypotheses, axial rotations preserve sums.

**Axial rotations preserve scaling.** Proved result `turnFun_smul`: Under the stated hypotheses, axial rotations preserve scaling.

**Reflection preserves sums.** Proved result `mirror_add`: Under the stated hypotheses, reflection preserves sums. Source: `Breakdown.FracCert.NiceClassDense:275`.

**Reflection preserves scaling.** Proved result `mirror_smul`: Under the stated hypotheses, reflection preserves scaling. Source: `Breakdown.FracCert.NiceClassDense:284`.

**Reflection is an involution.** Proved result `mirror_mirror`: Under the stated hypotheses, reflection is an involution.

**Reflection commutes with axial rotation.** Proved result `mirror_turnFun`: Under the stated hypotheses, reflection commutes with axial rotation.

**Axial rotation as an isometry.** Definition `turnIso`: This equips axial rotation with a linear isometry equivalence whose inverse is rotation through the negative angle.

**The isometry is axial rotation.** Proved result `turnIso_apply`: The constructed rotation isometry sends (x₁,x₂,x₃) to (cosθ x₁−sinθ x₂, sinθ x₁+cosθ x₂, x₃).

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection with a linear isometry equivalence whose inverse is reflection itself.

**Reflection negates the third coordinate.** Proved result `mirrorIso_apply`: The constructed reflection isometry sends (x₁,x₂,x₃) to (x₁,x₂,−x₃).

**Angles in the finite rotation group.** Definition `angle`: This defines the kth discrete rotation angle as 2πk/(n+1).

**An element of the finite symmetry group.** Definition `elem`: This defines a symmetry group element as a discrete axial rotation, optionally preceded by reflection according to its Boolean index.

**Explicit action of symmetry elements.** Proved result `elem_apply`: Under the stated hypotheses, symmetry elements have an explicit action.

**Successive angles give one discrete turn.** Proved result `angle_succ`: Under the stated hypotheses, successive angles give one discrete turn.

**Index shifting gives a discrete turn.** Proved result `elem_turn`: Under the stated hypotheses, index shifting gives a discrete turn.

**Flipping the index gives reflection.** Proved result `elem_mirror`: Under the stated hypotheses, flipping the index gives reflection.

**Inverses cancel a composed action.** Proved result `symm_of_comp`: Under the stated hypotheses, inverses cancel a composed action.

**Real parts commute with rotation.** Proved result `realVec_rotC`: Under the stated hypotheses, real parts commute with rotation.

**Rotation transfers across divergence.** Proved result `div_rotC`: Under the stated hypotheses, rotation transfers across divergence.

**The finite symmetry average of a symbol.** Definition `avgSym`: This defines the invariant symbol by averaging its rotated pullbacks over all n+1 discrete rotations and both reflection choices.

**Symmetry averages preserve nice symbols.** Proved result `avgSym_nice`: Under the stated hypotheses, symmetry averaging preserves nice symbols.

**Realization commutes with averaging.** Proved result `niceField_avgSym`: Under the stated hypotheses, Fourier realization commutes with averaging.

**The cyclic shift of symmetry indices.** Definition `shiftEquiv`: This defines the permutation of symmetry indices that adds one to the cyclic rotation index and retains the reflection choice.

**The flip of the reflection index.** Definition `boolFlip`: This defines the involution exchanging the two Boolean reflection choices.

**Reflection-index reversal.** Definition `flipEquiv`: This defines the permutation of symmetry indices that retains the rotation index and exchanges the reflection choice.

**average has discrete rotational symmetry.** Proved result `avg_turn`: Under the stated hypotheses, the average has discrete rotational symmetry.

**The average has reflection symmetry.** Proved result `avg_mirror`: Under the stated hypotheses, the average has reflection symmetry.

**Equivariance survives composition.** Proved result `equiv_comp`: Under the stated hypotheses, equivariance survives composition.

**Equivariance survives integer turns.** Proved result `equiv_turn_pow`: Under the stated hypotheses, equivariance survives integer turns.

**Class fields respect symmetry averages.** Proved result `equiv_elem`: Under the stated hypotheses, class fields respect all averaging actions.

**Symmetry averaging decreases error.** Proved result `avg_le`: Under the stated hypotheses, symmetry averaging does not increase error.

**discrete turn is the explicit rotation.** Proved result `turnStep_eq`: Under the stated hypotheses, the discrete turn is the explicit rotation.

**A full rotation is the identity.** Proved result `turnFun_full`: Under the stated hypotheses, a full rotation is the identity.

**A class-preserving average exists.** Proved result `classAverage`: Under the stated hypotheses, a class-preserving average exists.

**Nice class fields are dense.** Proved result `niceClassDense`: Under the stated assumptions, this establishes that every solenoidal L² field in the symmetry class can be approximated arbitrarily well in squared L² error by nice fields in that class.

### Breakdown.FracCert.PowerSymbol

Identifies weak fractional powers by pairing with band-limited Fourier tests and proving uniqueness of their symbols.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/PowerSymbol.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.PowerSymbolInternal`.

**Complex conjugation is an involution.** Proved result `conjVec_conjVec`: Under the stated hypotheses, complex conjugation is an involution. Source: `Breakdown.FracCert.PowerSymbol:20`.

**Conjugation preserves real pairings.** Proved result `inner_conjVec`: Under the stated hypotheses, conjugation preserves real inner products.

**Compact tests pair integrably.** Proved result `integrable_inner_of_compact`: Under the stated hypotheses, compact tests pair integrably.

**Symmetric scalar tests give band symbols.** Proved result `band_of_scalar`: Under the stated hypotheses, symmetrized scalar tests are band symbols.

**Symmetric band pairings double.** Proved result `integral_band_scalar`: Under the stated hypotheses, symmetric band pairings double.

**Source namespace:** `Breakdown.SteadyCert`.

**Band tests determine symbols uniquely.** Proved result `bandUnique`: Under the stated assumptions, this establishes that locally integrable complex vector fields with real conjugation symmetry and equal real pairings against all admissible band symbols agree almost everywhere.

**Real symbols have conjugate symmetry.** Proved result `symbolConjSym`: Under the stated assumptions, this establishes that the total L² Fourier symbol of any real field has conjugation symmetry almost everywhere.

**Frequency weights preserve band symbols.** Proved result `bandScale`: Under the stated assumptions, this establishes that multiplying a band symbol by a positive radial frequency power preserves smoothness, compact support away from zero and real conjugation symmetry.

**Band pairings satisfy Plancherel.** Proved result `bandPair`: Under the stated assumptions, this establishes that for any real L² field and admissible band symbol, the physical pairing with the inverse-transform test equals the frequency pairing with the field symbol.

**Source namespace:** `Breakdown.SteadyCert.PowerSymbolInternal`.

**Band symbols realize Schwartz fields.** Proved result `band_field`: Under the stated hypotheses, band symbols realize Schwartz fields.

**Fourier uniqueness of band fields.** Proved result `band_eq_of_transform`: Under the stated hypotheses, Fourier transforms determine the band field.

**The negative trace multiplies the symbol.** Proved result `band_negSecondTrace`: Under the stated hypotheses, the negative trace multiplies the symbol.

**Fractional powers weight band symbols.** Proved result `band_power`: Under the stated hypotheses, fractional powers multiply the band symbol.

**Source namespace:** `Breakdown.SteadyCert`.

**Band powers are weighted second traces.** Proved result `bandPowerTrace`: Under the stated assumptions, this establishes that for 1<α<3/2, the fractional power of a band test is its negative second derivative sum after multiplying the symbol by (2π‖ξ‖)^(2α−2).

**Band tests identify the weak power.** Proved result `weakPowerSymbol_of_band`: Under the stated assumptions, this establishes that for 1<α<3/2, the Fourier symbol of the weak fractional power of a second-order field equals (2π‖ξ‖)^(2α−2) times its negative-second-trace symbol almost everywhere.

**Negative second traces lie in L².** Proved result `memLp_trace_of`: Under the stated hypotheses, negative second traces lie in L².

**Rapid tests give band power pairings.** Proved result `bandWeakPower_of`: Under the stated assumptions, this establishes that for 1<α<3/2, the weak fractional-power pairing holds against physical fields whose smooth Fourier symbols are compactly supported away from zero and have real conjugation symmetry.

**Rapid tests give band second pairings.** Proved result `bandSecondPair_of`: Under the stated assumptions, this establishes that pairing a second-order velocity with the negative second derivative sum of a band test equals the frequency pairing of its negative-second-trace symbol with the band symbol.

**Rapid identities give the power symbol.** Proved result `weakPowerSymbol_of`: Under the stated assumptions, this establishes that for 1<α<3/2, the Fourier symbol of the weak fractional power of a second-order field equals (2π‖ξ‖)^(2α−2) times its negative-second-trace symbol almost everywhere.

### Breakdown.FracCert.PowerSymbolRapid

Extends the weak fractional-power identity from compact tests to Schwartz tests by quantitative cutoff decay estimates.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/PowerSymbolRapid.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.PowerSymbolRapid.Internal`.

**The near-and-far remainder weight.** Definition `edgeWeight`: This defines the radial dominating weight as the minimum of ‖z‖^(−2α) and ‖z‖^(−1−2α).

**The remainder weight is nonnegative.** Proved result `edgeWeight_nonneg`: Under the stated hypotheses, the remainder weight is nonnegative.

**Far translations compare radial weights.** Proved result `one_add_le_of_far`: Under the stated hypotheses, far translations compare radial weights.

**Nearby points compare radial weights.** Proved result `one_add_le_of_near`: Under the stated hypotheses, nearby points compare radial weights.

**Comparable radii compare decay weights.** Proved result `weight_shift`: Under the stated hypotheses, comparable radii compare decay weights.

**Far weights split into two factors.** Proved result `far_weight`: Under the stated hypotheses, far weights split into two factors.

**The fractional remainder has a majorant.** Proved result `pointwise_bound`: Under the stated hypotheses, the fractional remainder has a majorant.

**Near and far power bounds give L¹.** Proved result `integrable_near_far`: Under the stated hypotheses, near and far power bounds give L¹.

**The remainder weight is integrable.** Proved result `edgeWeight_integrable`: Under the stated hypotheses, the remainder weight is integrable.

**The fractional-power dominating function.** Definition `domFun`: This defines the two-variable bound (1+‖x‖)^(−3−2α) times the sum of the radial edge weight and (1+‖x+z‖)^(−4).

**The mass of the dominating kernel.** Definition `domTotal`: This defines the integrated dominating constant as the sum of the edge-weight integral and the integral of (1+‖z‖)^(−4).

**Fourth-order radial decay is integrable.** Proved result `integrable_four`: Under the stated hypotheses, fourth-order radial decay is integrable.

**The dominating function is integrable.** Proved result `domFun_integrable`: Under the stated hypotheses, the dominating function is integrable.

**The integral factors its spatial weight.** Proved result `domFun_integral`: Under the stated hypotheses, its integral separates the spatial weight.

**Radial weights factor from norms.** Proved result `kernel_norm`: Under the stated hypotheses, positive radial weights factor from norms.

**Fractional powers of rapid fields decay.** Proved result `power_bound`: Under the stated hypotheses, fractional powers of rapid fields decay.

**Weighted bounds imply pointwise decay.** Proved result `le_weight`: Under the stated hypotheses, weighted bounds imply pointwise decay.

**Finite derivative orders are bounded.** Proved result `nat_le_top`: Under the stated hypotheses, finite derivative orders are below infinity.

**Scaled bump derivatives stay bounded.** Proved result `bump_bound`: Under the stated hypotheses, scaled bump derivatives stay bounded.

**Cutoff derivatives retain rapid decay.** Proved result `cut_weight`: Under the stated hypotheses, cutoff fields retain rapid derivative bounds.

**One bound covers four derivative orders.** Proved result `cut_hyps`: Under the stated hypotheses, one constant bounds four derivative orders.

**Cutoff remainders eventually agree.** Proved result `remainder_eventually`: Under the stated hypotheses, cutoff remainders eventually agree.

**The second-order remainder is continuous.** Proved result `continuous_remainder`: Under the stated hypotheses, the second-order remainder is continuous.

**Cutoff fractional powers converge.** Proved result `power_tendsto`: Under the stated hypotheses, cutoff fractional powers converge.

**Fractional powers are continuous.** Proved result `power_continuous`: Under the stated hypotheses, fractional powers of smooth fields are continuous.

**The dominating mass is nonnegative.** Proved result `domTotal_nonneg`: Under the stated hypotheses, the dominating mass is nonnegative.

**L⁶ fields pair with the decay majorant.** Proved result `product_integrable`: Under the stated hypotheses, L⁶ fields pair with the decay majorant.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak powers pair with Schwartz tests.** Proved result `rapidWeakPower`: Under the stated assumptions, this establishes that for 1<α<3/2, the weak fractional-power pairing of a measurable L⁶ field extends to every Schwartz test field.

### Breakdown.FracCert.PowerSymbolSplit

Defines band-limited test symbols and the pairing, reality and uniqueness contracts used to recover fractional symbols.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/PowerSymbolSplit.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**A smooth real-symmetric band symbol.** Definition `IsBandSymbol`: This predicate requires an infinitely differentiable, compactly supported complex symbol that vanishes near zero frequency and has real conjugation symmetry.

**Weak powers pair with Schwartz tests.** Proposition `RapidWeakPowerStatement`: This proposition requires that for 1<α<3/2, the weak fractional-power pairing of a measurable L⁶ field extends to every Schwartz test field.

**Weak Hessians pair with Schwartz tests.** Proposition `RapidSecondPairStatement`: This proposition requires that for a second-order field, pairing the velocity with the negative second derivative sum of a Schwartz test equals pairing the negative second trace with that test.

**Weak powers pair with band fields.** Proposition `BandWeakPowerStatement`: This proposition requires that for 1<α<3/2, the weak fractional-power pairing holds against physical fields whose smooth Fourier symbols are compactly supported away from zero and have real conjugation symmetry.

**Weak Hessians pair with band fields.** Proposition `BandSecondPairStatement`: This proposition requires that pairing a second-order velocity with the negative second derivative sum of a band test equals the frequency pairing of its negative-second-trace symbol with the band symbol.

**Band pairings satisfy Plancherel.** Proposition `BandPairStatement`: This proposition requires that for any real L² field and admissible band symbol, the physical pairing with the inverse-transform test equals the frequency pairing with the field symbol.

**Frequency weights preserve band symbols.** Proposition `BandScaleStatement`: This proposition requires that multiplying a band symbol by a positive radial frequency power preserves smoothness, compact support away from zero and real conjugation symmetry.

**Band powers are weighted second traces.** Proposition `BandPowerTraceStatement`: This proposition requires that for 1<α<3/2, the fractional power of a band test is its negative second derivative sum after multiplying the symbol by (2π‖ξ‖)^(2α−2).

**Real symbols have conjugate symmetry.** Proposition `SymbolConjSymStatement`: This proposition requires that the total L² Fourier symbol of any real field has conjugation symmetry almost everywhere.

**Band tests determine symbols uniquely.** Proposition `BandUniqueStatement`: This proposition requires that locally integrable complex vector fields with real conjugation symmetry and equal real pairings against all admissible band symbols agree almost everywhere.

### Breakdown.FracCert.PressureGradientSquare

Bounds the Fourier pressure-gradient projection and uses L¹-L² convolution estimates to prove square integrability.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/PressureGradientSquare.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.PressureGradientSquareInternal`.

**Weighted Cauchy-Schwarz for integrals.** Proved result `sq_lintegral_mul_le`: For almost everywhere measurable nonnegative extended-real functions a and b, the square of the integral of ab is at most the integral of a times the integral of ab².

**The squared L¹-L² convolution bound.** Proved result `lintegral_conv_sq_le`: For measurable nonnegative extended-real functions, the integral of the squared convolution is at most the square of the first function's integral times the integral of the second function's square.

**An L¹-L² complex convolution is in L².** Proved result `memLp_convC`: The convolution of strongly measurable complex functions belongs to L² when the first is integrable and the second belongs to L².

**Coordinate norms bound the vector norm.** Proved result `norm_le_sum_coord`: Under the stated hypotheses, coordinate norms bound the vector norm.

**Frequency contraction is a pairing.** Proved result `inner_freqVec_eq`: Under the stated hypotheses, frequency contraction is an inner product.

**Longitudinal projection contracts norms.** Proved result `norm_gradSymbol_le`: The negative longitudinal frequency projection of a complex vector has norm at most that vector's norm, including the zero-frequency value supplied by total division.

**Source namespace:** `Breakdown.FracCert`.

**Moments give an L² pressure gradient.** Proved result `pressureGradientSquare`: Assuming the interface that converts all energy-space Fourier moments into L¹ symbol moments, every all-moments energy-space field has a canonical pressure with L² gradient.

### Breakdown.FracCert.ProductClass

Checks that symmetric convection with a smooth profile preserves rotational and reflection symmetry.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/ProductClass.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.ProductClassInternal`.

**Continuous symmetry holds at every point.** Proved result `equivariant_everywhere`: Under the stated hypotheses, continuous symmetry holds at every point.

**Derivatives preserve spatial symmetry.** Proved result `deriv_equivariant`: Under the stated hypotheses, derivatives preserve spatial symmetry.

**Symmetric products preserve equivariance.** Proved result `product_at`: Under the stated hypotheses, symmetric products preserve equivariance.

**turn isometry equals the discrete turn.** Proved result `turn_coe`: Under the stated hypotheses, the turn isometry equals the discrete turn.

**The mirror isometry equals reflection.** Proved result `mirror_coe`: Under the stated hypotheses, the mirror isometry equals reflection.

**Source namespace:** `Breakdown.SteadyCert`.

**Symmetric products preserve the class.** Proved result `productClass`: Under the stated assumptions, this establishes that the symmetric convection product of a C¹ symmetry-class profile and a second-order field in that class remains in the same symmetry class.

### Breakdown.FracCert.ProductCompact

Combines local translation compactness with a decaying-tail estimate to prove compactness of convection by the approximate profile.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/ProductCompact.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Gradient bounds control ball shifts.** Proposition `BallShiftStatement`: This proposition requires that for a field with the stated local L² regularity and square-integrable weak gradient, the integral over the radius-R ball of the squared difference between the field and its translate is at most the squared translation length times the global gradient energy whenever the translation has norm at most one.

**Bounded local energy gives finite nets.** Proposition `BallCompactStatement`: This proposition requires that uniform local L² bounds and global weak-gradient energy bounds give finite L² approximation nets on each smaller ball.

**Velocity and gradient share finite nets.** Proposition `BallNetStatement`: This proposition requires that uniform inverse-radius velocity and first- and second-derivative energy bounds for second-order fields give finite simultaneous L² approximation nets for velocity and gradient on every ball.

**Source namespace:** `Breakdown.SteadyCert.ProductCompactInternal`.

**Integral distance equals L² distance.** Proved result `integral_sq_dist`: Under the stated hypotheses, integral distance equals L² distance.

**Finite L² nets give subsequences.** Proved result `subseq_of_net`: Under the stated hypotheses, finite L² nets give convergent subsequences.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.ProductCompact:77`.

**Matrix energy controls squared action.** Proved result `apply_sq_le`: Under the stated hypotheses, matrix energy controls squared action.

**Profile decay controls product energy.** Proved result `sym_sq_le`: Under the stated hypotheses, profile decay controls product energy.

**Local nets and tails give global nets.** Proved result `net_of_split`: Under the stated hypotheses, local nets and small tails give global nets.

**Almost every spatial point is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every spatial point is nonzero. Source: `Breakdown.FracCert.ProductCompact:176`.

**product has L² bounds and small tails.** Proved result `field_bounds`: Under the stated hypotheses, the product has L² bounds and small tails.

**Uniform radial bounds give small tails.** Proved result `tail_of_bound`: Under the stated hypotheses, uniform radial bounds give small tails.

**Symmetric products preserve differences.** Proved result `diff_apply`: Under the stated hypotheses, symmetric products preserve differences.

**Local energy of product differences.** Proved result `diff_sq_le`: Under the stated hypotheses, product differences have local energy bounds.

**Matrix-entry energy is continuous.** Proved result `entrySq_continuous`: Under the stated hypotheses, matrix-entry energy is continuous. Source: `Breakdown.FracCert.ProductCompact:311`.

**Matrix differences have an energy bound.** Proved result `entrySq_sub_le`: Under the stated hypotheses, matrix differences have an energy bound.

**Local difference energies are integrable.** Proved result `ball_integrable`: Under the stated hypotheses, local difference energies are integrable.

**Two finite nets combine into one.** Proved result `net_add`: Under the stated hypotheses, two finite nets combine into one.

**Squared integral distances obey a bound.** Proved result `sq_tri`: Under the stated hypotheses, squared integral distances obey a bound.

**Squared integral distance is symmetric.** Proved result `sq_symm`: Under the stated hypotheses, squared integral distance is symmetric.

**Matrix energy controls each column.** Proved result `entry_le`: Under the stated hypotheses, matrix energy controls each column. Source: `Breakdown.FracCert.ProductCompact:391`.

**Full Hessian energy controls columns.** Proved result `col_entrySq_le`: Under the stated hypotheses, full Hessian energy controls columns.

**Tensor transposition is continuous.** Proved result `flip_cont`: Under the stated hypotheses, flipping derivative tensors is continuous.

**Evaluating linear maps is continuous.** Proved result `apply_cont`: Under the stated hypotheses, evaluating linear maps is continuous.

**Source namespace:** `Breakdown.SteadyCert.ShiftInternal`.

**A constant time slice removes the period.** Proved result `period_const`: Under the stated hypotheses, a constant time slice removes the period.

**Failure of finite nets gives separation.** Proved result `separated`: Under the stated hypotheses, failure of finite nets gives separation.

**Source namespace:** `Breakdown.SteadyCert`.

**Translation bounds give compactness.** Proved result `ballCompact_of`: Under the stated assumptions, this establishes that uniform local L² bounds and global weak-gradient energy bounds give finite L² approximation nets on each smaller ball.

**Local compactness gives finite nets.** Proved result `ballNet_of`: Under the stated assumptions, this establishes that uniform inverse-radius velocity and first- and second-derivative energy bounds for second-order fields give finite simultaneous L² approximation nets for velocity and gradient on every ball.

**Decaying profile products are compact.** Proved result `profileProductCompact_of`: Under the stated assumptions, this establishes that a C¹ profile decaying like inverse radius with derivative decaying like inverse radius squared maps any uniformly energy-bounded sequence of second-order fields, through symmetric convection, to an L² sequence with a strongly convergent subsequence.

### Breakdown.FracCert.ProductSquare

Closes the square-integrability estimate for symmetric convection of two second-order fields.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/ProductSquare.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Symmetric convection products lie in L².** Proved result `productSquare`: Under the stated assumptions, this establishes that the symmetric convection product of two second-order fields in the same symmetry class belongs to L².

### Breakdown.FracCert.ProfileMildForm

Integrates the profile equation along a heat-and-similarity test orbit, proving the decay and integrability needed for the resulting mild formula.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/ProfileMildForm.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.ProfileMildFormInternal`.

**Unit similarity leaves tests unchanged.** Proved result `simAdj_one`: Under the stated hypotheses, unit similarity leaves tests unchanged.

**Zero heat time leaves fields unchanged.** Proved result `heatField_zero`: Under the stated hypotheses, zero heat time leaves fields unchanged.

**The orbit starts at the original pairing.** Proved result `orbit_zero`: Under the stated hypotheses, the orbit starts at the original pairing.

**The heated test orbit remains nice.** Proved result `nice_orbit`: Under the stated hypotheses, the heated test orbit remains nice.

**Physical pairings become symbol pairings.** Proved result `pairing_symbol`: Under the stated hypotheses, physical pairings become symbol pairings.

**Heat and similarity preserve nice fields.** Proved result `orbit_field`: The heat-evolved similarity-adjoint image of a nice field is the nice field of the explicitly defined orbit symbol, and that orbit symbol remains nice.

**Drift preserves nice symbols.** Proved result `nice_drift`: Under the stated hypotheses, drift preserves nice symbols.

**Physical and Fourier orbit pairings.** Proved result `orbitPairing_eq`: Under the stated hypotheses, orbit pairings agree in physical and Fourier form.

**Orbit generators agree in both forms.** Proved result `orbitGenerator_eq`: Under the stated hypotheses, orbit generators agree in both forms.

**Differentiating symbol pairings.** Proved result `orbitPairingDeriv_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the velocity pairing with the heat and similarity orbit of a nice test has the stated generator as its derivative at each nonnegative time.

**Symbol integrability controls pairings.** Proved result `orbitGeneratorIntegrable_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the generator of the velocity pairing with a nice test orbit is integrable over positive time.

**Symbol decay gives pairing decay.** Proved result `orbitPairingLimit_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the velocity pairing with the heat and similarity orbit of a nice test tends to zero as time tends to infinity.

**heat multiplier has inverse-square decay.** Proved result `heat_le`: Under the stated hypotheses, the heat multiplier has inverse-square decay.

**Similarity coefficients are at most one.** Proved result `coef_le`: Under the stated hypotheses, similarity coefficients are at most one.

**The orbit symbol has a spatial majorant.** Proved result `symbol_bound`: Under the stated hypotheses, the orbit symbol has a spatial majorant.

**Dilated band symbols eventually vanish.** Proved result `symbol_eventually_zero`: Under the stated hypotheses, dilated band symbols eventually vanish.

**The drift symbol uses radial and turn.** Proved result `driftSym_eq`: The drift symbol is (1−1/(2α))n+Dn(ξ)/(2α)−a(Dn(Jξ)−Jn).

**Axial turns commute with rotation.** Proved result `rot_turn`: Under the stated hypotheses, spatial turns commute with axial rotation.

**Complex turns commute with rotation.** Proved result `turnC_rotC`: Under the stated hypotheses, complex turns commute with axial rotation.

**The radial power has a quadratic form.** Proved result `rpow_form`: Under the stated hypotheses, the radial power has a quadratic form.

**Orbit derivatives obey the product rule.** Proved result `fderiv_orbit`: For α>1 and differentiable input symbol, the spatial derivative of the orbit symbol is the transported derivative of the input times the heat factor plus the transported input times the derivative of that heat factor.

**An explicit formula for orbit drift.** Proved result `driftSym_orbit`: Under the stated hypotheses, drift of the orbit has an explicit formula.

**Complex rotation splits through the turn.** Proved result `rot_decomp`: Under the stated hypotheses, complex rotation splits through the turn.

**Complex rotation has the turn derivative.** Proved result `rot_hasDeriv`: Under the stated hypotheses, complex rotation has the turn derivative.

**orbit derivative is minus its generator.** Proved result `orbit_hasDeriv`: Under the stated hypotheses, the orbit derivative is minus its generator.

**L² pairs with the inverse-square weight.** Proved result `weight_integrable`: Under the stated hypotheses, L² fields pair with the inverse-square weight.

**Weighted symbol pairings have a bound.** Proved result `pair_le`: Under the stated hypotheses, weighted symbol pairings have a bound.

**The orbit symbol is measurable.** Proved result `orbit_meas`: Under the stated hypotheses, the orbit symbol is measurable.

**Drift of the orbit symbol is measurable.** Proved result `drift_meas`: Under the stated hypotheses, drift of the orbit symbol is measurable.

**The orbit power term is measurable.** Proved result `power_meas`: Under the stated hypotheses, the orbit power term is measurable.

**Symbols and derivatives share an annulus.** Proved result `support_facts`: Under the stated hypotheses, nice symbols and derivatives share an annulus.

**The generator bracket has a scalar bound.** Proved result `bracket_le`: Under the stated hypotheses, the generator bracket has a scalar bound.

**A time envelope for the orbit generator.** Definition `decayEnvelope`: This defines an explicit radial envelope combining exponential orbit scaling, polynomial factors and the damping at the inner and outer radii of a frequency annulus.

**scalar envelope bounds the orbit factor.** Proved result `scalar_le`: Under the stated hypotheses, the scalar envelope bounds the orbit factor.

**Exponential decay controls a cubic.** Proved result `cube_exp_le`: Under the stated hypotheses, exponential decay controls a cubic.

**The time envelope decays exponentially.** Proved result `bnd_le`: Under the stated hypotheses, the time envelope decays exponentially.

**Source namespace:** `Breakdown.FracCert`.

**Orbit symbol pairings vanish at infinity.** Proved result `orbitSymbolLimit`: Under the stated assumptions, this establishes that for 1<α<5/4, the weighted frequency pairing of an L² field with a nice symbol orbit tends to zero at infinite time.

**Orbit identities give the mild formula.** Proved result `profileMildForm_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Symbol identities give the mild formula.** Proved result `profileMildForm_of_symbol`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Bounds differentiate symbol pairings.** Proved result `orbitSymbolDeriv_of`: Under the stated assumptions, this establishes that for 1<α<5/4, pairing an L² frequency field with the weighted orbit of a nice symbol has the stated frequency generator as its derivative at each nonnegative time.

**Bounds give an integrable generator.** Proved result `orbitSymbolIntegrable_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the frequency generator pairing of an L² field with a nice symbol orbit is integrable over positive time.

**Symbol bounds give the mild profile form.** Proved result `profileMildForm_of_bound`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**A scalar envelope gives the symbol bound.** Proved result `orbitSymbolBound_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a nice symbol orbit, its drift symbol and its fractional-power symbol have inverse-radius-weighted bounds B(t)(1+‖ξ‖)^(−2), where B is integrable on positive time and locally bounded near every nonnegative time.

**Scalar bounds give the mild profile form.** Proved result `profileMildForm_of_scalar`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**The scalar orbit envelope exists.** Proved result `orbitScalarBound`: Under the stated assumptions, this establishes that for 1<α<5/4 and positive inner and outer annular radii, the scaled radial heat expression has an integrable positive-time envelope locally bounded near each nonnegative time.

**The profile mild formula holds.** Proved result `profileMildForm`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

### Breakdown.FracCert.ProfileMildFormParts

Defines physical and Fourier test orbits and states their differentiation, integrability and decay requirements.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/ProfileMildFormParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The heated similarity-orbit pairing.** Definition `orbitPairing`: This defines the orbit pairing of the velocity with a test field transported by similarity and evolved by fractional heat for time 1−exp(−τ).

**The generator of the orbit pairing.** Definition `orbitGenerator`: This defines the orbit generator as the negative sum of the velocity pairings with the drift adjoint and fractional power of the transported heat test.

**The orbit pairing has its generator.** Proposition `OrbitPairingDerivStatement`: This proposition requires that for 1<α<5/4, the velocity pairing with the heat and similarity orbit of a nice test has the stated generator as its derivative at each nonnegative time.

**The orbit generator is integrable.** Proposition `OrbitGeneratorIntegrableStatement`: This proposition requires that for 1<α<5/4, the generator of the velocity pairing with a nice test orbit is integrable over positive time.

**Orbit pairings vanish at infinity.** Proposition `OrbitPairingLimitStatement`: This proposition requires that for 1<α<5/4, the velocity pairing with the heat and similarity orbit of a nice test tends to zero as time tends to infinity.

**The explicit heated similarity symbol.** Definition `orbitSymbol`: This defines the Fourier orbit by combining fractional heat damping with the rotation, dilation and amplitude of the similarity-adjoint action.

**The inverse-radius Fourier pairing.** Definition `symbolPairing`: This defines the frequency pairing ∫⟨f(ξ),(2π‖ξ‖)⁻¹n(ξ)⟩ dξ.

**The generator in Fourier variables.** Definition `orbitSymbolGenerator`: This defines the frequency orbit generator as the negative sum of the symbol pairings with the drift symbol and the fractional-power multiplier.

**Symbol pairings have their generator.** Proposition `OrbitSymbolDerivStatement`: This proposition requires that for 1<α<5/4, pairing an L² frequency field with the weighted orbit of a nice symbol has the stated frequency generator as its derivative at each nonnegative time.

**The Fourier generator is integrable.** Proposition `OrbitSymbolIntegrableStatement`: This proposition requires that for 1<α<5/4, the frequency generator pairing of an L² field with a nice symbol orbit is integrable over positive time.

**Symbol pairings vanish at infinity.** Proposition `OrbitSymbolLimitStatement`: This proposition requires that for 1<α<5/4, the weighted frequency pairing of an L² field with a nice symbol orbit tends to zero at infinite time.

**An integrable envelope bounds the orbit.** Proposition `OrbitSymbolBoundStatement`: This proposition requires that for 1<α<5/4, a nice symbol orbit, its drift symbol and its fractional-power symbol have inverse-radius-weighted bounds B(t)(1+‖ξ‖)^(−2), where B is integrable on positive time and locally bounded near every nonnegative time.

**A scalar time envelope exists.** Proposition `OrbitScalarBoundStatement`: This proposition requires that for 1<α<5/4 and positive inner and outer annular radii, the scaled radial heat expression has an integrable positive-time envelope locally bounded near each nonnegative time.

### Breakdown.FracCert.ProfileSymbolEquation

Converts the Fourier profile equation into the physical drift-plus-power equation by differentiating inverse transforms along scaling and rotation.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/ProfileSymbolEquation.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.ProfileSymbolEquationInternal`.

**Continuity off zero gives measurability.** Proved result `aesm_of_continuousOn`: Under the stated hypotheses, continuity off zero gives measurability.

**Compact power bounds give integrability.** Proved result `integrable_of_rpow_bound`: Under the stated hypotheses, compact power bounds give integrability.

**power-bound constant can be nonnegative.** Proved result `bound_max`: Under the stated hypotheses, the power-bound constant can be nonnegative.

**Rescaling preserves power bounds.** Proved result `comp_bound`: Under the stated hypotheses, linear rescaling preserves the power bound.

**Fourier characters are continuous.** Proved result `char_continuous`: Under the stated hypotheses, Fourier characters are continuous.

**Characters preserve integrability.** Proved result `integrable_char_smul`: Under the stated hypotheses, characters preserve integrability.

**Linear motion differentiates integrals.** Proved result `param_hasDerivAt`: Under the stated hypotheses, linear motion differentiates under the integral.

**The Fourier character formula.** Proved result `integral_form`: Under the stated hypotheses, inverse transforms have the character formula.

**Scaling derivatives give the drift term.** Proved result `scale_identity`: Under the stated hypotheses, scaling differentiation gives the drift term.

**Projection onto the horizontal plane.** Definition `planeMap`: This defines orthogonal projection onto the plane of the first two spatial coordinates.

**Projection onto the vertical axis.** Definition `axisMap`: This defines orthogonal projection onto the third spatial coordinate.

**The infinitesimal horizontal turn.** Definition `turnMap`: This defines the quarter-turn map (x₁,x₂,x₃) ↦ (−x₂,x₁,0).

**Axial rotation as an operator.** Definition `rotMap`: This defines axial rotation as cosine times the plane projection plus sine times the turn map plus the axis projection.

**The derivative of the rotation operator.** Definition `rotMapDeriv`: This defines the derivative of the rotation matrix as negative sine times the plane projection plus cosine times the turn map.

**Coordinates determine spatial vectors.** Proved result `space_ext`: Under the stated hypotheses, coordinates determine spatial vectors. Source: `Breakdown.FracCert.ProfileSymbolEquation:235`.

**rotation has three coordinate formulas.** Proved result `rot_apply`: Under the stated hypotheses, the rotation has three coordinate formulas.

**Rotation derivatives mix sine and cosine.** Proved result `rotDeriv_apply`: Applied to (x₁,x₂,x₃), the rotation derivative is (−sin t x₁−cos t x₂, cos t x₁−sin t x₂, 0).

**The turn operator equals the axial turn.** Proved result `turnMap_eq`: Under the stated hypotheses, the turn operator equals the axial turn.

**Zero-angle rotation is the identity.** Proved result `rotMap_zero`: Under the stated hypotheses, zero-angle rotation is the identity.

**The initial derivative is the axial turn.** Proved result `rotMapDeriv_zero`: Under the stated hypotheses, the initial derivative is the axial turn.

**The rotation operator preserves norms.** Proved result `rotMap_norm`: Under the stated hypotheses, the rotation operator preserves norms.

**Axial rotation has the matrix derivative.** Proved result `rotMap_hasDerivAt`: The time derivative of the rotated vector is the rotation-derivative matrix applied to that vector, with coordinates (−sin t x₁−cos t x₂, cos t x₁−sin t x₂, 0).

**Axial rotation as an isometry.** Definition `rotIso`: This equips the coordinate rotation map with its norm-preserving linear equivalence structure.

**Rotation derivatives transfer to symbols.** Proved result `rot_identity`: Under the stated hypotheses, rotational differentiation transfers to Fourier space.

**Inverse transforms preserve sums.** Proved result `finv_add`: Under the stated hypotheses, inverse transforms preserve sums.

**Inverse transforms preserve differences.** Proved result `finv_sub`: Under the stated hypotheses, inverse transforms preserve differences.

**Inverse transforms preserve scaling.** Proved result `finv_smul`: Under the stated hypotheses, inverse transforms preserve scalar factors.

**The complex axial turn operator.** Definition `turnCL`: This equips the infinitesimal axial turn on complex vectors with its continuous real linear map structure.

**The complex turn is (−z₂,z₁,0).** Proved result `turnCL_apply`: The bundled continuous complex turn sends (z₁,z₂,z₃) to (−z₂,z₁,0), agreeing with the complex axial generator.

**Inverse transforms commute with the turn.** Proved result `finv_turn`: Under the stated hypotheses, inverse transforms commute with the turn.

**Taking real parts commutes with the turn.** Proved result `turn_real`: Under the stated hypotheses, taking real parts commutes with the turn.

**Squaring doubles the power bound.** Proved result `sq_bound`: Under the stated hypotheses, squaring doubles the power bound. Source: `Breakdown.FracCert.ProfileSymbolEquation:367`.

**Source namespace:** `Breakdown.SteadyCert`.

**Symbols satisfy the physical equation.** Proved result `profileSymbolEquation`: Under the stated assumptions, this establishes that for 1<α<5/4, an admissible profile symbol solving the free frequency equation for nice data realizes an L² drift and the physical free equation almost everywhere.

### Breakdown.FracCert.ProfileSymbolSix

Derives inverse-radius decay of the realized Fourier profile by separating the singular low-frequency part from a differentiable cutoff.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/ProfileSymbolSix.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.Internal.SymbolSix`.

**Integrable symbol derivatives give decay.** Proved result `decay_of_deriv`: Under the stated hypotheses, integrable symbol derivatives give decay.

**Profile symbols have two power bounds.** Proved result `profile_bounds`: Under the stated hypotheses, profile symbols have two power bounds.

**The near-zero majorant is integrable.** Proved result `majorant_integrable`: Under the stated hypotheses, the near-zero majorant is integrable.

**Profile symbols are measurable.** Proved result `profile_aesm`: Under the stated hypotheses, profile symbols are measurable. Source: `Breakdown.FracCert.ProfileSymbolSix:66`.

**One radius separates the two powers.** Proved result `rpow_split`: Under the stated hypotheses, one radius separates the two powers.

**Inverse-radius bounds for cutoff slopes.** Proved result `fderiv_cutoff_le`: Under the stated hypotheses, cutoff derivatives have inverse-radius bounds.

**A cutoff symbol obeys the product rule.** Proved result `smooth_part_hasFDerivAt`: Away from zero frequency, the derivative of (1−χ)w is (1−χ)Dw−Dχ⊗w for an admissible profile symbol and the specified cutoff.

**regularized symbol vanishes near zero.** Proved result `smooth_part_zero_near`: Under the stated hypotheses, the regularized symbol vanishes near zero.

**The regularized symbol is differentiable.** Proved result `smooth_part_differentiable`: Under the stated hypotheses, the regularized symbol is differentiable.

**regularized derivative has a majorant.** Proved result `smooth_part_fderiv_le`: Under the stated hypotheses, the regularized derivative has a majorant.

**The small-frequency part has a majorant.** Proved result `cut_part_le`: Under the stated hypotheses, the small-frequency part has a majorant.

**The two-variable pairing is continuous.** Proved result `continuous_two_inner`: Under the stated hypotheses, the two-variable pairing is continuous.

**Inverse transforms respect the cutoff.** Proved result `inverseTransform_split`: Under the stated hypotheses, inverse transforms respect the cutoff split.

**L¹ norms bound inverse transforms.** Proved result `norm_inverseTransform_le`: Under the stated hypotheses, l¹ norms bound inverse transforms.

**Inverse transforms decay as 1/r.** Proved result `transform_decay`: Under the stated hypotheses, the inverse transform has inverse-radius decay.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile symbols realize L⁶ fields.** Proved result `profileSymbolSix`: Under the stated assumptions, this establishes that for 1<α<5/4, the physical field realized by an admissible profile symbol belongs to L⁶.

### Breakdown.FracCert.QuadraticSquare

Uses Sobolev estimates for weak derivatives to place the quadratic convection term in L².

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/QuadraticSquare.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.QuadraticSquareInternal`.

**Jensen bounds mollified norm powers.** Proved result `normPow_conv_le`: Under the stated hypotheses, jensen bounds mollified norm powers.

**Mollification preserves weak derivatives.** Proved result `mollify_fderiv_apply`: Under the stated hypotheses, mollification preserves weak derivatives. Source: `Breakdown.FracCert.QuadraticSquare:72`.

**The cutoff Sobolev boundary error.** Proved result `cutoff_six`: Under the stated hypotheses, cutoff Sobolev bounds include a boundary error.

**Smooth fields obey the L⁶ Sobolev bound.** Proved result `smooth_six`: Under the stated hypotheses, smooth fields satisfy the L⁶ Sobolev bound.

**Weak derivative bounds give L⁶.** Proved result `six_of_weak`: Under the stated hypotheses, weak derivative bounds give L⁶.

**Sixth powers bound quadratic products.** Proved result `sq_mul_sq_le`: Under the stated hypotheses, quadratic products are bounded by sixth powers.

**Source namespace:** `Breakdown.SteadyCert`.

**Quadratic convection lies in L².** Proved result `quadraticSquareIntegrable`: Under the stated assumptions, this establishes that the self-convection Gv of every second-order field belongs to L².

### Breakdown.FracCert.ResidualGradient

Identifies the remaining smooth profile residual as a pressure gradient by Fourier orthogonality and transport integration by parts.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/ResidualGradient.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.Internal.ResidualGradient`.

**Conjugation conjugates scalar factors.** Proved result `conjVec_smul`: Under the stated hypotheses, conjugation conjugates scalar factors.

**Real symmetry gives a real inverse.** Proved result `conj_invTransform`: Under the stated hypotheses, real symmetry makes the inverse transform real.

**Real parts preserve real-field pairings.** Proved result `re_inner_realVec`: Under the stated hypotheses, real-vector pairings equal real complex parts.

**Physical pairings satisfy Plancherel.** Proved result `pair_symbol`: Under the stated hypotheses, physical pairings satisfy Plancherel.

**Transverse vectors kill radial terms.** Proved result `inner_freqVec_zero`: Under the stated hypotheses, solenoidal vectors kill longitudinal terms.

**Transport derivatives move across tests.** Proved result `transport_pair`: Under the stated hypotheses, transport derivatives move across pairings.

**Drift transfers to the transport adjoint.** Proved result `drift_pair`: Under the stated hypotheses, drift transfers to the transport adjoint.

**Radial fields have scalar coefficients.** Proved result `exists_coeff`: Under the stated hypotheses, longitudinal fields have scalar coefficients.

**Adjoint flow preserves longitudinality.** Proved result `flowAdjoint_long`: Under the stated hypotheses, the flow adjoint preserves longitudinal fields.

**The flow adjoint preserves real symmetry.** Proved result `flowAdjoint_conjSym`: Under the stated hypotheses, the flow adjoint preserves real symmetry.

**Complexification casts each coordinate.** Proved result `complexifyVec_apply`: The ith coordinate of a complexified real vector is the complex cast of its ith real coordinate.

**Source namespace:** `Breakdown.FracCert`.

**The residual annihilates gradient tests.** Proved result `residualGradient`: Assuming the symbol-moment integrability and field-smoothness interfaces, for 1<α<5/4 the residual of an energy-space field with all moments pairs to zero against every physical test with smooth conjugation-symmetric longitudinal Fourier symbol compactly supported away from zero.

### Breakdown.FracCert.ResidualNice

Shows that the smooth profile residual annihilates nice tests after adding the square-integrable pressure gradient.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/ResidualNice.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.ResidualNiceInternal`.

**Operator norms bound matrix-entry energy.** Proved result `entrySq_le`: Under the stated hypotheses, operator norms control matrix-entry energy. Source: `Breakdown.FracCert.ResidualNice:17`.

**Smooth pressure gradients are continuous.** Proved result `continuous_gradientAt`: Under the stated hypotheses, smooth pressure gradients are continuous.

**Classical gradients are weak gradients.** Proved result `isGradientField_of`: Under the stated hypotheses, classical gradients are weak gradient fields.

**Classical derivatives are weak gradients.** Proved result `isWeakGradient_of`: Under the stated hypotheses, classical derivatives are weak gradients.

**L² fields pair integrably.** Proved result `integrable_inner_pair`: Under the stated hypotheses, L² fields pair integrably.

**Source namespace:** `Breakdown.FracCert`.

**The residual annihilates nice tests.** Proved result `residualNice_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the pressure-corrected residual of a weak rotating profile with all moments pairs to zero against every nice test field.

### Breakdown.FracCert.SecondOrderComplete

Proves linearity and completeness of the second-order field class by passing weak derivative, symmetry and energy identities through Lp limits.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SecondOrderComplete.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Linear combinations have a square bound.** Proved result `sq_add_smul_le`: Under the stated hypotheses, linear combinations have a square bound.

**Discrete turns preserve linearity.** Proved result `turnStep_add_smul`: Under the stated hypotheses, discrete turns preserve linear combinations.

**Reflections preserve linear combinations.** Proved result `mirror_add_smul`: Under the stated hypotheses, reflections preserve linear combinations.

**Matrix-entry energy is continuous.** Proved result `entrySq_continuous`: Under the stated hypotheses, matrix-entry energy is continuous. Source: `Breakdown.FracCert.SecondOrderComplete:29`.

**Full Hessian energy is continuous.** Proved result `fullSq_continuous`: Under the stated hypotheses, full Hessian energy is continuous.

**Derivative columns lie in L².** Proved result `col_memLp`: Under the stated hypotheses, derivative columns lie in L². Source: `Breakdown.FracCert.SecondOrderComplete:38`.

**Hessian entries lie in L².** Proved result `entry_memLp`: Under the stated hypotheses, hessian entries lie in L². Source: `Breakdown.FracCert.SecondOrderComplete:50`.

**Compact tests pair integrably.** Proved result `test_integrable`: Under the stated hypotheses, compact tests pair integrably. Source: `Breakdown.FracCert.SecondOrderComplete:67`.

**Test derivatives are continuous.** Proved result `deriv_test_continuous`: Under the stated hypotheses, test derivatives are continuous. Source: `Breakdown.FracCert.SecondOrderComplete:72`.

**Test derivatives have compact support.** Proved result `deriv_test_support`: Under the stated hypotheses, test derivatives have compact support. Source: `Breakdown.FracCert.SecondOrderComplete:76`.

**Test integration preserves linearity.** Proved result `lin_integral`: Under the stated hypotheses, test integration preserves linear combinations.

**Second-order fields admit linearity.** Proved result `secondOrderLinear`: Under the stated assumptions, this establishes that linear combinations of second-order fields in the same symmetry class remain second-order fields with the corresponding combinations of their derivative fields.

**Gradient energy controls the L⁶ norm.** Proposition `SixthGradientBoundStatement`: This proposition requires that a universal constant bounds the sixth-power integral of a measurable L⁶ field by the cube of its square-integrable weak-gradient energy.

**Each basis vector has unit norm.** Proved result `unitVector_norm`: Under the stated hypotheses, each basis vector has unit norm. Source: `Breakdown.FracCert.SecondOrderComplete:164`.

**Operator norms control column norms.** Proved result `col_le`: Under the stated hypotheses, operator norms control column norms.

**Tensor norms control entry norms.** Proved result `entry_le`: Under the stated hypotheses, tensor norms control entry norms.

**Matrix entries control the operator norm.** Proved result `opNorm_le_sqrt_entrySq`: Under the stated hypotheses, matrix entries control the operator norm.

**Matrix energy bounds operator norms.** Proved result `opNorm_sq_le_entrySq`: Under the stated hypotheses, matrix energy controls squared operator norm.

**Operator norms bound matrix-entry energy.** Proved result `entrySq_le`: Under the stated hypotheses, operator norms control matrix-entry energy. Source: `Breakdown.FracCert.SecondOrderComplete:194`.

**Hessian energy bounds tensor norms.** Proved result `opNorm_sq_le_full`: Under the stated hypotheses, hessian entries control squared tensor norm.

**Tensor norms control full Hessian energy.** Proved result `full_le`: Under the stated hypotheses, tensor norms control full Hessian energy.

**Tensor norms control the second trace.** Proved result `trace_le`: Under the stated hypotheses, tensor norms control the second trace.

**Squared trace energy is continuous.** Proved result `trace_sq_continuous`: Under the stated hypotheses, squared trace energy is continuous.

**Integrable squares give L² membership.** Proved result `memLp_two_of_sq`: Under the stated hypotheses, integrable squares give L² membership.

**A square majorant gives integrability.** Proved result `integrable_of_sq`: Under the stated hypotheses, a square-integrable majorant gives integrability.

**The gradient tensor lies in L².** Proved result `gradient_memLp`: Under the stated hypotheses, the gradient tensor lies in L².

**The Hessian tensor lies in L².** Proved result `second_memLp`: Under the stated hypotheses, the Hessian tensor lies in L².

**Compact tests admit Lp pairings.** Proved result `test_integrable_gen`: Under the stated hypotheses, compact tests pair with general Lp fields.

**Lp Cauchy sequences have field limits.** Proved result `exists_lim`: Under the stated hypotheses, lp Cauchy sequences have field limits.

**Lp limits preserve compact test pairings.** Proved result `pair_lim`: Under the stated hypotheses, lp limits preserve compact test pairings.

**Linear maps preserve test-pairing limits.** Proved result `pair_clm`: Under the stated hypotheses, linear maps preserve limiting test pairings.

**Discrete turns preserve sums.** Proved result `turnStep_add`: Under the stated hypotheses, discrete turns preserve sums. Source: `Breakdown.FracCert.SecondOrderComplete:358`.

**Discrete turns preserve scaling.** Proved result `turnStep_smul`: Under the stated hypotheses, discrete turns preserve scaling. Source: `Breakdown.FracCert.SecondOrderComplete:362`.

**Discrete turns preserve norms.** Proved result `turnStep_norm`: Under the stated hypotheses, discrete turns preserve norms. Source: `Breakdown.FracCert.SecondOrderComplete:366`.

**Reflection preserves sums.** Proved result `mirror_add`: Under the stated hypotheses, reflection preserves sums. Source: `Breakdown.FracCert.SecondOrderComplete:372`.

**Reflection preserves scaling.** Proved result `mirror_smul`: Under the stated hypotheses, reflection preserves scaling. Source: `Breakdown.FracCert.SecondOrderComplete:376`.

**Reflection preserves norms.** Proved result `mirror_norm`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.SecondOrderComplete:380`.

**The discrete turn as an isometry.** Definition `turnIso`: This equips the discrete axial turn with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondOrderComplete:385`.

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondOrderComplete:390`.

**turn isometry equals the discrete turn.** Proved result `turnIso_coe`: Under the stated hypotheses, the turn isometry equals the discrete turn. Source: `Breakdown.FracCert.SecondOrderComplete:394`.

**The mirror isometry equals reflection.** Proved result `mirrorIso_coe`: Under the stated hypotheses, the mirror isometry equals reflection. Source: `Breakdown.FracCert.SecondOrderComplete:399`.

**Almost-everywhere facts survive turns.** Proved result `turn_ae`: Under the stated hypotheses, almost-everywhere facts survive turns.

**Reflection preserves a.e. facts.** Proved result `mirror_ae`: Under the stated hypotheses, almost-everywhere facts survive reflection.

**The discrete turn is continuous.** Proved result `turn_continuous`: Under the stated hypotheses, the discrete turn is continuous.

**Reflection is continuous.** Proved result `mirror_continuous`: Under the stated hypotheses, reflection is continuous.

**Completeness of second-order fields.** Proved result `secondOrderComplete_of`: Under the stated assumptions, this establishes that a Cauchy sequence of second-order fields for a measurable weight bounded above and bounded away from zero has a second-order limit with weighted derivative-energy convergence and strong L⁶ convergence.

### Breakdown.FracCert.SecondOrderWeakLimit

Passes second-order weak derivative and symmetry identities to a weighted weak limit, recovering L⁶ control by dual testing.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SecondOrderWeakLimit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.SecondOrderWeakLimitInternal`.

**Young bounds the sixth-power pairing.** Proved result `mul_pow_five_le`: Under the stated hypotheses, young bounds the sixth-power pairing.

**Almost every spatial point is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every spatial point is nonzero. Source: `Breakdown.FracCert.SecondOrderWeakLimit:20`.

**Each basis vector has unit norm.** Proved result `unitVector_norm`: Under the stated hypotheses, each basis vector has unit norm. Source: `Breakdown.FracCert.SecondOrderWeakLimit:25`.

**Weighted weak limits give physical tests.** Proved result `pair_tendsto`: Under the stated hypotheses, weighted weak limits give physical tests.

**Compact tests pair integrably.** Proved result `test_integrable`: Under the stated hypotheses, compact tests pair integrably. Source: `Breakdown.FracCert.SecondOrderWeakLimit:46`.

**Inner products commute with integrals.** Proved result `inner_integral`: Under the stated hypotheses, inner products pass through vector integrals.

**Constant-vector tests lie in L².** Proved result `test_memLp`: Under the stated hypotheses, constant-vector tests lie in L².

**Radius-weighted compact tests lie in L².** Proved result `test_memLp_weight`: Under the stated hypotheses, radius-weighted compact tests lie in L².

**Test derivatives are continuous.** Proved result `deriv_test_continuous`: Under the stated hypotheses, test derivatives are continuous. Source: `Breakdown.FracCert.SecondOrderWeakLimit:69`.

**Test derivatives have compact support.** Proved result `deriv_test_support`: Under the stated hypotheses, test derivatives have compact support. Source: `Breakdown.FracCert.SecondOrderWeakLimit:73`.

**Derivative columns lie in L².** Proved result `col_memLp`: Under the stated hypotheses, derivative columns lie in L². Source: `Breakdown.FracCert.SecondOrderWeakLimit:77`.

**Hessian entries lie in L².** Proved result `entry_memLp`: Under the stated hypotheses, hessian entries lie in L². Source: `Breakdown.FracCert.SecondOrderWeakLimit:89`.

**Discrete turns preserve sums.** Proved result `turnStep_add`: Under the stated hypotheses, discrete turns preserve sums. Source: `Breakdown.FracCert.SecondOrderWeakLimit:106`.

**Discrete turns preserve scaling.** Proved result `turnStep_smul`: Under the stated hypotheses, discrete turns preserve scaling. Source: `Breakdown.FracCert.SecondOrderWeakLimit:110`.

**Discrete turns preserve norms.** Proved result `turnStep_norm`: Under the stated hypotheses, discrete turns preserve norms. Source: `Breakdown.FracCert.SecondOrderWeakLimit:114`.

**Reflection preserves sums.** Proved result `mirror_add`: Under the stated hypotheses, reflection preserves sums. Source: `Breakdown.FracCert.SecondOrderWeakLimit:120`.

**Reflection preserves scaling.** Proved result `mirror_smul`: Under the stated hypotheses, reflection preserves scaling. Source: `Breakdown.FracCert.SecondOrderWeakLimit:124`.

**Reflection preserves norms.** Proved result `mirror_norm`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.SecondOrderWeakLimit:128`.

**The discrete turn as an isometry.** Definition `turnIso`: This equips the discrete axial turn with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondOrderWeakLimit:133`.

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondOrderWeakLimit:138`.

**turn isometry equals the discrete turn.** Proved result `turnIso_coe`: Under the stated hypotheses, the turn isometry equals the discrete turn. Source: `Breakdown.FracCert.SecondOrderWeakLimit:142`.

**The mirror isometry equals reflection.** Proved result `mirrorIso_coe`: Under the stated hypotheses, the mirror isometry equals reflection. Source: `Breakdown.FracCert.SecondOrderWeakLimit:147`.

**Isometries move across inner products.** Proved result `inner_symm`: Under the stated hypotheses, isometries move across inner products.

**Weak limits preserve spatial symmetry.** Proved result `sym_limit`: Under the stated hypotheses, weak limits preserve spatial symmetry.

**Pairing bounds recover L⁶ membership.** Proved result `six_of_pairing`: Under the stated hypotheses, pairing bounds recover L⁶ membership.

**Source namespace:** `Breakdown.SteadyCert`.

**Second-order fields admit weak limits.** Proved result `secondOrderWeakLimit_holds`: Under the stated assumptions, this establishes that under the stated uniform derivative bounds and weak L² convergence of weighted velocities and derivative entries, multiplying the limiting weighted velocity by radius gives a second-order field with the limiting derivatives.

### Breakdown.FracCert.SecondPairRapid

Extends the second-order weak integration identity from compact tests to rapidly decaying tests by cutoff approximation.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/SecondPairRapid.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.Internal.SecondPairRapid`.

**Pairability with every integrable weight.** Definition `IsRapidPairable`: This predicate requires integrability of the norm of the field multiplied by every scalar weight that belongs to every Lᵖ space.

**L² fields admit rapid pairings.** Proved result `pairable_two`: Under the stated hypotheses, L² fields admit rapid pairings.

**L⁶ fields admit rapid pairings.** Proved result `pairable_six`: Under the stated hypotheses, L⁶ fields admit rapid pairings.

**Rapid weights give vector integrals.** Proved result `integrable_smul`: Under the stated hypotheses, rapid scalar weights give vector integrals.

**Rapid vector tests pair integrably.** Proved result `integrable_inner`: Under the stated hypotheses, rapid vector tests pair integrably.

**A compact cutoff of a scalar test.** Definition `cut`: This defines a compact approximation to a rapidly decreasing test by multiplying it by the standard bump evaluated at y/R.

**Smooth tests remain smooth after cutoff.** Proved result `contDiff_cut`: Under the stated hypotheses, smooth tests remain smooth after cutoff.

**Cutoffs are test functions.** Proved result `test_cut`: Under the stated hypotheses, positive-radius cutoffs are test functions.

**cutoff agrees inside its central ball.** Proved result `cut_eq`: Under the stated hypotheses, the cutoff agrees inside its central ball.

**Cutoff derivatives agree on inner balls.** Proved result `fderiv_cut_eq`: Under the stated hypotheses, cutoff derivatives agree in the central ball.

**Cutoff derivatives share a majorant.** Proved result `cut_bound`: Under the stated hypotheses, cutoff derivatives have a uniform majorant.

**Expanding cutoffs cover each point.** Proved result `eventually_big`: Under the stated hypotheses, expanding cutoffs eventually contain each point.

**Weak derivatives admit Schwartz tests.** Proved result `weak_ext`: Under the stated hypotheses, weak derivatives extend to Schwartz tests.

**Inner products expand by coordinate.** Proved result `inner_expand`: Under the stated hypotheses, inner products expand by coordinate.

**Vector weak identities admit rapid tests.** Proved result `weak_vec`: Under the stated hypotheses, vector weak identities extend to Schwartz tests.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak Hessians pair with Schwartz tests.** Proved result `rapidSecondPair`: Under the stated assumptions, this establishes that for a second-order field, pairing the velocity with the negative second derivative sum of a Schwartz test equals pairing the negative second trace with that test.

### Breakdown.FracCert.SecondSymbol

Constructs the Fourier symbol of the negative second trace and proves the corresponding first- and second-derivative energy identities.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/SecondSymbol.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.Internal.SecondSymbol`.

**The L² Fourier symbol of a real field.** Definition `hatOf`: Defines the real field's Fourier symbol by taking its L² class when it is square-integrable and zero otherwise, complexifying that class, and applying the real-linear Fourier transform.

**Representative energy is its L² norm².** Proved result `integral_norm_sq_eq`: Under the stated hypotheses, L² representative energy equals norm squared.

**Fourier transforms preserve L² energy.** Proved result `integral_sq_hat`: Under the stated hypotheses, Fourier transform preserves squared energy.

**Complex tests preserve weak derivatives.** Proved result `cplx_deriv`: If real vector fields f and f′ lie in L² and satisfy the weak derivative identity in one coordinate against real scalar tests, their complexifications satisfy the same integration-by-parts identity against smooth compactly supported complex tests.

**Cutoff derivative pairings converge.** Proved result `tendsto_cut_val`: Under the stated hypotheses, cutoff derivative pairings converge.

**Schwartz tests preserve weak derivatives.** Proved result `rapid_deriv`: If the gradient columns and a proposed coordinate derivative lie in L² and satisfy the compact-test weak derivative identity, the same identity holds after complexification against every complex Schwartz test.

**Weak differentiation multiplies by 2πiξ.** Proved result `hat_deriv`: For L² gradient columns and an L² weak coordinate derivative, the derivative's Fourier symbol equals 2πi times that frequency coordinate times the original column's symbol almost everywhere.

**Gradient components lie in L².** Proved result `memLp_comp`: Under the stated hypotheses, gradient components lie in L².

**Hessian entries lie in L².** Proved result `memLp_second`: Under the stated hypotheses, hessian entries lie in L².

**Basis images bound the operator norm.** Proved result `norm_le_sum`: Under the stated hypotheses, basis images bound the operator norm.

**Fourier transforms respect negative sums.** Proved result `hat_negSum`: Under the stated hypotheses, Fourier transforms preserve negative sums.

**The quadratic frequency weight.** Proved result `freqPow_two`: The second radial frequency power is (2π)²‖ξ‖².

**Energy of a Fourier derivative factor.** Proved result `norm_coef_smul`: Multiplying a complex vector z by 2πit multiplies its squared norm by (2π)²t².

**Compatible symbols recover both energies.** Proved result `algebra_id`: At a nonzero frequency, if three vector symbols satisfy the cross-coordinate compatibility equations and s is minus their 2πi-weighted frequency contraction, then ‖s‖² divided by (2π‖ξ‖)² is their summed squared norm and their summed differentiated energy equals ‖s‖².

**Source namespace:** `Breakdown.SteadyCert`.

**second symbol carries derivative energy.** Proved result `secondSymbolEnergy`: Under the stated assumptions, this establishes that for a second-order field, the negative-second-trace Fourier symbol has integrable squared norm divided by (2π‖ξ‖)² equal to the gradient energy, while its unweighted squared norm gives both the full Hessian and trace energies.

### Breakdown.FracCert.SecondTraceSolenoidal

Shows that the negative second trace is a solenoidal symmetry-class field by moving the Laplacian through test derivatives and isometries.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SecondTraceSolenoidal.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.SecondTraceSolenoidalInternal`.

**A coordinate directional derivative.** Definition `dirDeriv`: This defines the directional derivative of a scalar function along the jth coordinate vector.

**The sum of diagonal second derivatives.** Definition `diagSum`: This defines the sum of the three second coordinate derivatives of a scalar function.

**Directional derivatives remain smooth.** Proved result `contDiff_dirDeriv`: Under the stated hypotheses, smooth directional derivatives are smooth.

**Directional derivatives preserve tests.** Proved result `test_dirDeriv`: Under the stated hypotheses, directional derivatives preserve test fields.

**Smooth functions are differentiable.** Proved result `differentiable_of_smooth`: Under the stated hypotheses, smooth functions are differentiable.

**Directional derivatives give Hessians.** Proved result `dirDeriv_dirDeriv`: Under the stated hypotheses, iterated directional derivatives are Hessian entries.

**Smooth mixed derivatives commute.** Proved result `dirDeriv_comm`: Under the stated hypotheses, smooth mixed directional derivatives commute.

**The diagonal sum has three terms.** Proved result `diagSum_eq`: Under the stated hypotheses, the diagonal sum has three terms.

**The diagonal sum preserves tests.** Proved result `test_diagSum`: Under the stated hypotheses, the diagonal sum preserves tests.

**diagonal sum commutes with derivatives.** Proved result `diagSum_dirDeriv`: Under the stated hypotheses, the diagonal sum commutes with derivatives.

**Compact tests pair integrably.** Proved result `integrable_test_smul`: Under the stated hypotheses, compact tests pair integrably.

**Derivative columns lie in L².** Proved result `memLp_column`: Under the stated hypotheses, derivative columns lie in L².

**Diagonal Hessian entries lie in L².** Proved result `memLp_entry`: Under the stated hypotheses, diagonal Hessian entries lie in L².

**Second traces lie in L².** Proved result `memLp_trace`: Under the stated hypotheses, second traces lie in L².

**Weak second traces transfer to tests.** Proved result `weak_diag`: Under the stated hypotheses, weak second traces move onto scalar tests.

**The negative second trace is solenoidal.** Proved result `solenoidal`: Under the stated hypotheses, the negative second trace is solenoidal.

**Orthogonal changes expand the trace.** Proved result `trace_iso_aux`: Under the stated hypotheses, orthogonal changes expand the trace.

**Orthogonal changes preserve the trace.** Proved result `trace_iso`: Under the stated hypotheses, orthogonal changes preserve the trace.

**Derivatives obey orthogonal composition.** Proved result `fderiv_comp_iso`: Under the stated hypotheses, derivatives obey orthogonal composition.

**Laplacian respects orthogonal changes.** Proved result `diagSum_comp_iso`: Under the stated hypotheses, the Laplacian respects orthogonal changes.

**Orthogonal changes preserve integrals.** Proved result `integral_comp_iso`: Under the stated hypotheses, orthogonal changes preserve integrals.

**Isometries pass through vector integrals.** Proved result `integral_iso_smul`: Under the stated hypotheses, isometries pass through vector integrals.

**Second traces preserve spatial symmetry.** Proved result `trace_equivariant`: Under the stated hypotheses, second traces preserve spatial symmetry.

**Discrete turns preserve sums.** Proved result `turnStep_add`: Under the stated hypotheses, discrete turns preserve sums. Source: `Breakdown.FracCert.SecondTraceSolenoidal:278`.

**Discrete turns preserve scaling.** Proved result `turnStep_smul`: Under the stated hypotheses, discrete turns preserve scaling. Source: `Breakdown.FracCert.SecondTraceSolenoidal:282`.

**Discrete turns preserve norms.** Proved result `turnStep_norm`: Under the stated hypotheses, discrete turns preserve norms. Source: `Breakdown.FracCert.SecondTraceSolenoidal:286`.

**Reflection preserves sums.** Proved result `mirror_add`: Under the stated hypotheses, reflection preserves sums. Source: `Breakdown.FracCert.SecondTraceSolenoidal:292`.

**Reflection preserves scaling.** Proved result `mirror_smul`: Under the stated hypotheses, reflection preserves scaling. Source: `Breakdown.FracCert.SecondTraceSolenoidal:296`.

**Reflection preserves norms.** Proved result `mirror_norm`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.SecondTraceSolenoidal:300`.

**The discrete turn as an isometry.** Definition `turnIso`: This equips the discrete axial turn with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondTraceSolenoidal:305`.

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SecondTraceSolenoidal:310`.

**turn isometry equals the discrete turn.** Proved result `turnIso_coe`: Under the stated hypotheses, the turn isometry equals the discrete turn. Source: `Breakdown.FracCert.SecondTraceSolenoidal:314`.

**The mirror isometry equals reflection.** Proved result `mirrorIso_coe`: Under the stated hypotheses, the mirror isometry equals reflection. Source: `Breakdown.FracCert.SecondTraceSolenoidal:319`.

**Source namespace:** `Breakdown.SteadyCert`.

**Second traces stay solenoidal.** Proved result `secondTraceSolenoidal`: Under the stated assumptions, this establishes that the negative second trace of a second-order field is solenoidal in L² and remains in the same discrete rotation and reflection class.

### Breakdown.FracCert.SixthGradientBound

Proves the homogeneous Sobolev L⁶ estimate for weak gradients, controlling cutoff errors by the L⁶ tail before mollification.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SixthGradientBound.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.SixthGradientBoundInternal`.

**Jensen bounds convolution powers.** Proved result `normPow_conv_le_of_dom`: Under the stated hypotheses, jensen bounds dominated convolution powers.

**A common bound controls summed integrals.** Proved result `sum_integral_le`: Under the stated hypotheses, a common majorant bounds summed integrals.

**Convolution preserves energy bounds.** Proved result `conv_sum_le`: Under the stated hypotheses, convolution preserves summed energy bounds.

**Mollification preserves weak derivatives.** Proved result `mollify_fderiv_apply`: Under the stated hypotheses, mollification preserves weak derivatives. Source: `Breakdown.FracCert.SixthGradientBound:107`.

**L⁶ means an integrable sixth power.** Proved result `memLp_six_iff`: Under the stated hypotheses, L⁶ membership means integrable sixth power.

**The L⁶ tail bounds cutoff errors.** Proved result `cross_tail_le`: Under the stated hypotheses, the L⁶ tail bounds cutoff errors.

**The L⁶ tail tends to zero.** Proved result `tail_tendsto`: Under the stated hypotheses, the L⁶ tail tends to zero.

**Smooth L⁶ fields obey the Sobolev bound.** Proved result `smooth_six_of_six`: Under the stated hypotheses, smooth L⁶ fields obey the Sobolev bound.

**Weak gradient energy bounds the L⁶ norm.** Proved result `six_bound_of_weak`: Under the stated hypotheses, weak gradient energy bounds the L⁶ norm.

**Source namespace:** `Breakdown.SteadyCert`.

**Gradient energy bounds the sixth power.** Proved result `sixthGradientBound`: Under the stated assumptions, this establishes that a universal constant bounds the sixth-power integral of a measurable L⁶ field by the cube of its square-integrable weak-gradient energy.

### Breakdown.FracCert.SmoothAssembly

Starts the Fourier moment induction from the energy norm and assembles the first regularity gain and repeated moment gains into smoothness.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothAssembly.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Extended L² energy equals squared norm.** Proved result `lintegral_enorm_sq_eq`: Under the stated hypotheses, extended L² energy equals squared norm.

**The first moment weight cancels radius.** Proved result `weight_sq_le`: Under the stated hypotheses, the first moment weight cancels radius.

**energy norm controls the first moment.** Proved result `homNormSq_one_le`: Under the stated hypotheses, the energy norm controls the first moment.

**Mild trajectories become smooth.** Proved result `mildSmoothing_of`: Under the stated assumptions, this establishes that for 1<α<5/4, every positive-time value of a mild solution in a concrete framework has all Fourier moments.

### Breakdown.FracCert.SmoothFirstGain

Obtains the first positive Fourier regularity gain for a bounded mild trajectory by truncating the weight and controlling the time singularity.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothFirstGain.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.SmoothFirstGain.Internal`.

**The first-gain Fourier weight.** Definition `gainWeight`: This defines the fractional regularity gain weight ‖ξ‖^(2α−1).

**The weighted squared gain norm.** Definition `gainNormSq`: This defines the extended nonnegative integral of the gain weight times the squared norm of the Fourier field.

**L² energy equals squared norm.** Proved result `lintegral_enorm_sq`: Under the stated hypotheses, L² energy equals squared norm.

**gain norm controls the Sobolev moment.** Proved result `fracHomSq_le`: Under the stated hypotheses, the gain norm controls the Sobolev moment.

**Heat decay bounds the gain weight.** Proved result `heat_weight_le`: Under the stated hypotheses, heat decay bounds the gain weight.

**Heat evolution gains weighted regularity.** Proved result `heat_gain`: Under the stated hypotheses, heat evolution gains weighted regularity.

**The gain weight is continuous.** Proved result `gainWeight_continuous`: Under the stated hypotheses, the gain weight is continuous.

**The truncated square-root weight.** Definition `cutMul`: This defines the bounded multiplication field given by the square root of the gain weight truncated at N.

**The bounded gain cutoff operator.** Definition `cutOp`: This defines the L² operator multiplying by the square root of the truncated regularity gain weight.

**The cutoff multiplies by √min(weight,N).** Proved result `cutOp_ae`: For α>1, the L² cutoff operator multiplies its input almost everywhere by √min(‖ξ‖^(2α−1),N).

**Cutoff norm² equals weighted energy.** Proved result `cutOp_sq`: Under the stated hypotheses, cutoff norm squares equal weighted energy.

**The full gain controls each cutoff.** Proved result `cutOp_le`: Under the stated hypotheses, the full gain controls each cutoff.

**The cutoffs recover the full gain.** Proved result `gainNormSq_le_iSup`: Under the stated hypotheses, the cutoffs recover the full gain.

**Weighted energy bounds cutoff norms.** Proved result `cutOp_norm_le`: Under the stated hypotheses, weighted energy bounds cutoff norms.

**The bilinear term gains regularity.** Proved result `bilin_gain`: Under the stated hypotheses, the bilinear term gains regularity.

**Halving time extracts a power of two.** Proved result `half_rpow_neg`: Under the stated hypotheses, halving time extracts a power of two.

**Bilinear cutoffs have a time bound.** Proved result `bilin_cut`: Under the stated hypotheses, bilinear cutoffs have a time bound.

**The time singularity is integrable.** Proved result `sub_rpow_integral`: Under the stated hypotheses, the time singularity is integrable.

**Mild evolution has uniform cutoff bounds.** Proved result `cut_bound`: Under the stated hypotheses, mild evolution has uniform cutoff bounds.

**Source namespace:** `Breakdown.FracCert`.

**Mild trajectories gain regularity.** Proved result `mildFirstGain`: Under the stated assumptions, this establishes that for 1<α<5/4, a mild solution in a concrete framework has uniformly bounded homogeneous squared norm of order α+1/2 on every closed time interval separated from zero.

### Breakdown.FracCert.SmoothMomentStep

Restarts the mild equation at positive time and gains one Fourier moment from the heat and nonlinear terms.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothMomentStep.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The time power has a finite integral.** Proved result `lintegral_rpow_sub_le`: Under the stated hypotheses, the time power has a finite integral.

**Squaring reverses the square root.** Proved result `sq_rpow_half`: Under the stated hypotheses, squaring reverses the square root.

**Mild solutions restart at positive time.** Proved result `restart_concrete`: Under the stated hypotheses, mild trajectories restart at positive time.

**The heat part gains one moment.** Proved result `heat_part`: Under the stated hypotheses, the heat part gains one moment.

**bilinear moment has an integrable bound.** Proved result `bilin_pointwise`: Under the stated hypotheses, the bilinear moment has an integrable bound.

**integrated bilinear term gains a moment.** Proved result `bilin_part`: Under the stated hypotheses, the integrated bilinear term gains a moment.

**Mild solutions gain the next moment.** Proved result `mildMomentStep`: Under the stated assumptions, this establishes that for 1<α<5/4 and k≥1, uniform Fourier L¹ and kth-moment energy bounds away from initial time for a mild solution imply uniform (k+1)st-moment energy bounds on the same type of intervals.

### Breakdown.FracCert.SmoothMomentStepAux

Proves weighted convolution, heat and integration estimates for the induction on Fourier moments.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothMomentStepAux.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The moment multiplier is measurable.** Proved result `momentWeight_measurable`: Under the stated hypotheses, the moment multiplier is measurable.

**The moment norm is a weighted L² norm.** Proved result `homNormSq_symbolX_eq`: Under the stated hypotheses, the moment norm is a weighted L² norm.

**Moment norms obey the triangle bound.** Proved result `smoothMomentNorm_add`: Under the stated hypotheses, moment norms obey the triangle inequality.

**Heat decay controls the extra weight.** Proved result `heat_weight_le`: Under the stated hypotheses, heat decay controls the extra weight.

**Heat evolution gains one Fourier moment.** Proved result `smoothHeatMomentGain`: Under the stated hypotheses, heat evolution gains one Fourier moment.

**Frequency powers split in convolution.** Proved result `norm_pow_le_split`: Under the stated hypotheses, a frequency power splits across convolution.

**Convolution moments have an L¹-L² bound.** Proved result `lintegral_hom_conv_sq_le`: Under the stated hypotheses, convolution moments have an L¹-L² bound.

**Symbol convolutions have moment bounds.** Proved result `smoothConvMomentBound`: Under the stated hypotheses, symbol convolutions have moment bounds.

**Energy-space symbols are measurable.** Proved result `symbolX_aesm`: Under the stated hypotheses, energy-space symbols are measurable.

**Zero higher moment forces zero L¹ mass.** Proved result `symbolL1_zero_of_hom_zero`: Under the stated hypotheses, zero higher moment forces zero L¹ mass.

**Symbol norms gain an inverse radius.** Proved result `enorm_symbolX_le`: If the underlying L² representative has extended norm at most c at a frequency, the energy symbol has extended norm at most the nonnegative reciprocal of 2π‖ξ‖ times c there.

**The bilinear multiplier gains one moment.** Proved result `bilin_weight_le`: Under the stated hypotheses, the bilinear multiplier gains one moment.

**Bilinear evolution gains one moment.** Proved result `smoothBilinMomentGain`: Under the stated hypotheses, bilinear evolution gains one moment.

**The Fourier moment multiplier.** Definition `momentWeight`: This defines the moment weight ‖ξ‖^m/(2π‖ξ‖).

**The capped Fourier moment multiplier.** Definition `truncWeight`: This defines the moment weight truncated above at n.

**The bounded moment cutoff operator.** Definition `truncOp`: This defines the bounded L² operator multiplying by the truncated moment weight.

**Moment weights are nonnegative.** Proved result `momentWeight_nonneg`: Under the stated hypotheses, moment weights are nonnegative.

**Capped moment weights are nonnegative.** Proved result `truncWeight_nonneg`: Under the stated hypotheses, capped moment weights are nonnegative.

**Capped moment weights are measurable.** Proved result `truncWeight_measurable`: Under the stated hypotheses, capped moment weights are measurable.

**The cutoff acts by the capped weight.** Proved result `truncOp_ae`: Under the stated hypotheses, the cutoff acts by the capped weight.

**Extended L² norms square to integrals.** Proved result `enorm_sq_L2C`: Under the stated hypotheses, extended L² norms square to integrals.

**Cutoff norm² equals weighted energy.** Proved result `truncOp_enorm_sq`: Under the stated hypotheses, cutoff norm squares equal weighted energy.

**homogeneous moment is weighted energy.** Proved result `hom_lintegral`: Under the stated hypotheses, the homogeneous moment is weighted energy.

**The full moment bounds every cutoff.** Proved result `truncOp_le`: Under the stated hypotheses, the full moment bounds every cutoff.

**Moment norms pass through time integrals.** Proved result `smoothMomentNorm_integral`: Under the stated hypotheses, moment norms pass through time integrals.

### Breakdown.FracCert.SmoothMomentStepSymbol

Extends a pointwise bilinear Fourier bound from regular symbols to general energy-space symbols by symmetry-preserving annular cutoffs.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothMomentStepSymbol.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Coordinate norms bound the vector norm.** Proved result `norm_sum_le_components`: Under the stated hypotheses, coordinate norms bound the vector norm.

**Convolution bounds the advection symbol.** Proved result `enorm_advection_le`: Under the stated hypotheses, convolution bounds the advection symbol.

**Nice bilinear terms have a symbol bound.** Proved result `smoothBilinNiceBound`: Under the stated hypotheses, nice bilinear terms have a symbol bound.

**Source namespace:** `Breakdown.FracCert.SmoothMomentStepSymbol.Internal`.

**Solenoidality and real symmetry.** Definition `IsBase`: This predicate requires the symbol to be perpendicular to the frequency and to obey real conjugation symmetry at that frequency.

**The expanding frequency annulus.** Definition `ann`: This defines the closed frequency annulus with inner radius 1/(n+1) and outer radius n+1.

**The symmetry-preserving annular cutoff.** Definition `cutSym`: This defines an annular symbol cutoff that retains h(ξ) only where ξ lies in the annulus and the pointwise solenoidal and conjugation conditions both hold, using zero elsewhere.

**Conjugation acts by coordinate.** Proved result `conjVec_apply`: Under the stated hypotheses, conjugation acts by coordinate.

**Complex conjugation is an involution.** Proved result `conjVec_conjVec`: Under the stated hypotheses, complex conjugation is an involution. Source: `Breakdown.FracCert.SmoothMomentStepSymbol:92`.

**Frequency annuli are measurable.** Proved result `measurableSet_ann`: Under the stated hypotheses, frequency annuli are measurable.

**Frequency annuli preserve negation.** Proved result `mem_ann_neg`: Under the stated hypotheses, frequency annuli preserve negation.

**base symbol conditions preserve negation.** Proved result `isBase_neg`: Under the stated hypotheses, the base symbol conditions preserve negation.

**The cutoff symbol is solenoidal.** Proved result `cutSym_sol`: Under the stated hypotheses, the cutoff symbol is solenoidal.

**Cutoffs equal annular restrictions.** Proved result `cutSym_of`: Under the stated hypotheses, admissible cutoffs equal annular restriction.

**Cutting off cannot increase symbol norms.** Proved result `norm_cutSym_le`: Under the stated hypotheses, cutting off cannot increase symbol norms.

**Each cutoff coordinate is norm bounded.** Proved result `norm_cutSym_apply_le`: Under the stated hypotheses, each cutoff coordinate is norm bounded.

**Expanding annuli cover nonzero points.** Proved result `eventually_ann`: Under the stated hypotheses, annuli eventually contain every nonzero point.

**Energy symbols meet the base conditions.** Proved result `isBase_ae`: Under the stated hypotheses, energy symbols satisfy the base conditions.

**Energy-space symbols are measurable.** Proved result `aesm_symbolX`: Under the stated hypotheses, energy-space symbols are measurable.

**Annular cutoff symbols are measurable.** Proved result `aesm_cutSym`: Under the stated hypotheses, annular cutoff symbols are measurable.

**Annuli bound the inverse-radius weight.** Proved result `norm_symbolX_le`: Under the stated hypotheses, annuli bound the inverse-radius multiplier.

**L² representatives have finite energy.** Proved result `lintegral_sq_ne_top`: Under the stated hypotheses, L² representatives have finite squared mass.

**Weighted extended norms convert to reals.** Proved result `ofReal_mul_enorm_sq`: Under the stated hypotheses, weighted extended norms convert to reals.

**Annular cutoffs have all Sobolev moments.** Proved result `hsNormSq_cutSym_lt_top`: Under the stated hypotheses, annular cutoffs have every Sobolev moment.

**Annular cutoffs have finite L¹ mass.** Proved result `symbolL1_cutSym_lt_top`: Under the stated hypotheses, annular cutoffs have finite L¹ mass.

**Cutoff gradients have finite L¹ mass.** Proved result `gradSymbolL1_cutSym_lt_top`: Under the stated hypotheses, annular cutoff gradients have finite L¹ mass.

**Almost every frequency avoids one point.** Proved result `ae_ne`: Under the stated hypotheses, almost every frequency avoids one point.

**The excluded-annulus energy vanishes.** Proved result `tendsto_lintegral_cut`: Under the stated hypotheses, the excluded-annulus energy vanishes.

**Radius multiplication recovers vectors.** Proved result `smul_symbolX`: Under the stated hypotheses, multiplying by radius recovers the vector.

**Cutoff realizations converge in energy.** Proved result `approx_tendsto`: Under the stated hypotheses, cutoff realizations converge in energy.

**Cutoff convolutions converge a.e..** Proved result `conv_tendsto_ae`: Under the stated hypotheses, cutoff convolutions converge almost everywhere.

**Bounded bilinear maps preserve limits.** Proved result `bilin_tendsto`: Under the stated hypotheses, bounded bilinear maps preserve convergence.

**Source namespace:** `Breakdown.FracCert`.

**Bilinear terms have a symbol bound.** Proved result `smoothBilinSymbolBound`: Under the stated hypotheses, general bilinear terms have a symbol bound.

### Breakdown.FracCert.SmoothSupGain

Splits low and high frequencies to turn the first Fourier regularity gain into an integrable symbol and a uniform velocity bound.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/SmoothSupGain.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.SmoothSupGainInternal`.

**Weighted Cauchy-Schwarz bounds L¹ mass.** Proved result `weighted_bound`: Under the stated hypotheses, weighted Cauchy-Schwarz bounds L¹ mass.

**Symbol norms are almost measurable.** Proved result `symbolX_enorm_aemeasurable`: Under the stated hypotheses, symbol norms are almost measurable.

**Source namespace:** `Breakdown.FracCert`.

**A regularity gain gives a uniform bound.** Proved result `supFromGain`: Under the stated assumptions, this establishes that for s>3/2, finite fractional homogeneous energy of order s bounds the Fourier L¹ norm by a constant times the sum of the square roots of its first-order and sth-order energies.

### Breakdown.FracCert.SolenoidalSplit

Constructs the Helmholtz decomposition in L² as projection onto the closure of test gradients and proves both parts retain the symmetry class.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SolenoidalSplit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.Internal.SolenoidalSplit`.

**The real vector-field L² space.** Abbreviation `L2F`: This abbreviates the real Hilbert space L² of spatial vector fields.

**Derivatives are pairings with gradients.** Proved result `fderiv_eq_inner`: Under the stated hypotheses, derivatives are pairings with gradients.

**Gradient norms bound derivative norms.** Proved result `norm_fderiv_le`: Under the stated hypotheses, gradient norms bound derivative norms.

**Scalar tests are C¹.** Proved result `test_one`: Under the stated hypotheses, scalar tests are continuously differentiable.

**Scalar tests are differentiable.** Proved result `test_diff`: Under the stated hypotheses, scalar tests are differentiable.

**Test gradients are continuous.** Proved result `continuous_grad`: Under the stated hypotheses, test gradients are continuous.

**Test gradients have compact support.** Proved result `support_grad`: Under the stated hypotheses, test gradients have compact support.

**Test gradients lie in every Lp.** Proved result `memLp_grad`: Under the stated hypotheses, test gradients lie in every Lp.

**Scalar tests lie in every Lp.** Proved result `memLp_test`: Under the stated hypotheses, scalar tests lie in every Lp.

**The zero scalar function is a test.** Proved result `test_zero`: Under the stated hypotheses, the zero scalar function is a test.

**Scalar tests admit sums.** Proved result `test_add`: Under the stated hypotheses, scalar tests admit sums.

**Scalar tests admit differences.** Proved result `test_sub`: Under the stated hypotheses, scalar tests admit differences.

**Scalar tests admit constant scaling.** Proved result `test_mul`: Under the stated hypotheses, scalar tests admit constant scaling.

**Orthogonal changes preserve scalar tests.** Proved result `test_comp`: Under the stated hypotheses, orthogonal changes preserve scalar tests.

**The zero field has zero gradient.** Proved result `grad_zero`: Under the stated hypotheses, the zero field has zero gradient.

**Gradients preserve sums.** Proved result `grad_add`: Under the stated hypotheses, gradients preserve sums.

**Gradients preserve differences.** Proved result `grad_sub`: Under the stated hypotheses, gradients preserve differences.

**Gradients preserve constant scaling.** Proved result `grad_mul`: Under the stated hypotheses, gradients preserve constant scaling.

**Gradients respect orthogonal changes.** Proved result `grad_comp`: Under the stated hypotheses, gradients respect orthogonal changes.

**The subspace of compact test gradients.** Definition `grads`: This defines the linear subspace of L² classes represented almost everywhere by gradients of scalar test functions.

**The L² closure of test gradients.** Definition `gradClosure`: This defines the norm closure of the test-gradient subspace in L².

**Every test gradient lies in the closure.** Proved result `toLp_mem`: Under the stated hypotheses, every test gradient lies in the closure.

**Gradient pairings equal L² pairings.** Proved result `inner_toLp`: Under the stated hypotheses, gradient pairings equal L² inner products.

**Orthogonal fields are solenoidal.** Proved result `solenoidal_of_mem`: Under the stated hypotheses, orthogonal fields are solenoidal.

**Solenoidal fields are orthogonal.** Proved result `mem_orth_of`: Under the stated hypotheses, solenoidal fields lie in the orthogonal space.

**The scalar Sobolev bound.** Proved result `potential_bound`: A universal nonnegative constant bounds the L⁶ norm of every smooth compactly supported real scalar test by the L² norm of its gradient.

**L² closure gives weak gradients.** Proved result `gradient_of_mem`: Every element of the L² closure of smooth compactly supported scalar-test gradients is a weak gradient field.

**Discrete turns preserve sums.** Proved result `turnStep_add`: Under the stated hypotheses, discrete turns preserve sums. Source: `Breakdown.FracCert.SolenoidalSplit:272`.

**Discrete turns preserve scaling.** Proved result `turnStep_smul`: Under the stated hypotheses, discrete turns preserve scaling. Source: `Breakdown.FracCert.SolenoidalSplit:276`.

**Discrete turns preserve norms.** Proved result `turnStep_norm`: Under the stated hypotheses, discrete turns preserve norms. Source: `Breakdown.FracCert.SolenoidalSplit:280`.

**Reflection preserves sums.** Proved result `mirror_add`: Under the stated hypotheses, reflection preserves sums. Source: `Breakdown.FracCert.SolenoidalSplit:286`.

**Reflection preserves scaling.** Proved result `mirror_smul`: Under the stated hypotheses, reflection preserves scaling. Source: `Breakdown.FracCert.SolenoidalSplit:290`.

**Reflection preserves norms.** Proved result `mirror_norm`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.SolenoidalSplit:294`.

**The discrete turn as an isometry.** Definition `turnIso`: This equips the discrete axial turn with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SolenoidalSplit:299`.

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection with its norm-preserving linear equivalence structure. Source: `Breakdown.FracCert.SolenoidalSplit:304`.

**turn isometry equals the discrete turn.** Proved result `turnIso_coe`: Under the stated hypotheses, the turn isometry equals the discrete turn. Source: `Breakdown.FracCert.SolenoidalSplit:308`.

**The mirror isometry equals reflection.** Proved result `mirrorIso_coe`: Under the stated hypotheses, the mirror isometry equals reflection. Source: `Breakdown.FracCert.SolenoidalSplit:313`.

**The induced isometry action on fields.** Definition `act`: This defines the L² action of a spatial isometry by composing the field with that isometry and applying its inverse to the field values.

**Isometries act by R⁻¹f(Ry).** Proved result `act_ae`: The L² action of a spatial isometry R agrees almost everywhere with the field y ↦ R⁻¹(f(Ry)).

**Orthogonal changes respect a.e. equality.** Proved result `comp_ae`: Under the stated hypotheses, almost equality survives orthogonal changes.

**The action preserves test gradients.** Proved result `act_grads`: Under the stated hypotheses, the action preserves test gradients.

**The action preserves their closure.** Proved result `act_closure`: Under the stated hypotheses, the action preserves their closure.

**action preserves the orthogonal space.** Proved result `act_orth`: Under the stated hypotheses, the action preserves the orthogonal space.

**Equivariance means a fixed point.** Proved result `act_fix`: Under the stated hypotheses, equivariant fields are fixed by the action.

**Projection preserves fixed points.** Proved result `fixed_part`: Under the stated hypotheses, orthogonal projections preserve fixed points.

**Fixed projections retain equivariance.** Proved result `class_part`: Under the stated hypotheses, fixed projected fields retain equivariance.

**Solenoidal and gradient decomposition.** Proved result `main`: Every L² vector field in the prescribed symmetry class decomposes almost everywhere into a solenoidal L² field in that class and an L² weak gradient field.

**Source namespace:** `Breakdown.SteadyCert`.

**Solenoidal and gradient decomposition.** Proved result `solenoidalSplit`: Every L² vector field in the prescribed symmetry class is almost everywhere a sum of a solenoidal L² field retaining that class and an L² weak gradient field.

### Breakdown.FracCert.SplitFormBounds

Converts the scalar frequency bounds in the certificate into lower bounds and norm estimates for the split quadratic form.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/SplitFormBounds.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.Internal.SplitFormBounds`.

**Matrix entries bound the squared trace.** Proved result `trace_sq_le`: Under the stated hypotheses, matrix entries bound the squared trace.

**Negative second traces lie in L².** Proved result `memLp_trace`: Under the stated hypotheses, negative second traces lie in L².

**The L² representative equals its field.** Proved result `toLpOrZero_ae`: Under the stated hypotheses, the L² representative equals its field.

**L² fields pair integrably.** Proved result `integrable_pair`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.SplitFormBounds:49`.

**Fourier transform preserves pairings.** Proved result `pair_symbol`: Under the stated hypotheses, Fourier transform preserves pairings.

**Almost every frequency is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every frequency is nonzero. Source: `Breakdown.FracCert.SplitFormBounds:67`.

**A pointwise linear bound integrates.** Proved result `comb_le`: Under the stated hypotheses, a pointwise linear bound integrates.

**The splitting power is 2(α−1).** Proved result `freqPow_eq`: The radial splitting frequency power is (2π‖ξ‖)^(2(α−1)).

**The quadratic weight is a squared radius.** Proved result `freqPow_two_eq`: Under the stated hypotheses, the quadratic weight is a squared radius.

**Source namespace:** `Breakdown.SteadyCert`.

**The split form satisfies three bounds.** Proved result `splitFormBounds_of`: Under the stated hypotheses, the split form satisfies three bounds.

**The split-form estimate interface holds.** Proved result `splitFormBounds`: Under the stated assumptions, this establishes that a valid fractional certificate bounds the splitting pairing below by minus the low-frequency loss times the base derivative energy, makes its coercivity-corrected expression nonnegative and controls the trace norm by the splitting energy.

### Breakdown.FracCert.StDecay

Defines the heat-divergence and far-field operators and states the fractional profile, power and pressure decay contracts.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/StDecay.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The velocity tensor square.** Definition `tensorSq`: This defines the tensor square of a velocity field by the entries Vⱼ(y)Vₖ(y).

**Projected heat-divergence convolution.** Definition `heatDivConv`: This defines the projected heat-divergence convolution by summing the real kernel convolutions against the tensor entries.

**The rotating far-field integral operator.** Definition `farFieldOp`: This defines the far-field operator as the negative positive-time integral of the rotated and self-similarly scaled heat-divergence convolution at time 1−exp(−τ).

**The physical profile from its symbol.** Definition `profileField`: This defines the physical profile by realizing the Fourier symbol of the energy-space element.

**Weighted heat-divergence bounds.** Proposition `HeatDivBoundStatement`: This proposition requires that for 1<α<5/4, 0≤β<3 and 0≤b≤β+1+j, weighted bounds A and B on a tensor and its jth derivative imply a weighted jth heat-divergence bound Ct^(−1/(2α))(A+B) for 0<t≤1.

**Weighted far-field derivative decay.** Proposition `FarFieldBoundStatement`: This proposition requires that under the stated fractional and tensor-decay assumptions with b≠2α−1+j, the far-field operator is Cʲ and its jth derivative decays with weight exponent min(b,2α−1+j).

**The profile is a far-field fixed point.** Proposition `ProfileFixedPointStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all Fourier moments is pointwise the far-field operator applied to its velocity tensor square.

**The profile has its initial power decay.** Proposition `ProfileDecayBaseStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all Fourier moments has velocity bounded by C(1+‖y‖)^(−(2α−1)).

**Profile decay improves by one derivative.** Proposition `ProfileDecayStepStatement`: This proposition requires that for 1<α<5/4, the expected decay bounds on all lower derivatives of a weak rotating profile with all moments imply the jth derivative bound C(1+‖y‖)^(−(2α−1+j)).

**Every profile derivative has power decay.** Definition `ProfileDecay`: This predicate requires every jth physical-profile derivative to be bounded by a constant times (1+‖y‖)^(−(2α−1+j)).

**Fractional powers have faster decay.** Proposition `PowerDecayStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all moments and profile decay has a smooth fractional power whose jth derivative is bounded by C(1+‖y‖)^(−(4α−1+j)).

**Pressure derivatives have faster decay.** Proposition `PressureDecayStatement`: This proposition requires that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Nonzero energy profiles remain nonzero.** Proposition `ProfileNonzeroStatement`: This proposition requires that a nonzero energy-space element with all Fourier moments has a physical profile that is nonzero at some point.

### Breakdown.FracCert.StFree

Defines the Fourier symbols and states the free fractional operator estimates, completeness and compactness requirements.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/StFree.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**The symbol of the negative second trace.** Definition `secondSymbol`: This defines the Fourier symbol of the negative second trace through complexification and the total conversion of that field to L².

**The Fourier symbol of a vector field.** Definition `fieldSymbol`: This defines a field's Fourier symbol through complexification and its total conversion to L².

**The radial Fourier frequency power.** Definition `freqPow`: This defines the radial frequency power (2π‖ξ‖)^s.

**The sum of squared Hessian entries.** Definition `fullSecondSq`: This defines the full Hessian square as the sum of ‖H(eᵢ,eⱼ)‖² over the nine pairs of coordinate vectors.

**second symbol carries derivative energy.** Proposition `SecondSymbolEnergyStatement`: This proposition requires that for a second-order field, the negative-second-trace Fourier symbol has integrable squared norm divided by (2π‖ξ‖)² equal to the gradient energy, while its unweighted squared norm gives both the full Hessian and trace energies.

**Weak powers multiply the second symbol.** Proposition `WeakPowerSymbolStatement`: This proposition requires that for 1<α<3/2, the Fourier symbol of the weak fractional power of a second-order field equals (2π‖ξ‖)^(2α−2) times its negative-second-trace symbol almost everywhere.

**Drift pairing equals gradient energy.** Proposition `DriftEnergyStatement`: This proposition requires that for 1<α<5/4 and an L² drift, its pairing with the negative second trace of a second-order field equals (1−3/(4α)) times the gradient energy.

**The weighted drift-power identity.** Proposition `DriftPowerStatement`: This proposition requires that for 1<α<5/4, the pairing of an L² drift with the weak fractional power equals (3/2−5/(4α)) times the integral of (2π‖ξ‖)^(2α−4) times the squared negative-second-trace symbol, and that integral is finite.

**Completeness of second-order fields.** Proposition `SecondOrderCompleteStatement`: This proposition requires that a Cauchy sequence of second-order fields for a measurable weight bounded above and bounded away from zero has a second-order limit with weighted derivative-energy convergence and strong L⁶ convergence.

**Second-order fields admit linearity.** Proposition `SecondOrderLinearStatement`: This proposition requires that linear combinations of second-order fields in the same symmetry class remain second-order fields with the corresponding combinations of their derivative fields.

**The homogeneous free state vanishes.** Proposition `FreeUniqueStatement`: This proposition requires that for 1<α<5/4, a second-order field with weak fractional power, L² drift and zero free residual has velocity, both derivative fields and fractional power all zero almost everywhere.

**The free operator satisfies L² bounds.** Proposition `FreeBoundsStatement`: This proposition requires that for 1<α<5/4, a free solution with L² forcing has separate power and drift norms bounded by the forcing norm, the stated trace-pairing energy identity and a uniform bound on the sum of square-root gradient and trace energies.

**The inverse-square Hardy bound holds.** Proposition `InverseSquareBoundStatement`: This proposition requires that a measurable L⁶ velocity with square-integrable weak gradient has integrable ‖v(y)‖²/‖y‖² and its integral is at most four times the gradient energy.

**Decaying profile products are compact.** Proposition `ProfileProductCompactStatement`: This proposition requires that a C¹ profile decaying like inverse radius with derivative decaying like inverse radius squared maps any uniformly energy-bounded sequence of second-order fields, through symmetric convection, to an L² sequence with a strongly convergent subsequence.

**The free fractional equation is solvable.** Proposition. For 1 < α < 5/4, every square-integrable solenoidal right side in the symmetry class has a second-order field in that class and a fractional power whose drift equation holds almost everywhere, with square-integrable drift. ([`FreeExistsStatement`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StFree.lean#L87))

### Breakdown.FracCert.StFreeNice

States solvability for nice Fourier forcing and density of nice fields inside each solenoidal symmetry class.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/StFreeNice.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Nice data give free solutions.** Proposition `FreeExistsNiceStatement`: This proposition requires that for 1<α<5/4, every nice solenoidal forcing in the prescribed symmetry class has a second-order free solution with weak fractional power and L² drift satisfying the free equation almost everywhere.

**Nice class fields are dense.** Proposition `NiceClassDenseStatement`: This proposition requires that every solenoidal L² field in the symmetry class can be approximated arbitrarily well in squared L² error by nice fields in that class.

### Breakdown.FracCert.StFreeNiceParts

Defines admissible free-profile Fourier symbols and the contracts connecting their equation, smoothness, energy and physical realization.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/StFreeNiceParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**The infinitesimal complex axial turn.** Definition `axialTurnC`: This defines the infinitesimal complex axial turn (z₁,z₂,z₃) ↦ (−z₂,z₁,0).

**An admissible fractional profile symbol.** Definition `IsProfileSymbol`: This predicate requires a profile symbol to be smooth off zero, zero outside a finite radius, bounded at derivative order j by C‖ξ‖^(2α−4−j), conjugation symmetric and perpendicular to the frequency.

**free profile operator in frequency space.** Definition `profileSymbolLhs`: This defines the frequency profile operator as (1−2/α)w−Dw(ξ)/(2α)+a(Dw(Jξ)−Jw)+(2π‖ξ‖)^(2α)w.

**A class-preserving free symbol exists.** Proposition `FreeSymbolExistsStatement`: This proposition requires that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

**Symbols realize second-order fields.** Proposition `ProfileSymbolRealizeStatement`: This proposition requires that for 1<α<5/4, an admissible profile symbol with the prescribed physical symmetry realizes a second-order field whose weak fractional power is obtained by multiplying its symbol by (2π‖ξ‖)^(2α).

**Symbols give the physical free equation.** Proposition `ProfileSymbolEquationStatement`: This proposition requires that for 1<α<5/4, an admissible profile symbol solving the free frequency equation for nice data realizes an L² drift and the physical free equation almost everywhere.

**Symbols give C² solenoidal fields.** Proposition `ProfileSymbolSmoothStatement`: This proposition requires that for 1<α<5/4, an admissible profile symbol realizes a C² vector field with vanishing classical divergence.

**Profile symbols realize L⁶ fields.** Proposition `ProfileSymbolSixStatement`: This proposition requires that for 1<α<5/4, the physical field realized by an admissible profile symbol belongs to L⁶.

**Symbols give finite derivative energy.** Proposition `ProfileSymbolEnergyStatement`: This proposition requires that for 1<α<5/4, the physical field realized by an admissible profile symbol has finite gradient energy and finite full Hessian energy.

**Weighted symbols realize weak powers.** Proposition `ProfileSymbolPowerStatement`: This proposition requires that for 1<α<5/4, multiplying an admissible profile symbol by (2π‖ξ‖)^(2α) realizes the weak fractional power of its physical field.

### Breakdown.FracCert.StGradientAdd

States closure of weak gradient fields under addition for use in the held equation.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/StGradientAdd.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak gradient fields admit sums.** Proposition `GradientAddStatement`: This proposition requires that the sum of two weak gradient fields is a weak gradient field.

### Breakdown.FracCert.StHeld

Defines the held linear and nonlinear states and the estimates that lead to parameter cancellation and a nonzero weak profile.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/StHeld.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.FracCertData`.

**The full bordered linear field.** Definition `fullField`: This defines the full bordered linear field as the sum of the certificate's local operator and its fractional splitting term.

**Second-order data with a weak power.** Structure `IsLinearState`: This proposition bundles second-order regularity of the correction, its weak fractional power and square integrability of its rotating drift.

**A pinned nonlinear held solution.** Structure `IsHeldSolution`: This proposition requires a linear correction state whose nonlinear residual equals a negative gradient almost everywhere and whose pin functionals all vanish.

**The corrected actuator multipliers.** Definition `heldMultiplier`: This defines the held multiplier vector by adding the correction κ to the approximate profile's multiplier vector.

**Source namespace:** `Breakdown.SteadyCert`.

**The certificate gives an a priori bound.** Proposition `AprioriBoundStatement`: This proposition requires that a valid fractional certificate bounds a linear correction state and its multipliers by the certificate function of its projected residual norm, gradient-insensitive row residuals and pin size.

**Interval bounds for active multipliers.** Proposition `ActiveEnclosureStatement`: This proposition requires that for a held solution within the certified radius at a test-box parameter, each active coordinate of the transformed corrected multiplier differs from its slope times the parameter by at most the absolute slope times that coordinate radius.

**Ellipsoid bounds for stiff multipliers.** Proposition `StiffEnclosureStatement`: This proposition requires that for a held solution within the certified radius at a test-box parameter, the sum of squared inactive transformed multiplier errors is at most the squared ellipsoid radius.

**test box lies inside the parameter box.** Proposition `TestBoxSubsetStatement`: This proposition requires that a valid fractional certificate places its test box inside its parameter box.

**The corrected held profile is nonzero.** Proposition `HeldNonzeroStatement`: This proposition requires that for a valid fractional certificate, a held correction within the certified radius cannot cancel the approximate profile almost everywhere.

**Cancelled held states give weak profiles.** Proposition `HeldWeakProfileStatement`: This proposition requires that for a valid fractional certificate, a held solution within the certified radius whose corrected multiplier is zero yields a nontrivial weak rotating fractional profile.

**Fractional certificate to weak profile.** Proposition. For 1 < α < 5/4, a fractional certificate gives a weak rotating profile. ([`CertificateWeakProfileStatement`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeld.lean#L98))

**Solve the fractional bordered equation.** Proposition. For 1 < α < 5/4, valid fractional certificate data, a parameter in the box, a square-integrable right side in the symmetry class and prescribed pin values, the bordered linear equation has a solution and multipliers whose full field equals the right side up to a gradient and whose pins take the prescribed values. ([`LinearSolveStatement`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeld.lean#L45))

### Breakdown.FracCert.StHeldParts

The held-solution construction is divided into gradient orthogonality, Helmholtz decomposition, closed linear-state limits and compactness requirements.

**Source namespace:** Breakdown.SteadyCert.

**Gradient orthogonality.** This proposition requires every square integrable gradient to have zero pairing with every square integrable solenoidal field. Source: Breakdown.SteadyCert.GradientOrthogonalStatement in Breakdown.FracCert.StHeldParts, line 13. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L13).

**The second trace stays solenoidal.** This proposition requires the negative second trace of a second order field to remain solenoidal and in the same regularity class. Source: Breakdown.SteadyCert.SecondTraceSolenoidalStatement in Breakdown.FracCert.StHeldParts, line 16. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L16).

**Split a field into two components.** This proposition requires a square integrable field to split almost everywhere into a solenoidal part and a gradient. Source: Breakdown.SteadyCert.SolenoidalSplitStatement in Breakdown.FracCert.StHeldParts, line 20. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L20).

**Bounds for the split quadratic form.** This proposition packages the lower bounds and second derivative estimate for the split form of a fractional certificate. Source: Breakdown.SteadyCert.SplitFormBoundsStatement in Breakdown.FracCert.StHeldParts, line 25. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L25).

**Limits of linear states.** This proposition requires Cauchy linear states and convergent forcing to have a limiting state with convergent velocity and pins. Source: Breakdown.SteadyCert.LinearStateClosedStatement in Breakdown.FracCert.StHeldParts, line 34. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L34).

**Limits of held solutions.** This proposition requires a bounded sequence of held solutions to admit a subsequence whose multipliers converge to those of a limiting held solution. Source: Breakdown.SteadyCert.HeldLimitStatement in Breakdown.FracCert.StHeldParts, line 53. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L53).

**Embed a weak gradient field.** This proposition requires a solenoidal L6 field with square integrable weak gradient to have a matching representative in the Fourier space. Source: Breakdown.SteadyCert.EmbedWeakStatement in Breakdown.FracCert.StHeldParts, line 65. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StHeldParts.lean#L65).

### Breakdown.FracCert.StKernel

Dyadic annular cutoffs organize the kernel decay, scaling and homogeneous-multiplier requirements used by the fractional regularity route.

**Source namespace:** Breakdown.FracCert.

**A dyadic partition on annuli.** The cutoff condition combines smoothness, values between zero and one, annular support and a dyadic partition of unity away from zero. Source: Breakdown.FracCert.IsRingCutoff in Breakdown.FracCert.StKernel, line 10. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L10).

**Existence of an annular cutoff.** This proposition asks for a smooth annular cutoff whose dyadic dilations sum to one away from zero. Source: Breakdown.FracCert.RingCutoffStatement in Breakdown.FracCert.StKernel, line 15. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L15).

**Sum the dyadic decay bounds.** This proposition bounds the dyadic sum by a constant times the negative power of the radius when the two exponents have the stated order. Source: Breakdown.FracCert.DyadicSumStatement in Breakdown.FracCert.StKernel, line 17. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L17).

**Decay from an annular symbol.** This proposition converts finitely many derivative bounds on an annular symbol into weighted derivative bounds on its inverse Fourier transform. Source: Breakdown.FracCert.PieceKernelStatement in Breakdown.FracCert.StKernel, line 22. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L22).

**Projected heat divergence symbol.** The symbol multiplies a coordinate derivative, the Leray projection matrix and the fractional heat factor. Source: Breakdown.FracCert.projDivSymbol in Breakdown.FracCert.StKernel, line 29. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L29).

**Projected heat divergence kernel.** The kernel is the inverse Fourier transform of the projected fractional heat divergence symbol. Source: Breakdown.FracCert.projDivKernel in Breakdown.FracCert.StKernel, line 34. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L34).

**Decay of the fractional heat kernel.** This proposition bounds every kernel derivative by the corresponding negative power of the heat length plus the spatial radius. Source: Breakdown.FracCert.KernelDecayStatement in Breakdown.FracCert.StKernel, line 37. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L37).

**Scaling of the fractional kernel.** This proposition combines kernel dilation, real values, integrability and the stated L1 and L3/2 scaling identities. Source: Breakdown.FracCert.KernelScalingStatement in Breakdown.FracCert.StKernel, line 44. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L44).

**A homogeneous smooth symbol.** A homogeneous symbol is smooth away from zero and scales by its specified degree under positive dilations. Source: Breakdown.FracCert.IsHomogeneousSymbol in Breakdown.FracCert.StKernel, line 55. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L55).

**Weighted bounds for all derivatives.** Weighted smoothness requires smoothness and a spatially weighted bound for every derivative order. Source: Breakdown.FracCert.IsWeightedSmooth in Breakdown.FracCert.StKernel, line 59. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L59).

**A distributional Fourier transform.** The transform relation equates pairings against Schwartz functions and requires local integrability of the frequency function. Source: Breakdown.FracCert.IsTransformOf in Breakdown.FracCert.StKernel, line 62. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L62).

**All integrable frequency moments.** The moment condition requires measurability and integrability of every polynomially weighted symbol norm. Source: Breakdown.FracCert.HasMomentsInL1 in Breakdown.FracCert.StKernel, line 66. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L66).

**Convolve a kernel and a field.** The convolution integrates the kernel against the translated field. Source: Breakdown.FracCert.kernelConv in Breakdown.FracCert.StKernel, line 69. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L69).

**One dyadic convolution kernel.** The dyadic kernel rescales the inverse transform of an annular homogeneous symbol by its dimension and degree. Source: Breakdown.FracCert.dyadicKernel in Breakdown.FracCert.StKernel, line 71. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L71).

**Recover the multiplier dyadically.** This proposition expresses every derivative of the multiplier output as the sum of the dyadic convolution derivatives. Source: Breakdown.FracCert.DyadicSplitStatement in Breakdown.FracCert.StKernel, line 75. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L75).

**Bounds for one dyadic piece.** This proposition separates the low and high scaled radius regimes to bound each differentiated dyadic convolution. Source: Breakdown.FracCert.DyadicPieceBoundStatement in Breakdown.FracCert.StKernel, line 85. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L85).

**Decay gained from homogeneity.** This proposition transfers weighted smoothness through a homogeneous Fourier multiplier, increasing the decay order by the symbol degree. Source: Breakdown.FracCert.HomogeneousMultiplierStatement in Breakdown.FracCert.StKernel, line 94. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StKernel.lean#L94).

### Breakdown.FracCert.StMildProfile

The weak rotating fractional profile is connected to mild evolution through heat duality, bilinear test pairings, similarity composition and moment requirements.

**Source namespace:** Breakdown.FracCert.

**Fractional heat on physical tests.** The physical heat field takes the real inverse Fourier transform after multiplication by the fractional heat factor. Source: Breakdown.FracCert.heatField in Breakdown.FracCert.StMildProfile, line 13. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L13).

**Heat preserves the test class.** This proposition requires fractional heat to preserve nice test fields and to move across the velocity pairing. Source: Breakdown.FracCert.NiceHeatStatement in Breakdown.FracCert.StMildProfile, line 17. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L17).

**Nice tests detect zero.** This proposition says that a Fourier state is zero if its velocity pairs to zero with every nice field. Source: Breakdown.FracCert.NiceAnnihilatorStatement in Breakdown.FracCert.StMildProfile, line 22. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L22).

**The fractional bilinear pairing.** This proposition identifies the fractional bilinear velocity pairing with the negative trilinear pairing against the heated test field. Source: Breakdown.FracCert.BilinPairingStatement in Breakdown.FracCert.StMildProfile, line 25. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L25).

**Fractional power under similarity.** This proposition requires the fractional power to commute with the adjoint similarity action with the specified factor of the scale. Source: Breakdown.FracCert.PowerSimAdjStatement in Breakdown.FracCert.StMildProfile, line 30. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L30).

**A weak profile yields mild flow.** This proposition requires a weak rotating profile to give a mild trajectory on each closed time interval before time one. Source: Breakdown.FracCert.MildOfWeakProfileStatement in Breakdown.FracCert.StMildProfile, line 34. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L34).

**Compose the similarity actions.** This proposition requires the similarity action at one to be the identity and positive scales to compose multiplicatively. Source: Breakdown.FracCert.SimOpComposeStatement in Breakdown.FracCert.StMildProfile, line 39. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L39).

**Similarity preserves all moments.** This proposition requires the similarity action at a positive scale to preserve every homogeneous frequency moment. Source: Breakdown.FracCert.SimOpMomentsStatement in Breakdown.FracCert.StMildProfile, line 43. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L43).

**All moments of a weak profile.** This proposition requires a weak rotating fractional profile to have all homogeneous frequency moments. Source: Breakdown.FracCert.ProfileMomentsStatement in Breakdown.FracCert.StMildProfile, line 46. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StMildProfile.lean#L46).

### Breakdown.FracCert.StQuadratic

The quadratic forcing obligation asks for square integrability of the gradient applied to the velocity under the second-order field assumptions.

**Source namespace:** Breakdown.SteadyCert.

**Square integrable quadratic term.** This proposition requires the gradient applied to the velocity of a second order field to be square integrable. Source: Breakdown.SteadyCert.QuadraticSquareIntegrableStatement in Breakdown.FracCert.StQuadratic, line 7. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StQuadratic.lean#L7).

### Breakdown.FracCert.StWeak

The weak rotating profile equation is expressed using the adjoint drift and similarity actions on nice test fields.

**Source namespace:** Breakdown.FracCert.

**The adjoint similarity drift.** The adjoint drift combines the test field, its radial derivative and its infinitesimal rotational derivative with the fractional scaling coefficients. Source: Breakdown.FracCert.driftAdjoint in Breakdown.FracCert.StWeak, line 12. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L12).

**A weak rotating fractional profile.** A weak rotating profile is a nonzero Fourier state satisfying the drift, fractional power and nonlinear pairing identity for every nice test field. Source: Breakdown.FracCert.IsWeakRotatingProfile in Breakdown.FracCert.StWeak, line 16. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L16).

**The fractional similarity action.** The similarity operator composes a logarithmic axial rotation with the fractional dilation at the inverse scale. Source: Breakdown.FracCert.simOp in Breakdown.FracCert.StWeak, line 27. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L27).

**The adjoint similarity action.** The adjoint action rescales a physical test field and applies the opposite logarithmic axial rotation. Source: Breakdown.FracCert.simAdj in Breakdown.FracCert.StWeak, line 30. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L30).

**Drift preserves nice fields.** This proposition requires the adjoint drift to preserve the nice test field class for a positive fractional exponent. Source: Breakdown.FracCert.NiceDriftClosedStatement in Breakdown.FracCert.StWeak, line 33. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L33).

**Similarity preserves nice fields.** This proposition requires the adjoint similarity action to preserve nice fields at positive exponent and scale. Source: Breakdown.FracCert.NiceSimAdjClosedStatement in Breakdown.FracCert.StWeak, line 36. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L36).

**Move similarity across a pairing.** This proposition identifies the velocity pairing after similarity with the original velocity paired against the adjoint action. Source: Breakdown.FracCert.SimAdjPairingStatement in Breakdown.FracCert.StWeak, line 39. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L39).

**Differentiate the adjoint pairing.** This proposition differentiates the moving test pairing before time one, with the reciprocal remaining time multiplying the adjoint drift. Source: Breakdown.FracCert.SimAdjDerivStatement in Breakdown.FracCert.StWeak, line 44. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L44).

**A weak rotating profile exists.** Proposition. For an exponent α, some rotation rate and field form a weak rotating profile. ([`WeakRotatingProfileExists`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L22))

**Regularise a weak fractional profile.** Proposition. For 1 < α < 5/4, a weak rotating profile can be upgraded to a rotating fractional profile. ([`WeakToProfileStatement`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeak.lean#L24))

### Breakdown.FracCert.StWeakRegular

Weighted L1 frequency moments provide the interfaces for reconstructing a smooth profile and removing the frequency-zero gap in weak tests.

**Source namespace:** Breakdown.FracCert.

**All weighted L1 symbol moments.** The condition requires integrability of the symbol norm against every nonnegative integer power of one plus frequency radius. Source: Breakdown.FracCert.HasAllSymbolL1Moments in Breakdown.FracCert.StWeakRegular, line 13. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeakRegular.lean#L13).

**Recover an integrable velocity symbol.** This proposition derives all weighted L1 moments and the physical velocity representative from all homogeneous moments. Source: Breakdown.FracCert.SymbolL1OfMomentsStatement in Breakdown.FracCert.StWeakRegular, line 16. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeakRegular.lean#L16).

**Smoothness from L1 moments.** This proposition turns conjugate symmetry and all weighted L1 moments into a smooth physical field with bounded derivatives of every order. Source: Breakdown.FracCert.FieldSmoothOfMomentsStatement in Breakdown.FracCert.StWeakRegular, line 20. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeakRegular.lean#L20).

**Regularise the weak profile equation.** This proposition turns a weak rotating profile with all moments into a smooth divergence free field with a smooth pressure satisfying the profile equation. Source: Breakdown.FracCert.WeakProfileRegularStatement in Breakdown.FracCert.StWeakRegular, line 24. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeakRegular.lean#L24).

**Remove the missing zero frequency.** This proposition forces a continuous weighted L2 field to vanish when it annihilates every smooth, compactly supported, conjugate symmetric frequency test that vanishes near zero. Source: Breakdown.FracCert.LowFrequencyRemovalStatement in Breakdown.FracCert.StWeakRegular, line 29. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StWeakRegular.lean#L29).

### Breakdown.FracCert.StatementsSmooth

Homogeneous frequency moments and smoothing gains specify the bootstrap from a fractional mild trajectory to smooth positive-time slices.

**Source namespace:** Breakdown.FracCert.

**The velocity frequency symbol.** The velocity symbol divides the Fourier state by two pi times the frequency radius, using Lean's total inverse at zero. Source: Breakdown.FracCert.symbolX in Breakdown.FracCert.StatementsSmooth, line 13. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L13).

**All homogeneous frequency moments.** The condition requires finite squared homogeneous norms at every integer order at least one. Source: Breakdown.FracCert.HasAllMoments in Breakdown.FracCert.StatementsSmooth, line 15. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L15).

**A fractional homogeneous norm.** The squared fractional norm integrates the squared velocity symbol against the frequency radius to twice the chosen exponent. Source: Breakdown.FracCert.fracHomSq in Breakdown.FracCert.StatementsSmooth, line 17. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L17).

**The concrete fractional framework.** A concrete framework uses exactly the fractional heat operator and fractional bilinear operator as its two evolution maps. Source: Breakdown.FracCert.IsConcreteFrame in Breakdown.FracCert.StatementsSmooth, line 20. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L20).

**The first smoothing gain.** This proposition gives a uniform fractional derivative gain on each positive time interval bounded away from the initial time. Source: Breakdown.FracCert.MildFirstGainStatement in Breakdown.FracCert.StatementsSmooth, line 23. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L23).

**An L1 bound from derivative gain.** This proposition bounds the L1 frequency norm by the first homogeneous norm and a fractional norm above order three halves. Source: Breakdown.FracCert.SupFromGainStatement in Breakdown.FracCert.StatementsSmooth, line 28. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L28).

**Gain the next frequency moment.** This proposition upgrades a uniform L1 and order k bound along a mild trajectory to an order k plus one bound away from the initial time. Source: Breakdown.FracCert.MildMomentStepStatement in Breakdown.FracCert.StatementsSmooth, line 32. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L32).

**All moments after positive time.** This proposition requires every positive time slice of a concrete fractional mild trajectory to have all homogeneous moments. Source: Breakdown.FracCert.MildSmoothingStatement in Breakdown.FracCert.StatementsSmooth, line 39. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StatementsSmooth.lean#L39).

### Breakdown.FracCert.StiffEnclosure

Finite-dimensional square-norm estimates control the inactive held multiplier coordinates inside the certificate ellipsoid.

**Source namespace:** Breakdown.SteadyCert.StiffEnclosureInternal.

**The triangle bound for squares.** The squared Euclidean norm of the sum of two finite vectors is at most the square of the sum of their Euclidean norms. Source: Breakdown.SteadyCert.StiffEnclosureInternal.sum_sq_add_le in Breakdown.FracCert.StiffEnclosure, line 15. [Proved lemma](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StiffEnclosure.lean#L15).

**Transfer the bound to the transpose.** A bound on the norm distortion of a matrix gives the corresponding upper square norm bound for its transpose. Source: Breakdown.SteadyCert.StiffEnclosureInternal.transpose_sq_le in Breakdown.FracCert.StiffEnclosure, line 34. [Proved lemma](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StiffEnclosure.lean#L34).

**Source namespace:** Breakdown.SteadyCert.

**Prove the stiff enclosure.** For a valid fractional certificate and a held solution within its radius, the inactive multiplier coordinates satisfy the prescribed ellipsoid bound. Source: Breakdown.SteadyCert.stiffEnclosure in Breakdown.FracCert.StiffEnclosure, line 68. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/StiffEnclosure.lean#L68).

### Breakdown.FracCert.WeakFieldSmooth

Differentiation of the inverse Fourier integral turns all weighted L1 moments into smooth physical fields with bounded derivatives.

**Source namespace:** Breakdown.FracCert.

**Integrability of a radial moment.** Every radial power times the symbol norm is integrable when all weighted L1 moments are available. Source: Breakdown.FracCert.moment_integrable in Breakdown.FracCert.WeakFieldSmooth, line 13. [Private proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakFieldSmooth.lean#L13).

**Write the inverse transform integral.** The inverse Fourier transform agrees with the vector Fourier integral using the negative inner product. Source: Breakdown.FracCert.inverse_transform_eq_integral in Breakdown.FracCert.WeakFieldSmooth, line 23. [Private proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakFieldSmooth.lean#L23).

**Prove smoothness from moments.** The theorem discharges the interface deriving physical smoothness and bounded derivatives from all weighted L1 moments. Source: Breakdown.FracCert.fieldSmoothOfMoments in Breakdown.FracCert.WeakFieldSmooth, line 28. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakFieldSmooth.lean#L28).

### Breakdown.FracCert.WeakLowFrequency

Compact frequency tests supported away from zero are enlarged through weighted estimates until they force a continuous residual to vanish everywhere.

**Source namespace:** Breakdown.FracCert.WeakLowFrequency.Internal.

**A unit ball cutoff.** The construction chooses a smooth bump centered at the spatial origin. Source: Breakdown.FracCert.WeakLowFrequency.Internal.bump in Breakdown.FracCert.WeakLowFrequency, line 22. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L22).

**The complex valued cutoff.** The cutoff is the complex valued version of the real bump. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump in Breakdown.FracCert.WeakLowFrequency, line 24. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L24).

**Smoothness of the complex cutoff.** The complex cutoff is smooth. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_contDiff in Breakdown.FracCert.WeakLowFrequency, line 26. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L26).

**Compact support of the cutoff.** The complex cutoff has compact support. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_hasCompactSupport in Breakdown.FracCert.WeakLowFrequency, line 29. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L29).

**Continuity of the complex cutoff.** The complex cutoff is continuous. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_continuous in Breakdown.FracCert.WeakLowFrequency, line 32. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L32).

**Integrability of the cutoff.** The complex cutoff is integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_integrable in Breakdown.FracCert.WeakLowFrequency, line 34. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L34).

**The cutoff is even.** Negating the frequency leaves the complex cutoff unchanged. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_neg in Breakdown.FracCert.WeakLowFrequency, line 37. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L37).

**The cutoff equals one at zero.** The complex cutoff takes the value one at zero. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_zero in Breakdown.FracCert.WeakLowFrequency, line 40. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L40).

**The cutoff equals one on the ball.** The complex cutoff is one when the frequency norm is at most one. Source: Breakdown.FracCert.WeakLowFrequency.Internal.cbump_eq_one in Breakdown.FracCert.WeakLowFrequency, line 43. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L43).

**The cutoff as a Schwartz function.** The cutoff is packaged as a Schwartz function. Source: Breakdown.FracCert.WeakLowFrequency.Internal.bumpTest in Breakdown.FracCert.WeakLowFrequency, line 47. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L47).

**The inverse transformed cutoff.** The inverse transformed cutoff is packaged as a Schwartz function. Source: Breakdown.FracCert.WeakLowFrequency.Internal.bumpTestInv in Breakdown.FracCert.WeakLowFrequency, line 49. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L49).

**The transformed cutoff.** The forward transformed cutoff is packaged as a Schwartz function. Source: Breakdown.FracCert.WeakLowFrequency.Internal.bumpTestFwd in Breakdown.FracCert.WeakLowFrequency, line 51. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L51).

**The cutoff kernel.** The kernel is the inverse Fourier transform of the complex cutoff. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern in Breakdown.FracCert.WeakLowFrequency, line 53. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L53).

**Identify the Schwartz kernel.** The kernel agrees with the inverse transformed Schwartz cutoff. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_eq_bumpTest in Breakdown.FracCert.WeakLowFrequency, line 55. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L55).

**Integrability of the cutoff kernel.** The cutoff kernel is integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_integrable in Breakdown.FracCert.WeakLowFrequency, line 59. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L59).

**Continuity of the cutoff kernel.** The cutoff kernel is continuous. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_continuous in Breakdown.FracCert.WeakLowFrequency, line 62. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L62).

**Expand the kernel integral.** The kernel is the integral of the Fourier character multiplied by the cutoff. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_apply in Breakdown.FracCert.WeakLowFrequency, line 65. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L65).

**Fourth order kernel decay.** The kernel norm is bounded by a nonnegative constant times the inverse fourth power of one plus radius. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_decay in Breakdown.FracCert.WeakLowFrequency, line 68. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L68).

**The kernel has total mass one.** The integral of the cutoff kernel is one. Source: Breakdown.FracCert.WeakLowFrequency.Internal.integral_kern in Breakdown.FracCert.WeakLowFrequency, line 78. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L78).

**The real cutoff kernel.** The real kernel takes the real part of the complex cutoff kernel. Source: Breakdown.FracCert.WeakLowFrequency.Internal.rk in Breakdown.FracCert.WeakLowFrequency, line 86. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L86).

**Continuity of the real kernel.** The real cutoff kernel is continuous. Source: Breakdown.FracCert.WeakLowFrequency.Internal.rk_continuous in Breakdown.FracCert.WeakLowFrequency, line 88. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L88).

**Integrability of the real kernel.** The real cutoff kernel is integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.rk_integrable in Breakdown.FracCert.WeakLowFrequency, line 90. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L90).

**The real kernel has mass one.** The integral of the real cutoff kernel is one. Source: Breakdown.FracCert.WeakLowFrequency.Internal.integral_rk in Breakdown.FracCert.WeakLowFrequency, line 92. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L92).

**Decay of the real kernel.** The real kernel is bounded by a constant times the inverse fourth power of one plus radius. Source: Breakdown.FracCert.WeakLowFrequency.Internal.rk_decay in Breakdown.FracCert.WeakLowFrequency, line 98. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L98).

**The cutoff Fourier integrand.** The wave factor combines the Fourier character with the frequency cutoff. Source: Breakdown.FracCert.WeakLowFrequency.Internal.wave in Breakdown.FracCert.WeakLowFrequency, line 102. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L102).

**Recover the kernel from the wave.** Integrating the wave factor recovers the cutoff kernel. Source: Breakdown.FracCert.WeakLowFrequency.Internal.kern_eq_wave in Breakdown.FracCert.WeakLowFrequency, line 104. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L104).

**A translated frequency test.** The symbol combines a scaled cutoff, the translation character and one coordinate basis vector. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym in Breakdown.FracCert.WeakLowFrequency, line 106. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L106).

**A translated physical kernel.** The physical profile is the scaled and translated real cutoff kernel. Source: Breakdown.FracCert.WeakLowFrequency.Internal.prof in Breakdown.FracCert.WeakLowFrequency, line 109. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L109).

**Multiply Fourier characters.** Multiplication of two Fourier characters adds their phases. Source: Breakdown.FracCert.WeakLowFrequency.Internal.char_mul in Breakdown.FracCert.WeakLowFrequency, line 111. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L111).

**Scale the kernel integral.** For positive scale, the translated cutoff integral has the inverse cubic Jacobian and the rescaled kernel argument. Source: Breakdown.FracCert.WeakLowFrequency.Internal.scaling in Breakdown.FracCert.WeakLowFrequency, line 114. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L114).

**Real parts of a basis vector.** Taking the real part of a complex multiple of one basis vector gives the corresponding real multiple. Source: Breakdown.FracCert.WeakLowFrequency.Internal.realVec_smul_single in Breakdown.FracCert.WeakLowFrequency, line 125. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L125).

**Identify the physical test field.** The physical field of the translated symbol is the scalar kernel profile times its coordinate basis vector. Source: Breakdown.FracCert.WeakLowFrequency.Internal.physField_sym in Breakdown.FracCert.WeakLowFrequency, line 133. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L133).

**Conjugate a Fourier character.** Conjugation negates the phase of the Fourier character. Source: Breakdown.FracCert.WeakLowFrequency.Internal.star_char in Breakdown.FracCert.WeakLowFrequency, line 139. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L139).

**Symmetry of the translated test.** The translated frequency test satisfies conjugate symmetry. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym_conjSym in Breakdown.FracCert.WeakLowFrequency, line 143. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L143).

**Smoothness of the translation phase.** The Fourier character encoding a fixed translation is smooth. Source: Breakdown.FracCert.WeakLowFrequency.Internal.char_contDiff in Breakdown.FracCert.WeakLowFrequency, line 151. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L151).

**Smoothness of the translated test.** The translated frequency symbol is smooth. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym_contDiff in Breakdown.FracCert.WeakLowFrequency, line 160. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L160).

**Compact support of translated tests.** At positive scale the translated frequency test has compact support. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym_hasCompactSupport in Breakdown.FracCert.WeakLowFrequency, line 164. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L164).

**Integrability of translated tests.** At positive scale the translated frequency test is integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym_integrable in Breakdown.FracCert.WeakLowFrequency, line 171. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L171).

**The test inside its cutoff radius.** Inside the scaled unit ball, the test symbol reduces to its translation phase times the basis vector. Source: Breakdown.FracCert.WeakLowFrequency.Internal.sym_eq in Breakdown.FracCert.WeakLowFrequency, line 174. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L174).

**Continuity of the physical profile.** The translated real kernel profile is continuous. Source: Breakdown.FracCert.WeakLowFrequency.Internal.prof_continuous in Breakdown.FracCert.WeakLowFrequency, line 179. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L179).

**Integrability of sixth order decay.** The inverse sixth power of one plus radius is integrable in three dimensions. Source: Breakdown.FracCert.WeakLowFrequency.Internal.inv6_integrable in Breakdown.FracCert.WeakLowFrequency, line 182. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L182).

**The dilation Jacobian.** A positive dilation and translation change the spatial integral by the cube of the scale. Source: Breakdown.FracCert.WeakLowFrequency.Internal.change_var in Breakdown.FracCert.WeakLowFrequency, line 189. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L189).

**A translated radial weight bound.** One plus the original radius is bounded by the product of one plus the translation radius and one plus the translated radius. Source: Breakdown.FracCert.WeakLowFrequency.Internal.weight_le in Breakdown.FracCert.WeakLowFrequency, line 194. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L194).

**A weighted kernel square bound.** The weighted squared kernel profile has the stated sixth order integrable majorant after rescaling. Source: Breakdown.FracCert.WeakLowFrequency.Internal.prof_sq_le in Breakdown.FracCert.WeakLowFrequency, line 200. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L200).

**Integrability after translation.** The translated and positively rescaled inverse sixth power remains integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.inv6_comp_integrable in Breakdown.FracCert.WeakLowFrequency, line 231. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L231).

**Integrability of the profile square.** The radial kernel decay bound makes the weighted profile square integrable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.prof_sq_integrable in Breakdown.FracCert.WeakLowFrequency, line 235. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L235).

**Bound the profile square integral.** The weighted profile square integral is bounded by the explicitly rescaled sixth order majorant integral. Source: Breakdown.FracCert.WeakLowFrequency.Internal.integral_prof_sq_le in Breakdown.FracCert.WeakLowFrequency, line 244. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L244).

**A weighted pairing estimate.** The weighted Cauchy Schwarz estimate makes the scalar field pairing integrable and bounds its absolute integral. Source: Breakdown.FracCert.WeakLowFrequency.Internal.weighted_pairing_bound in Breakdown.FracCert.WeakLowFrequency, line 252. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L252).

**The low frequency limit.** The broad kernel pairing tends to zero for a continuous field with the stated weighted L2 bound. Source: Breakdown.FracCert.WeakLowFrequency.Internal.low_limit in Breakdown.FracCert.WeakLowFrequency, line 292. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L292).

**The kernel tail outside the core.** The tail keeps the rescaled kernel outside the local region used in the approximate identity argument. Source: Breakdown.FracCert.WeakLowFrequency.Internal.tail in Breakdown.FracCert.WeakLowFrequency, line 323. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L323).

**The local kernel core.** The core keeps the rescaled kernel in the local region used to recover the field value. Source: Breakdown.FracCert.WeakLowFrequency.Internal.hbase in Breakdown.FracCert.WeakLowFrequency, line 325. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L325).

**Measurability of the tail.** The kernel tail is almost everywhere strongly measurable. Source: Breakdown.FracCert.WeakLowFrequency.Internal.tail_measurable in Breakdown.FracCert.WeakLowFrequency, line 327. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L327).

**Compare the tail square to the kernel.** The weighted tail square is bounded by the corresponding full profile square. Source: Breakdown.FracCert.WeakLowFrequency.Internal.tail_sq_le_prof in Breakdown.FracCert.WeakLowFrequency, line 330. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L330).

**A decaying tail square bound.** The weighted tail square has the scale dependent upper bound used for its vanishing limit. Source: Breakdown.FracCert.WeakLowFrequency.Internal.tail_sq_le in Breakdown.FracCert.WeakLowFrequency, line 338. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L338).

**The tail pairing vanishes.** The pairing with the kernel tail tends to zero as the scale tends to zero from above. Source: Breakdown.FracCert.WeakLowFrequency.Internal.tail_limit in Breakdown.FracCert.WeakLowFrequency, line 378. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L378).

**The core recovers a field value.** The core kernel pairing tends to the selected coordinate of the continuous field. Source: Breakdown.FracCert.WeakLowFrequency.Internal.core_limit in Breakdown.FracCert.WeakLowFrequency, line 415. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L415).

**Each residual coordinate is zero.** Annihilation of the annular frequency tests and the weighted L2 condition force each coordinate of the continuous residual to vanish. Source: Breakdown.FracCert.WeakLowFrequency.Internal.component_zero in Breakdown.FracCert.WeakLowFrequency, line 474. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L474).

**Source namespace:** Breakdown.FracCert.

**Prove low frequency removal.** A continuous weighted L2 field vanishes everywhere if it annihilates every smooth, compactly supported, conjugate symmetric frequency test that vanishes near zero. Source: Breakdown.FracCert.lowFrequencyRemoval in Breakdown.FracCert.WeakLowFrequency, line 553. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakLowFrequency.lean#L553).

### Breakdown.FracCert.WeakNiceDrift

Schwartz decay, conjugate symmetry and transversality show that the adjoint profile drift preserves nice test fields.

**Source namespace:** Breakdown.FracInternal.NiceDrift.

**Complex infinitesimal rotation.** The complex linear turn map rotates the first two coordinates and vanishes in the axial coordinate. Source: Breakdown.FracInternal.NiceDrift.turnC in Breakdown.FracCert.WeakNiceDrift, line 14. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L14).

**First coordinate of the turn.** The first coordinate of the complex turn is the negative second coordinate. Source: Breakdown.FracInternal.NiceDrift.turnC_0 in Breakdown.FracCert.WeakNiceDrift, line 18. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L18).

**Second coordinate of the turn.** The second coordinate of the complex turn is the first coordinate. Source: Breakdown.FracInternal.NiceDrift.turnC_1 in Breakdown.FracCert.WeakNiceDrift, line 19. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L19).

**Axial coordinate of the turn.** The axial coordinate of the complex turn is zero. Source: Breakdown.FracInternal.NiceDrift.turnC_2 in Breakdown.FracCert.WeakNiceDrift, line 20. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L20).

**Real parts commute with the turn.** Taking real parts of the complex turn gives the physical axial turn. Source: Breakdown.FracInternal.NiceDrift.realVec_turnC in Breakdown.FracCert.WeakNiceDrift, line 22. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L22).

**Conjugation commutes with the turn.** Vector conjugation commutes with the complex turn map. Source: Breakdown.FracInternal.NiceDrift.conjVec_turnC in Breakdown.FracCert.WeakNiceDrift, line 26. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L26).

**Move a linear map through inversion.** A complex continuous linear map commutes with inverse Fourier transformation of a Schwartz function. Source: Breakdown.FracInternal.NiceDrift.invTransform_postcomp in Breakdown.FracCert.WeakNiceDrift, line 30. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L30).

**Coordinates have temperate growth.** Each coordinate function has temperate growth. Source: Breakdown.FracInternal.NiceDrift.temperate in Breakdown.FracCert.WeakNiceDrift, line 40. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L40).

**Multiply a Schwartz map by a coordinate.** The coordinate multiplier sends a Schwartz function to its coordinate weighted version. Source: Breakdown.FracInternal.NiceDrift.coordMul in Breakdown.FracCert.WeakNiceDrift, line 43. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L43).

**Evaluate the coordinate multiplier.** The coordinate multiplier acts by the inner product with the corresponding unit vector. Source: Breakdown.FracInternal.NiceDrift.coordMul_apply in Breakdown.FracCert.WeakNiceDrift, line 46. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L46).

**Read a coordinate as an inner product.** Pairing a vector with a unit vector extracts its corresponding coordinate. Source: Breakdown.FracInternal.NiceDrift.inner_unit in Breakdown.FracCert.WeakNiceDrift, line 50. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L50).

**Transform a coordinate derivative.** Inverse transformation exchanges the differentiated coordinate multiplier with the corresponding signed physical coordinate derivative. Source: Breakdown.FracInternal.NiceDrift.mul_lineDeriv in Breakdown.FracCert.WeakNiceDrift, line 53. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L53).

**Differentiate the real part.** The derivative of the real part of a Schwartz vector field is the real part of its directional derivative. Source: Breakdown.FracInternal.NiceDrift.fderiv_realVec in Breakdown.FracCert.WeakNiceDrift, line 67. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L67).

**Expand a vector in coordinates.** A three dimensional vector is the sum of its coordinate multiples of the unit vectors. Source: Breakdown.FracInternal.NiceDrift.vec_expand in Breakdown.FracCert.WeakNiceDrift, line 74. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L74).

**Expand the axial turn.** The axial turn is the sum of the negative second coordinate in the first direction and the first coordinate in the second direction. Source: Breakdown.FracInternal.NiceDrift.turn_expand in Breakdown.FracCert.WeakNiceDrift, line 78. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L78).

**Expand the radial derivative.** The derivative in the position direction is the sum of coordinate weighted partial derivatives. Source: Breakdown.FracInternal.NiceDrift.lineDeriv_self in Breakdown.FracCert.WeakNiceDrift, line 83. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L83).

**Expand the rotational derivative.** The derivative in the axial turn direction uses only the first two coordinate derivatives with their rotation signs. Source: Breakdown.FracInternal.NiceDrift.lineDeriv_turn in Breakdown.FracCert.WeakNiceDrift, line 89. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L89).

**Inverse transform as a linear map.** The inverse Fourier transform is packaged as a continuous complex linear map on Schwartz functions. Source: Breakdown.FracInternal.NiceDrift.invTransformCLM in Breakdown.FracCert.WeakNiceDrift, line 96. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L96).

**Identify the inverse transform map.** The inverse Fourier transform agrees with its continuous linear map representation. Source: Breakdown.FracInternal.NiceDrift.invTransform_eq in Breakdown.FracCert.WeakNiceDrift, line 100. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L100).

**The drift on Schwartz symbols.** The symbol drift combines scaling derivatives and infinitesimal rotation on Schwartz functions. Source: Breakdown.FracInternal.NiceDrift.driftS in Breakdown.FracCert.WeakNiceDrift, line 102. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L102).

**Invert the symbol drift.** The inverse transformed symbol drift has the stated physical scaling and rotation formula. Source: Breakdown.FracInternal.NiceDrift.invTransform_driftS in Breakdown.FracCert.WeakNiceDrift, line 108. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L108).

**Identify the physical adjoint drift.** The adjoint drift of a nice field is the nice field associated with its Schwartz symbol drift. Source: Breakdown.FracInternal.NiceDrift.drift_eq in Breakdown.FracCert.WeakNiceDrift, line 119. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L119).

**Differentiate a coordinate product.** Differentiating the coordinate multiplier gives its product rule, including the basis inner product term. Source: Breakdown.FracInternal.NiceDrift.lineDeriv_coordMul in Breakdown.FracCert.WeakNiceDrift, line 139. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L139).

**The pointwise drift symbol.** The pointwise symbol expresses the scaling and rotation drift using frequency derivatives. Source: Breakdown.FracInternal.NiceDrift.driftSym in Breakdown.FracCert.WeakNiceDrift, line 152. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L152).

**Evaluate the Schwartz drift.** The Schwartz drift applied to a nice symbol agrees pointwise with the explicit drift symbol. Source: Breakdown.FracInternal.NiceDrift.driftS_apply in Breakdown.FracCert.WeakNiceDrift, line 157. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L157).

**Drift vanishes near a zero symbol.** If the symbol vanishes in a neighborhood, its pointwise drift vanishes there as well. Source: Breakdown.FracInternal.NiceDrift.driftSym_zero in Breakdown.FracCert.WeakNiceDrift, line 164. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L164).

**Differentiate conjugate symmetry.** The derivative at the opposite frequency is the negative conjugate of the derivative at the original frequency. Source: Breakdown.FracInternal.NiceDrift.fderiv_neg_conj in Breakdown.FracCert.WeakNiceDrift, line 172. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L172).

**The drift keeps conjugate symmetry.** The drift symbol of a nice symbol remains conjugate symmetric. Source: Breakdown.FracInternal.NiceDrift.driftSym_conj in Breakdown.FracCert.WeakNiceDrift, line 184. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L184).

**Differentiate the divergence identity.** Differentiating the zero frequency divergence identity produces the stated coordinate sum identity. Source: Breakdown.FracInternal.NiceDrift.div_deriv in Breakdown.FracCert.WeakNiceDrift, line 190. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L190).

**The drift keeps zero divergence.** The drift symbol of a nice symbol is orthogonal to its frequency vector. Source: Breakdown.FracInternal.NiceDrift.driftSym_div in Breakdown.FracCert.WeakNiceDrift, line 214. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L214).

**Source namespace:** Breakdown.FracCert.

**Prove closure under drift.** The theorem discharges preservation of the nice field class under adjoint drift. Source: Breakdown.FracCert.niceDriftClosed in Breakdown.FracCert.WeakNiceDrift, line 233. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceDrift.lean#L233).

### Breakdown.FracCert.WeakNiceSim

Scalar multiplication, dilation and rotation preserve the nice test class needed for the adjoint similarity action.

**Source namespace:** Breakdown.FracCert.Internal.WeakNiceSim.

**Scale a nice symbol.** Real scalar multiplication preserves the nice symbol conditions. Source: Breakdown.FracCert.Internal.WeakNiceSim.nice_const in Breakdown.FracCert.WeakNiceSim, line 18. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L18).

**Dilate a nice symbol.** A positive dilation preserves the nice symbol conditions. Source: Breakdown.FracCert.Internal.WeakNiceSim.nice_dilate in Breakdown.FracCert.WeakNiceSim, line 23. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L23).

**Rotate a nice symbol.** Orthogonal rotation of both frequency and vector components preserves the nice symbol conditions. Source: Breakdown.FracCert.Internal.WeakNiceSim.nice_rot in Breakdown.FracCert.WeakNiceSim, line 44. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L44).

**Invert a real scalar multiple.** A real scalar multiple can be moved outside the inverse Fourier transform. Source: Breakdown.FracCert.Internal.WeakNiceSim.inverseTransform_const_smul in Breakdown.FracCert.WeakNiceSim, line 71. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L71).

**The complex rotation equivalence.** A real spatial isometry induces a continuous complex linear equivalence on complex vectors. Source: Breakdown.FracCert.Internal.WeakNiceSim.rotEquiv in Breakdown.FracCert.WeakNiceSim, line 79. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L79).

**Evaluate the rotation equivalence.** The complex linear equivalence agrees with the coordinate rotation map. Source: Breakdown.FracCert.Internal.WeakNiceSim.rotEquiv_apply in Breakdown.FracCert.WeakNiceSim, line 88. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L88).

**Rotate an inverse Fourier transform.** Rotating the symbol rotates the inverse transformed field with the inverse spatial argument. Source: Breakdown.FracCert.Internal.WeakNiceSim.inverseTransform_rot in Breakdown.FracCert.WeakNiceSim, line 90. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L90).

**Transport a scaled rotated field.** The inverse transform of the scaled rotated symbol has the physical dilation Jacobian and corresponding rotated argument. Source: Breakdown.FracCert.Internal.WeakNiceSim.transport in Breakdown.FracCert.WeakNiceSim, line 99. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L99).

**Source namespace:** Breakdown.FracCert.

**Prove closure under similarity.** The theorem discharges preservation of nice fields under the adjoint similarity action. Source: Breakdown.FracCert.niceSimAdjClosed in Breakdown.FracCert.WeakNiceSim, line 112. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakNiceSim.lean#L112).

### Breakdown.FracCert.WeakPowerLimit

Weighted test estimates allow the weak fractional power relation to pass to weak L2 limits of the radial velocity weight and the power field.

**Source namespace:** Breakdown.SteadyCert.WeakPowerLimitInternal.

**A weighted fractional test bound.** For fractional exponent between one and three halves, radius times the fractional power of a test field is square integrable. Source: Breakdown.SteadyCert.WeakPowerLimitInternal.weighted_power_memLp in Breakdown.FracCert.WeakPowerLimit, line 15. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakPowerLimit.lean#L15).

**Almost every point is nonzero.** The spatial origin is negligible for volume measure. Source: Breakdown.SteadyCert.WeakPowerLimitInternal.ae_nonzero in Breakdown.FracCert.WeakPowerLimit, line 49. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakPowerLimit.lean#L49).

**Source namespace:** Breakdown.SteadyCert.

**Pass the fractional power to a limit.** For exponents between one and five quarters, the weak fractional power relation passes to the stated weak L2 limits of the radially weighted velocity and its power. Source: Breakdown.SteadyCert.weakPowerLimit_holds in Breakdown.FracCert.WeakPowerLimit, line 57. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakPowerLimit.lean#L57).

### Breakdown.FracCert.WeakPowerSub

The weak fractional power relation is stable under subtraction for the stated fractional exponent range and L6 velocity class.

**Source namespace:** Breakdown.SteadyCert.

**Subtract weak fractional powers.** For exponents between one and five quarters, subtracting two L6 velocities and their weak fractional powers preserves the weak fractional power relation. Source: Breakdown.SteadyCert.weakPowerSub in Breakdown.FracCert.WeakPowerSub, line 14. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakPowerSub.lean#L14).

### Breakdown.FracCert.WeakRegular

Moment bounds reconstruct pressure and the profile residual, assemble its weighted L2 control and remove the remaining weak-test obstruction.

**Source namespace:** Breakdown.FracCert.WeakRegularInternal.

**Conjugation is an involution.** Conjugating a complex vector twice gives the original vector. Source: Breakdown.FracCert.WeakRegularInternal.conjVec_invol in Breakdown.FracCert.WeakRegular, line 25. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L25).

**The good frequency set.** The good set consists of frequencies where the required symmetry and solenoidal relations hold. Source: Breakdown.FracCert.WeakRegularInternal.goodSet in Breakdown.FracCert.WeakRegular, line 29. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L29).

**A pointwise valid symbol.** The cleaned symbol agrees with the original symbol on the good set and is zero elsewhere. Source: Breakdown.FracCert.WeakRegularInternal.cleanSymbol in Breakdown.FracCert.WeakRegular, line 34. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L34).

**The good set is symmetric.** Negating a frequency in the good set leaves it in the good set. Source: Breakdown.FracCert.WeakRegularInternal.neg_mem_goodSet in Breakdown.FracCert.WeakRegular, line 36. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L36).

**Symmetry of the cleaned symbol.** The cleaned symbol satisfies conjugate symmetry pointwise. Source: Breakdown.FracCert.WeakRegularInternal.cleanSymbol_conjSym in Breakdown.FracCert.WeakRegular, line 42. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L42).

**The cleaned symbol is solenoidal.** The cleaned symbol has zero contraction with the frequency vector at every frequency. Source: Breakdown.FracCert.WeakRegularInternal.cleanSymbol_div in Breakdown.FracCert.WeakRegular, line 50. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L50).

**Cleaning preserves almost all values.** If the good set has full measure, the cleaned symbol equals the original symbol almost everywhere. Source: Breakdown.FracCert.WeakRegularInternal.cleanSymbol_ae in Breakdown.FracCert.WeakRegular, line 57. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L57).

**Almost everywhere symbol constraints.** A Fourier state's velocity symbol is conjugate symmetric and solenoidal almost everywhere. Source: Breakdown.FracCert.WeakRegularInternal.symbolX_ae in Breakdown.FracCert.WeakRegular, line 62. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L62).

**The good set has full measure.** Almost every frequency lies in the good set of a Fourier state's velocity symbol. Source: Breakdown.FracCert.WeakRegularInternal.goodSet_ae in Breakdown.FracCert.WeakRegular, line 91. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L91).

**Cleaning preserves the physical field.** The physical inverse transform is unchanged by cleaning the symbol. Source: Breakdown.FracCert.WeakRegularInternal.physField_clean in Breakdown.FracCert.WeakRegular, line 99. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L99).

**Cleaning preserves all moments.** Cleaning a velocity symbol preserves all weighted L1 moments. Source: Breakdown.FracCert.WeakRegularInternal.moments_clean in Breakdown.FracCert.WeakRegular, line 104. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L104).

**Measurability of the velocity symbol.** The velocity symbol is almost everywhere strongly measurable. Source: Breakdown.FracCert.WeakRegularInternal.aesm_symbolX in Breakdown.FracCert.WeakRegular, line 111. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L111).

**Weighted integrability after cleaning.** The cleaned velocity symbol belongs to each weighted L1 space supplied by the moment condition. Source: Breakdown.FracCert.WeakRegularInternal.memLp_clean in Breakdown.FracCert.WeakRegular, line 115. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L115).

**Advection ignores null set changes.** Almost everywhere equal symbols give equal advection symbols. Source: Breakdown.FracCert.WeakRegularInternal.advection_congr in Breakdown.FracCert.WeakRegular, line 127. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L127).

**Cleaning preserves the pressure.** The pressure symbol is unchanged by cleaning the velocity symbol. Source: Breakdown.FracCert.WeakRegularInternal.pressure_clean in Breakdown.FracCert.WeakRegular, line 140. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L140).

**Invert a single basis component.** The inverse transform of a scalar symbol in one basis direction is its scalar inverse transform in that direction. Source: Breakdown.FracCert.WeakRegularInternal.inverseTransform_smul_single in Breakdown.FracCert.WeakRegular, line 145. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L145).

**The pressure as a vector symbol.** The pressure field symbol places the scalar pressure symbol in one coordinate direction. Source: Breakdown.FracCert.WeakRegularInternal.pressureField in Breakdown.FracCert.WeakRegular, line 152. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L152).

**Smoothness of the pressure transform.** All weighted L1 velocity moments give a smooth inverse transform of the pressure field symbol. Source: Breakdown.FracCert.WeakRegularInternal.contDiff_pressureField in Breakdown.FracCert.WeakRegular, line 155. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L155).

**Source namespace:** Breakdown.FracCert.

**Prove smoothness of pressure.** The theorem derives the pressure smoothness interface from the weighted symbol moment interface. Source: Breakdown.FracCert.pressureSmooth_of in Breakdown.FracCert.WeakRegular, line 173. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L173).

**Source namespace:** Breakdown.FracCert.WeakRegularInternal.

**Real parts do not increase norm.** The norm of the real part of a complex vector is at most its complex norm. Source: Breakdown.FracCert.WeakRegularInternal.norm_realVec_le' in Breakdown.FracCert.WeakRegular, line 191. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L191).

**Pair a weighted field with Schwartz.** The weighted L2 assumption makes the pairing of a continuous field with a Schwartz field integrable. Source: Breakdown.FracCert.WeakRegularInternal.integrable_pairing in Breakdown.FracCert.WeakRegular, line 199. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L199).

**Symmetry of the longitudinal part.** Conjugation and frequency reflection preserve the longitudinal projection. Source: Breakdown.FracCert.WeakRegularInternal.longitudinal_conjSym in Breakdown.FracCert.WeakRegular, line 233. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L233).

**Recover the longitudinal remainder.** Subtracting the symmetrised solenoidal projection leaves the longitudinal part of a conjugate symmetric symbol. Source: Breakdown.FracCert.WeakRegularInternal.sub_symField_projField in Breakdown.FracCert.WeakRegular, line 239. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L239).

**Read a Schwartz physical field.** The physical field of a Schwartz symbol is the real part of its inverse Fourier transform. Source: Breakdown.FracCert.WeakRegularInternal.physField_of_rapid in Breakdown.FracCert.WeakRegular, line 246. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L246).

**An integrable symbol gives continuity.** The physical inverse transform of an integrable symbol is continuous. Source: Breakdown.FracCert.WeakRegularInternal.continuous_physField_of in Breakdown.FracCert.WeakRegular, line 252. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L252).

**Continuity of the axial turn.** The axial turn is a continuous map. Source: Breakdown.FracCert.WeakRegularInternal.continuous_axialTurn in Breakdown.FracCert.WeakRegular, line 261. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L261).

**Integrability of the power symbol.** The specified third weighted moment controls the fractional power symbol when the exponent lies between zero and three halves. Source: Breakdown.FracCert.WeakRegularInternal.integrable_powerSymbol in Breakdown.FracCert.WeakRegular, line 270. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L270).

**The axial turn does not enlarge norm.** The norm of the axial turn is at most the original norm. Source: Breakdown.FracCert.WeakRegularInternal.norm_axialTurn_le in Breakdown.FracCert.WeakRegular, line 290. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L290).

**Read a finite homogeneous norm.** Finiteness of the homogeneous norm gives square integrability of the corresponding radially weighted symbol. Source: Breakdown.FracCert.WeakRegularInternal.memLp_of_homNormSq in Breakdown.FracCert.WeakRegular, line 298. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L298).

**Bound an intermediate radial power.** For exponents between one and three, the radial power is bounded by the sum of the first and third powers. Source: Breakdown.FracCert.WeakRegularInternal.rpow_le_add in Breakdown.FracCert.WeakRegular, line 311. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L311).

**Bound an operator on a basis.** The operator norm is bounded by the sum of the norms of its values on the three coordinate unit vectors. Source: Breakdown.FracCert.WeakRegularInternal.opNorm_le_sum_basis in Breakdown.FracCert.WeakRegular, line 326. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L326).

**A smooth derivative is weak.** The classical derivative of a smooth vector field also represents its weak gradient. Source: Breakdown.FracCert.WeakRegularInternal.weakGradient_of_smooth in Breakdown.FracCert.WeakRegular, line 345. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L345).

**Source namespace:** Breakdown.FracCert.

**Continuity of the profile residual.** The moment and smoothness interfaces make the fractional profile residual continuous in the stated exponent range. Source: Breakdown.FracCert.residualContinuous_of in Breakdown.FracCert.WeakRegular, line 369. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L369).

**Assemble residual growth control.** The theorem combines residual continuity and weighted square integrability into the residual growth interface. Source: Breakdown.FracCert.residualGrowth_of in Breakdown.FracCert.WeakRegular, line 405. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L405).

**Annihilate annular residual tests.** The theorem combines growth, nice test and gradient test interfaces to annihilate all annular frequency tests. Source: Breakdown.FracCert.residualAnnulus_of in Breakdown.FracCert.WeakRegular, line 410. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L410).

**Assemble the weighted residual bound.** The theorem assembles the velocity, gradient, fractional power, advection and pressure gradient bounds into weighted residual square integrability. Source: Breakdown.FracCert.residualWeighted_of in Breakdown.FracCert.WeakRegular, line 463. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L463).

**Bound the fractional power in L2.** The theorem derives square integrability of the fractional power from the weighted symbol moment interface. Source: Breakdown.FracCert.powerSquare_of in Breakdown.FracCert.WeakRegular, line 546. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L546).

**Bound advection in L2.** The theorem combines moment, smoothness and gradient bounds to obtain square integrability of advection. Source: Breakdown.FracCert.advectionSquare_of in Breakdown.FracCert.WeakRegular, line 583. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L583).

**Bound the velocity gradient in L2.** The theorem derives square integrability of the physical gradient from the weighted symbol moment interface. Source: Breakdown.FracCert.velocityGradientSquare_of in Breakdown.FracCert.WeakRegular, line 604. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L604).

**Bound the weighted velocity in L2.** The theorem derives the inverse radial weighted velocity bound from the moment and smoothness interfaces. Source: Breakdown.FracCert.velocityInverseWeight_of in Breakdown.FracCert.WeakRegular, line 658. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L658).

**Prove the smooth profile equation.** The theorem combines symbol moments, smoothness, residual tests and low frequency removal to discharge weak profile regularity. Source: Breakdown.FracCert.weakProfileRegular_of in Breakdown.FracCert.WeakRegular, line 702. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegular.lean#L702).

### Breakdown.FracCert.WeakRegularParts

Pressure and residual definitions isolate the smoothness, growth, square-integrability and annular-testing obligations of the weak regularity proof.

**Source namespace:** Breakdown.FracCert.

**Recover pressure from its symbol.** The profile pressure is the real physical scalar associated with the pressure symbol. Source: Breakdown.FracCert.profilePressure in Breakdown.FracCert.WeakRegularParts, line 12. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L12).

**The fractional profile residual.** The residual evaluates the rotating fractional profile equation at unit scaling using the reconstructed velocity and pressure. Source: Breakdown.FracCert.profileResidual in Breakdown.FracCert.WeakRegularParts, line 14. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L14).

**Pressure is smooth.** This proposition requires the reconstructed profile pressure to be smooth whenever all frequency moments are finite. Source: Breakdown.FracCert.PressureSmoothStatement in Breakdown.FracCert.WeakRegularParts, line 17. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L17).

**Continuity and weighted residual control.** This proposition requires the profile residual to be continuous and square integrable after division by one plus radius. Source: Breakdown.FracCert.ResidualGrowthStatement in Breakdown.FracCert.WeakRegularParts, line 20. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L20).

**A weighted L2 residual.** This proposition requires the profile residual divided by one plus radius to be square integrable. Source: Breakdown.FracCert.ResidualWeightedStatement in Breakdown.FracCert.WeakRegularParts, line 25. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L25).

**A weighted L2 velocity.** This proposition requires the physical velocity divided by one plus radius to be square integrable. Source: Breakdown.FracCert.VelocityInverseWeightStatement in Breakdown.FracCert.WeakRegularParts, line 29. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L29).

**A square integrable velocity gradient.** This proposition requires the norm of the physical velocity gradient to be square integrable. Source: Breakdown.FracCert.VelocityGradientSquareStatement in Breakdown.FracCert.WeakRegularParts, line 32. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L32).

**A square integrable fractional power.** This proposition requires the fractional power of the physical velocity to be square integrable in the stated exponent range. Source: Breakdown.FracCert.PowerSquareStatement in Breakdown.FracCert.WeakRegularParts, line 35. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L35).

**Square integrability of advection.** This proposition requires the physical advection field to be square integrable. Source: Breakdown.FracCert.AdvectionSquareStatement in Breakdown.FracCert.WeakRegularParts, line 39. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L39).

**A square integrable pressure gradient.** This proposition requires the gradient of the reconstructed pressure to be square integrable. Source: Breakdown.FracCert.PressureGradientSquareStatement in Breakdown.FracCert.WeakRegularParts, line 42. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L42).

**The residual annihilates annular tests.** This proposition requires the residual pairing to vanish on smooth compact frequency tests supported away from zero. Source: Breakdown.FracCert.ResidualAnnulusStatement in Breakdown.FracCert.WeakRegularParts, line 45. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L45).

**The residual annihilates nice fields.** This proposition requires the residual pairing to vanish against each nice field. Source: Breakdown.FracCert.ResidualNiceStatement in Breakdown.FracCert.WeakRegularParts, line 51. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L51).

**The residual annihilates gradients.** This proposition requires the residual to annihilate annular frequency tests that are pointwise parallel to the frequency vector. Source: Breakdown.FracCert.ResidualGradientStatement in Breakdown.FracCert.WeakRegularParts, line 55. [Proposition definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakRegularParts.lean#L55).

### Breakdown.FracCert.WeakSimDeriv

Local domination of the moving adjoint test field justifies differentiating its velocity pairing before physical time one.

**Source namespace:** Breakdown.FracCert.Internal.SimDeriv.

**The axial turn respects scaling.** The axial turn commutes with real scalar multiplication. Source: Breakdown.FracCert.Internal.SimDeriv.turn_smul in Breakdown.FracCert.WeakSimDeriv, line 16. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L16).

**The axial turn respects addition.** The axial turn of a sum is the sum of the two turns. Source: Breakdown.FracCert.Internal.SimDeriv.turn_add in Breakdown.FracCert.WeakSimDeriv, line 20. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L20).

**The axial turn respects subtraction.** The axial turn of a difference is the difference of the two turns. Source: Breakdown.FracCert.Internal.SimDeriv.turn_sub in Breakdown.FracCert.WeakSimDeriv, line 24. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L24).

**The axial turn vanishes at zero.** The axial turn sends zero to zero. Source: Breakdown.FracCert.Internal.SimDeriv.turn_zero in Breakdown.FracCert.WeakSimDeriv, line 28. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L28).

**Bound the axial turn.** The axial turn does not increase the vector norm. Source: Breakdown.FracCert.Internal.SimDeriv.norm_turn_le in Breakdown.FracCert.WeakSimDeriv, line 31. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L31).

**Expand the adjoint similarity action.** The adjoint similarity action has the stated rotation, amplitude and spatial scaling formula. Source: Breakdown.FracCert.Internal.SimDeriv.simAdj_eq in Breakdown.FracCert.WeakSimDeriv, line 37. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L37).

**Differentiate a conjugated field.** The derivative of a field conjugated by linear isometries and dilations obeys the displayed chain rule. Source: Breakdown.FracCert.Internal.SimDeriv.fderiv_conj in Breakdown.FracCert.WeakSimDeriv, line 43. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L43).

**Transport the adjoint drift.** Applying drift after adjoint similarity gives the transformed derivative and rotation expression. Source: Breakdown.FracCert.Internal.SimDeriv.drift_simAdj in Breakdown.FracCert.WeakSimDeriv, line 57. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L57).

**Differentiate a moving similarity.** Before time one, differentiating the adjoint similarity action introduces the reciprocal remaining time times its drift. Source: Breakdown.FracCert.Internal.SimDeriv.hasDerivAt_simAdj in Breakdown.FracCert.WeakSimDeriv, line 70. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L70).

**Bound powers on a positive interval.** A real power at an intermediate positive point is bounded by the sum of its endpoint powers. Source: Breakdown.FracCert.Internal.SimDeriv.rpow_le_sum in Breakdown.FracCert.WeakSimDeriv, line 99. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L99).

**Uniform Schwartz decay.** A Schwartz field and its first derivative admit a common bound with the fifth radial weight. Source: Breakdown.FracCert.Internal.SimDeriv.rapid_decay in Breakdown.FracCert.WeakSimDeriv, line 109. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L109).

**Compare scaled radial weights.** The stated lower bound on the dilation controls one plus the unscaled radius by one plus the scaled radius. Source: Breakdown.FracCert.Internal.SimDeriv.one_add_scale in Breakdown.FracCert.WeakSimDeriv, line 120. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L120).

**Bound the transformed drift terms.** The algebraic norm estimate controls the combined field, derivative and rotation terms by their scalar coefficients. Source: Breakdown.FracCert.Internal.SimDeriv.abstract_bound in Breakdown.FracCert.WeakSimDeriv, line 125. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L125).

**Bound the similarity drift.** The scaled adjoint drift is bounded by the stated weighted field and derivative norms at the transformed point. Source: Breakdown.FracCert.Internal.SimDeriv.drift_norm_le in Breakdown.FracCert.WeakSimDeriv, line 157. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L157).

**Norm of the adjoint similarity.** The adjoint similarity norm is its positive amplitude factor times the original field norm at the transformed point. Source: Breakdown.FracCert.Internal.SimDeriv.simAdj_norm_eq in Breakdown.FracCert.WeakSimDeriv, line 172. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L172).

**Uniform bounds on a scale interval.** On a positive compact scale interval, both the adjoint test field and its time derivative have uniform fourth order decay bounds. Source: Breakdown.FracCert.Internal.SimDeriv.simAdj_bounds in Breakdown.FracCert.WeakSimDeriv, line 179. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L179).

**Compare first and sixth powers.** A nonnegative real number is at most one plus its sixth power. Source: Breakdown.FracCert.Internal.SimDeriv.le_one_add_rpow_six in Breakdown.FracCert.WeakSimDeriv, line 241. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L241).

**Dominate a decaying test pairing.** The pairing with a fourth order decaying test field is bounded by an integrable radial tail plus the sixth power of the velocity. Source: Breakdown.FracCert.Internal.SimDeriv.pair_bound in Breakdown.FracCert.WeakSimDeriv, line 248. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L248).

**The turn map is continuous.** The axial turn map is continuous. Source: Breakdown.FracCert.Internal.SimDeriv.continuous_turn in Breakdown.FracCert.WeakSimDeriv, line 271. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L271).

**Continuity after adjoint similarity.** The adjoint similarity image of a Schwartz field is continuous. Source: Breakdown.FracCert.Internal.SimDeriv.continuous_simAdj in Breakdown.FracCert.WeakSimDeriv, line 276. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L276).

**Continuity of the moving drift.** The scaled drift of a transformed Schwartz field is continuous in space. Source: Breakdown.FracCert.Internal.SimDeriv.continuous_drift in Breakdown.FracCert.WeakSimDeriv, line 283. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L283).

**Source namespace:** Breakdown.FracCert.

**Prove the differentiated pairing.** The theorem discharges the differentiation interface for the moving adjoint similarity pairing. Source: Breakdown.FracCert.simAdjDeriv in Breakdown.FracCert.WeakSimDeriv, line 323. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimDeriv.lean#L323).

### Breakdown.FracCert.WeakSimPair

The similarity action is transferred from the Fourier state to the adjoint action on physical tests inside the velocity pairing.

**Source namespace:** Breakdown.FracCert.

**Prove the adjoint pairing identity.** The theorem discharges the identity moving similarity from velocity to the test field. Source: Breakdown.FracCert.simAdjPairing in Breakdown.FracCert.WeakSimPair, line 15. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSimPair.lean#L15).

### Breakdown.FracCert.WeakSymbolL1

Positive homogeneous square moments control every weighted L1 moment of the velocity symbol and recover its physical representative.

**Source namespace:** Breakdown.FracCert.MomentsInternal.

**The symbol is measurable.** The velocity symbol of a Fourier state is almost everywhere strongly measurable. Source: Breakdown.FracCert.MomentsInternal.aesm_symbolX in Breakdown.FracCert.WeakSymbolL1, line 17. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L17).

**The velocity symbol at zero.** The velocity symbol takes value zero at zero frequency. Source: Breakdown.FracCert.MomentsInternal.symbolX_zero in Breakdown.FracCert.WeakSymbolL1, line 22. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L22).

**Integrability from a finite moment.** A finite homogeneous square norm makes its weighted squared symbol norm integrable. Source: Breakdown.FracCert.MomentsInternal.integrable_weight_sq in Breakdown.FracCert.WeakSymbolL1, line 24. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L24).

**A weighted elementary square bound.** The scalar is bounded by half the sum of the positive weight's inverse and its weighted square. Source: Breakdown.FracCert.MomentsInternal.le_half_inv_add in Breakdown.FracCert.WeakSymbolL1, line 35. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L35).

**All polynomial L1 moments.** A measurable symbol vanishing at zero with all positive homogeneous square moments has every weighted L1 moment. Source: Breakdown.FracCert.MomentsInternal.weighted_moment in Breakdown.FracCert.WeakSymbolL1, line 42. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L42).

**The conjugate symmetric part.** The even part averages a symbol with the conjugate of its reflected symbol. Source: Breakdown.FracCert.MomentsInternal.evenPart in Breakdown.FracCert.WeakSymbolL1, line 93. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L93).

**A solenoidal representative.** The representative applies the divergence free projection to the conjugate symmetric part of the symbol. Source: Breakdown.FracCert.MomentsInternal.solRep in Breakdown.FracCert.WeakSymbolL1, line 95. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L95).

**The representative is solenoidal.** The projected representative satisfies the solenoidal symbol conditions. Source: Breakdown.FracCert.MomentsInternal.solRep_solenoidal in Breakdown.FracCert.WeakSymbolL1, line 97. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L97).

**The representative agrees a.e..** The projected symmetric representative of a Fourier state agrees almost everywhere with its velocity symbol. Source: Breakdown.FracCert.MomentsInternal.solRep_ae in Breakdown.FracCert.WeakSymbolL1, line 111. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L111).

**Remove a small frequency ball.** The cutoff set keeps frequencies whose norm exceeds the reciprocal of the index plus one. Source: Breakdown.FracCert.MomentsInternal.cutSet in Breakdown.FracCert.WeakSymbolL1, line 128. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L128).

**The frequency cutoff is measurable.** The complement of the small frequency ball is measurable. Source: Breakdown.FracCert.MomentsInternal.measurableSet_cutSet in Breakdown.FracCert.WeakSymbolL1, line 130. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L130).

**Every nonzero frequency survives.** Every nonzero frequency eventually belongs to all sufficiently large cutoff sets. Source: Breakdown.FracCert.MomentsInternal.eventually_mem_cutSet in Breakdown.FracCert.WeakSymbolL1, line 133. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L133).

**The truncated solenoidal symbol.** The truncated representative is the indicator of the cutoff set times the solenoidal representative. Source: Breakdown.FracCert.MomentsInternal.cutRep in Breakdown.FracCert.WeakSymbolL1, line 136. [Definition](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L136).

**Truncation keeps zero divergence.** The truncated representative remains a solenoidal symbol. Source: Breakdown.FracCert.MomentsInternal.cutRep_solenoidal in Breakdown.FracCert.WeakSymbolL1, line 138. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L138).

**Measurability of the representative.** The solenoidal representative of a Fourier state is almost everywhere strongly measurable. Source: Breakdown.FracCert.MomentsInternal.aesm_solRep in Breakdown.FracCert.WeakSymbolL1, line 147. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L147).

**Measurability after truncation.** The truncated solenoidal representative is almost everywhere strongly measurable. Source: Breakdown.FracCert.MomentsInternal.aesm_cutRep in Breakdown.FracCert.WeakSymbolL1, line 150. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L150).

**Compare the two frequency weights.** Away from the excluded ball, the inhomogeneous weight is bounded by the stated higher homogeneous weight. Source: Breakdown.FracCert.MomentsInternal.weight_le_of_mem in Breakdown.FracCert.WeakSymbolL1, line 153. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L153).

**Cleaning preserves the square moment.** Passing to the solenoidal representative preserves every homogeneous square norm. Source: Breakdown.FracCert.MomentsInternal.homNormSq_solRep in Breakdown.FracCert.WeakSymbolL1, line 167. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L167).

**Truncation has finite Sobolev norms.** Every inhomogeneous Sobolev norm of the truncated representative is finite when all original moments are finite. Source: Breakdown.FracCert.MomentsInternal.hsNormSq_cutRep in Breakdown.FracCert.WeakSymbolL1, line 173. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L173).

**Embed the truncated physical field.** Embedding the truncated physical field recovers the cutoff of the original Fourier state almost everywhere. Source: Breakdown.FracCert.MomentsInternal.embed_cut in Breakdown.FracCert.WeakSymbolL1, line 192. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L192).

**The truncated embeddings converge.** The embedded truncated physical fields converge to the original Fourier state. Source: Breakdown.FracCert.MomentsInternal.tendsto_embed_cut in Breakdown.FracCert.WeakSymbolL1, line 205. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L205).

**Integrability of the velocity symbol.** All homogeneous moments imply integrability of the velocity symbol. Source: Breakdown.FracCert.MomentsInternal.integrable_symbolX in Breakdown.FracCert.WeakSymbolL1, line 244. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L244).

**The representative has the same field.** The solenoidal representative and original velocity symbol have the same physical field. Source: Breakdown.FracCert.MomentsInternal.physField_solRep in Breakdown.FracCert.WeakSymbolL1, line 249. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L249).

**The truncated physical fields converge.** The physical fields of the truncated representatives converge pointwise to the physical field of the original symbol. Source: Breakdown.FracCert.MomentsInternal.tendsto_phys_cut in Breakdown.FracCert.WeakSymbolL1, line 258. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L258).

**The physical field represents velocity.** The reconstructed physical field agrees almost everywhere with the Fourier state's velocity. Source: Breakdown.FracCert.MomentsInternal.velocity_ae in Breakdown.FracCert.WeakSymbolL1, line 277. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L277).

**Source namespace:** Breakdown.FracCert.

**Prove the weighted moment interface.** The theorem discharges the weighted L1 moment and physical velocity representation interface. Source: Breakdown.FracCert.symbolL1OfMoments in Breakdown.FracCert.WeakSymbolL1, line 297. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakSymbolL1.lean#L297).

### Breakdown.FracCert.WeakToProfile

Regularity, derivative decay and nonzero recovery are assembled into a smooth rotating fractional profile from the weak profile premise.

**Source namespace:** Breakdown.FracCert.

**Assemble profile decay.** The base and derivative step estimates give the required decay of a weak rotating profile with all moments. Source: Breakdown.FracCert.profileDecay_of_parts in Breakdown.FracCert.WeakToProfile, line 12. [Private proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakToProfile.lean#L12).

**Pass from a weak to a smooth profile.** The theorem combines moment, regularity, decay and nonzero interfaces to discharge the weak to rotating profile implication. Source: Breakdown.FracCert.weakToProfile_of in Breakdown.FracCert.WeakToProfile, line 25. [Proved theorem](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/WeakToProfile.lean#L25).
