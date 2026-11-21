# Library guide 23: Breakdown/FracCert

**Navier–Stokes pages:** [the paper](../navier-stokes-paper/paper.pdf) · [proof routes](../navier-stokes-routes/paper.md) · [routes in detail](../navier-stokes-route-details/paper.md) · library guide: [1](../navier-stokes-library-01/paper.md) [2](../navier-stokes-library-02/paper.md) [3](../navier-stokes-library-03/paper.md) [4](../navier-stokes-library-04/paper.md) [5](../navier-stokes-library-05/paper.md) [6](../navier-stokes-library-06/paper.md) [7](../navier-stokes-library-07/paper.md) [8](../navier-stokes-library-08/paper.md) [9](../navier-stokes-library-09/paper.md) [10](../navier-stokes-library-10/paper.md) [11](../navier-stokes-library-11/paper.md) [12](../navier-stokes-library-12/paper.md) [13](../navier-stokes-library-13/paper.md) [14](../navier-stokes-library-14/paper.md) [15](../navier-stokes-library-15/paper.md) [16](../navier-stokes-library-16/paper.md) [17](../navier-stokes-library-17/paper.md) [18](../navier-stokes-library-18/paper.md) [19](../navier-stokes-library-19/paper.md) [20](../navier-stokes-library-20/paper.md) [21](../navier-stokes-library-21/paper.md) [22](../navier-stokes-library-22/paper.md) **23** [24](../navier-stokes-library-24/paper.md) [25](../navier-stokes-library-25/paper.md) [26](../navier-stokes-library-26/paper.md) [27](../navier-stokes-library-27/paper.md) [28](../navier-stokes-library-28/paper.md) [29](../navier-stokes-library-29/paper.md) [30](../navier-stokes-library-30/paper.md)

*A plain title and a sentence for each declaration in `Breakdown.FracCert.ActiveEnclosure` to `Breakdown.FracCert.KernelDecay` of Alpöge and Buckmaster's Lean at `ad53419de079eb8f95f60313473374624a348546`, in the authors' file order. Prepared with AI assistance. The authors have not reviewed it.*

Each paragraph names one declaration and says whether it is a definition, a proposition that the library defines (its name usually ends in `Holds` or `Statement`) or a proved result, then what it states. Click a paragraph to open its Lean on the right.

### Breakdown.FracCert.ActiveEnclosure

Bounds the active transformed held multipliers by testing the residual against certificate rows and controlling pin and nonlinear errors.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/ActiveEnclosure.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.ActiveEnclosureInternal`.

**L² fields pair integrably.** Proved result `pair_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.ActiveEnclosure:15`.

**L² energy equals norm squared.** Proved result `sq_integral_eq`: Under the stated hypotheses, L² energy equals norm squared.

**Cauchy-Schwarz bounds integral pairings.** Proved result `abs_pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds integral pairings. Source: `Breakdown.FracCert.ActiveEnclosure:28`.

**Cauchy-Schwarz bounds finite sums.** Proved result `sum_mul_le_sqrt`: Under the stated hypotheses, Cauchy-Schwarz bounds finite sums.

**Two products obey Cauchy-Schwarz.** Proved result `two_mul_le`: Under the stated hypotheses, two products obey Cauchy-Schwarz.

**Finite matrix energy gives L² columns.** Proved result `col_memLp`: Under the stated hypotheses, finite matrix energy gives L² columns. Source: `Breakdown.FracCert.ActiveEnclosure:50`.

**Matrix pairings obey Cauchy-Schwarz.** Proved result `entry_pair`: Under the stated hypotheses, matrix pairings obey Cauchy-Schwarz.

**Second traces belong to L².** Proved result `trace_memLp`: Under the stated hypotheses, second traces belong to L².

**Inverse-radius decay is in L⁶.** Proved result `decay_six`: Under the stated hypotheses, inverse-radius decay is in L⁶.

**Mixed powers admit a sum bound.** Proved result `pointwise_split`: Under the stated hypotheses, mixed powers admit a sum bound.

**Decaying matrices send L⁶ fields to L².** Proved result `decay_apply_memLp`: Under the stated hypotheses, decaying matrices send L⁶ fields to L².

**Basis vectors reconstruct linear maps.** Proved result `apply_expand`: Under the stated hypotheses, basis vectors reconstruct linear maps.

**Bounded vectors preserve L² bounds.** Proved result `bounded_apply_memLp`: Under the stated hypotheses, bounded vectors preserve matrix L² bounds.

**Certificate profiles have uniform decay.** Proved result `profile_bounds_of`: Under the stated hypotheses, certificate profiles have uniform decay.

**Profile decay gives a global bound.** Proved result `profile_le`: Under the stated hypotheses, profile decay gives a global bound.

**Finite actuator sums belong to L².** Proved result `sum_smul_memLp`: Under the stated hypotheses, finite actuator sums belong to L².

**The local linear field belongs to L².** Proved result `local_memLp`: Under the stated hypotheses, the local linear field belongs to L².

**The certificate defect belongs to L².** Proved result `defect_memLp`: Under the stated hypotheses, the certificate defect belongs to L².

**Difference squares have a sum bound.** Proved result `norm_sub_sq_le`: Under the stated hypotheses, difference squares have a sum bound.

**Matrix difference energy has a sum bound.** Proved result `entrySq_sub_le`: Under the stated hypotheses, matrix difference energy has a sum bound.

**Weighted energy controls gradient energy.** Proved result `energy_facts`: Under the stated hypotheses, weighted energy controls gradient energy.

**Pin errors obey the certificate gap.** Proved result `pin_bound`: Under the stated hypotheses, pin errors obey the certificate gap.

**Source namespace:** `Breakdown.SteadyCert`.

**Active multipliers satisfy the enclosure.** Proved result `activeEnclosure`: Under the stated assumptions, this establishes that for a held solution within the certified radius at a test-box parameter, each active coordinate of the transformed corrected multiplier differs from its slope times the parameter by at most the absolute slope times that coordinate radius.

### Breakdown.FracCert.AprioriBound

Turns certificate coercivity, fractional splitting estimates and finite row and pin errors into the quantitative inverse bound for a linear correction state.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/AprioriBound.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**L² fields pair integrably.** Proved result `int_inner_two`: Under the stated hypotheses, L² fields pair integrably.

**Cauchy-Schwarz bounds the L² pairing.** Proved result `pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds the L² pairing.

**Compact L² fields pair with local L².** Proved result `int_inner_loc`: Under the stated hypotheses, compact L² fields pair with local L².

**Integral pairings preserve sums.** Proved result `pair_add`: Under the stated hypotheses, integral pairings preserve sums.

**Integral pairings preserve differences.** Proved result `pair_sub`: Under the stated hypotheses, integral pairings preserve differences.

**Sum pairings remain integrable.** Proved result `int_add`: Under the stated hypotheses, sum pairings remain integrable.

**Difference pairings remain integrable.** Proved result `int_sub`: Under the stated hypotheses, difference pairings remain integrable.

**Weighted norms obey a triangle bound.** Proved result `wsum_tri`: Under the stated hypotheses, weighted finite norms obey a triangle bound.

**Weighted norms ignore negation.** Proved result `wsum_neg`: Under the stated hypotheses, weighted norms ignore negation.

**Two-coordinate errors have a norm bound.** Proved result `plane_tri`: Under the stated hypotheses, two-coordinate errors have a norm bound.

**A quadratic inequality gives a bound.** Proved result `quad_solve`: Under the stated hypotheses, a quadratic inequality gives a root bound.

**Mixed powers admit a sum bound.** Proved result `sq_mul_le`: Under the stated hypotheses, mixed powers admit a sum bound.

**Matrix energy controls vector action.** Proved result `op_entry`: Under the stated hypotheses, matrix energy controls vector action.

**The second trace is continuous.** Proved result `trace_cont`: Under the stated hypotheses, the second trace is continuous.

**Second traces belong to L².** Proved result `trace_two`: Under the stated hypotheses, second traces belong to L².

**Profile cross products belong to L².** Proved result `sym_two`: Under the stated hypotheses, profile cross products belong to L².

**The local bordered field belongs to L².** Proved result `local_two`: Under the stated hypotheses, the local bordered field belongs to L².

**Row errors obey a three-term bound.** Proved result `rows_tri`: Under the stated hypotheses, row errors obey a three-term bound.

**Coefficient norms obey a triangle bound.** Proved result `vec_tri`: Under the stated hypotheses, coefficient norms obey a triangle bound.

**The zero field is a gradient.** Proved result `grad_zero`: Under the stated hypotheses, the zero field is a gradient.

**Negation preserves weak gradients.** Proved result `grad_neg`: Under the stated hypotheses, negation preserves weak gradients.

**Weak gradients have local L² regularity.** Proved result `grad_parts`: Under the stated hypotheses, weak gradients have local L² regularity.

**Coercivity absorbs row and pin errors.** Proved result `chain`: Under the stated hypotheses, coercivity combines with row and pin errors.

**The certificate gives the inverse bound.** Proved result `aprioriBound`: Under the stated assumptions, this establishes that a valid fractional certificate bounds a linear correction state and its multipliers by the certificate function of its projected residual norm, gradient-insensitive row residuals and pin size.

### Breakdown.FracCert.BallShift

Proves the local translation estimate behind compactness by mollifying weakly differentiable fields and bounding their translated L² differences.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/BallShift.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.BallShiftInternal`.

**Squared averages are bounded by averages.** Proved result `average_sq_le`: Under the stated hypotheses, squared averages are bounded by averages.

**Finite sums pass below lower integrals.** Proved result `sum_three_le`: Under the stated hypotheses, finite sums pass below lower integrals.

**Mollified derivatives recover weak ones.** Proved result `deriv_eq`: Under the stated hypotheses, mollified derivatives recover weak ones.

**Mollified gradient energy is bounded.** Proved result `grad_sq_le`: Under the stated hypotheses, mollified gradient energy is bounded.

**Translated mollifiers have energy bounds.** Proved result `smooth_ball_le`: Under the stated hypotheses, translated mollifiers have energy bounds.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak gradients bound local translations.** Proved result `ballShift`: Under the stated assumptions, this establishes that for a field with the stated local L² regularity and square-integrable weak gradient, the integral over the radius-R ball of the squared difference between the field and its translate is at most the squared translation length times the global gradient energy whenever the translation has norm at most one.

### Breakdown.FracCert.CertTestBox

Extracts containment of the active and stiff test region inside the certificate parameter box.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/CertTestBox.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**The test box lies in the parameter box.** Proved result `testBoxSubset`: Under the stated assumptions, this establishes that a valid fractional certificate places its test box inside its parameter box.

### Breakdown.FracCert.CertificateWeakProfile

Connects a zero of the held multiplier map to a nontrivial weak fractional rotating profile, conditional on the two bridge interfaces.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/CertificateWeakProfile.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Cancelled held states give weak profiles.** Proved result `certificateWeakProfile`: Assuming the held-multiplier zero theorem and the implication from cancelled held solutions to weak profiles, the fractional certificate hypothesis yields a nontrivial weak rotating fractional profile.

### Breakdown.FracCert.DecayBase

Obtains the first spatial decay rate for a fractional profile by splitting its tensor square into a small tail and a compact core, then improving a subcritical weight.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayBase.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FarFieldAddInternal`.

**The projected heat kernel is measurable.** Proved result `kernel_measurable`: Under the stated hypotheses, the projected heat kernel is measurable.

**The projected heat kernel is integrable.** Proved result `kernel_integrable`: Under the stated hypotheses, the projected heat kernel is integrable.

**Bounded tensors pair with the kernel.** Proved result `comp_integrable`: Under the stated hypotheses, bounded tensors pair with the kernel.

**Heat-divergence convolution is additive.** Proved result `heatDivConv_add`: Under the stated hypotheses, heat-divergence convolution is additive.

**The total projected kernel mass.** Definition `kernelMass`: This defines the total mass of the time-one projected heat-divergence kernel by summing the L¹ norms of all twenty-seven scalar components.

**Kernel mass is nonnegative.** Proved result `kernelMass_nonneg`: Under the stated hypotheses, kernel mass is nonnegative. Source: `Breakdown.FracCert.DecayBase:54`.

**Three coordinate bounds control the norm.** Proved result `norm_le_three`: Under the stated hypotheses, three coordinate bounds control the norm.

**Kernel mass bounds heat divergence.** Proved result `heatDivConv_norm_le`: Under the stated hypotheses, kernel mass bounds heat divergence. Source: `Breakdown.FracCert.DecayBase:72`.

**Source namespace:** `Breakdown.FracCert`.

**The far-field operator is additive.** Proposition `FarFieldAddStatement`: This proposition requires that for 1<α<5/4, the far-field operator preserves sums of bounded continuous tensor fields.

**Source namespace:** `Breakdown.FracCert.FarFieldAddInternal`.

**Negative exponentials are below one.** Proved result `exp_neg_lt_one`: Under the stated hypotheses, negative exponentials are below one. Source: `Breakdown.FracCert.DecayBase:122`.

**The far-field integrand is additive.** Proved result `integrand_add`: Under the stated hypotheses, the far-field integrand is additive.

**Coordinate embeddings are measurable.** Proved result `single_measurable`: Under the stated hypotheses, coordinate embeddings are measurable. Source: `Breakdown.FracCert.DecayBase:139`.

**Rotations preserve measurability.** Proved result `meas_rot`: Under the stated hypotheses, rotations preserve measurability.

**Heat convolutions vary measurably.** Proved result `meas_heat`: Under the stated hypotheses, heat convolutions vary measurably. Source: `Breakdown.FracCert.DecayBase:160`.

**The far-field integrand is measurable.** Proved result `integrand_measurable`: Under the stated hypotheses, the far-field integrand is measurable.

**Small heat times have a lower bound.** Proved result `one_sub_exp_ge`: Under the stated hypotheses, small heat times have a linear lower bound. Source: `Breakdown.FracCert.DecayBase:191`.

**The time singularity is integrable.** Proved result `weight_integrable`: Under the stated hypotheses, the time singularity is integrable. Source: `Breakdown.FracCert.DecayBase:197`.

**The far-field integrand is integrable.** Proved result `integrand_integrable`: Under the stated hypotheses, the far-field integrand is integrable.

**Source namespace:** `Breakdown.FracCert`.

**Kernel decay gives far-field additivity.** Proved result `farFieldAdd_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the far-field operator preserves sums of bounded continuous tensor fields.

**Source namespace:** `Breakdown.FracCert.DecayBaseInternal`.

**The tensor product of two fields.** Definition `outer`: This defines the tensor product of two vector fields by the entries uⱼ(y)vₖ(y).

**Tensor norms obey a product bound.** Proved result `norm_outer_le`: Under the stated hypotheses, tensor-product norms obey a product bound.

**Tensor products preserve continuity.** Proved result `continuous_outer`: Under the stated hypotheses, tensor products preserve continuity.

**Tensor products distribute on the right.** Proved result `outer_add_right`: Under the stated hypotheses, tensor products distribute on the right.

**Tensor products distribute on the left.** Proved result `outer_add_left`: Under the stated hypotheses, tensor products distribute on the left.

**All moments give bounded continuity.** Proved result `field_facts`: Under the stated hypotheses, all moments give a bounded continuous field.

**The physical field vanishes at infinity.** Proved result `field_small`: Under the stated hypotheses, the physical field vanishes at infinity.

**The far field inherits a minimum weight.** Proved result `farField_zero_order`: Under the stated hypotheses, the far field inherits a minimum weight.

**A small tail gives subcritical decay.** Proved result `decay_first`: Under the stated hypotheses, a small tail gives subcritical decay.

**Subcritical decay gives the profile rate.** Proved result `decay_second`: Under the stated hypotheses, subcritical decay gives the profile rate.

**Source namespace:** `Breakdown.FracCert`.

**Weak profiles have the base decay rate.** Proved result `profileDecayBase_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all Fourier moments has velocity bounded by C(1+‖y‖)^(−(2α−1)).

### Breakdown.FracCert.DecayFarField

Integrates the rescaled projected heat operator in time, proving differentiability and the minimum of the input and self-similar spatial decay exponents.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayFarField.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Heat derivatives have uniform regularity.** Proposition `HeatDivRegularStatement`: This proposition requires that for 1<α<5/4 and 0≤β<3, a Cʲ tensor with bounded jth derivative and a β-weighted value bound has Cʲ heat-divergence convolutions, jointly continuous derivatives through order j and bounds Ct^(−1/(2α))(A+B) for 0<t≤1.

**Source namespace:** `Breakdown.FracCert.DecayFarField.Internal`.

**The rotating and scaled heat integrand.** Definition `integrand`: This defines the far-field time integrand by rotating and self-similarly scaling the heat-divergence convolution at time 1−exp(−τ).

**Dominated integrals preserve derivatives.** Proved result `integral_contDiff`: Under the stated hypotheses, dominated integrals preserve derivatives.

**The integrand retains derivatives.** Proved result `integrand_contDiff`: Under the stated hypotheses, the time integrand retains spatial derivatives.

**Scaling bounds integrand derivatives.** Proved result `integrand_norm_le`: Under the stated hypotheses, scaling bounds integrand derivatives.

**The transformed heat time is positive.** Proved result `t_pos`: Under the stated hypotheses, the transformed heat time is positive. Source: `Breakdown.FracCert.DecayFarField:148`.

**Integrable majorants give integrability.** Proved result `integrableOn_of_abs_le`: Under the stated hypotheses, an integrable majorant gives integrability.

**Heat-time powers are continuous.** Proved result `tpow_continuousOn`: Under the stated hypotheses, heat-time powers are continuous.

**Near-time singularities have bounds.** Proved result `tpow_le_near`: Under the stated hypotheses, the near-time singularity has a power bound.

**Large times bound the heat-time factor.** Proved result `tpow_le_far`: Under the stated hypotheses, large times bound the heat-time factor.

**Heat-time powers are nonnegative.** Proved result `tpow_nonneg`: Under the stated hypotheses, heat-time powers are nonnegative.

**Damped time singularities are integrable.** Proved result `weight_integrable`: Under the stated hypotheses, damped time singularities are integrable.

**The weighted time kernel is continuous.** Proved result `base_cont`: Under the stated hypotheses, the weighted time kernel is continuous.

**The spatial decay factor is at most one.** Proved result `upow_le_one`: Under the stated hypotheses, the spatial decay factor is at most one.

**Spatial decay only reduces the integrand.** Proved result `base_le`: Under the stated hypotheses, spatial decay only reduces the integrand.

**The weighted time kernel is integrable.** Proved result `base_integrable`: Under the stated hypotheses, the weighted time kernel is integrable.

**The translated scalar decay profile.** Definition `shape`: This defines the scalar profile exp(−gsx)(1+exp(−gx))^(−b) used after a logarithmic shift in the time integral.

**The scalar decay profile is nonnegative.** Proved result `shape_nonneg`: Under the stated hypotheses, the scalar decay profile is nonnegative.

**The scalar decay profile is integrable.** Proved result `shape_integrable`: Under the stated hypotheses, the scalar decay profile is integrable.

**Logarithmic shifts extract decay.** Proved result `shape_identity`: Under the stated hypotheses, a logarithmic shift extracts spatial decay.

**Time integration gives a minimum weight.** Proved result `scalar_bound`: Under the stated hypotheses, time integration gives the minimum weight.

**Output composition preserves continuity.** Proved result `cont_left`: Under the stated hypotheses, output composition preserves continuity.

**Input composition preserves continuity.** Proved result `cont_right`: Under the stated hypotheses, input composition preserves continuity.

**Rotation operators vary continuously.** Proved result `rot_clm_cont`: Under the stated hypotheses, rotation operators vary continuously.

**Inverse rotations vary continuously.** Proved result `rot_symm_clm_cont`: Under the stated hypotheses, inverse rotations vary continuously.

**Integrand derivatives follow scaling.** Proved result `integrand_iteratedFDeriv`: Under the stated hypotheses, integrand derivatives follow scaling.

**Integrand derivatives are measurable.** Proved result `integrand_aesm`: Under the stated hypotheses, integrand derivatives are measurable.

**Source namespace:** `Breakdown.FracCert`.

**Heat bounds give far-field decay.** Proved result `farFieldBound_of`: Under the stated assumptions, this establishes that under the stated fractional and tensor-decay assumptions with b≠2α−1+j, the far-field operator is Cʲ and its jth derivative decays with weight exponent min(b,2α−1+j).

### Breakdown.FracCert.DecayFixedPoint

Identifies a weak fractional profile with the far-field integral by matching solenoidal and gradient frequency tests, then removing annular restrictions.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayFixedPoint.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayFixedPointInternal`.

**All moments give a continuous profile.** Proved result `profileField_continuous`: Under the stated hypotheses, all moments give a continuous profile. Source: `Breakdown.FracCert.DecayFixedPoint:20`.

**All moments give a bounded profile.** Proved result `profileField_bounded`: Under the stated hypotheses, all moments give a bounded profile. Source: `Breakdown.FracCert.DecayFixedPoint:26`.

**Tensor squares preserve continuity.** Proved result `tensorSq_continuous`: Under the stated hypotheses, tensor squares preserve continuity. Source: `Breakdown.FracCert.DecayFixedPoint:36`.

**Tensor squares have a squared bound.** Proved result `tensorSq_norm_le`: Under the stated hypotheses, tensor squares have a squared bound. Source: `Breakdown.FracCert.DecayFixedPoint:42`.

**The profile far field is continuous.** Proved result `farField_continuous`: Under the stated hypotheses, the profile far field is continuous.

**Weighted L² pairs with compact symbols.** Proved result `pairing_integrable`: Under the stated hypotheses, weighted L² fields pair with compact symbols.

**Two test classes determine annuli.** Proved result `annulus_of_parts`: Under the stated hypotheses, solenoidal and gradient tests determine annuli.

**Source namespace:** `Breakdown.FracCert`.

**Annular tests identify the fixed point.** Proved result `profileFixedPoint_of_annulus`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all Fourier moments is pointwise the far-field operator applied to its velocity tensor square.

**Annular pairings agree.** Proved result `fixedPointAnnulus_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments has zero difference from its far field in pairing against every real-symmetric smooth frequency test compactly supported away from zero.

**The profile is a far-field fixed point.** Proved result `profileFixedPoint_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all Fourier moments is pointwise the far-field operator applied to its velocity tensor square.

### Breakdown.FracCert.DecayFixedPointGradient

Shows the physical field of an energy-space element annihilates frequency-localized gradient tests by Fourier orthogonality.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayFixedPointGradient.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayGradientInternal`.

**Fourier inversion exchanges pairings.** Proved result `pair_scalar`: Under the stated hypotheses, inverse Fourier transforms exchange pairings.

**L¹ symbols have continuous inverses.** Proved result `continuous_inverseTransform_of`: Under the stated hypotheses, integrable symbols have continuous inverses.

**Symbol L¹ mass bounds inverse transforms.** Proved result `norm_inverseTransform_le_of`: Under the stated hypotheses, symbol L¹ mass bounds inverse transforms.

**Source namespace:** `Breakdown.FracCert`.

**Profiles annihilate gradient tests.** Proved result `profileGradientFree`: Under the stated assumptions, this establishes that the physical profile of an energy-space element with all moments annihilates every real-symmetric smooth annular frequency test whose value is parallel to its frequency.

### Breakdown.FracCert.DecayFixedPointParts

States the weighted integrability and test-pairing contracts used to convert the weak profile identity into a pointwise far-field fixed point.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayFixedPointParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**The far field has weighted L² size.** Proposition `FarFieldWeightedStatement`: This proposition requires that for 1<α<5/4, the far-field operator applied to the tensor square of a profile with all moments belongs to L² after multiplication by (1+‖y‖)⁻¹.

**Annular tests kill fixed-point errors.** Proposition `FixedPointAnnulusStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all moments has zero difference from its far field in pairing against every real-symmetric smooth frequency test compactly supported away from zero.

**Weak profiles have the mild pairing.** Proposition `ProfileMildFormStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Far-field pairings give the mild form.** Proposition `FarFieldPairingStatement`: This proposition requires that for 1<α<5/4, the far field of a profile tensor square with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Profiles annihilate gradient tests.** Proposition `ProfileGradientFreeStatement`: This proposition requires that the physical profile of an energy-space element with all moments annihilates every real-symmetric smooth annular frequency test whose value is parallel to its frequency.

**Far fields annihilate gradient tests.** Proposition `FarFieldGradientFreeStatement`: This proposition requires that for 1<α<5/4, the far field of a profile tensor square with all moments annihilates real-symmetric smooth annular frequency tests parallel to their frequencies.

### Breakdown.FracCert.DecayFixedPointWeight

Reconstructs an energy-space velocity gradient from its coordinate partials and applies the inverse-square estimate to obtain weighted velocity integrability.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayFixedPointWeight.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayWeightInternal`.

**The gradient assembled from partials.** Definition `gradOf`: This assembles the velocity gradient from its three energy-space coordinate partial fields as a continuous linear map at each point.

**Gradient columns are the partial fields.** Proved result `gradOf_apply`: Applying the assembled gradient to the jth coordinate vector gives the jth energy-space partial field at that point.

**The assembled gradient is measurable.** Proved result `gradOf_aesm`: Under the stated hypotheses, the assembled gradient is measurable.

**The assembled gradient has finite energy.** Proved result `gradOf_entrySq`: Under the stated hypotheses, the assembled gradient has finite energy.

**The assembled gradient is a weak one.** Proved result `gradOf_weak`: Under the stated hypotheses, the assembled gradient is the weak gradient.

**Source namespace:** `Breakdown.FracCert`.

**Energy velocities admit radial weighting.** Proved result `profileInverseWeight`: Under the stated assumptions, this establishes that the physical velocity of an energy-space element with all moments belongs to L² after multiplication by (1+‖y‖)⁻¹.

### Breakdown.FracCert.DecayHeatDiv

Proves weighted derivative bounds for projected heat-divergence convolutions by separating a compact kernel core from a differentiated far kernel.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayHeatDiv.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.DecayHeatDiv`.

**Compact kernels transfer derivatives.** Proved result `near_deriv`: Under the stated hypotheses, compact kernels transfer derivatives.

**Nearby inverse-fourth weights compare.** Proved result `shift16`: Under the stated hypotheses, nearby radii compare inverse-fourth weights.

**Far convolutions admit differentiation.** Proved result `far_deriv`: Under the stated hypotheses, far kernels differentiate under convolution.

**Exterior cutoffs rescale from radius one.** Proved result `cutoff_scale`: Under the stated hypotheses, exterior cutoffs rescale from radius one.

**Exterior cutoffs have derivative bounds.** Proved result `cutoff_deriv`: Under the stated hypotheses, exterior cutoff derivatives obey power bounds.

**Cutoff kernels have derivative bounds.** Proved result `far_kernel`: Under the stated hypotheses, cutoff kernels have far derivative bounds.

**Exterior derivatives decay integrably.** Proved result `far_kernel_qual`: Under the stated hypotheses, exterior kernel derivatives decay integrably.

**Spatial scaling cancels inverse powers.** Proved result `scale_pow`: Under the stated hypotheses, spatial scaling cancels inverse powers.

**Quotient powers separate their scales.** Proved result `div_pow_neg`: Under the stated hypotheses, quotient powers separate their scales.

**Dilation gives the cubic Jacobian.** Proved result `scale_int`: Under the stated hypotheses, dilation gives the cubic Jacobian.

**Positive dilation scales vector norms.** Proved result `norm_inv_smul`: Under the stated hypotheses, positive dilation scales vector norms.

**Far convolution tails have decay bounds.** Proved result `far_integral`: Under the stated hypotheses, far convolution tails have weighted bounds.

**Convolutions split into near and far.** Proved result `split_eq`: Under the stated hypotheses, convolutions split into near and far terms.

**The weight cancels kernel decay.** Proved result `weight_alg`: Under the stated hypotheses, the permitted weight cancels kernel decay.

**Weighted derivatives control convolution.** Proved result `conv_core`: Under the stated hypotheses, weighted derivatives control convolution.

**The coordinate embedding as a linear map.** Definition `unitMap`: This defines the continuous linear map sending a scalar to that scalar times the ith coordinate vector.

**A single heat-divergence component.** Definition `comp`: This defines one scalar component integral pairing the real projected heat-divergence kernel with the corresponding tensor entry.

**Heat divergence sums its components.** Proved result `heatDivConv_eq`: Under the stated hypotheses, heat divergence sums its components.

**Source namespace:** `Breakdown.FracCert`.

**Kernel bounds give weighted heat bounds.** Proved result `heatDivBound_of`: Under the stated assumptions, this establishes that for 1<α<5/4, 0≤β<3 and 0≤b≤β+1+j, weighted bounds A and B on a tensor and its jth derivative imply a weighted jth heat-divergence bound Ct^(−1/(2α))(A+B) for 0<t≤1.

### Breakdown.FracCert.DecayNonzero

Transfers nonzero energy-space data to a pointwise nonzero physical profile using integrability of its Fourier symbol.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayNonzero.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Nonzero energy gives a nonzero profile.** Proved result `profileNonzero_of`: Under the stated assumptions, this establishes that a nonzero energy-space element with all Fourier moments has a physical profile that is nonzero at some point.

### Breakdown.FracCert.DecayPower

Applies the homogeneous Fourier multiplier estimate to the fractional Laplacian, obtaining smoothness and the stronger spatial decay of the power term.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPower.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPowerInternal`.

**Inversion commutes with coordinates.** Proved result `inverseTransform_coord`: Under the stated hypotheses, inverse transforms commute with coordinates.

**Conjugate symmetry gives a real inverse.** Proved result `inverseTransform_real`: Under the stated hypotheses, conjugate symmetry gives a real inverse.

**L¹ symbols give inverse transforms.** Proved result `transform_of`: Under the stated hypotheses, integrable symbols give inverse transforms.

**Weighted bounds give decay bounds.** Proved result `le_of_weighted`: Under the stated hypotheses, weighted bounds give decay bounds.

**Opposite weights cancel.** Proved result `weight_cancel`: Under the stated hypotheses, opposite weights cancel.

**The power multiplier has cubic growth.** Proved result `power_le`: Under the stated hypotheses, the fractional multiplier has cubic growth.

**The power symbol is homogeneous.** Proved result `homogeneous_power`: Under the stated hypotheses, the power symbol is homogeneous.

**Source namespace:** `Breakdown.FracCert`.

**Fractional powers have stronger decay.** Proved result `powerDecay_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments and profile decay has a smooth fractional power whose jth derivative is bounded by C(1+‖y‖)^(−(4α−1+j)).

### Breakdown.FracCert.DecayPressure

Identifies the physical pressure with a decaying Fourier pressure model up to a harmonic function with vanishing gradient, obtaining decay of every pressure derivative.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressure.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressure`.

**Derivatives pair with the gradient.** Proved result `fderiv_apply_eq_inner`: Under the stated hypotheses, derivatives pair with the scalar gradient.

**Gradient norm bounds derivative norm.** Proved result `norm_fderiv_le_grad`: Under the stated hypotheses, gradient norm bounds derivative norm.

**Axial turns do not increase norms.** Proved result `norm_turn_le`: Under the stated hypotheses, axial turns do not increase norms.

**Profile decay powers compare.** Proved result `weight_facts`: Under the stated hypotheses, profile decay powers compare.

**The equation bounds pressure gradients.** Proved result `grad_bound`: Under the stated hypotheses, the equation bounds the pressure gradient.

**Source namespace:** `Breakdown.FracCert`.

**A decaying model gives pressure decay.** Proved result `pressureDecay_of_parts`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Solenoidal powers close pressure decay.** Proved result `pressureDecay_of_model`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**The pressure model gives pressure decay.** Proved result `pressureDecay_of_pressureModel`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Trace and decay give a pressure model.** Proved result `pressureModel_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a weak rotating profile with all moments and profile decay admits a smooth pressure solving ΔQ=−div(V·∇V) whose (j+1)st derivative decays at rate 4α−1+j.

**Pressure trace estimates give decay.** Proved result `pressureDecay_of_split`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Weighted products give pressure decay.** Proved result `pressureDecay_of_reduced`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Fourier formulas give pressure decay.** Proved result `pressureDecay_of_representation`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**Homogeneous bounds give pressure decay.** Proved result `pressureDecay_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a smooth pressure solving the profile equation for a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

### Breakdown.FracCert.DecayPressureDiv

Takes the divergence of the smooth rotating profile equation, cancels the solenoidal drift and fractional terms, and identifies the pressure Poisson equation.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureDiv.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressureDiv`.

**The matrix trace as a linear functional.** Definition `traceL`: This defines the matrix trace as the continuous linear functional summing the three diagonal entries.

**The trace sums diagonal entries.** Proved result `traceL_apply`: Under the stated hypotheses, the trace sums diagonal entries.

**Divergence is the derivative trace.** Proved result `div_eq`: Under the stated hypotheses, divergence is the derivative trace.

**The infinitesimal turn as a linear map.** Definition `turnL`: This defines the continuous linear map sending (x₁,x₂,x₃) to (−x₂,x₁,0).

**The spatial turn is (−x₂,x₁,0).** Proved result `turnL_eq`: The bundled spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0).

**The turn map is the axial generator.** Proved result `turnL_apply`: Under the stated hypotheses, the turn map is the axial generator.

**Trace commutes with the axial turn.** Proved result `trace_comm_turn`: Under the stated hypotheses, trace commutes with the axial turn.

**The Laplacian is gradient divergence.** Proved result `trace_eq_div_grad`: Under the stated hypotheses, the scalar Laplacian is gradient divergence.

**The residual gives pressure Laplacians.** Proved result `trace_of_residual`: Under the stated hypotheses, the residual gives the pressure Laplacian.

**Source namespace:** `Breakdown.FracCert`.

**Solenoidal powers give pressure traces.** Proved result `residualDivergence_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a weak rotating profile with all moments and profile decay, every smooth pressure satisfying the profile residual equation also satisfies ΔP=−div(V·∇V).

**Fractional powers remain divergence free.** Proved result `powerDivergenceFree_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the fractional power of a weak rotating profile with all moments and profile decay has zero classical divergence.

### Breakdown.FracCert.DecayPressureModel

Obtains the derivative decay of the Fourier-defined pressure by applying the degree-zero multiplier estimate to weighted velocity products.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureModel.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressureModel`.

**Pressure multipliers have degree zero.** Proved result `multiplier_homogeneous`: Under the stated hypotheses, pressure multipliers have degree zero.

**Homogeneous bounds give pressure decay.** Proved result `modelPressureDecay_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the Fourier pressure of a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

### Breakdown.FracCert.DecayPressureParts

Defines the pressure multiplier and the representation, Poisson, decay and harmonic-uniqueness contracts used in pressure regularity.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**A smooth decaying pressure model exists.** Proposition `PressureModelStatement`: This proposition requires that for 1<α<5/4, a weak rotating profile with all moments and profile decay admits a smooth pressure solving ΔQ=−div(V·∇V) whose (j+1)st derivative decays at rate 4α−1+j.

**Model pressure satisfies Poisson.** Proposition `PressureTraceStatement`: This proposition requires that for 1<α<5/4, the Fourier pressure of a weak rotating profile with all moments and profile decay satisfies ΔP=−div(V·∇V) pointwise.

**Model pressure derivatives have decay.** Proposition `ModelPressureDecayStatement`: This proposition requires that for 1<α<5/4, the Fourier pressure of a weak rotating profile with all moments and profile decay has its (j+1)st derivative bounded by C(1+‖y‖)^(−(4α−1+j)).

**The pressure Fourier multiplier.** Definition `pressureMultiplier`: This defines the degree-zero pressure multiplier −ξᵢξⱼ/‖ξ‖², viewed as a complex scalar.

**Velocity products have weighted bounds.** Proposition `ProductWeightedSmoothStatement`: This proposition requires that for 1<α<5/4, each coordinate product of a weak rotating profile with all moments and profile decay is weighted smooth with base decay exponent 4α−2.

**Pressure is a sum of Fourier multipliers.** Proposition `PressureRepresentationStatement`: This proposition requires that for 1<α<5/4 and a weak rotating profile with all moments and profile decay, its coordinate velocity products have Fourier transforms whose pressure-multiplier products have all L¹ moments and whose inverse transforms sum in real part to the pressure.

**The profile pressure satisfies Poisson.** Proposition `ResidualDivergenceStatement`: This proposition requires that for 1<α<5/4 and a weak rotating profile with all moments and profile decay, every smooth pressure satisfying the profile residual equation also satisfies ΔP=−div(V·∇V).

**Fractional powers are divergence free.** Proposition `PowerDivergenceFreeStatement`: This proposition requires that for 1<α<5/4, the fractional power of a weak rotating profile with all moments and profile decay has zero classical divergence.

**Decaying harmonic gradients vanish.** Proposition `DecayingGradientVanishesStatement`: This proposition requires that an infinitely differentiable harmonic scalar function whose gradient is bounded by K(1+‖y‖)^(−s) for some s>0 has zero gradient everywhere.

### Breakdown.FracCert.DecayPressureRep

Relates the convolution-defined profile pressure to bounded measurable degree-zero multipliers acting on Fourier transforms of velocity products.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureRep.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressureRep`.

**Pressure multiplier norms are ≤1.** Proved result `multiplier_norm_le`: Under the stated hypotheses, pressure multipliers have norm at most one.

**Pressure multipliers are measurable.** Proved result `multiplier_measurable`: Under the stated hypotheses, pressure multipliers are measurable.

**Pressure has its Fourier representation.** Proved result `pressureRepresentation_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a weak rotating profile with all moments and profile decay, its coordinate velocity products have Fourier transforms whose pressure-multiplier products have all L¹ moments and whose inverse transforms sum in real part to the pressure.

### Breakdown.FracCert.DecayPressureTrace

Proves the pressure model Poisson identity from its Fourier representation and transfers profile derivative decay to every velocity product.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureTrace.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressureTrace`.

**Coordinate squares give the norm².** Proved result `sum_sq_coord`: Under the stated hypotheses, coordinate squares sum to the squared norm.

**Divergence preserves sums.** Proved result `divergenceAt_add'`: Under the stated hypotheses, divergence preserves sums.

**The model has the required trace.** Proved result `pressureTrace_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the Fourier pressure of a weak rotating profile with all moments and profile decay satisfies ΔP=−div(V·∇V) pointwise.

**Profile products are weighted smooth.** Proved result `productWeightedSmooth_of`: Under the stated assumptions, this establishes that for 1<α<5/4, each coordinate product of a weak rotating profile with all moments and profile decay is weighted smooth with base decay exponent 4α−2.

### Breakdown.FracCert.DecayPressureVanish

Proves the harmonic uniqueness step for pressure by a maximum-principle argument applied to directional derivatives that decay at infinity.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayPressureVanish.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayPressureVanish`.

**Local maxima have nonpositive Hessians.** Proved result `second_le_of_localMax`: Under the stated hypotheses, local maxima have nonpositive Hessians.

**Local maxima have nonpositive Laplacians.** Proved result `trace_le_of_localMax`: Under the stated hypotheses, local maxima have nonpositive Laplacians.

**The Laplacian of ε‖x‖² is 6ε.** Proved result `trace_quadratic`: Under the stated hypotheses, quadratic Laplacians equal six times scale.

**Harmonic upper decay gives a sign.** Proved result `nonpos_of_decay`: Under the stated hypotheses, harmonic upper decay forces nonpositivity.

**Harmonic derivatives remain harmonic.** Proved result `dir_harmonic`: Under the stated hypotheses, derivatives of harmonic fields are harmonic.

**Decaying harmonic gradients vanish.** Proved result `decayingGradientVanishes`: Under the stated assumptions, this establishes that an infinitely differentiable harmonic scalar function whose gradient is bounded by K(1+‖y‖)^(−s) for some s>0 has zero gradient everywhere.

### Breakdown.FracCert.DecayStep

Bootstraps the base velocity decay to the expected decay of every spatial derivative through the tensor-square fixed-point equation.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/DecayStep.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.DecayStep.Internal`.

**The tensor product as a bilinear map.** Definition `pairMap`: This defines the continuous bilinear map sending two vectors to the tensor with entries vᵢwₖ.

**The tensor map has norm at most one.** Proved result `norm_pairMap_le`: Under the stated hypotheses, the tensor map has norm at most one.

**Tensor squares are bilinear evaluations.** Proved result `tensorSq_eq`: Under the stated hypotheses, tensor squares are bilinear evaluations.

**Product decay weights add.** Proved result `prod_weight`: Under the stated hypotheses, product decay weights add.

**Decay bounds become weighted bounds.** Proved result `weight_of`: Under the stated hypotheses, decay bounds become weighted bounds.

**Weighted bounds become decay bounds.** Proved result `unweight_of`: Under the stated hypotheses, weighted bounds become decay bounds.

**Lower derivatives give the next decay.** Proved result `decay_core`: Under the stated hypotheses, lower derivative decay gives the next rate.

**Source namespace:** `Breakdown.FracCert`.

**Profile derivatives gain decay.** Proved result `profileDecayStep_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the expected decay bounds on all lower derivatives of a weak rotating profile with all moments imply the jth derivative bound C(1+‖y‖)^(−(2α−1+j)).

### Breakdown.FracCert.DefectRightSide

Verifies the L² and symmetry properties needed to use the profile defect and correction convection as a right-hand side for the held contraction.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/DefectRightSide.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Compatible symmetries retain the defect.** Proved result `defect_at`: Under the stated hypotheses, compatible symmetries preserve the defect.

**Compatible symmetries retain the forcing.** Proved result `rhs_at`: Under the stated hypotheses, compatible symmetries preserve the forcing.

**Profile self-convection belongs to L².** Proved result `quad_memLp`: Under the stated hypotheses, profile self-convection belongs to L².

**The defect gives admissible forcing.** Proved result `defectRightSide`: Under the stated assumptions, this establishes that a valid fractional certificate makes its defect square integrable and makes minus that defect minus the correction convection an admissible symmetry-class forcing.

### Breakdown.FracCert.Defs

Defines the fractional certificate language: weak derivatives, symmetry and gradient spaces, weighted energies, projected residuals, bordered operators and the scalar bounds used in validation.

This belongs to the fractional analogue of the paper §7 certificate strategy; it supplies definitions, quantitative inverse bounds or the held-solution bridge, while its fractional conclusions are outside the ordinary-dissipation argument claimed in the paper.

Source: `lean/Breakdown/FracCert/Defs.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**The squared matrix-entry norm.** Definition `entrySq`: This defines the squared matrix-entry norm by summing ‖G(eᵢ)‖² over the three coordinate vectors.

**The matrix-entry inner product.** Definition `entryInner`: This defines the matrix-entry inner product by summing the inner products of corresponding columns.

**The trace of second derivatives.** Definition `secondTrace`: This defines the vector-valued second trace by summing H(eⱼ,eⱼ) over the three coordinate directions.

**The discrete axial turn.** Definition `turnStep`: This defines axial rotation through angle 2π/m, leaving the third coordinate fixed.

**Reflection of the third coordinate.** Definition `mirror`: This defines reflection by retaining the first two coordinates and negating the third.

**The equivariant vector-field class.** Definition `IsClassField`: This predicate requires a vector field to commute almost everywhere with the discrete axial turn and with reflection.

**The invariant scalar-field class.** Definition `IsClassScalar`: This predicate requires a scalar field to be pointwise invariant under the discrete axial turn and reflection.

**Smooth compact vector tests.** Definition `IsTestVectorField`: This predicate requires a vector test field to be infinitely differentiable and compactly supported.

**Smooth compact scalar tests.** Definition `IsTestScalar`: This predicate requires a scalar test function to be infinitely differentiable and compactly supported.

**The weak gradient identity.** Definition `IsWeakGradientOf`: This predicate specifies G as the weak gradient of v through integration by parts against every compact smooth scalar test in each coordinate direction.

**The weak second-derivative identity.** Definition `IsWeakSecondDerivOf`: This predicate specifies H as the weak derivative of G through coordinatewise integration by parts against compact smooth scalar tests.

**Integrability on every compact set.** Definition `IsLocalSquareIntegrable`: This predicate requires the supplied scalar function to be integrable on every compact set.

**Locally L² gradient fields.** Definition `IsGradientField`: This predicate requires a measurable vector field with locally integrable squared norm and a potential with locally integrable square satisfying the scalar weak-gradient identities.

**Square-integrable solenoidal fields.** Definition `IsSolenoidalL2`: This predicate requires a vector field to belong to L² and to annihilate the gradients of all compact smooth scalar tests.

**The integral L² norm.** Definition `l2Norm`: This defines the integral L² size as the square root of ∫‖F(y)‖² dy.

**The integral L² pairing.** Definition `l2Pair`: This defines the real integral pairing ∫⟨F(y),E(y)⟩ dy.

**The gradient-quotient residual norm.** Definition `projectedNorm`: This defines the projected residual norm as the infimum of the L² norms of F+Q over weak gradient fields Q for which F+Q belongs to L².

**A second-order solenoidal symmetry field.** Structure `IsSecondOrderField`: This proposition bundles measurable velocity and derivative fields, L⁶ velocity, finite gradient and full Hessian energies, the two weak-derivative identities, almost-everywhere zero divergence and the discrete rotation and reflection symmetry.

**The weak fractional-power identity.** Definition `IsWeakFractionalPower`: This predicate requires P to belong to L² and to represent the fractional power of v by transferring the fractional operator to every compact smooth vector test.

**The rotating self-similar drift.** Definition `driftField`: This defines the rotating self-similar drift (1−1/(2α))v+G(y)/(2α)+a(G(Jy)−Jv).

**The weighted derivative energy.** Definition `weightedEnergy`: This defines weighted derivative energy as the squared L² norm of the second trace plus the integral of the weight times the squared matrix-entry norm of G.

**The energy and multiplier size.** Definition `sizeNorm`: This defines the correction size as the square root of weighted derivative energy plus μ² times the squared Euclidean norm of the multiplier vector.

**The gradient pin functional.** Definition `pinValue`: This defines a pin functional by the integral matrix-entry pairing of the correction gradient with the supplied pin field.

**The coefficient vector norm.** Definition `vecNorm`: This defines the coefficient-vector norm as the square root of the sum of its squared entries.

**The symmetric convection product.** Definition `symProduct`: This defines the symmetric convection product as one half of G(W)+DW(v).

**The weighted residual row size.** Definition `rowSize`: This defines the residual row size as the square root of the weighted sum of squared pairings with the finite row fields.

**The row size modulo gradients.** Definition `rowSeminorm`: This defines the row seminorm modulo gradients as the infimum of the row sizes of F+Q over weak gradient fields Q.

**The scalar inverse-bound function.** Definition `boundConst`: This defines the explicit quadratic-root inverse bound from the form scale, contraction factor, coercivity gap, pin weight and three residual sizes.

**The small quadratic solution radius.** Definition `radiusOf`: This defines the smaller quadratic solution radius in its rationalized form 2ρ/(1+√(1−4KNLρ)).

**The coordinate parameter box.** Definition `box`: This defines the parameter box by the coordinate bounds |pᵢ|≤radᵢ.

**The negative second trace.** Definition `negSecondTrace`: This defines the negative second trace by negating the sum of the three diagonal second derivatives.

**Source namespace:** `Breakdown.SteadyCert.FracCertData`.

**The approximate profile gradient.** Definition `gradProfile`: This defines the approximate profile gradient as the Fréchet derivative of the parameterized profile.

**The local bordered operator.** Definition `localField`: This defines the local bordered operator as drift minus the split viscosity times the second trace, plus twice the symmetric profile-correction convection and the actuator combination.

**The fractional splitting correction.** Definition `splitField`: This defines the fractional splitting correction as the weak fractional power plus the split viscosity times the second trace.

**The certificate derivative energy.** Definition `energy`: This specializes the weighted derivative energy to the certificate's weight.

**The certificate correction size.** Definition `size`: This specializes the correction size to the certificate's weight and multiplier scale.

**The nonnegative splitting energy.** Definition `splitEnergy`: This defines the square root of the splitting pairing against the negative trace plus reduced coercivity times the trace energy and minimum-weight gradient energy.

**The certificate pin vector.** Definition `pins`: This defines the finite pin vector by pairing the correction gradient with each certificate pin field.

**The approximate profile defect.** Definition `defect`: This defines the profile defect as the approximate profile drift, fractional power, self-convection and multiplier-weighted actuator sum.

**The certificate residual row size.** Definition `rows`: This specializes the weighted row size to the certificate's row fields and row weights.

**The certificate rows modulo gradients.** Definition `rowsModGrad`: This specializes the row seminorm modulo gradients to the certificate's row fields and weights.

**The remaining coercivity gap.** Definition `reducedGap`: This defines the coercivity gap remaining after subtracting the low-frequency loss from reduced coercivity.

**The scalar contraction factor.** Definition `contraction`: This defines the contraction factor from the split bound, row loss, pin loss, pin weight and remaining coercivity gap through the displayed square-root expression.

**The certificate inverse-bound function.** Definition `boundFn`: This specializes the explicit inverse-bound function to the certificate's form scale, contraction, coercivity gap and pin weight.

**The residual-to-size constant.** Definition `rowConst`: This defines the residual-to-size constant by evaluating the inverse-bound function at residual norm one, row input √rowMax and zero pin input.

**The certified held radius.** Definition `heldRadius`: This defines the held radius by applying the quadratic radius formula to the residual-to-size constant, nonlinear product constant and defect size bound.

**The active and stiff test region.** Definition `testBox`: This defines the held test region from the active coordinate set, coordinate radii, slopes and stiff ellipsoid radius.

**The actuator-adjoint frame error.** Definition `adjointError`: This defines the actuator-adjoint error vector by subtracting the chosen frame column from the actuator pairings with the jth adjoint field.

**The slope-adjusted multiplier error.** Definition `adjustedMultiplier`: This defines the transformed multiplier error after subtracting both the defect pairing with the jth adjoint and the expected slope times parameter coordinate.

**A fractional certificate exists.** Proposition. For an exponent α, some certificate data satisfy the fractional certificate conditions. ([`FracCertificateHypothesis`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/Defs.lean#L327))

**Fractional certificate conditions.** Structure. The fractional certificate conditions on certificate data for an exponent α: polynomial order at least 3, a coercivity constant between zero and the split viscosity, a positive pin weight, row maximum and multiplier scale, a measurable weight in the symmetry class bounded between positive constants, nonnegative radii, nonzero slopes, an ellipsoid radius bounded by the inactive slopes, and a frame that distorts lengths by a factor less than one. ([`IsFracCert`](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/FracCert/Defs.lean#L223))

### Breakdown.FracCert.DriftEnergy

Proves the drift-gradient energy identity by a localized divergence calculation and removal of radial cutoffs with controlled boundary terms.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftEnergy.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Axial turns do not increase norms.** Proved result `norm_axialTurn_le`: Under the stated hypotheses, axial turns do not increase norms. Source: `Breakdown.FracCert.DriftEnergy:13`.

**The axial turn is continuous.** Proved result `continuous_axialTurn`: Under the stated hypotheses, the axial turn is continuous.

**Coordinate unit vectors have norm one.** Proved result `norm_unitVector`: Under the stated hypotheses, coordinate unit vectors have norm one.

**Cutoff derivatives vanish far away.** Proved result `fderiv_cutoff_far`: Under the stated hypotheses, cutoff derivatives vanish far away.

**Cutoff derivatives vanish near zero.** Proved result `fderiv_cutoff_near`: Under the stated hypotheses, cutoff derivatives vanish near zero.

**Radial cutoffs have uniform bounds.** Proved result `cutoff_bounds`: Under the stated hypotheses, radial cutoff derivatives have uniform bounds.

**Hessian entries are measurable.** Proved result `aesm_apply_second`: Under the stated hypotheses, hessian entries are measurable.

**Gradient columns are measurable.** Proved result `aesm_apply_first`: Under the stated hypotheses, gradient columns are measurable.

**The negative second trace belongs to L².** Proved result `memLp_negSecondTrace`: Under the stated hypotheses, the negative second trace belongs to L².

**The drift boundary is energy controlled.** Proved result `boundary_bound`: Under the stated hypotheses, the drift boundary is energy controlled.

**The spatial turn is (−x₂,x₁,0).** Proved result `axialTurn_eq`: The axial generator sends (x₁,x₂,x₃) to (−x₂,x₁,0).

**The axial turn is smooth.** Proved result `contDiff_axialTurn`: Under the stated hypotheses, the axial turn is smooth. Source: `Breakdown.FracCert.DriftEnergy:153`.

**Smooth inputs give a smooth drift flux.** Proved result `contDiff_driftFlux`: Under the stated hypotheses, smooth inputs give a smooth drift flux.

**Compact derivatives integrate to zero.** Proved result `integral_fderiv_eq_zero`: Under the stated hypotheses, compact derivatives integrate to zero.

**A compact factor gives compact support.** Proved result `compactSupport_of_factor`: Under the stated hypotheses, a compact factor gives compact support.

**Divergence gives the local identity.** Proved result `driftLocalSmooth_of`: Under the stated assumptions, this establishes that for a smooth velocity and compact smooth cutoff, the localized drift-trace pairing equals (1−3/(4α)) times the localized gradient energy plus the boundary integral.

**The axial turn as a linear map.** Definition `turnMap`: This defines the infinitesimal axial turn as a continuous linear map on spatial vectors.

**The spatial turn is (−x₂,x₁,0).** Proved result `turnMap_eq`: The continuous spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator.

**Coordinates reconstruct each vector.** Proved result `expand_vec`: Under the stated hypotheses, coordinates reconstruct each vector.

**The turn map acts on the basis.** Proved result `turnMap_units`: Under the stated hypotheses, the turn map acts on the basis.

**Coordinates reconstruct the turn map.** Proved result `turnMap_expand`: Under the stated hypotheses, coordinates reconstruct the turn map.

**Drift flux has the energy divergence.** Proved result `driftDivergence`: Under the stated assumptions, this establishes that for smooth velocity and cutoff, the divergence of the defined flux equals the localized drift-trace pairing density minus (1−3/(4α)) times the gradient-energy density and minus the boundary density.

**Smooth limits give the local identity.** Proved result `driftLocal_of`: Under the stated assumptions, this establishes that for any second-order field and compact smooth cutoff, the cutoff pairing of drift with the negative second trace equals (1−3/(4α)) times the cutoff gradient energy plus the explicitly defined boundary integral.

**Local identities give drift energy.** Proved result `driftEnergy_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and an L² drift, its pairing with the negative second trace of a second-order field equals (1−3/(4α)) times the gradient energy.

**Drift pairing equals gradient energy.** Proved result `driftEnergy`: Under the stated assumptions, this establishes that for 1<α<5/4 and an L² drift, its pairing with the negative second trace of a second-order field equals (1−3/(4α)) times the gradient energy.

### Breakdown.FracCert.DriftEnergyLocal

Proves the local weak drift identity by mollifying the velocity and its weak derivatives, organizing convergence of L² factors and compactly weighted integrals.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftEnergyLocal.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**The cutoff drift boundary term.** Definition `driftBoundary`: This defines the cutoff boundary term as the sum of cutoff-gradient pairings between drift and gradient columns, minus one half of the cutoff derivative along the spatial drift times gradient energy density.

**The localized drift energy identity.** Proposition `DriftLocalStatement`: This proposition requires that for any second-order field and compact smooth cutoff, the cutoff pairing of drift with the negative second trace equals (1−3/(4α)) times the cutoff gradient energy plus the explicitly defined boundary integral.

**The smooth localized drift identity.** Proposition `DriftLocalSmoothStatement`: This proposition requires that for a smooth velocity and compact smooth cutoff, the localized drift-trace pairing equals (1−3/(4α)) times the localized gradient energy plus the boundary integral.

**Smooth fields approximate drift data.** Proposition `DriftLocalApproxStatement`: This proposition requires that every second-order field and compact smooth cutoff admit smooth approximations for which the localized drift-trace pairing, gradient energy and boundary integral all converge to their weak-field counterparts.

**The localized drift flux.** Definition `driftFlux`: This defines the ith localized flux as the cutoff times minus the drift-gradient-column pairing plus one half of the ith spatial drift coefficient times gradient energy density.

**Drift flux has the energy divergence.** Proposition `DriftDivergenceStatement`: This proposition requires that for smooth velocity and cutoff, the divergence of the defined flux equals the localized drift-trace pairing density minus (1−3/(4α)) times the gradient-energy density and minus the boundary density.

**A shrinking smooth averaging bump.** Definition `approxBump`: This defines a smooth bump centered at zero with inner radius 1/(2(n+1)) and outer radius 1/(n+1).

**Convolution with the normalized bump.** Definition `smoothen`: This defines smoothing by convolution with the normalized shrinking bump.

**Bump radii are at most one.** Proved result `approxBump_rOut_le`: Under the stated hypotheses, bump radii are at most one.

**Bump radii tend to zero.** Proved result `approxBump_rOut_tendsto`: Under the stated hypotheses, bump radii tend to zero.

**Mollification gives smooth fields.** Proved result `smoothen_contDiff`: Under the stated hypotheses, mollification gives smooth fields.

**Mollifiers commute with weak derivatives.** Proved result `smoothen_partial`: Under the stated hypotheses, mollification commutes with weak derivatives.

**The normalized bump has unit mass.** Proved result `approxBump_lintegral`: Under the stated hypotheses, the normalized bump has unit mass.

**Mollifiers do not increase L² energy.** Proved result `smoothen_sq_le`: Under the stated hypotheses, mollification does not increase L² energy.

**L² seminorm² equals the square integral.** Proved result `eLpNorm_two_sq_space`: Under the stated hypotheses, squared L² seminorms equal squared integrals.

**Zero square-mass limit gives norm decay.** Proved result `eLpNorm_tendsto_of_sq_space`: Under the stated hypotheses, vanishing squared mass gives vanishing norm.

**Mollification contracts L² differences.** Proved result `smoothen_sub_eLpNorm_le`: Under the stated hypotheses, mollification contracts L² differences.

**Compact continuous fields recover in L².** Proved result `smoothen_sq_tendsto_of_continuous`: Under the stated hypotheses, compact continuous fields recover in L².

**Mollifiers recover L² fields.** Proved result `smoothen_eLpNorm_tendsto`: Under the stated hypotheses, mollifiers recover L² fields.

**Mollifiers recover fields locally in L².** Proved result `smoothen_local_tendsto`: Under the stated hypotheses, mollifiers recover fields locally in L².

**Strong L² convergence on a fixed set.** Definition `SqLim`: This predicate requires every sequence member and its proposed limit to lie in L² on K and the L² seminorm of their differences to tend to zero.

**Continuous fields are locally L².** Proved result `memLp_restrict_of_continuous`: Under the stated hypotheses, continuous fields are locally L².

**Mollifiers converge on compact sets.** Proved result `smoothen`: Under the stated hypotheses, mollifiers converge on compact sets.

**Equal fields retain strong L² limits.** Proved result `congr`: Under the stated hypotheses, equal fields retain strong L² convergence.

**Strong L² convergence respects sums.** Proved result `add`: Under the stated hypotheses, strong L² convergence respects sums.

**Pointwise errors transfer L² limits.** Proved result `of_le`: Under the stated hypotheses, pointwise error bounds transfer L² limits.

**Continuous weights retain L² limits.** Proved result `smul_fun`: Under the stated hypotheses, continuous weights preserve local L² limits.

**Linear maps preserve strong L² limits.** Proved result `clm`: Under the stated hypotheses, linear maps preserve strong L² limits.

**Negation preserves strong L² limits.** Proved result `neg`: Under the stated hypotheses, negation preserves strong L² limits.

**Differences preserve strong L² limits.** Proved result `sub`: Under the stated hypotheses, differences preserve strong L² limits.

**Three strong L² limits may be summed.** Proved result `sum3`: Under the stated hypotheses, three strong L² limits may be summed.

**Strong L² pairings converge.** Proved result `tendsto_inner`: Under the stated hypotheses, strong L² pairs have convergent integrals.

**Local L² fields pair integrably.** Proved result `integrableOn_inner`: Under the stated hypotheses, local L² fields pair integrably.

**Convergence of scalar integrals.** Definition `IntLim`: This predicate requires integrability of every scalar integrand and its proposed limit, together with convergence of the real integrals.

**Equal integrands retain integral limits.** Proved result `congr`: Under the stated hypotheses, equal integrands retain integral convergence.

**Integral convergence respects sums.** Proved result `add`: Under the stated hypotheses, integral convergence respects sums.

**Integral limits respect differences.** Proved result `sub`: Under the stated hypotheses, integral convergence respects differences.

**Three integral limits may be summed.** Proved result `sum3`: Under the stated hypotheses, three integral limits may be summed.

**Compact weighted pairings pass to limits.** Proved result `base`: Under the stated hypotheses, compact weighted pairings pass to limits.

**Basis vectors reconstruct linear maps.** Proved result `clm_expand`: Under the stated hypotheses, basis vectors reconstruct linear maps.

**The axial turn as a linear map.** Definition `turnMap`: This equips the infinitesimal axial turn with its continuous linear map structure. Source: `Breakdown.FracCert.DriftEnergyLocal:509`.

**The spatial turn is (−x₂,x₁,0).** Proved result `turnMap_apply`: The continuous spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator. Source: `Breakdown.FracCert.DriftEnergyLocal:519`.

**Coordinate functions are continuous.** Proved result `coord_continuous`: Under the stated hypotheses, coordinate functions are continuous.

**The drift from gradient columns.** Definition `driftOf`: This defines the rotating drift from the velocity vector and three gradient columns through their coordinate expansions.

**Gradient columns recover the drift field.** Proved result `driftField_eq`: Under the stated hypotheses, gradient columns recover the drift field.

**Local L² limits preserve the drift.** Proved result `driftOf`: Under the stated hypotheses, local L² limits preserve the drift.

**Matrix energy is a sum of column pairs.** Proved result `mul_entrySq_eq`: Under the stated hypotheses, matrix energy splits into column pairings.

**Boundary terms split into column pairs.** Proved result `driftBoundary_eq`: Under the stated hypotheses, boundary terms split into column pairings.

**Smooth limits preserve drift integrals.** Proved result `driftLocalApprox`: Under the stated assumptions, this establishes that every second-order field and compact smooth cutoff admit smooth approximations for which the localized drift-trace pairing, gradient energy and boundary integral all converge to their weak-field counterparts.

### Breakdown.FracCert.DriftPower

Derives the mixed drift and fractional-power identity from weak frequency transport and the weighted flow pairing, with the required Fourier integrability.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftPower.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**The frequency drift-power identity.** Proposition `DriftPairSymbolStatement`: This proposition requires that for 1<α<5/4 and the stated L² weighted-symbol assumptions, the drift-symbol pairing with (2π‖ξ‖)^(2α−2) times the second symbol equals (3/2−5/(4α)) times its (2α−4)-weighted squared integral.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftPower`.

**Intermediate weights have two bounds.** Proved result `freqPow_le`: Under the stated hypotheses, intermediate weights lie between two bounds.

**Radial frequency powers are measurable.** Proved result `measurable_freqPow`: Under the stated hypotheses, radial frequency powers are measurable.

**Endpoint energies control middle weights.** Proved result `integrable_weighted`: Under the stated hypotheses, endpoint energies control intermediate weights.

**The L² representative equals its field.** Proved result `toLpOrZero_ae'`: Under the stated hypotheses, the L² representative equals its field.

**Fourier transform preserves L² pairings.** Proved result `l2Pair_eq`: Under the stated hypotheses, Fourier transform preserves L² pairings.

**Source namespace:** `Breakdown.SteadyCert`.

**Fourier identities give mixed energy.** Proved result `driftPower_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the pairing of an L² drift with the weak fractional power equals (3/2−5/(4α)) times the integral of (2π‖ξ‖)^(2α−4) times the squared negative-second-trace symbol, and that integral is finite.

**The infinitesimal frequency turn.** Definition `freqTurn`: This defines the infinitesimal turn on complex vectors by (z₁,z₂,z₃) ↦ (−z₂,z₁,0).

**Smooth frequency tests away from zero.** Definition `IsFreqTest`: This predicate requires an infinitely differentiable, compactly supported frequency test whose closed support avoids zero.

**The frequency flow adjoint.** Definition `flowAdjoint`: This defines the frequency flow adjoint as (1−1/(2α))ψ+Dψ(ξ)/(2α)−aDψ(Jξ)+aJψ.

**The weak Fourier drift identity.** Proposition `DriftSymbolWeakStatement`: This proposition requires that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

**Weak flow derivatives give energy.** Proposition `FlowPairingStatement`: This proposition requires that for 1<α<5/4, an L² weak flow derivative D of a field h with its first and 2α frequency weights in L² satisfies the identity ∫⟨D,(2π‖ξ‖)^(2α)h⟩=(3/2−5/(4α))∫(2π‖ξ‖)^(2α)‖h‖².

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftPower`.

**Frequency powers multiply by adding.** Proved result `freqPow_mul`: Under the stated hypotheses, frequency exponents add under multiplication.

**Inversion negates frequency exponents.** Proved result `freqPow_inv`: Under the stated hypotheses, inverting frequency powers negates exponents.

**Frequency powers are nonnegative.** Proved result `freqPow_nonneg`: Under the stated hypotheses, frequency powers are nonnegative.

**Almost every frequency is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every frequency is nonzero. Source: `Breakdown.FracCert.DriftPower:137`.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak drift and flow give the pairing.** Proved result `driftPairSymbol_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and the stated L² weighted-symbol assumptions, the drift-symbol pairing with (2π‖ξ‖)^(2α−2) times the second symbol equals (3/2−5/(4α)) times its (2α−4)-weighted squared integral.

### Breakdown.FracCert.DriftPowerSolenoidal

Shows that both the rotating drift and weak fractional power annihilate compact gradient tests, yielding a solenoidal free residual.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftPowerSolenoidal.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.DriftPowerSolenoidalInternal`.

**Basis pairings give vector coordinates.** Proved result `unit_inner`: Under the stated hypotheses, basis pairings recover vector coordinates.

**Reversed pairings give coordinates.** Proved result `unit_inner'`: Under the stated hypotheses, reversed basis pairings recover coordinates.

**Second-order velocities are locally L¹.** Proved result `locInt_velocity`: Under the stated hypotheses, second-order velocities are locally integrable.

**Gradient columns belong to L².** Proved result `memLp_col`: Under the stated hypotheses, gradient columns belong to L².

**Gradient columns are locally integrable.** Proved result `locInt_col`: Under the stated hypotheses, gradient columns are locally integrable.

**Compact weights give integrable pairs.** Proved result `integrable_pair`: Under the stated hypotheses, compact scalar weights give integrable pairs.

**Weak gradients give coordinate pairings.** Proved result `weak_pair`: Under the stated hypotheses, weak gradients give coordinate pairings.

**The velocity annihilates gradients.** Proved result `weak_div`: Under the stated hypotheses, the velocity annihilates scalar gradients.

**Basis vectors reconstruct each vector.** Proved result `basis_sum`: Under the stated hypotheses, basis vectors reconstruct each vector.

**Gradients give directional derivatives.** Proved result `grad_inner`: Under the stated hypotheses, gradient pairings are directional derivatives.

**Smooth derivatives are differentiable.** Proved result `diff_fderiv`: Under the stated hypotheses, smooth derivatives are differentiable.

**Smooth second derivatives commute.** Proved result `symm2`: Under the stated hypotheses, smooth second derivatives commute.

**A coefficient-weighted derivative test.** Definition `coef`: This defines the scalar coefficient test (My)ⱼ times the ith coordinate derivative of the scalar test.

**A derivative along the linear flow.** Definition `flowTest`: This defines the scalar test obtained by differentiating φ along the linear vector field My.

**Linear coordinates have their derivative.** Proved result `coord_hasFDerivAt`: Under the stated hypotheses, linear coordinates have their derivative.

**Coefficient tests retain smooth support.** Proved result `test_coef`: Under the stated hypotheses, coefficient tests retain compact smoothness.

**Flow tests retain compact smoothness.** Proved result `test_flow`: Under the stated hypotheses, flow tests retain compact smoothness.

**Coefficient tests obey the product rule.** Proved result `deriv_coef`: Under the stated hypotheses, coefficient tests obey the product rule.

**Flow tests obey the chain rule.** Proved result `deriv_flow`: Under the stated hypotheses, flow tests obey the chain rule.

**Matrix actions expand in coefficients.** Proved result `expand_left`: Under the stated hypotheses, matrix actions expand in test coefficients.

**Linear functionals expand in coordinates.** Proved result `lin_expand`: Under the stated hypotheses, linear functionals expand in coordinates.

**Coefficient derivatives give divergence.** Proved result `pointwise_flow`: Under the stated hypotheses, coefficient derivatives give flow divergence.

**Solenoidality transfers a linear flow.** Proved result `flow_identity`: Under the stated hypotheses, solenoidality transfers a linear flow.

**Gradient-flow pairings are integrable.** Proved result `int_left`: Under the stated hypotheses, gradient-flow pairings are integrable.

**Velocity-flow pairings are integrable.** Proved result `int_right`: Under the stated hypotheses, velocity-flow pairings are integrable.

**The axial turn as a linear map.** Definition `turnMap`: This equips the infinitesimal axial turn with its continuous linear map structure. Source: `Breakdown.FracCert.DriftPowerSolenoidal:283`.

**The spatial turn is (−x₂,x₁,0).** Proved result `turnMap_apply`: The continuous spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator. Source: `Breakdown.FracCert.DriftPowerSolenoidal:296`.

**Local L¹ fields pair with compact tests.** Proved result `integrable_inner_cpt`: Under the stated hypotheses, local integrability pairs with compact tests.

**Smooth scalar gradients are smooth.** Proved result `grad_smooth`: Under the stated hypotheses, smooth scalar gradients are smooth.

**Gradient support remains compact.** Proved result `grad_support`: Under the stated hypotheses, gradient support remains compact.

**Velocity-gradient pairs are integrable.** Proved result `integrable_div`: Under the stated hypotheses, velocity-gradient pairings are integrable.

**Drift annihilates compact gradients.** Proved result `drift_zero`: Under the stated hypotheses, drift annihilates compact gradients.

**Directional derivatives differentiate.** Proved result `dapp`: Under the stated hypotheses, directional derivatives commute with differentiation.

**Derivatives commute with gradients.** Proved result `grad_fderiv`: Under the stated hypotheses, differentiation commutes with the gradient.

**Gradient remainders split into gradients.** Proved result `remainder_grad`: Under the stated hypotheses, gradient remainders split into gradients.

**Translations preserve scalar tests.** Proved result `test_shift`: Under the stated hypotheses, translations preserve scalar tests.

**Directional derivatives preserve tests.** Proved result `test_dir`: Under the stated hypotheses, directional derivatives preserve scalar tests.

**Solenoidal fields kill gradient errors.** Proved result `slice_zero`: Under the stated hypotheses, solenoidal velocities kill gradient remainders.

**Far remainders have quadratic growth.** Proved result `far_bound`: Under the stated hypotheses, far Taylor remainders have quadratic growth.

**Remainders vanish outside larger support.** Proved result `zero_far`: Under the stated hypotheses, remainders vanish beyond enlarged support.

**Taylor remainders are jointly continuous.** Proved result `cont_pair`: Under the stated hypotheses, taylor remainders are jointly continuous.

**Fixed-shift remainders are continuous.** Proved result `cont_slice`: Under the stated hypotheses, fixed-shift remainders are continuous.

**A mixed product has power bounds.** Proved result `mul_le_pow_six`: Under the stated hypotheses, a mixed product has power bounds.

**Translated tests have uniform bounds.** Proved result `translate_bound`: Under the stated hypotheses, translated tests have uniform pairing bounds.

**Local and far powers give integrability.** Proved result `near_far`: Under the stated hypotheses, local and far powers give integrability.

**Natural and real powers combine.** Proved result `rpow_pow_add`: Under the stated hypotheses, natural and real powers combine.

**Fractional remainders pair integrably.** Proved result `prod_integrable`: Under the stated hypotheses, fractional remainders pair integrably.

**Velocities kill fractional gradients.** Proved result `power_zero`: Under the stated hypotheses, velocities annihilate fractional gradient tests.

**Source namespace:** `Breakdown.SteadyCert`.

**Drift plus power is solenoidal in L².** Proved result `driftPowerSolenoidal`: Under the stated assumptions, this establishes that for 1<α<5/4, the sum of the L² rotating drift and weak fractional power of a second-order field is solenoidal in L².

### Breakdown.FracCert.DriftSymbolWeak

Derives the Fourier weak drift identity from physical integration by parts, inverse-transform formulas and the negative-second-trace representation of velocity.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftSymbolWeak.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftSymbolWeak`.

**Complexification pairs with real parts.** Proved result `inner_complexifyVec`: Under the stated hypotheses, complexification pairs with real parts.

**Fourier tests preserve real pairings.** Proved result `pairing`: Under the stated hypotheses, Fourier tests preserve real field pairings.

**Negative second traces belong to L².** Proved result `memLp_negSecondTrace`: Under the stated hypotheses, negative second traces belong to L².

**The flow adjoint vanishes off support.** Proved result `flowAdjoint_eq_zero`: Under the stated hypotheses, the flow adjoint vanishes off support.

**Adjoint support stays within the test.** Proved result `support_flowAdjoint_subset`: Under the stated hypotheses, adjoint support stays inside test support.

**Closed adjoint support stays within test.** Proved result `tsupport_flowAdjoint_subset`: Under the stated hypotheses, closed adjoint support stays inside support.

**The axial turn is smooth.** Proved result `contDiff_axialTurn`: Under the stated hypotheses, the axial turn is smooth. Source: `Breakdown.FracCert.DriftSymbolWeak:79`.

**The complex frequency turn is smooth.** Proved result `contDiff_freqTurn`: Under the stated hypotheses, the complex frequency turn is smooth.

**The flow adjoint preserves smoothness.** Proved result `contDiff_flowAdjoint`: Under the stated hypotheses, the flow adjoint preserves smoothness.

**Smooth compact fields are Schwartz.** Proved result `exists_rapid`: Under the stated hypotheses, smooth compact fields are Schwartz fields.

**The quadratic frequency-power formula.** Proved result `freqPow_two_eq`: The second frequency power is exactly (2π)²‖ξ‖².

**Inverse-square weights are smooth off 0.** Proved result `contDiff_scaled`: Under the stated hypotheses, inverse-square weighting stays smooth off zero.

**Real parts commute with derivatives.** Proved result `lineDeriv_postcomp`: Under the stated hypotheses, taking real parts commutes with derivatives.

**Coordinate squares give squared norm.** Proved result `sum_sq_inner`: Under the stated hypotheses, coordinate squares give squared norm.

**Fourier weights give negative traces.** Proved result `sum_second_invTransform`: Under the stated hypotheses, Fourier weights give negative second traces.

**Source namespace:** `Breakdown.SteadyCert`.

**Second-trace tests represent velocity.** Proved result `velocitySecondPhysical_of`: Under the stated assumptions, this establishes that for a second-order field and Schwartz symbols with Φ=(2π‖ξ‖)²Ψ, pairing velocity with the real inverse transform of Φ equals pairing the negative second trace with the real inverse transform of Ψ.

**Physical adjoints give Fourier drift.** Proved result `driftSymbolWeak_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

**Transport and inversion give the adjoint.** Proved result `driftAdjointPhysical_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, pairing that drift with the real inverse transform of a Schwartz test equals pairing velocity with the real inverse transform of its frequency flow adjoint.

**Three pairing identities give weak drift.** Proved result `driftSymbolWeak_of_parts`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftSymbolWeakFreq`.

**Linear weights obey the derivative rule.** Proved result `hasFDerivAt_inner_smul`: Under the stated hypotheses, linear weights obey the derivative rule.

**Linear weights obey the product rule.** Proved result `lineDeriv_inner_smul`: Under the stated hypotheses, linear-weight derivatives obey the product rule.

**Inversion converts weighted derivatives.** Proved result `invTransform_inner_lineDeriv`: Under the stated hypotheses, Fourier inversion converts weighted derivatives.

**The complex turn as a linear map.** Definition `turnL`: This equips the complex frequency turn with its continuous complex linear map structure.

**The complex turn is (−z₂,z₁,0).** Proved result `turnL_apply`: The continuous complex-linear turn sends (z₁,z₂,z₃) to (−z₂,z₁,0), agreeing with the frequency axial generator.

**Fourier inversion commutes with turns.** Proved result `invTransform_turn`: Under the stated hypotheses, Fourier inversion commutes with turns.

**Coordinates reconstruct each frequency.** Proved result `decomp`: Under the stated hypotheses, coordinates reconstruct each frequency.

**Coordinates reconstruct the axial turn.** Proved result `decomp_turn`: Under the stated hypotheses, coordinates reconstruct the axial turn.

**Basis pairings give coordinates.** Proved result `inner_unit`: Under the stated hypotheses, basis pairings give coordinates.

**Real parts commute with axial turns.** Proved result `realVec_turn`: Under the stated hypotheses, real parts commute with axial turns.

**Real parts commute with differentiation.** Proved result `fderiv_realVec`: Under the stated hypotheses, real parts commute with differentiation.

**Radial derivatives expand in coordinates.** Proved result `fderiv_self`: Under the stated hypotheses, radial derivatives expand in coordinates.

**Turn derivatives expand in coordinates.** Proved result `fderiv_turn`: Under the stated hypotheses, turn derivatives expand in coordinates.

**Source namespace:** `Breakdown.SteadyCert`.

**Inversion converts the flow adjoint.** Proved result `flowAdjointInverse`: Under the stated assumptions, this establishes that taking the real inverse Fourier transform converts the frequency flow adjoint of a Schwartz test into the physical transport adjoint of its real inverse transform.

**Two physical identities give weak drift.** Proved result `driftSymbolWeak_of_two`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftSymbolWeakTransport`.

**The spatial turn as a linear map.** Definition `axialL`: This equips the spatial axial turn with its continuous real linear map structure.

**The spatial turn is (−x₂,x₁,0).** Proved result `axialL_apply`: The continuous spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator.

**Axial turns are skew adjoint.** Proved result `inner_axialTurn`: Under the stated hypotheses, axial turns are skew adjoint.

**Source namespace:** `Breakdown.SteadyCert`.

**Linear transport gives the drift adjoint.** Proved result `driftTransportPairing_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, its drift pairing with every Schwartz vector test equals the velocity pairing with the physical transport adjoint.

**Linear transport gives Fourier drift.** Proved result `driftSymbolWeak_of_transport`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftSymbolWeakLinear`.

**Linear maps expand in coordinates.** Proved result `clm_decomp`: Under the stated hypotheses, linear maps expand in coordinates.

**Linear coordinates have temperate growth.** Proved result `hasTG`: Under the stated hypotheses, linear coordinates have temperate growth.

**Coordinate weights have two derivatives.** Proved result `lineDeriv_coord_smul`: Under the stated hypotheses, coordinate-weight derivatives have two terms.

**Source namespace:** `Breakdown.SteadyCert`.

**Linear transport integrates by parts.** Proved result `linearTransportPair`: Under the stated assumptions, this establishes that for a second-order field and a Schwartz vector test, differentiation of the velocity along a linear field Wy transfers by integration by parts to the negative test derivative along Wy and the trace of W, with all stated pairings integrable.

**The drift has its weak Fourier identity.** Proved result `driftSymbolWeak`: Under the stated assumptions, this establishes that for 1<α<5/4 and a second-order field with L² drift, the drift symbol pairs with every frequency test as the inverse-square-weighted second symbol paired with the flow adjoint of that test.

### Breakdown.FracCert.DriftSymbolWeakParts

States the physical transport, Fourier inversion and second-trace pairing interfaces needed to identify the weak Fourier drift.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftSymbolWeakParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Drift transfers to the flow adjoint.** Proposition `DriftAdjointPhysicalStatement`: This proposition requires that for 1<α<5/4 and a second-order field with L² drift, pairing that drift with the real inverse transform of a Schwartz test equals pairing velocity with the real inverse transform of its frequency flow adjoint.

**Fourier second traces represent velocity.** Proposition `VelocitySecondPhysicalStatement`: This proposition requires that for a second-order field and Schwartz symbols with Φ=(2π‖ξ‖)²Ψ, pairing velocity with the real inverse transform of Φ equals pairing the negative second trace with the real inverse transform of Ψ.

**Weak Hessians pair with Schwartz tests.** Proposition `SecondTracePairingStatement`: This proposition requires that for a second-order field, pairing velocity with the negative second derivative sum of a Schwartz test equals pairing the negative second trace with that test.

**The physical transport adjoint.** Definition `transportAdjoint`: This defines the physical transport adjoint as (1−2/α)χ−Dχ(y)/(2α)−aDχ(Jy)+aJχ.

**Physical drift integrates by parts.** Proposition `DriftTransportPairingStatement`: This proposition requires that for 1<α<5/4 and a second-order field with L² drift, its drift pairing with every Schwartz vector test equals the velocity pairing with the physical transport adjoint.

**Inversion gives the transport adjoint.** Proposition `FlowAdjointInverseStatement`: This proposition requires that taking the real inverse Fourier transform converts the frequency flow adjoint of a Schwartz test into the physical transport adjoint of its real inverse transform.

**Linear transport integrates by parts.** Proposition `LinearTransportPairStatement`: This proposition requires that for a second-order field and a Schwartz vector test, differentiation of the velocity along a linear field Wy transfers by integration by parts to the negative test derivative along Wy and the trace of W, with all stated pairings integrable.

### Breakdown.FracCert.DriftWeakLimit

Identifies the drift of a weakly convergent correction using compact continuous tests and the inverse-radius weighted velocity limit.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/DriftWeakLimit.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.Internal.DriftWeakLimit`.

**Continuous compact vector fields.** Definition `IsBumpField`: This predicate requires a vector field to be continuous and compactly supported.

**Coordinate functions are continuous.** Proved result `coord_cont`: Under the stated hypotheses, coordinate functions are continuous.

**The axial turn as a linear map.** Definition `turnL`: This defines the continuous axial turn sending (x₁,x₂,x₃) to (−x₂,x₁,0).

**The spatial turn is (−x₂,x₁,0).** Proved result `turnL_apply`: The continuous spatial turn sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator.

**The axial turn is continuous.** Proved result `continuous_turn`: Under the stated hypotheses, the axial turn is continuous.

**The axial turn fixes zero.** Proved result `turn_zero`: Under the stated hypotheses, the axial turn fixes zero.

**Coordinates reconstruct each vector.** Proved result `vec_decomp`: Under the stated hypotheses, coordinates reconstruct each vector.

**Coordinates reconstruct linear maps.** Proved result `clm_decomp`: Under the stated hypotheses, coordinates reconstruct linear maps.

**Axial turns are skew adjoint.** Proved result `inner_turn`: Under the stated hypotheses, axial turns are skew adjoint.

**Compact continuous fields belong to L².** Proved result `bump_memLp`: Under the stated hypotheses, compact continuous fields belong to L².

**Continuous weights retain compact fields.** Proved result `bump_smul`: Under the stated hypotheses, continuous weights preserve compact fields.

**Compact scalars give compact vectors.** Proved result `bump_const`: Under the stated hypotheses, compact scalar weights give compact vectors.

**Axial turns preserve compact fields.** Proved result `bump_turn`: Under the stated hypotheses, axial turns preserve compact fields.

**Compact fields pair with local L¹ fields.** Proved result `pair_int`: Under the stated hypotheses, compact fields pair with local L¹ fields.

**Second-order velocities are locally L¹.** Proved result `vel_li`: Under the stated hypotheses, second-order velocities are locally integrable.

**Gradient columns belong to L².** Proved result `col_memLp`: Under the stated hypotheses, gradient columns belong to L².

**Gradient columns are locally integrable.** Proved result `col_li`: Under the stated hypotheses, gradient columns are locally integrable.

**Drift pairings split by coordinate.** Proved result `drift_pair`: Under the stated hypotheses, drift pairings split into coordinate terms.

**Drift integrals split by coordinate.** Proved result `drift_int`: Under the stated hypotheses, drift integrals split into coordinate terms.

**Weighted limits give compact pairings.** Proved result `vel_tendsto`: Under the stated hypotheses, weighted weak limits give compact pairings.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak drift limits remain in L².** Proved result `driftWeakLimit_holds`: Under the stated assumptions, this establishes that under convergence of rotation rates and the stated simultaneous weak limits, the drift of the limiting second-order velocity is square integrable.

### Breakdown.FracCert.EmbedWeak

Embeds physical weak derivative data into the Fourier energy space, relating operator norms to coordinate energies and controlling the extended-valued norms.

This provides functional analysis or weak Fourier identities for the fractional certificate route; the source README distinguishes these fractional statements from the ordinary-dissipation results used by the paper.

Source: `lean/Breakdown/FracCert/EmbedWeak.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.EmbedWeak.Internal`.

**Basis vectors reconstruct linear maps.** Proved result `apply_eq_sum`: Under the stated hypotheses, basis vectors reconstruct linear maps.

**Column norms bound operator norm.** Proved result `norm_le_sum`: Under the stated hypotheses, column norms bound operator norm.

**Matrix energy bounds the operator norm².** Proved result `norm_sq_le`: Under the stated hypotheses, matrix energy bounds squared operator norm.

**Matrix energy gives L² operator norm.** Proved result `integrable_norm_sq`: Under the stated hypotheses, matrix energy gives integrable operator norm.

**The first finite term is below the sum.** Proved result `le_ofReal_add`: Under the stated hypotheses, a finite first term lies below the real sum.

**The second finite term is below the sum.** Proved result `le_ofReal_add'`: Under the stated hypotheses, a finite second term lies below the real sum.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak derivatives embed in energy space.** Proved result `embedWeak`: Under the stated assumptions, this establishes that a measurable divergence-free L⁶ velocity with measurable square-integrable weak gradient is represented by an energy-space element whose velocity and coordinate partial fields agree with those physical data almost everywhere.

### Breakdown.FracCert.FarFieldGradientFree

Uses the transverse projection in the heat-divergence symbol to prove that the rotated and scaled far-field integral annihilates gradient frequency tests.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/FarFieldGradientFree.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FarFieldGradientFreeInternal`.

**All moments give a continuous profile.** Proved result `profileField_continuous`: Under the stated hypotheses, all moments give a continuous profile. Source: `Breakdown.FracCert.FarFieldGradientFree:21`.

**All moments give a bounded profile.** Proved result `profileField_bounded`: Under the stated hypotheses, all moments give a bounded profile. Source: `Breakdown.FracCert.FarFieldGradientFree:27`.

**Tensor squares preserve continuity.** Proved result `tensorSq_continuous`: Under the stated hypotheses, tensor squares preserve continuity. Source: `Breakdown.FracCert.FarFieldGradientFree:37`.

**Tensor squares have a squared bound.** Proved result `tensorSq_norm_le`: Under the stated hypotheses, tensor squares have a squared bound. Source: `Breakdown.FracCert.FarFieldGradientFree:43`.

**The heat-divergence kernel is measurable.** Proved result `kernel_measurable`: Under the stated hypotheses, the heat-divergence kernel is measurable.

**The heat-divergence kernel is integrable.** Proved result `kernel_integrable`: Under the stated hypotheses, the heat-divergence kernel is integrable.

**The total projected kernel mass.** Definition `kernelMass`: This defines the total time-one projected kernel mass by summing the L¹ norms of its twenty-seven scalar components.

**Kernel mass is nonnegative.** Proved result `kernelMass_nonneg`: Under the stated hypotheses, kernel mass is nonnegative. Source: `Breakdown.FracCert.FarFieldGradientFree:66`.

**Coordinate bounds control vector norms.** Proved result `norm_le_three`: Under the stated hypotheses, coordinate bounds control the vector norm.

**Kernel mass bounds heat divergence.** Proved result `heatDivConv_norm_le`: Under the stated hypotheses, kernel mass bounds heat divergence. Source: `Breakdown.FracCert.FarFieldGradientFree:84`.

**Negative exponentials are below one.** Proved result `exp_neg_lt_one`: Under the stated hypotheses, negative exponentials are below one. Source: `Breakdown.FracCert.FarFieldGradientFree:123`.

**Coordinate embeddings are measurable.** Proved result `single_measurable`: Under the stated hypotheses, coordinate embeddings are measurable. Source: `Breakdown.FracCert.FarFieldGradientFree:127`.

**Variable rotations retain measurability.** Proved result `meas_rot`: Under the stated hypotheses, variable rotations preserve measurability.

**Heat convolutions vary measurably.** Proved result `meas_heat`: Under the stated hypotheses, heat convolutions vary measurably. Source: `Breakdown.FracCert.FarFieldGradientFree:148`.

**The far-field integrand is measurable.** Proved result `joint_measurable`: Under the stated hypotheses, the far-field integrand is jointly measurable.

**The far-field integrand has a time bound.** Proved result `integrand_norm_le`: Under the stated hypotheses, the far-field integrand has a time bound.

**Small heat times have a lower bound.** Proved result `one_sub_exp_ge`: Under the stated hypotheses, small heat times have a linear lower bound. Source: `Breakdown.FracCert.FarFieldGradientFree:201`.

**The time singularity is integrable.** Proved result `weight_integrable`: Under the stated hypotheses, the time singularity is integrable. Source: `Breakdown.FracCert.FarFieldGradientFree:207`.

**Projected symbols are continuous off 0.** Proved result `symbol_continuousAt`: Under the stated hypotheses, the projected symbol is continuous off zero.

**Kernel pairings have a Fourier formula.** Proved result `kernel_pairing_step`: Under the stated hypotheses, kernel pairings have a Fourier formula.

**Transverse projections kill frequencies.** Proved result `real_contract`: Under the stated hypotheses, transverse projections kill frequencies.

**The projected symbol kills frequencies.** Proved result `symbol_contract`: Under the stated hypotheses, the projected symbol kills frequencies.

**Inverse rotations expand in entries.** Proved result `symm_apply_eq_sum`: Under the stated hypotheses, inverse rotations expand by matrix entries.

**Symbol L¹ mass bounds inverse transforms.** Proved result `inverse_transform_norm_le`: Under the stated hypotheses, symbol L¹ mass bounds inverse transforms.

**Projected kernels annihilate gradients.** Proved result `kernel_core`: Under the stated hypotheses, projected kernels annihilate gradient tests.

**Heat convolutions annihilate gradients.** Proved result `conv_pair_zero`: Under the stated hypotheses, heat convolutions annihilate gradient tests.

**Far-field pairings pass through time.** Proved result `farFieldTimeSplit`: Under the stated assumptions, this establishes that for 1<α<5/4, pairing the far-field operator of a bounded continuous tensor with a continuous integrable test equals the negative time integral of the corresponding pairings of the rotated and scaled heat convolution.

**Rotated heat fields annihilate gradients.** Proved result `heatDivGradientFree`: Under the stated assumptions, this establishes that for α>1 and positive heat time and similarity scale, each rotated and scaled heat-divergence convolution of a bounded continuous tensor annihilates smooth compact frequency tests parallel to their frequencies.

**Source namespace:** `Breakdown.FracCert`.

**Far fields annihilate gradient tests.** Proved result `farFieldGradientFree`: Under the stated assumptions, this establishes that for 1<α<5/4, the far field of a profile tensor square with all moments annihilates real-symmetric smooth annular frequency tests parallel to their frequencies.

### Breakdown.FracCert.FarFieldGradientFreeParts

States the time-interchange and projected-gradient orthogonality contracts used to show the far-field term is solenoidal.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/FarFieldGradientFreeParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Far-field pairings pass through time.** Proposition `FarFieldTimeSplitStatement`: This proposition requires that for 1<α<5/4, pairing the far-field operator of a bounded continuous tensor with a continuous integrable test equals the negative time integral of the corresponding pairings of the rotated and scaled heat convolution.

**Rotated heat fields annihilate gradients.** Proposition `HeatDivGradientFreeStatement`: This proposition requires that for α>1 and positive heat time and similarity scale, each rotated and scaled heat-divergence convolution of a bounded continuous tensor annihilates smooth compact frequency tests parallel to their frequencies.

### Breakdown.FracCert.FarFieldPairing

Matches the physical far-field integral to the nonlinear mild pairing by transposing the heat-divergence kernel and integrating the convection term by parts.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/FarFieldPairing.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FarFieldPairingInternal`.

**All moments give a continuous profile.** Proved result `field_continuous`: Under the stated hypotheses, all moments give a continuous profile.

**All moments give a bounded profile.** Proved result `field_bounded`: Under the stated hypotheses, all moments give a bounded profile.

**Tensor squares preserve continuity.** Proved result `tensor_continuous`: Under the stated hypotheses, tensor squares preserve continuity.

**Tensor squares have a squared bound.** Proved result `tensor_norm_le`: Under the stated hypotheses, tensor squares have a squared bound.

**Nice fields are continuous and in L¹.** Proved result `nice_props`: Under the stated hypotheses, nice fields are continuous and integrable.

**Heat continuity gives continuity.** Proved result `integrand_continuousOn`: Under the stated hypotheses, heat continuity gives integrand continuity.

**Similarity moves across pairings.** Proved result `change_vars`: Under the stated hypotheses, similarity moves across integral pairings.

**Source namespace:** `Breakdown.FracCert`.

**Heat pairings give far-field identities.** Proved result `farFieldPairing_of`: Under the stated assumptions, this establishes that for 1<α<5/4, the far field of a profile tensor square with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Source namespace:** `Breakdown.FracCert.FarFieldPairingInternal`.

**Coordinate magnitudes are norm bounded.** Proved result `coord_abs_le`: Under the stated hypotheses, coordinate magnitudes are bounded by norm.

**Product magnitudes obey product bounds.** Proved result `abs_mul_le'`: Under the stated hypotheses, product magnitudes obey product bounds.

**Bounded continuous factors preserve L¹.** Proved result `integrable_bdd`: Under the stated hypotheses, bounded continuous factors preserve L¹.

**Coordinates preserve continuity.** Proved result `coord_continuous`: Under the stated hypotheses, continuous fields have continuous coordinates.

**Coordinates inherit vector derivatives.** Proved result `coord_hasFDerivAt`: Under the stated hypotheses, coordinates inherit vector derivatives.

**Derivatives equal coordinate entries.** Proved result `coord_fderiv`: Under the stated hypotheses, coordinate derivatives equal vector entries.

**Coordinates preserve integrability.** Proved result `coord_integrable`: Under the stated hypotheses, integrable fields have integrable coordinates.

**Derivative entries are integrable.** Proved result `dcoord_integrable`: Under the stated hypotheses, integrable derivatives have integrable entries.

**Convection integrates by coordinates.** Proved result `parts_jk`: Under the stated hypotheses, convection admits coordinate integration by parts.

**Source namespace:** `Breakdown.FracCert`.

**Trilinear terms integrate by parts.** Proved result `trilinearByParts`: Under the stated assumptions, this establishes that for an energy-space element with all moments, the trilinear pairing with a nice test equals minus the sum of the velocity tensor entries paired with the corresponding test derivatives.

**Transposition gives the heat pairing.** Proved result `heatDivPairing_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0<t<1, pairing heat divergence of a profile tensor square with a nice test equals its trilinear pairing with the heat-evolved test.

**Kernel transpose gives integral duality.** Proved result `heatDivTranspose_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0<t<1, pairing heat divergence of a bounded continuous tensor with a nice test equals the negative tensor pairing with the derivatives of the heat-evolved test.

**Heat duality gives the far-field pairing.** Proved result `farFieldPairing_of_transpose`: Under the stated assumptions, this establishes that for 1<α<5/4, the far field of a profile tensor square with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Kernel duality gives far-field pairings.** Proved result `farFieldPairing_of_kernel`: Under the stated assumptions, this establishes that for 1<α<5/4, the far field of a profile tensor square with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

**Source namespace:** `Breakdown.FracCert.FarFieldPairingInternal`.

**Fourier inversion respects coordinates.** Proved result `coord_inverseTransform`: Under the stated hypotheses, Fourier inversion commutes with coordinates.

**Real vector parts agree coordinatewise.** Proved result `realVec_coord`: Under the stated hypotheses, real vector parts agree coordinatewise.

**Source namespace:** `Breakdown.FracCert`.

**Kernel transposes are heat derivatives.** Proved result `kernelTranspose`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0<t<1, summing kernel component pairings with a nice test gives the negative corresponding derivative of the fractional heat-evolved test.

**Heat regularity gives far-field pairings.** Proved result `farFieldPairing_of_regular`: Under the stated assumptions, this establishes that for 1<α<5/4, the far field of a profile tensor square with all moments pairs against each nice test as the negative positive-time integral of its trilinear pairing with the heat-evolved similarity-adjoint test.

### Breakdown.FracCert.FarFieldPairingParts

States the heat-kernel transpose and trilinear integration-by-parts identities needed to express far-field pairings as the nonlinear mild integral.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/FarFieldPairingParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert`.

**Heat divergence gives trilinear pairings.** Proposition `HeatDivPairingStatement`: This proposition requires that for 1<α<5/4 and 0<t<1, pairing heat divergence of a profile tensor square with a nice test equals its trilinear pairing with the heat-evolved test.

**Heat divergence transfers to tests.** Proposition `HeatDivTransposeStatement`: This proposition requires that for 1<α<5/4 and 0<t<1, pairing heat divergence of a bounded continuous tensor with a nice test equals the negative tensor pairing with the derivatives of the heat-evolved test.

**Trilinear terms transfer to test fields.** Proposition `TrilinearByPartsStatement`: This proposition requires that for an energy-space element with all moments, the trilinear pairing with a nice test equals minus the sum of the velocity tensor entries paired with the corresponding test derivatives.

**Kernel transposes are heat derivatives.** Proposition `KernelTransposeStatement`: This proposition requires that for 1<α<5/4 and 0<t<1, summing kernel component pairings with a nice test gives the negative corresponding derivative of the fractional heat-evolved test.

### Breakdown.FracCert.FarFieldWeighted

Proves weighted L² integrability of the profile far field using a positive kernel majorant, weighted Cauchy-Schwarz, affine changes of variables and the profile L⁶ bound.

This develops the smoothness, far-field representation or spatial decay of the fractional extension, supporting conversion of a weak fractional profile to a classical decaying solution; no numbered paper theorem correspondence is asserted.

Source: `lean/Breakdown/FracCert/FarFieldWeighted.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.FarFieldWeightedInternal`.

**The projected heat kernel has decay.** Proved result `kernelDecayHolds`: Under the stated assumptions, this establishes that for α>0, every positive-time projected heat-divergence kernel component is smooth and its nth derivative is bounded by C(t^(1/(2α))+‖x‖)^(−4−n).

**The projected heat kernel has scaling.** Proved result `kernelScalingHolds`: Under the stated assumptions, this establishes that for α>0 and t>0, the projected kernel is real, integrable and in L³⁄², obeys the t^(−2/α) spatial rescaling, and has L¹ and L³⁄² norms scaling respectively by t^(−1/(2α)) and t^(−1/α).

**A positive heat-kernel majorant.** Definition `kk`: This defines an extended nonnegative kernel majorant by summing the norms of all components of the rescaled time-one projected heat-divergence kernel.

**The transformed heat time is positive.** Proved result `t_pos`: Under the stated hypotheses, the transformed heat time is positive. Source: `Breakdown.FracCert.FarFieldWeighted:32`.

**The majorant sums kernel component norms.** Proved result `kk_eq`: Under the stated hypotheses, the majorant sums kernel component norms.

**Positive-time kernels are continuous.** Proved result `kernel_cont`: Under the stated hypotheses, positive-time kernels are continuous.

**The kernel majorant is measurable.** Proved result `kk_meas`: Under the stated hypotheses, the kernel majorant is jointly measurable.

**Each kernel majorant slice is measurable.** Proved result `kk_meas_z`: Under the stated hypotheses, each kernel majorant slice is measurable.

**Majorant mass follows heat scaling.** Proved result `kk_lintegral`: Under the stated hypotheses, majorant mass follows heat scaling.

**Coordinate norms bound the vector norm.** Proved result `enorm_le_sum_comp`: Under the stated hypotheses, coordinate norms bound the vector norm.

**The majorant bounds heat convolution.** Proved result `heat_bound`: Under the stated hypotheses, the majorant bounds heat convolution.

**Inverse rotation negates the angle.** Proved result `rot_symm`: Under the stated hypotheses, inverse rotation negates the angle.

**A double integral bounds the far field.** Proved result `pointwise`: Under the stated hypotheses, a positive double integral bounds the far field.

**The affine argument is continuous.** Proved result `arg_cont`: Under the stated hypotheses, the affine convolution argument is continuous.

**Affine changes give the volume factor.** Proved result `lintegral_affine`: Under the stated hypotheses, affine changes give the volume factor.

**Weighted Cauchy-Schwarz bounds integrals.** Proved result `cst_weighted`: Under the stated hypotheses, weighted Cauchy-Schwarz bounds integrals.

**Heat time has a rational lower bound.** Proved result `t_lower`: Under the stated hypotheses, heat time has a rational lower bound.

**Heat-time powers have bounds.** Proved result `t_pow_le`: Under the stated hypotheses, heat-time singularities have power bounds.

**The weighted kernel measure is finite.** Proved result `lam_finite`: Under the stated hypotheses, the weighted kernel measure is finite.

**The similarity amplitude factor.** Definition `aA`: This defines the similarity amplitude exp(−τ)^(1−1/(2α)).

**The similarity spatial scale.** Definition `cC`: This defines the similarity spatial scale exp(−τ)^(1/(2α)).

**The transformed tensor magnitude.** Definition `psi`: This defines the extended norm of the tensor evaluated at the rotated, scaled spatial point minus the convolution displacement.

**The amplitude-weighted kernel measure.** Definition `mm`: This defines the positive kernel density as the product of the similarity amplitude and the scalar kernel majorant.

**The inverse-scale kernel weight.** Definition `m1`: This defines the first Cauchy-Schwarz weight as the kernel majorant times the similarity amplitude divided by the spatial scale.

**The direct-scale kernel weight.** Definition `m2`: This defines the second Cauchy-Schwarz weight as the kernel majorant times the similarity amplitude and spatial scale.

**The amplitude factor is measurable.** Proved result `aA_meas`: Under the stated hypotheses, the amplitude factor is measurable.

**The spatial scale is measurable.** Proved result `cC_meas`: Under the stated hypotheses, the spatial scale is measurable.

**The spatial scale is positive.** Proved result `cC_pos`: Under the stated hypotheses, the spatial scale is positive.

**The amplitude factor is nonnegative.** Proved result `aA_nonneg`: Under the stated hypotheses, the amplitude factor is nonnegative.

**The kernel measure weight is measurable.** Proved result `mm_meas`: Under the stated hypotheses, the kernel measure weight is measurable.

**The inverse-scale weight is measurable.** Proved result `m1_meas`: Under the stated hypotheses, the inverse-scale weight is measurable.

**The direct-scale weight is measurable.** Proved result `m2_meas`: Under the stated hypotheses, the direct-scale weight is measurable.

**The transformed tensor is measurable.** Proved result `psi_meas`: Under the stated hypotheses, the transformed tensor is measurable.

**The split weights recover the square.** Proved result `huv`: Under the stated hypotheses, the split weights recover the square.

**The cubic Jacobian cancels the scale.** Proved result `real_id`: Under the stated hypotheses, the cubic Jacobian cancels the scale.

**The kernel measure bounds the far field.** Proved result `pointwise'`: Under the stated hypotheses, the kernel measure bounds the far field.

**The inverse-radius weight lies in L⁶.** Proved result `weight_six`: Under the stated hypotheses, the inverse-radius weight lies in L⁶.

**L³ tensors give weighted L² far fields.** Proved result `hbase`: Under the stated hypotheses, L³ tensors give weighted L² far fields.

**All moments give a continuous profile.** Proved result `profile_cont`: Under the stated hypotheses, all moments give a continuous profile.

**All moments give an L⁶ profile.** Proved result `profile_six`: Under the stated hypotheses, all moments give an L⁶ profile.

**Tensor squares preserve continuity.** Proved result `tensor_cont`: Under the stated hypotheses, tensor squares preserve continuity.

**Velocity squared bounds the tensor norm.** Proved result `tensor_bound`: Under the stated hypotheses, tensor norm is bounded by velocity squared.

**L⁶ velocities give L³ tensors.** Proved result `tensor_three`: Under the stated hypotheses, L⁶ velocities give L³ tensors.

**A rescaled real heat-kernel component.** Definition `kf`: This defines a real component of the heat kernel using the explicit rescaling of its time-one Fourier inverse.

**The rescaled component is measurable.** Proved result `kf_meas`: Under the stated hypotheses, the rescaled kernel component is measurable.

**Rescaling recovers the heat kernel.** Proved result `kf_eq`: Under the stated hypotheses, the rescaled component equals the heat kernel.

**The componentwise heat convolution.** Definition `hform`: This defines the componentwise heat-divergence convolution using the rescaled real kernel formula.

**The components give heat divergence.** Proved result `hform_eq`: Under the stated hypotheses, the component formula equals heat divergence.

**The heat convolution is measurable.** Proved result `hform_meas`: Under the stated hypotheses, the heat convolution formula is measurable.

**The rotated similarity integrand.** Definition `gform`: This defines the joint spatial-time far-field integrand by composing the componentwise convolution with the similarity rotation, scale and amplitude.

**Similarity gives the integrand formula.** Proved result `g_eq`: Under the stated hypotheses, the similarity formula equals the integrand.

**The similarity integrand is measurable.** Proved result `gform_meas`: Under the stated hypotheses, the similarity integrand is measurable.

**The far-field operator is measurable.** Proved result `far_meas`: Under the stated hypotheses, the far-field operator is measurable.

**Source namespace:** `Breakdown.FracCert`.

**The far field has weighted L² size.** Proved result `farFieldWeighted`: Under the stated assumptions, this establishes that for 1<α<5/4, the far-field operator applied to the tensor square of a profile with all moments belongs to L² after multiplication by (1+‖y‖)⁻¹.

### Breakdown.FracCert.FlowDeriv

Differentiates the rotation and dilation flow on test functions, which supplies the weak drift pairing identity.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FlowDeriv.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.Internal.FlowDeriv`.

**Frequency turns preserve scaling.** Proved result `freqTurn_smul`: Under the stated hypotheses, frequency turns preserve scaling.

**Frequency turns preserve differences.** Proved result `freqTurn_sub`: Under the stated hypotheses, frequency turns preserve differences.

**Axial turns preserve differences.** Proved result `axialTurn_sub`: Under the stated hypotheses, axial turns preserve differences. Source: `Breakdown.FracCert.FlowDeriv:25`.

**Frequency turns do not increase norms.** Proved result `norm_freqTurn_le`: Under the stated hypotheses, frequency turns do not increase norms.

**Axial turns do not increase norms.** Proved result `norm_axialTurn_le`: Under the stated hypotheses, axial turns do not increase norms. Source: `Breakdown.FracCert.FlowDeriv:36`.

**Frequency turns are continuous.** Proved result `continuous_freqTurn`: Under the stated hypotheses, frequency turns are continuous.

**Axial turns are continuous.** Proved result `continuous_axialTurn`: Under the stated hypotheses, axial turns are continuous.

**Complex rotations expand in a basis.** Proved result `rotC_eq_sum`: Under the stated hypotheses, complex rotations expand in a basis.

**Rotating vectors obey the chain rule.** Proved result `hasDerivAt_rotC`: Under the stated hypotheses, rotating vectors obey the chain rule.

**Spatial derivatives follow the flow.** Proved result `fderiv_flowPush`: Under the stated hypotheses, spatial derivatives follow the flow.

**Time derivatives give the adjoint.** Proved result `hasDerivAt_flowPush`: Under the stated hypotheses, time derivatives give the adjoint.

**The adjoint vanishes off support.** Proved result `flowAdjoint_of_notMem`: Under the stated hypotheses, the adjoint vanishes off support.

**The flow adjoint is continuous.** Proved result `continuous_flowAdjoint`: Under the stated hypotheses, the flow adjoint is continuous.

**Values and derivatives bound the adjoint.** Proved result `norm_flowAdjoint_le`: Under the stated hypotheses, values and derivatives bound the adjoint.

**The transported adjoint has a bound.** Proved result `norm_flowAdjoint_push_le`: Under the stated hypotheses, the transported adjoint has a bound.

**Source namespace:** `Breakdown.SteadyCert`.

**The flow pairing is differentiable.** Proved result `flowDeriv`: Under the stated assumptions, this establishes that for 1<α<5/4 and a field whose first frequency weight is in L², pairing with the transported test is differentiable in time and its derivative pairs the field with the flow adjoint of that test.

### Breakdown.FracCert.FlowPairing

Builds the strongly continuous rotation and dilation flow on L² and derives its weak integral and pairing identities.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FlowPairing.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Rotation and dilation of frequencies.** Definition `flowLin`: This defines the frequency transformation ξ ↦ exp(−gt) R(at)ξ as a continuous linear equivalence.

**Rotation and scaling of field values.** Definition `flowValue`: This defines the value transformation z ↦ exp(ct) R(−at)z on complex vectors.

**Pullback along the frequency flow.** Definition `flowPull`: This defines the transported field by evaluating it along the frequency transformation and applying the value transformation.

**The flow operator on L².** Definition `flowOp`: This defines the bounded linear operator on L² induced by the frequency and value transformations.

**The L² flow is continuous.** Proposition `FlowContinuityStatement`: This proposition requires that for every choice of the three flow rates, the rotation and dilation action on each L² field is continuous in time.

**Weak drift integrates along the flow.** Proposition `FlowIntegralStatement`: This proposition requires that for 1<α<5/4, a weighted L² field with weak flow derivative D has transported increment equal almost everywhere to the time integral of the L² flow applied to D.

**Source namespace:** `Breakdown.SteadyCert.Internal.FlowPairing`.

**The frequency flow has a formula.** Proved result `flowLin_apply`: Under the stated hypotheses, the frequency flow has a formula.

**The L² flow agrees almost everywhere.** Proved result `flowOp_ae`: Under the stated hypotheses, the L² flow agrees almost everywhere.

**Field norms scale exponentially.** Proved result `norm_flowValue`: Under the stated hypotheses, field norms scale exponentially.

**Raising the weight multiplies by exp.** Proved result `flowValue_succ`: Under the stated hypotheses, raising the weight multiplies by exp.

**The identity rotation fixes vectors.** Proved result `rotC_refl`: Under the stated hypotheses, the identity rotation fixes vectors.

**The flow starts at the identity.** Proved result `flowOp_zero`: Under the stated hypotheses, the flow starts at the identity.

**The frequency flow preserves null sets.** Proved result `qmp_flowLin`: Under the stated hypotheses, the frequency flow preserves null sets.

**Integrability survives the flow.** Proved result `integrable_flowLin`: Under the stated hypotheses, integrability survives the flow.

**Integrals acquire the Jacobian factor.** Proved result `integral_flowLin`: Under the stated hypotheses, integrals acquire the Jacobian factor.

**Frequency powers scale along the flow.** Proved result `freqPow_flowLin`: Under the stated hypotheses, frequency powers scale along the flow.

**The fractional energy is integrable.** Proved result `integrable_weight`: Under the stated hypotheses, the fractional energy is integrable.

**Frequency norms scale exponentially.** Proved result `norm_flowLin`: Under the stated hypotheses, frequency norms scale exponentially.

**L² norms square to integrals.** Proved result `norm_sq_L2`: Under the stated hypotheses, L² norms square to integrals.

**Flow norms scale exponentially.** Proved result `norm_flowOp`: Under the stated hypotheses, flow norms scale exponentially.

**Moving complex rotations are continuous.** Proved result `continuous_rotC`: Under the stated hypotheses, moving complex rotations are continuous.

**Moving field values are continuous.** Proved result `continuous_flowValue`: Under the stated hypotheses, moving field values are continuous.

**Frequency trajectories are continuous.** Proved result `continuous_flowLin`: Under the stated hypotheses, frequency trajectories are continuous.

**Compact fields have continuous orbits.** Proved result `tendsto_flowOp_of_compact`: Under the stated hypotheses, compact fields have continuous orbits.

**The quadratic frequency weight.** Proved result `freqPow_two_eq`: The second radial frequency power is (2π)²‖ξ‖².

**The second weight is the first squared.** Proved result `freqPow_two_mul`: Under the stated hypotheses, the second weight is the first squared.

**The first frequency weight is continuous.** Proved result `continuous_freqPow_one`: Under the stated hypotheses, the first frequency weight is continuous.

**The second frequency weight is smooth.** Proved result `contDiff_freqPow_two`: Under the stated hypotheses, the second frequency weight is smooth.

**Weighted L² survives the flow.** Proved result `memLp_weight_pull`: Under the stated hypotheses, weighted L² survives the flow.

**The quadratic weight is locally L¹.** Proved result `locallyIntegrable_weight_two`: Under the stated hypotheses, the quadratic weight is locally L¹.

**Source namespace:** `Breakdown.SteadyCert`.

**Flow identities give the energy pairing.** Proved result `flowPairing_of`: Under the stated assumptions, this establishes that for 1<α<5/4, an L² weak flow derivative D of a field h with its first and 2α frequency weights in L² satisfies the identity ∫⟨D,(2π‖ξ‖)^(2α)h⟩=(3/2−5/(4α))∫(2π‖ξ‖)^(2α)‖h‖².

**The L² flow is continuous.** Proved result `flowContinuity`: Under the stated assumptions, this establishes that for every choice of the three flow rates, the rotation and dilation action on each L² field is continuous in time.

**The integral gives the energy pairing.** Proved result `flowPairing_of_integral`: Under the stated assumptions, this establishes that for 1<α<5/4, an L² weak flow derivative D of a field h with its first and 2α frequency weights in L² satisfies the identity ∫⟨D,(2π‖ξ‖)^(2α)h⟩=(3/2−5/(4α))∫(2π‖ξ‖)^(2α)‖h‖².

**The flow identity holds on tests.** Proposition `FlowTestStatement`: This proposition requires that for 1<α<5/4, the transported increment of a weighted L² field with weak flow derivative D and the integrated flow of D have equal pairings against every frequency test.

**Test identities identify the integral.** Proved result `flowIntegral_of_test`: Under the stated assumptions, this establishes that for 1<α<5/4, a weighted L² field with weak flow derivative D has transported increment equal almost everywhere to the time integral of the L² flow applied to D.

**Test identities give the pairing.** Proved result `flowPairing_of_test`: Under the stated assumptions, this establishes that for 1<α<5/4, an L² weak flow derivative D of a field h with its first and 2α frequency weights in L² satisfies the identity ∫⟨D,(2π‖ξ‖)^(2α)h⟩=(3/2−5/(4α))∫(2π‖ξ‖)^(2α)‖h‖².

**Source namespace:** `Breakdown.SteadyCert.Internal.FlowPairing`.

**Rotation moves across inner products.** Proved result `real_inner_rotC`: Under the stated hypotheses, rotation moves across inner products.

**Reversing rates inverts the flow.** Proved result `flowLin_inv`: Under the stated hypotheses, reversing rates inverts the flow.

**The flow moves across integral pairings.** Proved result `integral_inner_flowPull`: Under the stated hypotheses, the flow moves across integral pairings.

**Inverse-weighted tests are continuous.** Proved result `continuous_invWeight`: Under the stated hypotheses, inverse-weighted tests are continuous.

**Weighted fields pair integrably.** Proved result `integrable_inner_test`: Under the stated hypotheses, weighted fields pair integrably.

**The flow preserves frequency tests.** Proved result `isFreqTest_flowPull`: Under the stated hypotheses, the flow preserves frequency tests.

**Source namespace:** `Breakdown.SteadyCert`.

**The adjoint transport of tests.** Definition `flowPush`: This defines test transport with dilation rate −1/(2α), rotation rate −a and amplitude rate 1−1/(2α), the rates adjoint to the profile flow.

**The flow pairing is differentiable.** Proposition `FlowDerivStatement`: This proposition requires that for 1<α<5/4 and a field whose first frequency weight is in L², pairing with the transported test is differentiable in time and its derivative pairs the field with the flow adjoint of that test.

**Derivatives give the test identity.** Proved result `flowTest_of_deriv`: Under the stated assumptions, this establishes that for 1<α<5/4, the transported increment of a weighted L² field with weak flow derivative D and the integrated flow of D have equal pairings against every frequency test.

**Derivatives give the energy pairing.** Proved result `flowPairing_of_deriv`: Under the stated assumptions, this establishes that for 1<α<5/4, an L² weak flow derivative D of a field h with its first and 2α frequency weights in L² satisfies the identity ∫⟨D,(2π‖ξ‖)^(2α)h⟩=(3/2−5/(4α))∫(2π‖ξ‖)^(2α)‖h‖².

### Breakdown.FracCert.FreeBounds

Obtains coercive L² estimates for the fractional free operator from Fourier energy and drift identities.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeBounds.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**L² norms square to integrals.** Proved result `lp_norm_sq`: Under the stated hypotheses, L² norms square to integrals.

**Complexification preserves norms.** Proved result `norm_complexifyVec_eq`: Under the stated hypotheses, complexification preserves norms.

**Complexification preserves L² energy.** Proved result `integral_norm_sq_complexify`: Under the stated hypotheses, complexification preserves L² energy.

**The L² representative agrees a.e..** Proved result `toLpOrZero_coe`: For a square-integrable real vector field, conversion to L² followed by taking a representative agrees with the original field almost everywhere.

**Fourier transform preserves L² energy.** Proved result `integral_fieldSymbol_sq`: Under the stated hypotheses, Fourier transform preserves L² energy.

**The trace is bounded by matrix entries.** Proved result `secondTrace_sq_le`: Under the stated hypotheses, the trace is bounded by matrix entries.

**The negative trace lies in L².** Proved result `memLp_negSecondTrace`: Under the stated hypotheses, the negative trace lies in L².

**L² fields pair integrably.** Proved result `integrable_pair`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.FreeBounds:73`.

**Integral pairings equal L² pairings.** Proved result `pair_eq_inner`: Under the stated hypotheses, integral pairings equal L² pairings. Source: `Breakdown.FracCert.FreeBounds:79`.

**The concrete L² norm is the Lp norm.** Proved result `l2Norm_eq_norm`: Under the stated hypotheses, the concrete L² norm is the Lp norm.

**Cauchy-Schwarz bounds the pairing.** Proved result `abs_pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds the pairing. Source: `Breakdown.FracCert.FreeBounds:94`.

**Two frequency weights dominate one.** Proved result `pointwise_le`: For nonzero ξ, nonnegative β, and nonnegative s, the quantity s is at most s/(2π‖ξ‖)² plus (2π‖ξ‖)^(2β)s.

**Almost every frequency is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every frequency is nonzero. Source: `Breakdown.FracCert.FreeBounds:118`.

**Gradient and power energies bound trace.** Proved result `trace_le`: Assuming the gradient and trace Fourier energy identities, integrability of the inverse-square-weighted trace symbol, an L² power whose symbol is (2π‖ξ‖)^(2α−2) times the negative-second-trace symbol, and α≥1, the trace's squared L² norm is at most gradient energy plus the power's squared L² norm.

**Squared norms split with a cross term.** Proved result `sq_split`: Under the stated hypotheses, squared norms split with a cross term.

**Pairing distributes over a sum.** Proved result `pair_split`: Under the stated hypotheses, pairing distributes over a sum.

**A coercive scalar estimate.** Proved result `final_alg`: If 0<κ≤1 and nonnegative f,g,n,p satisfy p≤f, n²≤g²+p², absolute bounds abs(A)≤fn and abs(B)≤pn, and κg²+B=A, then n+g≤(6/κ+1)f.

**Grouped estimates for the free equation.** Proved result `freeBounds_grouped_of`: Assuming the second-symbol energy, weak-power symbol, drift energy, and drift-power identities, every free solution with 1<α<5/4 and L² forcing and drift has both power and drift norms bounded by the forcing norm, satisfies the trace-pairing energy identity, and has the sum of gradient and trace norms bounded by a constant depending only on α times the forcing norm.

**The free bounds interface follows.** Proved result `freeBounds_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a free solution with L² forcing has separate power and drift norms bounded by the forcing norm, the stated trace-pairing energy identity and a uniform bound on the sum of square-root gradient and trace energies.

### Breakdown.FracCert.FreeExists

Extends solvability of the free equation from smooth Fourier data to arbitrary square-integrable data using density and completeness.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeExists.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.FreeExistsInternal`.

**Axial turns preserve sums.** Proved result `axialTurn_add`: Under the stated hypotheses, axial turns preserve sums. Source: `Breakdown.FracCert.FreeExists:15`.

**Axial turns preserve scaling.** Proved result `axialTurn_smul`: Under the stated hypotheses, axial turns preserve scaling. Source: `Breakdown.FracCert.FreeExists:18`.

**Axial turns preserve differences.** Proved result `axialTurn_sub`: Under the stated hypotheses, axial turns preserve differences. Source: `Breakdown.FracCert.FreeExists:21`.

**Axial turns are continuous.** Proved result `axialTurn_continuous`: Under the stated hypotheses, axial turns are continuous.

**Coordinates reconstruct each vector.** Proved result `sum_unit`: Under the stated hypotheses, coordinates reconstruct each vector. Source: `Breakdown.FracCert.FreeExists:28`.

**Basis convergence gives convergence.** Proved result `clm_tendsto`: Under the stated hypotheses, basis convergence gives convergence.

**The concrete L² norm is the Lp norm.** Proved result `l2Norm_eq`: Under the stated hypotheses, the concrete L² norm is the Lp norm. Source: `Breakdown.FracCert.FreeExists:43`.

**Difference norms agree in L².** Proved result `l2Norm_sub`: Under the stated hypotheses, difference norms agree in L².

**L² fields pair integrably.** Proved result `inner_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.FreeExists:54`.

**Test fractional powers lie in L⁶⁄⁵.** Proved result `power_memLp`: Under the stated hypotheses, test fractional powers lie in L⁶⁄⁵.

**Six and six-fifths are conjugate.** Proved result `conj_six`: Under the stated hypotheses, six and six-fifths are conjugate.

**The norm of an L⁶ field lies in L⁶.** Proved result `six_memLp`: Under the stated hypotheses, the norm of an L⁶ field lies in L⁶.

**Fractional-power tests pair integrably.** Proved result `pair_integrable`: Under the stated hypotheses, fractional-power tests pair integrably.

**Hölder bounds the test pairing.** Proved result `pair_bound`: Under the stated hypotheses, Hölder bounds the test pairing.

**Second-order fields admit differences.** Proved result `sub_field`: Under the stated hypotheses, second-order fields admit differences.

**Weak powers admit differences.** Proved result `sub_power`: Under the stated hypotheses, weak powers admit differences.

**Drift fields preserve differences.** Proved result `drift_sub`: Under the stated hypotheses, drift fields preserve differences. Source: `Breakdown.FracCert.FreeExists:138`.

**Square-root bounds control energy.** Proved result `sq_bound`: Under the stated hypotheses, square-root bounds control energy.

**Vanishing powers imply vanishing.** Proved result `tendsto_of_pow`: Under the stated hypotheses, vanishing powers imply vanishing.

**Free solutions survive L² limits.** Proved result `closure_core`: Under the stated hypotheses, free solutions survive L² limits.

**Source namespace:** `Breakdown.SteadyCert`.

**The free equation is solvable.** Proved result `freeExists_of`: Under the stated assumptions, this establishes that for 1<α<5/4, every solenoidal L² forcing in the prescribed symmetry class has a second-order free solution with weak fractional power and L² drift satisfying drift plus power equals the forcing almost everywhere.

### Breakdown.FracCert.FreeNice

Realizes a Fourier profile symbol as a twice differentiable solenoidal field with finite energy and a weak fractional power.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeNice.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile symbols are measurable.** Proved result `profile_aesm`: Under the stated hypotheses, profile symbols are measurable. Source: `Breakdown.FracCert.FreeNice:16`.

**Low moments of the symbol are integrable.** Proved result `profile_integrable_pow`: Under the stated hypotheses, low moments of the symbol are integrable.

**The realized profile is C².** Proved result `contDiff_profileField`: Under the stated hypotheses, the realized profile is C².

**The realized profile is solenoidal.** Proved result `divergence_profileField`: Under the stated hypotheses, the realized profile is solenoidal.

**Profile symbols give smooth fields.** Proved result `profileSymbolSmooth`: Under the stated assumptions, this establishes that for 1<α<5/4, an admissible profile symbol realizes a C² vector field with vanishing classical divergence.

**Classical derivatives are weak ones.** Proved result `weak_of_contDiff`: Under the stated hypotheses, classical derivatives are weak ones.

**Second derivatives agree componentwise.** Proved result `second_apply`: Under the stated hypotheses, second derivatives agree componentwise.

**A power bound gives integrability.** Proved result `integrable_of_rpow_bound`: Under the stated hypotheses, a power bound gives integrability.

**The Fourier derivative factor is bounded.** Proved result `norm_mult_le`: Under the stated hypotheses, the Fourier derivative factor is bounded.

**Differentiation raises the power bound.** Proved result `mult_bound`: Under the stated hypotheses, differentiation raises the power bound.

**Squaring doubles the power bound.** Proved result `sq_bound`: Under the stated hypotheses, squaring doubles the power bound. Source: `Breakdown.FracCert.FreeNice:170`.

**Fourier multiplication is measurable.** Proved result `mult_aesm`: Under the stated hypotheses, Fourier multiplication is measurable.

**Derivatives act on Fourier symbols.** Proved result `fderiv_niceField_apply`: Under the stated hypotheses, derivatives act on Fourier symbols.

**Compact symbols have finite L² energy.** Proved result `profile_facts`: Under the stated hypotheses, compact symbols have finite L² energy.

**The first symbol moment is integrable.** Proved result `moment_integrable`: Under the stated hypotheses, the first symbol moment is integrable.

**Realized derivatives have finite energy.** Proved result `energy_profileField`: Under the stated hypotheses, realized derivatives have finite energy.

**Profile symbols give finite energy.** Proved result `profileSymbolEnergy`: Under the stated assumptions, this establishes that for 1<α<5/4, the physical field realized by an admissible profile symbol has finite gradient energy and finite full Hessian energy.

**Inverse transforms satisfy a pairing.** Proved result `pair_scalar`: Under the stated hypotheses, inverse transforms satisfy a pairing.

**Inverse transforms of L¹ are continuous.** Proved result `continuous_inverseTransform_of`: Under the stated hypotheses, inverse transforms of L¹ are continuous.

**L¹ norms bound inverse transforms.** Proved result `norm_inverseTransform_le_of`: Under the stated hypotheses, l¹ norms bound inverse transforms.

**Vector pairings split by coordinate.** Proved result `pair_vector`: Under the stated hypotheses, vector pairings split by coordinate.

**Frequency weights realize weak powers.** Proved result `power_profileField`: For 1<α<5/4 and an admissible profile symbol w, the inverse field of (2π‖ξ‖)^(2α)w is the weak fractional power of the inverse field of w.

**Profile symbols give weak powers.** Proved result `profileSymbolPower`: Under the stated assumptions, this establishes that for 1<α<5/4, multiplying an admissible profile symbol by (2π‖ξ‖)^(2α) realizes the weak fractional power of its physical field.

**Symbol properties give realization.** Proved result `profileSymbolRealize_of`: Under the stated assumptions, this establishes that for 1<α<5/4, an admissible profile symbol with the prescribed physical symmetry realizes a second-order field whose weak fractional power is obtained by multiplying its symbol by (2π‖ξ‖)^(2α).

**Nice data give free solutions.** Proved result `freeExistsNice_of`: Under the stated assumptions, this establishes that for 1<α<5/4, every nice solenoidal forcing in the prescribed symmetry class has a second-order free solution with weak fractional power and L² drift satisfying the free equation almost everywhere.

### Breakdown.FracCert.FreeSymbolExists

Closes the Fourier construction of a free fractional solution from its smoothness, decay, equation and symmetry properties.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExists.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Four symbol properties give existence.** Proved result `freeSymbolExists_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

**Small-frequency bounds give existence.** Proved result `freeSymbolExists_of_small`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

**Core bounds give symbol existence.** Proved result `freeSymbolExists_of_core`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

**A free solution symbol exists.** Proved result `freeSymbolExists`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice forcing in the symmetry class, an admissible profile symbol exists in that class and solves the free frequency equation away from zero.

### Breakdown.FracCert.FreeSymbolExistsBasic

Checks support, conjugation symmetry and solenoidality of the explicit free Fourier solution.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsBasic.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolExistsInternal`.

**Axial rotation has three coordinates.** Proved result `rot_coord`: Under the stated hypotheses, axial rotation has three coordinates.

**Axial rotations preserve norms.** Proved result `rot_norm`: Under the stated hypotheses, axial rotations preserve norms.

**Axial rotations preserve negation.** Proved result `rot_neg`: Under the stated hypotheses, axial rotations preserve negation.

**Complex rotations have three coordinates.** Proved result `rotC_coord`: Under the stated hypotheses, complex rotations have three coordinates.

**Conjugation acts on each coordinate.** Proved result `conj_coord`: Under the stated hypotheses, conjugation acts on each coordinate.

**Rotation commutes with conjugation.** Proved result `rotC_conj`: Under the stated hypotheses, rotation commutes with conjugation.

**Rotation fixes the zero vector.** Proved result `rotC_zero`: Under the stated hypotheses, rotation fixes the zero vector.

**Complex conjugation as an isometry.** Definition `conjIsometry`: This equips coordinatewise complex conjugation with its real linear isometry structure.

**The free symbol vanishes far away.** Proved result `support_zero`: Under the stated hypotheses, the free symbol vanishes far away.

**The free symbol has real symmetry.** Proved result `conjSymmetric`: Under the stated hypotheses, the free symbol has real symmetry.

**Rotation transfers to the frequency.** Proved result `pair_rotC`: Under the stated hypotheses, rotation transfers to the frequency.

**The free symbol is solenoidal.** Proved result `divergence`: Under the stated hypotheses, the free symbol is solenoidal.

### Breakdown.FracCert.FreeSymbolExistsBound

Promotes near-zero bounds for the free Fourier solution to global derivative bounds using compact support and smoothness away from zero.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsBound.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolBoundInternal`.

**All free derivatives vanish far away.** Proved result `far_zero`: Under the stated hypotheses, all free derivatives vanish far away.

**Free derivatives are continuous off zero.** Proved result `deriv_continuousOn`: Under the stated hypotheses, free derivatives are continuous off zero.

**Source namespace:** `Breakdown.SteadyCert`.

**Local decay gives global decay.** Proved result `freeSolutionBound_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and nice input data, each jth derivative of the free Fourier solution is bounded by C‖ξ‖^(2α−4−j) at every nonzero frequency.

### Breakdown.FracCert.FreeSymbolExistsClass

Transports the prescribed rotational and reflection symmetries through the explicit free Fourier inverse.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsClass.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolClassInternal`.

**Fourier transforms respect linear maps.** Proved result `transform_clm`: Under the stated hypotheses, Fourier transforms respect linear maps.

**Inverse transforms respect linear maps.** Proved result `inverseTransform_clm`: Under the stated hypotheses, inverse transforms respect linear maps.

**Compatible spatial and complex actions.** Structure `Compatible`: This proposition bundles commutation of the spatial and complex actions with axial rotations and compatibility with taking real parts and complexification.

**Field symmetry implies symbol symmetry.** Proved result `symbol_equiv`: Under the stated hypotheses, field symmetry implies symbol symmetry.

**Free solutions preserve symmetry.** Proved result `solution_equiv`: Under the stated hypotheses, free solutions preserve symmetry.

**Symbol symmetry implies field symmetry.** Proved result `field_equiv`: Under the stated hypotheses, symbol symmetry implies field symmetry.

**Axial rotation as a linear map.** Definition `rotLin`: This equips axial rotation through θ with its real linear map structure.

**Axial rotation as an isometry.** Definition `rotIso`: This equips axial rotation through θ with its norm-preserving linear equivalence structure.

**Reflection as a linear map.** Definition `mirrorLin`: This equips reflection of the third spatial coordinate with its real linear map structure.

**Reflection preserves norms.** Proved result `mirror_norm`: Under the stated hypotheses, reflection preserves norms. Source: `Breakdown.FracCert.FreeSymbolExistsClass:81`.

**Reflection as an isometry.** Definition `mirrorIso`: This equips reflection of the third spatial coordinate with its norm-preserving linear equivalence structure.

**Complex rotation as an equivalence.** Definition `rotCLE`: This equips rotation of the first two complex coordinates through θ with its continuous complex linear equivalence structure and inverse rotation through −θ.

**Reflection of complex vectors.** Definition `mirrorC`: This defines complex reflection by retaining the first two coordinates and negating the third.

**Complex reflection as an equivalence.** Definition `mirrorCLE`: This equips complex reflection with its continuous complex linear equivalence structure and uses reflection itself as its inverse.

**The discrete turn is compatible.** Proved result `turn_compatible`: Under the stated hypotheses, the discrete turn is compatible.

**Reflection is compatible.** Proved result `mirror_compatible`: Under the stated hypotheses, reflection is compatible.

**Free solutions retain class symmetry.** Proved result `solution_class`: Under the stated hypotheses, free solutions stay in the symmetry class.

**Source namespace:** `Breakdown.SteadyCert`.

**The free solution preserves its class.** Proved result `freeSolutionClass`: Under the stated assumptions, this establishes that for 1<α<5/4, the explicit free Fourier solution preserves the prescribed discrete rotation and reflection class of the physical forcing.

### Breakdown.FracCert.FreeSymbolExistsCore

Proves the near-origin power bounds for the undamped core of the free Fourier solution by homogeneity along the rotation and dilation flow.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsCore.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolCoreInternal`.

**Flow norms scale exponentially.** Proved result `flow_norm`: Under the stated hypotheses, flow norms scale exponentially.

**The kernel vanishes before time zero.** Proved result `kernel_nonpos`: Under the stated hypotheses, the kernel vanishes before time zero.

**The core obeys a scaling identity.** Proved result `core_homog`: Under the stated hypotheses, the core obeys a scaling identity.

**Complex rotations have a uniform bound.** Proved result `rotC_bound`: Under the stated hypotheses, complex rotations have a uniform bound.

**Core derivatives have power bounds.** Proved result `core_bound`: Under the stated assumptions, this establishes that for 1<α<5/4 and nice input data, the jth derivative of the undamped Fourier core is bounded by C‖ξ‖^(2α−4−j) near zero frequency.

**Source namespace:** `Breakdown.SteadyCert`.

**The core bound interface holds.** Proved result `freeCoreBound`: Under the stated assumptions, this establishes that for 1<α<5/4 and nice input data, the jth derivative of the undamped Fourier core is bounded by C‖ξ‖^(2α−4−j) near zero frequency.

### Breakdown.FracCert.FreeSymbolExistsEquation

Differentiates the explicit free Fourier integral along characteristics to obtain the fractional profile equation away from zero frequency.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsEquation.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolEquationInternal`.

**The integrated undamped Fourier core.** Definition `hbase`: This defines the undamped Fourier core as the integral of the characteristic kernel over positive times.

**The infinitesimal spatial turn.** Definition `turnCL`: This defines the continuous real linear map sending (x₁,x₂,x₃) to (−x₂,x₁,0).

**Projection onto the spatial axis.** Definition `axisCL`: This defines projection onto the third spatial coordinate as a continuous linear map.

**The infinitesimal complex turn.** Definition `turnCLC`: This defines the continuous real linear map sending a complex vector (z₁,z₂,z₃) to (−z₂,z₁,0).

**Projection onto the complex axis.** Definition `axisCLC`: This defines projection onto the third complex coordinate as a continuous real linear map.

**The spatial turn is (−x₂,x₁,0).** Proved result `turnCL_apply`: The continuous spatial turn map sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator.

**The axis map selects coordinate three.** Proved result `axisCL_apply`: Under the stated hypotheses, the axis map selects coordinate three.

**The complex turn is (−z₂,z₁,0).** Proved result `turnCLC_apply`: The continuous complex turn map sends (z₁,z₂,z₃) to (−z₂,z₁,0), agreeing with the complex axial generator.

**complex axis selects coordinate three.** Proved result `axisCLC_apply`: Under the stated hypotheses, the complex axis selects coordinate three.

**Zero-angle rotation is the identity.** Proved result `rot_zero`: Under the stated hypotheses, zero-angle rotation is the identity.

**Zero-angle complex rotation is identity.** Proved result `rotC_zero'`: Under the stated hypotheses, zero-angle complex rotation is identity.

**Rotation splits into three terms.** Proved result `rot_decomp`: Under the stated hypotheses, rotation splits into three terms.

**Complex rotation splits into three terms.** Proved result `rotC_decomp`: Under the stated hypotheses, complex rotation splits into three terms.

**Cosine has zero initial derivative.** Proved result `cos_deriv`: Under the stated hypotheses, scaled cosine has zero derivative at zero.

**The initial sine derivative is a.** Proved result `sin_deriv`: The function t ↦ sin(at) has derivative a at t=0.

**Complex rotations obey the product rule.** Proved result `rotC_deriv`: Under the stated hypotheses, complex rotations obey the product rule.

**Axial rotations have the turn derivative.** Proved result `rot_deriv`: Under the stated hypotheses, axial rotations have the turn derivative.

**The characteristic frequency flow.** Definition `flowPt`: This defines the characteristic frequency trajectory exp(−t/(2α)) R(at)ξ.

**The flow fixes its initial frequency.** Proved result `flow_zero`: At time zero, the characteristic frequency trajectory equals its initial frequency.

**The flow derivative is drift plus turn.** Proved result `flow_deriv`: Under the stated hypotheses, the flow derivative is drift plus turn.

**Rotation preserves scalar multiples.** Proved result `rot_smul'`: Under the stated hypotheses, rotation preserves scalar multiples.

**Rotation angles add under composition.** Proved result `rot_rot`: Under the stated hypotheses, rotation angles add under composition.

**Complex rotation angles add.** Proved result `rotC_rotC`: Under the stated hypotheses, complex rotation angles add.

**Flow shifts translate kernel time.** Proved result `kernel_shift`: Under the stated hypotheses, flow shifts translate kernel time.

**The characteristic kernel is continuous.** Proved result `kernel_cont`: Under the stated hypotheses, the characteristic kernel is continuous.

**The core integral has a finite cutoff.** Proved result `core_eq_interval`: Under the stated hypotheses, the core integral has a finite cutoff.

**The core is smooth away from zero.** Proved result `core_contDiffAt`: Under the stated hypotheses, the core is smooth away from zero.

**core satisfies its transport identity.** Proved result `core_deriv`: Under the stated hypotheses, the core satisfies its transport identity.

**Drift differentiates the frequency power.** Proved result `pow_deriv`: Under the stated hypotheses, drift differentiates the frequency power.

**The kernel at zero is damped data.** Proved result `kernel_zero`: Under the stated hypotheses, the kernel at zero is damped data.

**Complex turns preserve scaling.** Proved result `turnC_smul`: Under the stated hypotheses, complex turns preserve scaling.

**The free symbol solves its equation.** Proved result `equation`: Under the stated hypotheses, the free symbol solves its equation.

**Source namespace:** `Breakdown.SteadyCert`.

**The free equation interface holds.** Proved result `freeSolutionEquation`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice input symbol, applying the profile operator to the explicit free Fourier solution recovers the input at every nonzero frequency.

### Breakdown.FracCert.FreeSymbolExistsExp

Bounds derivatives of radial frequency powers and their exponential multiplier near zero.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsExp.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolExpInternal`.

**Frequency derivatives are continuous.** Proved result `pow_deriv_cont`: Under the stated hypotheses, frequency derivatives are continuous.

**Frequency derivatives have power bounds.** Proved result `pow_deriv_bound`: Under the stated hypotheses, frequency derivatives have power bounds.

**Power bounds for exponential derivatives.** Proved result `exp_bound`: Under the stated assumptions, this establishes that for 1<α<5/4, each jth derivative of exp((2π‖ξ‖)^(2α)) is bounded by C‖ξ‖^(−j) for nonzero frequencies of norm at most one.

**Source namespace:** `Breakdown.SteadyCert`.

**The exponential bound interface holds.** Proved result `freeExpBound`: Under the stated assumptions, this establishes that for 1<α<5/4, each jth derivative of exp((2π‖ξ‖)^(2α)) is bounded by C‖ξ‖^(−j) for nonzero frequencies of norm at most one.

### Breakdown.FracCert.FreeSymbolExistsParts

Defines the explicit free Fourier solution and the smoothness, decay, equation and symmetry contracts used to certify it.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Complex axial rotation.** Definition `axialRotationC`: This defines axial rotation of a complex vector by the usual sine and cosine matrix on its first two coordinates, leaving the third unchanged.

**The free-solution damping weight.** Definition `freeWeight`: This defines the characteristic damping weight exp(−(1−2/α)τ) exp(−(exp τ−1)(2π‖ξ‖)^(2α)).

**The free Fourier solution.** Definition `freeSolution`: This defines the free Fourier solution as the positive-time integral of damped, rotated input data evaluated along the expanding frequency characteristics.

**The free solution is smooth off zero.** Proposition `FreeSolutionSmoothStatement`: This proposition requires that for 1<α<5/4 and a nice input symbol, the explicit free Fourier solution is infinitely differentiable away from zero frequency.

**Free derivatives satisfy power bounds.** Proposition `FreeSolutionBoundStatement`: This proposition requires that for 1<α<5/4 and nice input data, each jth derivative of the free Fourier solution is bounded by C‖ξ‖^(2α−4−j) at every nonzero frequency.

**Free derivatives have local power bounds.** Proposition `FreeSolutionSmallBoundStatement`: This proposition requires that for 1<α<5/4 and nice input data, each jth derivative of the free Fourier solution has a bound C‖ξ‖^(2α−4−j) in some punctured neighborhood of zero.

**The free solution solves its equation.** Proposition `FreeSolutionEquationStatement`: This proposition requires that for 1<α<5/4 and a nice input symbol, applying the profile operator to the explicit free Fourier solution recovers the input at every nonzero frequency.

**The free solution preserves symmetry.** Proposition `FreeSolutionClassStatement`: This proposition requires that for 1<α<5/4, the explicit free Fourier solution preserves the prescribed discrete rotation and reflection class of the physical forcing.

### Breakdown.FracCert.FreeSymbolExistsSmall

Separates the near-origin estimate for the free Fourier solution into an undamped core estimate and an exponential-factor estimate.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsSmall.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Core derivatives satisfy power bounds.** Proposition `FreeCoreBoundStatement`: This proposition requires that for 1<α<5/4 and nice input data, the jth derivative of the undamped Fourier core is bounded by C‖ξ‖^(2α−4−j) near zero frequency.

**Exponential derivatives satisfy bounds.** Proposition `FreeExpBoundStatement`: This proposition requires that for 1<α<5/4, each jth derivative of exp((2π‖ξ‖)^(2α)) is bounded by C‖ξ‖^(−j) for nonzero frequencies of norm at most one.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolSmallInternal`.

**Core and exponential bounds combine.** Proved result `small_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and nice input data, each jth derivative of the free Fourier solution has a bound C‖ξ‖^(2α−4−j) in some punctured neighborhood of zero.

**Source namespace:** `Breakdown.SteadyCert`.

**The local free bound follows.** Proved result `freeSolutionSmallBound_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and nice input data, each jth derivative of the free Fourier solution has a bound C‖ξ‖^(2α−4−j) in some punctured neighborhood of zero.

### Breakdown.FracCert.FreeSymbolExistsSmooth

Uses compact support of the Fourier data to make the characteristic integral locally finite and smooth away from zero frequency.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeSymbolExistsSmooth.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeSymbolSmoothInternal`.

**Real inclusion into complex is smooth.** Proved result `ofReal_smooth`: Under the stated hypotheses, real inclusion into complex is smooth.

**Smooth rotations compose smoothly.** Proved result `rot_comp`: Under the stated hypotheses, smooth rotations compose smoothly.

**Complex rotations compose smoothly.** Proved result `rotC_comp`: Under the stated hypotheses, complex rotations compose smoothly.

**Frequency powers are smooth off zero.** Proved result `pow_smoothAt`: Under the stated hypotheses, frequency powers are smooth off zero.

**The exponentially damped symbol.** Definition `damped`: This defines the damped input symbol by multiplying it by exp(−(2π‖ξ‖)^(2α)).

**The damped nice symbol is smooth.** Proved result `damped_smooth`: Under the stated hypotheses, the damped nice symbol is smooth.

**The characteristic integral kernel.** Definition `kernel`: This defines the characteristic kernel by rotating the damped input along expanding, counterrotating frequencies and multiplying by exp(−(1−2/α)τ).

**The kernel is jointly smooth.** Proved result `kernel_smooth`: Under the stated hypotheses, the kernel is jointly smooth.

**Complex rotations preserve scaling.** Proved result `rotC_smul`: Under the stated hypotheses, complex rotations preserve scaling.

**Axial rotations preserve norms.** Proved result `rot_norm'`: Under the stated hypotheses, axial rotations preserve norms.

**Frequency powers respect dilation.** Proved result `pow_scale`: Under the stated hypotheses, frequency powers respect dilation.

**The integrand splits off its exponential.** Proved result `integrand_eq`: Under the stated hypotheses, the integrand splits off its exponential.

**The free solution splits off damping.** Proved result `solution_eq`: Under the stated hypotheses, the free solution splits off damping.

**The kernel has a finite time cutoff.** Proved result `kernel_far`: Under the stated hypotheses, the kernel has a finite time cutoff.

**The free solution is smooth off zero.** Proved result `solution_smooth`: Under the stated hypotheses, the free solution is smooth off zero.

**Source namespace:** `Breakdown.SteadyCert`.

**The free smoothness interface holds.** Proved result `freeSolutionSmooth`: Under the stated assumptions, this establishes that for 1<α<5/4 and a nice input symbol, the explicit free Fourier solution is infinitely differentiable away from zero frequency.

### Breakdown.FracCert.FreeUnique

Uses the energy identities to prove uniqueness of free solutions, including the fact that an L⁶ field with zero weak gradient vanishes.

This supplies the Fourier and free-operator analysis behind the fractional analogue of the linear estimates used in the certificate strategy; fractional statements are not used by the paper according to the source README.

Source: `lean/Breakdown/FracCert/FreeUnique.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeUnique.Internal`.

**Zero basis values give the zero map.** Proved result `clm_zero_of_unit`: Under the stated hypotheses, zero basis values give the zero map. Source: `Breakdown.FracCert.FreeUnique:15`.

**Zero weak gradients kill convolutions.** Proved result `conv_deriv_zero`: Under the stated hypotheses, zero weak gradients kill convolutions.

**Zero gradients give constant mollifiers.** Proved result `conv_const`: Under the stated hypotheses, a mollified zero-gradient field is constant.

**An L⁶ field with zero gradient vanishes.** Proved result `velocity_zero`: Under the stated hypotheses, an L⁶ field with zero gradient vanishes.

**Zero symbol energy kills derivatives.** Proved result `second_zero_of_energy`: Under the stated hypotheses, zero symbol energy kills derivatives.

**Source namespace:** `Breakdown.SteadyCert`.

**The free solution is unique.** Proved result `freeUnique_of`: Under the stated assumptions, this establishes that for 1<α<5/4, a second-order field with weak fractional power, L² drift and zero free residual has velocity, both derivative fields and fractional power all zero almost everywhere.

### Breakdown.FracCert.GradientAdd

Proves that weak gradient fields are closed under addition, handling the measurability required by their test identities.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/GradientAdd.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.GradientAddInternal`.

**Absolute values are bounded by squares.** Proved result `abs_le_one_add_sq`: Under the stated hypotheses, absolute values are bounded by squares.

**A local square bound implies local L¹.** Proved result `locInt_of_bound`: Under the stated hypotheses, a local square bound implies local L¹.

**Compact tests pair integrably.** Proved result `pair_integrable`: Under the stated hypotheses, compact tests pair integrably.

**Gradient components are locally L¹.** Proved result `comp_locInt`: Under the stated hypotheses, gradient components are locally L¹.

**Test derivatives are continuous.** Proved result `deriv_continuous`: Under the stated hypotheses, test derivatives are continuous.

**Test derivatives have compact support.** Proved result `deriv_support`: Under the stated hypotheses, test derivatives have compact support.

**Test pairings force measurability.** Proved result `aesm_of_pairings`: Under the stated hypotheses, test pairings force measurability.

**The nonmeasurable case has zero pairings.** Proved result `pairing_zero`: If the potential in the weak-gradient identities is not almost-everywhere strongly measurable while the vector field has the stated local square integrability, each compact scalar-test pairing with a field coordinate is zero.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak gradient fields admit sums.** Proved result `gradientAdd`: Under the stated assumptions, this establishes that the sum of two weak gradient fields is a weak gradient field.

### Breakdown.FracCert.GradientClosed

Identifies the closed L² subspace of gradient fields through orthogonality to solenoidal fields.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/GradientClosed.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.GradientClosedInternal`.

**Gradient fields respect almost equality.** Proved result `gradient_congr`: Under the stated hypotheses, gradient fields respect almost equality.

**Difference norms equal squared integrals.** Proved result `norm_sub_sq`: Under the stated hypotheses, difference norms equal squared integrals.

**Orthogonality implies gradient closure.** Proved result `closed_of_orthogonal`: Under the stated assumptions, this establishes that strong L² limits of square-integrable weak gradient fields are weak gradient fields.

**Source namespace:** `Breakdown.SteadyCert`.

**Gradient closure follows from duality.** Proved result `gradientClosed_of_orthogonal`: Under the stated assumptions, this establishes that strong L² limits of square-integrable weak gradient fields are weak gradient fields.

**The L² gradient fields form a closed set.** Proved result `gradientClosed`: Under the stated assumptions, this establishes that strong L² limits of square-integrable weak gradient fields are weak gradient fields.

### Breakdown.FracCert.GradientOrthogonal

Shows that gradient fields are orthogonal to square-integrable solenoidal fields using curl identities and translated pairings.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/GradientOrthogonal.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.GradientOrthogonalInternal`.

**Reversed scalar multiplication.** Abbreviation `mulFlip`: This abbreviates real scalar multiplication with its two arguments exchanged, represented as a continuous bilinear map.

**Flipped multiplication is r times a.** Proved result `mulFlip_apply`: Evaluating the flipped scalar multiplication map at a and r gives the real product r·a.

**Test derivatives remain tests.** Proved result `test_dir`: Under the stated hypotheses, test derivatives remain tests.

**Smooth mixed derivatives commute.** Proved result `second_dir`: Under the stated hypotheses, smooth mixed derivatives commute.

**Gradient fields have symmetric curl data.** Proved result `curl_symm`: Under the stated hypotheses, gradient fields have symmetric curl data.

**Zero basis values give the zero map.** Proved result `clm_zero_of_unit`: Under the stated hypotheses, zero basis values give the zero map. Source: `Breakdown.FracCert.GradientOrthogonal:49`.

**Zero weak derivatives kill smoothing.** Proved result `conv_hasFDerivAt_zero`: Under the stated hypotheses, vanishing weak derivatives kill smoothing.

**Continuous decay gives a global bound.** Proved result `bounded_of`: Under the stated hypotheses, continuous decay gives a global bound.

**The smoothed constant must vanish.** Proved result `conv_zero`: Under the stated hypotheses, the smoothed constant must vanish.

**The zero-derivative pairing vanishes.** Proved result `zero_of_parts`: Under the stated hypotheses, the zero-derivative pairing vanishes.

**Source namespace:** `Breakdown.SteadyCert`.

**Gradient and solenoidal orthogonality.** Proved result `gradientOrthogonal`: Under the stated assumptions, this establishes that every square-integrable weak gradient field has zero integral pairing with every solenoidal L² field.

### Breakdown.FracCert.GradientOrthogonalParts

Develops translated L² pairings, their decay and differentiated convolution identities for the gradient-orthogonality proof.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/GradientOrthogonalParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.GradientOrthogonalInternal`.

**The translated field pairing.** Definition `pairShift`: This defines the translated pairing ∫⟨ζ(x),Q(x+y)⟩ dx.

**The generic integral L² size.** Definition `sq2'`: This defines the square root of the integral of the squared norm of a general normed-space-valued field.

**The vector integral L² size.** Definition `sq2`: This defines the square root of the integral of the squared norm of a spatial vector field.

**The integral L² size is nonnegative.** Proved result `sq2_nonneg`: Under the stated hypotheses, the integral L² size is nonnegative.

**Translation preserves L².** Proved result `memLp_shift`: Under the stated hypotheses, translation preserves L².

**Translation preserves the L² size.** Proved result `sq2_shift`: Under the stated hypotheses, translation preserves the L² size.

**L² fields pair integrably.** Proved result `integrable_pair`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.GradientOrthogonalParts:35`.

**Cauchy-Schwarz bounds the pairing.** Proved result `abs_pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds the pairing. Source: `Breakdown.FracCert.GradientOrthogonalParts:42`.

**Compact continuous fields approximate L².** Proved result `approx`: Under the stated hypotheses, compact continuous fields approximate L².

**Pairing errors obey a two-term bound.** Proved result `pair_sub`: Under the stated hypotheses, pairing errors obey a two-term bound.

**Compact pairings approximate uniformly.** Proved result `uniform_approx`: Under the stated hypotheses, compact pairings approximate uniformly.

**Shifted pairings are convolutions.** Proved result `pairShift_conv`: Under the stated hypotheses, shifted pairings are convolutions.

**Compact pairings decay continuously.** Proved result `approx_cont`: Under the stated hypotheses, compact pairings are continuous and decay.

**Translated L² pairings are continuous.** Proved result `continuous_pairShift`: Under the stated hypotheses, translated L² pairings are continuous.

**Translated L² pairings decay at infinity.** Proved result `tendsto_pairShift`: Under the stated hypotheses, translated L² pairings decay at infinity.

**Shifted weighted pairings are integrable.** Proved result `integrable_pair_shift`: Under the stated hypotheses, shifted weighted pairings are integrable.

**Derivative norms control gradient norms.** Proved result `grad_norm_le`: Under the stated hypotheses, derivative norms control gradient norms.

**Scalar gradients obey the product rule.** Proved result `grad_mul`: Under the stated hypotheses, scalar gradients obey the product rule.

**Smooth scalar gradients are continuous.** Proved result `continuous_grad`: Under the stated hypotheses, smooth scalar gradients are continuous.

**Solenoidal fields annihilate gradients.** Proved result `cut_pair`: Under the stated hypotheses, solenoidal fields annihilate gradients.

**Fubini exchanges the shifted pairing.** Proved result `exchange_pair`: Under the stated hypotheses, fubini exchanges the shifted pairing.

**Reversed scalar multiplication.** Abbreviation `scalFlip`: This abbreviates real multiplication with its two arguments exchanged as a continuous bilinear map.

**Flipped multiplication is r times a.** Proved result `scalFlip_apply`: Evaluating the flipped scalar multiplication map at a and r gives the real product r·a.

**Shifted integrals are convolutions.** Proved result `shift_conv`: Under the stated hypotheses, shifted integrals are convolutions.

**Test convolution differentiates smoothly.** Proved result `deriv_shift`: Under the stated hypotheses, test convolution differentiates smoothly.

**Test derivatives retain compact support.** Proved result `test_dir'`: Under the stated hypotheses, test derivatives are continuous and compact.

**Curl symmetry survives translation.** Proved result `curl_shift`: Under the stated hypotheses, curl symmetry survives translation.

**Pairing derivatives vanish weakly.** Proved result `integral_deriv_pairShift`: Under the stated hypotheses, pairing derivatives vanish weakly.

### Breakdown.FracCert.HeatDivRegular

Differentiates the projected heat-divergence operator under an integrable kernel to propagate smoothness and derivative bounds.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/HeatDivRegular.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracInternal.HeatDivRegular`.

**derivative bound gives Lipschitz control.** Proved result `deriv_increment`: Under the stated hypotheses, one more derivative gives a Lipschitz bound.

**Top and zeroth derivatives give bounds.** Proved result `step_bound`: Under the stated hypotheses, values and top derivatives control the rest.

**Derivative bounds interpolate.** Proved result `interp`: Under the stated hypotheses, derivative bounds interpolate.

**Dominated integrals preserve derivatives.** Proved result `param_contDiff`: Under the stated hypotheses, dominated integrals preserve derivatives.

**Convolution preserves derivatives.** Proved result `conv_contDiff`: Under the stated hypotheses, integrable convolutions preserve derivatives.

**Kernel mass controls convolution norms.** Proved result `conv_norm_le`: Under the stated hypotheses, kernel mass controls convolution norms.

**Scaled convolutions are continuous.** Proved result `conv_continuous`: Under the stated hypotheses, scaled convolutions are continuous.

**Kernel rescaling gives its Jacobian.** Proved result `scale_integral`: Under the stated hypotheses, kernel rescaling gives its Jacobian.

**Kernel values rescale from time one.** Proved result `kernel_re`: For α>0 and t>0, the real kernel at (t,y) equals t^(−2/α) times its time-one value at t^(−1/(2α))y, assuming the kernel-decay interface.

**Coordinates reconstruct each vector.** Proved result `basis_expand`: Under the stated hypotheses, coordinates reconstruct each vector.

**Joint scaling preserves continuity.** Proved result `cont_scaled`: Under the stated hypotheses, joint scaling preserves continuity.

**Source namespace:** `Breakdown.FracCert`.

**Kernel decay gives heat regularity.** Proved result `heatDivRegular_of`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0≤β<3, a Cʲ tensor with bounded jth derivative and a β-weighted value bound has Cʲ heat-divergence convolutions, jointly continuous derivatives through order j and bounds Ct^(−1/(2α))(A+B) for 0<t≤1.

**Heat-divergence regularity holds.** Proved result `heatDivRegular`: Under the stated assumptions, this establishes that for 1<α<5/4 and 0≤β<3, a Cʲ tensor with bounded jth derivative and a β-weighted value bound has Cʲ heat-divergence convolutions, jointly continuous derivatives through order j and bounds Ct^(−1/(2α))(A+B) for 0<t≤1.

### Breakdown.FracCert.HeldExists

Solves the nonlinear held equation by contraction inside the certificate radius, using the bordered inverse and the a priori estimate.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldExists.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak fractional powers admit differences.** Proposition `WeakPowerSubStatement`: This proposition requires that for 1<α<5/4, subtracting two L⁶ fields with weak fractional powers subtracts their weak fractional powers.

**defect gives an admissible right side.** Proposition `DefectRightSideStatement`: This proposition requires that a valid fractional certificate makes its defect square integrable and makes minus that defect minus the correction convection an admissible symmetry-class forcing.

**Source namespace:** `Breakdown.FracInternal.HeldExists`.

**The components of a held state.** Structure `HeldState`: This structure stores a correction velocity, its candidate first and second derivatives, a candidate fractional power and a finite vector of multiplier corrections.

**The zero held state.** Definition `zero`: This defines the held state whose velocity, derivatives, fractional power and multiplier corrections are all zero.

**Distance between two held states.** Definition `dsz`: This defines the distance of two held states by applying the certificate size to the differences of their first derivatives, second derivatives and multipliers.

**The size of a held state.** Definition `sz`: This defines the size of a held state by applying the certificate size to its two derivative fields and its multiplier vector.

**Axial turns preserve differences.** Proved result `axialTurn_sub`: Under the stated hypotheses, axial turns preserve differences. Source: `Breakdown.FracCert.HeldExists:46`.

**Gradient fields admit negatives.** Proved result `isGradientField_neg`: Under the stated hypotheses, negatives of gradient fields are gradients.

**The zero field is a gradient.** Proved result `isGradientField_zero`: Under the stated hypotheses, the zero field is a gradient.

**The zero field is second order.** Proved result `secondOrder_zero`: Under the stated hypotheses, the zero field is second order.

**The zero held state has zero size.** Proved result `size_zero`: Under the stated hypotheses, the zero held state has zero size.

**Negation preserves certificate size.** Proved result `size_neg`: Under the stated hypotheses, negation preserves certificate size.

**Distance from zero equals size.** Proved result `dsz_zero_right`: Under the stated hypotheses, distance from zero equals size.

**Held-state distance is symmetric.** Proved result `dsz_comm`: Under the stated hypotheses, held-state distance is symmetric.

**Held-state distance is nonnegative.** Proved result `dsz_nonneg`: Under the stated hypotheses, held-state distance is nonnegative.

**Certificate energy is nonnegative.** Proved result `energy_nonneg`: Under the stated hypotheses, certificate energy is nonnegative. Source: `Breakdown.FracCert.HeldExists:97`.

**Squared size controls energy.** Proved result `energy_le`: Under the stated hypotheses, squared size controls energy.

**Size controls the square-root energy.** Proved result `sqrt_energy_le`: Under the stated hypotheses, size controls the square-root energy.

**The concrete L² norm is the Lp norm.** Proved result `l2Norm_eq`: Under the stated hypotheses, the concrete L² norm is the Lp norm. Source: `Breakdown.FracCert.HeldExists:118`.

**The concrete L² norm is nonnegative.** Proved result `l2Norm_nonneg`: Under the stated hypotheses, the concrete L² norm is nonnegative. Source: `Breakdown.FracCert.HeldExists:125`.

**L² differences obey a triangle bound.** Proved result `l2Norm_sub_le`: Under the stated hypotheses, L² difference norms obey a triangle bound.

**One norm is bounded by another and error.** Proved result `l2Norm_le_add_sub`: Under the stated hypotheses, one norm is bounded by another and error.

**Bounds for convection differences.** Proved result `product_bound`: Under the stated hypotheses, nonlinear differences have a product bound.

**The quadratic term is energy controlled.** Proved result `product_self`: Under the stated hypotheses, the quadratic term is energy controlled.

**L² Cauchy sequences converge.** Proved result `l2_limit`: Under the stated hypotheses, L² Cauchy sequences converge.

**L² limits agree almost everywhere.** Proved result `l2_unique`: Under the stated hypotheses, L² limits agree almost everywhere.

**The scalar radius bound is monotone.** Proved result `g_mono`: Under the stated hypotheses, the scalar radius bound is monotone.

**The scalar radius bound is subadditive.** Proved result `g_add`: Under the stated hypotheses, the scalar radius bound is subadditive.

**The scalar bound scales positively.** Proved result `g_smul`: Under the stated hypotheses, the scalar bound scales positively.

**The inverse bound is nonnegative.** Proved result `bc_nonneg`: Under the stated hypotheses, the inverse bound is nonnegative.

**The inverse bound splits additively.** Proved result `bc_split`: Under the stated hypotheses, the inverse bound splits additively.

**Almost equality preserves L² norms.** Proved result `l2Norm_congr_ae`: Under the stated hypotheses, almost equality preserves L² norms.

**L² fields pair integrably.** Proved result `inner_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.HeldExists:348`.

**L² inner products equal integrals.** Proved result `inner_toLp`: Under the stated hypotheses, L² inner products equal integrals.

**Residual pairings obey a triangle bound.** Proved result `pair_triangle`: Under the stated hypotheses, residual pairings obey the triangle bound.

**Row sizes obey a triangle bound.** Proved result `rowSize_le`: Under the stated hypotheses, row sizes obey a triangle bound.

**The row maximum bounds all rows.** Proved result `rows_le`: Under the stated hypotheses, the row maximum bounds all rows.

**A priori bounds control the held size.** Proved result `apriori_rhs`: Under the stated hypotheses, a priori bounds control the held size.

**The zero input has zero inverse bound.** Proved result `boundFn_zero`: Under the stated hypotheses, the zero input has zero inverse bound.

**The projected zero norm vanishes.** Proved result `projectedNorm_zero`: Under the stated hypotheses, the projected zero norm vanishes.

**Rows of the zero field vanish.** Proved result `rowsModGrad_zero`: Under the stated hypotheses, rows of the zero field vanish.

**Linear states admit differences.** Proved result `lin_sub`: Under the stated hypotheses, linear states admit differences.

**The full linear field admits differences.** Proved result `fullField_sub`: Under the stated hypotheses, the full linear field admits differences.

**Matrix-entry pairings are integrable.** Proved result `entryInner_integrable`: Under the stated hypotheses, matrix-entry pairings are integrable.

**Pins preserve differences.** Proved result `pins_sub`: Under the stated hypotheses, pins preserve differences.

**The held radius gives a contraction.** Proved result `radius_facts`: Under the stated hypotheses, the held radius gives a contraction.

**Source namespace:** `Breakdown.SteadyCert`.

**A held nonlinear solution exists.** Proved result `heldExists`: Under the stated assumptions, this establishes that for a valid fractional certificate and every parameter in its box, a held nonlinear solution exists with correction size at most the certified held radius.

### Breakdown.FracCert.HeldLimit

Passes bounded held solutions to a limit, retaining symmetry and identifying gradient residuals through solenoidal test pairings.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldLimit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldLimitInternal`.

**L² fields pair integrably.** Proved result `inner_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.HeldLimit:16`.

**Negatives of gradients are gradients.** Proved result `gradient_neg`: Under the stated hypotheses, negatives of gradients are gradients. Source: `Breakdown.FracCert.HeldLimit:22`.

**Orthogonality characterizes gradients.** Proved result `recover`: Under the stated hypotheses, solenoidal orthogonality gives a gradient.

**Held residuals kill solenoidal tests.** Proved result `residual_orthogonal`: Under the stated hypotheses, held residuals annihilate solenoidal fields.

**Multipliers split from the residual.** Proved result `residual_split`: Under the stated hypotheses, multipliers split from the residual.

**Residual pairings split by multiplier.** Proved result `residual_pair`: Under the stated hypotheses, residual pairings split by multiplier.

**Certificate energy is nonnegative.** Proved result `energy_nonneg`: Under the stated hypotheses, certificate energy is nonnegative. Source: `Breakdown.FracCert.HeldLimit:102`.

**Size splits into energy and multipliers.** Proved result `size_sq`: Under the stated hypotheses, squared size splits energy and multipliers.

**Size bounds each multiplier coordinate.** Proved result `coord_bound`: Under the stated hypotheses, size bounds each multiplier coordinate.

**The held residual expands into its terms.** Proved result `residual_terms`: Under the stated hypotheses, the held residual expands into its terms.

**The discrete turn as a linear map.** Definition `turnLin`: This equips rotation through the discrete symmetry angle 2π/m with its real linear map structure.

**Reflection as a linear map.** Definition `mirrorLin`: This equips reflection of the third coordinate with its real linear map structure.

**axial turn commutes with discrete turns.** Proved result `axial_turn`: Under the stated hypotheses, the axial turn commutes with discrete turns.

**The axial turn commutes with reflection.** Proved result `axial_mirror`: Under the stated hypotheses, the axial turn commutes with reflection.

**Basis pairings determine vectors.** Proved result `vec_ext`: Under the stated hypotheses, basis pairings determine vectors.

**Weak powers preserve orthogonal symmetry.** Proved result `power_equivariant`: Under the stated hypotheses, weak powers preserve orthogonal symmetry.

**The discrete turn as an isometry.** Definition `turnIsom`: This equips the discrete axial turn with its norm-preserving linear equivalence structure.

**Reflection as an isometry.** Definition `mirrorIsom`: This equips reflection of the third coordinate with its norm-preserving linear equivalence structure.

**The isometry rotates through 2π/m.** Proved result `turnIsom_apply`: The discrete-turn isometry acts as the axial rotation through 2π/m used in the symmetry class.

**The mirror isometry reflects vectors.** Proved result `mirrorIsom_apply`: Under the stated hypotheses, the mirror isometry reflects vectors.

**Coordinates reconstruct each vector.** Proved result `sum_unit`: Under the stated hypotheses, coordinates reconstruct each vector. Source: `Breakdown.FracCert.HeldLimit:258`.

**Linear maps expand in a basis.** Proved result `clm_sum`: Under the stated hypotheses, linear maps expand in a basis.

**Test derivatives are continuous.** Proved result `dir_continuous`: Under the stated hypotheses, test derivatives are continuous.

**Test derivatives have compact support.** Proved result `dir_support`: Under the stated hypotheses, test derivatives have compact support.

**Weak gradients work in every direction.** Proved result `weak_dir`: Under the stated hypotheses, weak gradients work in every direction.

**Weak gradients preserve spatial symmetry.** Proved result `gradient_equivariant`: Under the stated hypotheses, weak gradients preserve spatial symmetry.

**The residual preserves spatial symmetry.** Proved result `residual_at`: Under the stated hypotheses, the residual preserves spatial symmetry.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak powers remain in their class.** Proved result `weakPowerClass_holds`: Under the stated assumptions, this establishes that for 1<α<5/4, a measurable L⁶ field in the discrete rotation and reflection class has its weak fractional power in the same class.

**Weak gradients retain class symmetry.** Proved result `gradientClass_holds`: Under the stated assumptions, this establishes that a measurable L⁶ field in the symmetry class with a measurable square-integrable weak gradient has that gradient equivariant almost everywhere under the discrete turn and reflection.

**The held residual retains its class.** Proved result `heldResidualClass_of`: Under the stated assumptions, this establishes that for a valid fractional certificate, the held residual of every admissible linear correction state preserves the prescribed symmetry class.

**The held residual lies in L².** Proved result `heldResidualSquare_of`: Under the stated assumptions, this establishes that for a valid fractional certificate and a linear correction state in the parameter box, every held residual belongs to L² and to the prescribed symmetry class.

**Held solutions have weak limits.** Proved result `heldWeakLimit_of`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a subsequence with a limiting linear state, no larger size, convergent multipliers and pins, and convergent residual pairings against every solenoidal L² field.

**The held solution relation is closed.** Proved result `heldLimit_of`: Under the stated assumptions, this establishes that for a valid fractional certificate, held solutions within the certified radius at convergent parameters have a subsequence with convergent multipliers and a held-solution limit within the same radius.

### Breakdown.FracCert.HeldLimitParts

Names the residual and the weak compactness, symmetry and lower-bound contracts needed to close the held-solution relation.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldLimitParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.FracCertData`.

**The full nonlinear held residual.** Definition `heldResidual`: This defines the held residual as the full bordered linear field plus the correction convection Gv and the profile defect.

**Source namespace:** `Breakdown.SteadyCert`.

**Held residuals are L² class fields.** Proposition `HeldResidualSquareStatement`: This proposition requires that for a valid fractional certificate and a linear correction state in the parameter box, every held residual belongs to L² and to the prescribed symmetry class.

**Bounded held solutions have weak limits.** Proposition `HeldWeakLimitStatement`: This proposition requires that bounded held solutions at convergent parameters have a subsequence with a limiting linear state, no larger size, convergent multipliers and pins, and convergent residual pairings against every solenoidal L² field.

**Weak powers preserve the symmetry class.** Proposition `WeakPowerClassStatement`: This proposition requires that for 1<α<5/4, a measurable L⁶ field in the discrete rotation and reflection class has its weak fractional power in the same class.

**Weak gradients preserve class symmetry.** Proposition `GradientClassStatement`: This proposition requires that a measurable L⁶ field in the symmetry class with a measurable square-integrable weak gradient has that gradient equivariant almost everywhere under the discrete turn and reflection.

**Held residuals preserve class symmetry.** Proposition `HeldResidualClassStatement`: This proposition requires that for a valid fractional certificate, the held residual of every admissible linear correction state preserves the prescribed symmetry class.

**Weak held limits retain energy bounds.** Proposition `HeldStateLimitStatement`: This proposition requires that bounded held solutions at convergent parameters have a linear-state subsequential limit with lower semicontinuous energy, weakly convergent gradients and convergent zero-multiplier residual pairings against solenoidal L² fields.

### Breakdown.FracCert.HeldMultiplierContinuous

Combines bounded existence, uniqueness and closedness to make the held multipliers continuous in the certificate parameter.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldMultiplierContinuous.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldMultiplierContinuousInternal`.

**State size controls square-root energy.** Proved result `sqrt_energy_le_size`: Under the stated hypotheses, state size controls square-root energy.

**Certificate size is nonnegative.** Proved result `size_nonneg`: Under the stated hypotheses, certificate size is nonnegative.

**The held radius has a linear bound.** Proved result `held_radius_le`: Under the stated hypotheses, the held radius has a linear bound.

**The held ball satisfies uniqueness.** Proved result `unique_condition`: Under the stated hypotheses, the held ball satisfies uniqueness.

**Source namespace:** `Breakdown.SteadyCert`.

**The held multipliers vary continuously.** Proved result `heldMultiplierContinuous`: Under the stated assumptions, this establishes that a valid fractional certificate admits a continuous corrected multiplier map on its parameter box, with each value realized by a held solution within the certified radius.

### Breakdown.FracCert.HeldNonzero

Uses the certificate energy gap to exclude cancellation of the approximate profile by the correction.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldNonzero.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldNonzeroInternal`.

**Integration by parts for smooth fields.** Proved result `partsIdentity`: Under the stated hypotheses, smooth fields satisfy integration by parts.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.HeldNonzero:34`.

**Cancellation fixes the gradient energy.** Proved result `gradient_ae_eq`: Under the stated hypotheses, cancellation identifies gradient energies.

**Source namespace:** `Breakdown.SteadyCert`.

**The corrected profile is nonzero.** Proved result `heldNonzero`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held correction within the certified radius cannot cancel the approximate profile almost everywhere.

### Breakdown.FracCert.HeldResidualLimit

Identifies the weak limit of the nonlinear held residual, using a locally strong subsequence and separate drift and product limits.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldResidualLimit.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldResidualLimitInternal`.

**Almost every spatial point is nonzero.** Proved result `ae_ne_zero`: Under the stated hypotheses, almost every spatial point is nonzero. Source: `Breakdown.FracCert.HeldResidualLimit:27`.

**The inverse-radius field lies in L².** Proved result `inv_memLp`: Under the stated hypotheses, the inverse-radius field lies in L².

**Removing the radius recovers L².** Proved result `weight_memLp`: Under the stated hypotheses, removing the radius recovers L².

**The held residual splits into four parts.** Proved result `residual_parts`: Under the stated hypotheses, the held residual splits into four parts.

**The residual expands into profile terms.** Proved result `residual_expand`: Under the stated hypotheses, the residual expands into profile terms. Source: `Breakdown.FracCert.HeldResidualLimit:58`.

**The held residual lies in L².** Proved result `residual_memLp`: Under the stated hypotheses, the held residual lies in L². Source: `Breakdown.FracCert.HeldResidualLimit:72`.

**The convection cross terms lie in L².** Proved result `cross_memLp`: Under the stated hypotheses, the convection cross terms lie in L².

**The profile defect lies in L².** Proved result `defect_memLp`: Under the stated hypotheses, the profile defect lies in L².

**Residual pairings split into four parts.** Proved result `pair_parts`: Under the stated hypotheses, residual pairings split into four parts.

**Held residuals kill solenoidal tests.** Proved result `held_orthogonal`: Under the stated hypotheses, held residuals annihilate solenoidal fields. Source: `Breakdown.FracCert.HeldResidualLimit:132`.

**Integration respects a four-term sum.** Proved result `combine4`: Under the stated hypotheses, integration respects a four-term sum.

**Drift test pairings pass to the limit.** Proved result `drift_test_limit`: Under the stated hypotheses, drift test pairings pass to the limit.

**Matrix-vector products are locally L¹.** Proved result `apply_locInt`: Under the stated hypotheses, matrix-vector products are locally L¹.

**The drift field is locally integrable.** Proved result `drift_locInt`: Under the stated hypotheses, the drift field is locally integrable.

**Weak limits identify the drift field.** Proved result `drift_identify`: Under the stated hypotheses, weak limits identify the drift field.

**Source namespace:** `Breakdown.SteadyCert.LocalStrongInternal`.

**Ball integrals equal cutoff integrals.** Proved result `ind_sq`: Under the stated hypotheses, ball integrals equal cutoff integrals.

**Ball restrictions of the field lie in L².** Proved result `ind_memLp`: Under the stated hypotheses, ball restrictions of the field lie in L².

**Radius-weighted cutoffs lie in L².** Proved result `ind_weight_memLp`: Under the stated hypotheses, radius-weighted cutoffs lie in L².

**Weighted weak limits give local tests.** Proved result `ball_weak`: Under the stated hypotheses, weighted weak limits give local tests.

**Ball energy is lower semicontinuous.** Proved result `lsc_ball`: Under the stated hypotheses, ball energy is lower semicontinuous.

**Second-order fields are locally L².** Proved result `loc_memLp`: Under the stated hypotheses, second-order fields are locally L².

**Radius-weighted L² fields are locally L².** Proved result `loc_weight_memLp`: Under the stated hypotheses, radius-weighted L² fields are locally L².

**Local difference squares are integrable.** Proved result `sq_int`: Under the stated hypotheses, local difference squares are integrable.

**Matrix differences have finite energy.** Proved result `entry_int`: Under the stated hypotheses, matrix difference energies are integrable.

**Finite local nets give small errors.** Proved result `frequent_small`: Under the stated hypotheses, finite local nets give small errors.

**Source namespace:** `Breakdown.SteadyCert`.

**A locally strong subsequence exists.** Proved result `localStrongSubseq`: Under the stated assumptions, this establishes that uniformly energy-bounded second-order fields whose inverse-radius velocities converge weakly in L² have a subsequence converging strongly on every ball to the radius times that weak limit.

**Local strong limits close the residual.** Proved result `heldResidualLimit_of`: Under the stated assumptions, this establishes that under the boundedness and weak-convergence hypotheses for held solutions, the residual of the limiting linear state with the limiting multiplier annihilates every solenoidal L² field.

**The held residual limit interface holds.** Proved result `heldResidualLimit_holds`: Under the stated assumptions, this establishes that under the boundedness and weak-convergence hypotheses for held solutions, the residual of the limiting linear state with the limiting multiplier annihilates every solenoidal L² field.

### Breakdown.FracCert.HeldResidualLimitParts

States the compactness step that upgrades a weighted weak limit and bounded derivative energy to strong L² convergence on every ball.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldResidualLimitParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**A locally strong subsequence exists.** Proposition `LocalStrongSubseqStatement`: This proposition requires that uniformly energy-bounded second-order fields whose inverse-radius velocities converge weakly in L² have a subsequence converging strongly on every ball to the radius times that weak limit.

### Breakdown.FracCert.HeldStateLimitAApply

Controls matrix-vector pairings and passes them to the limit when matrix fields converge weakly and vectors converge locally strongly.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitAApply.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.ApplyPairingInternal`.

**Cauchy-Schwarz bounds integral pairings.** Proved result `abs_pair_le`: Under the stated hypotheses, Cauchy-Schwarz bounds integral pairings. Source: `Breakdown.FracCert.HeldStateLimitAApply:16`.

**The first basis vector has unit norm.** Proved result `unit_norm`: Under the stated hypotheses, the first basis vector has unit norm.

**Matrix-vector evaluation is measurable.** Proved result `apply_meas`: Under the stated hypotheses, matrix-vector evaluation is measurable.

**Matrix entries control operator action.** Proved result `apply_norm_le`: Under the stated hypotheses, matrix entries control operator action.

**Local L² norms bound test pairings.** Proved result `small_bound`: Under the stated hypotheses, local L² norms bound test pairings.

**Basis inner products give coordinates.** Proved result `unit_inner`: Under the stated hypotheses, basis inner products give coordinates.

**A difference square has a two-term bound.** Proved result `sub_sq_le`: Under the stated hypotheses, a difference square has a two-term bound.

**Rank-one test matrices are measurable.** Proved result `frame_meas`: Under the stated hypotheses, rank-one test matrices are measurable.

**Rank-one action is ⟨x,w⟩v.** Proved result `frame_apply`: The rank-one operator built from x and v sends w to ⟨x,w⟩v.

**Matrix pairings represent vector action.** Proved result `frame_entry`: Under the stated hypotheses, matrix pairings represent vector action.

**Rank-one matrix energy is bounded.** Proved result `frame_sq`: Under the stated hypotheses, rank-one matrix energy is bounded.

**Weak-strong products converge on tests.** Proved result `apply_pairing_limit`: Under the stated hypotheses, weak and strong factors give pairing limits.

### Breakdown.FracCert.HeldStateLimitACross

Combines uniform L² control of convection cross terms with convergence against compact test fields.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitACross.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**The convection cross terms stay bounded.** Proposition `CrossUniformBoundStatement`: This proposition requires that a valid fractional certificate and a common energy bound give a uniform L² bound on the profile-correction cross convection together with the correction self-convection.

**Cross terms converge against tests.** Proposition `CrossTestLimitStatement`: This proposition requires that under parameter convergence, bounded derivative energy, weak gradient convergence and local strong L² velocity convergence, the three convection terms converge in pairing against every compact test field.

**Test limits extend to L² pairings.** Proved result `crossPairingLimit_of`: Under the stated assumptions, this establishes that under parameter convergence, bounded derivative energy, weak gradient convergence and local strong velocity convergence, the convection cross terms and correction convection converge against every solenoidal L² field.

**Inverse-square bounds from profile decay.** Proved result `decay_sq_le`: Under the stated hypotheses, profile decay has an inverse-square bound.

**Three-term squares have a sum bound.** Proved result `sum3_sq_le`: Under the stated hypotheses, three-term squares have a sum bound.

**The uniform cross-term bound holds.** Proved result `crossUniformBound`: Under the stated assumptions, this establishes that a valid fractional certificate and a common energy bound give a uniform L² bound on the profile-correction cross convection together with the correction self-convection.

### Breakdown.FracCert.HeldStateLimitADefect

Separates parameter continuity of the defect into free-profile, nonlinear-profile and multiplier contributions.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitADefect.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Free-profile pairings pass to the limit.** Proposition `ProfileFreePairingLimitStatement`: This proposition requires that under convergence within the certificate parameter box, the approximate profile drift plus fractional power converges in pairing against every solenoidal L² field.

**The free-profile part stays L² bounded.** Proposition `ProfileFreeBoundStatement`: This proposition requires that the free part of a valid certificate profile has uniformly bounded squared L² norm throughout the parameter box.

**Free-profile test pairings converge.** Proposition `ProfileFreeTestLimitStatement`: This proposition requires that under convergence within the certificate parameter box, the approximate profile drift plus fractional power converges in pairing against every compact test field.

**Test limits give free-profile pairings.** Proved result `profileFreePairingLimit_of`: Under the stated assumptions, this establishes that under convergence within the certificate parameter box, the approximate profile drift plus fractional power converges in pairing against every solenoidal L² field.

**Source namespace:** `Breakdown.SteadyCert.DefectPairingInternal`.

**Profile decay controls matrix action.** Proved result `decay_le`: Under the stated hypotheses, profile decay controls matrix action.

**Profile products converge weakly.** Proved result `product_limit`: Under the stated hypotheses, profile products converge weakly.

**Each profile multiplier is continuous.** Proved result `multiplier_limit`: Under the stated hypotheses, each profile multiplier is continuous.

**Source namespace:** `Breakdown.SteadyCert`.

**Defect pairings pass to the limit.** Proved result `defectPairingLimit_of`: Under the stated assumptions, this establishes that the defect of a valid fractional certificate varies continuously in pairing against every solenoidal L² field as the parameter converges within its box.

### Breakdown.FracCert.HeldStateLimitAFree

Obtains uniform L² bounds on the free part of held and approximate profiles from solenoidal drift and power estimates.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitAFree.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.FreeBoundInternal`.

**The concrete L² norm is the Lp norm.** Proved result `l2Norm_eq`: Under the stated hypotheses, the concrete L² norm is the Lp norm. Source: `Breakdown.FracCert.HeldStateLimitAFree:15`.

**L² norms obey the triangle inequality.** Proved result `l2_add_le`: Under the stated hypotheses, L² norms obey the triangle inequality.

**Scaling multiplies L² norms by magnitude.** Proved result `l2_smul`: Under the stated hypotheses, scaling multiplies L² norms by magnitude.

**Finite L² sums have a norm bound.** Proved result `l2_sum_le`: Under the stated hypotheses, finite L² sums have a norm bound.

**The zero field is a gradient.** Proved result `gradient_zero`: Under the stated hypotheses, the zero field is a gradient.

**Source namespace:** `Breakdown.SteadyCert`.

**The held free part stays L² bounded.** Proved result `heldFreeBound_of`: Under the stated assumptions, this establishes that a common bound on held-state size gives a uniform squared L² bound on the sum of the correction drift and its fractional power.

**The parameter box is compact.** Proved result `box_compact`: Under the stated hypotheses, the parameter box is compact.

**The profile free part stays L² bounded.** Proved result `profileFreeBound_of`: Under the stated assumptions, this establishes that the free part of a valid certificate profile has uniformly bounded squared L² norm throughout the parameter box.

### Breakdown.FracCert.HeldStateLimitAParts

States a route to held-state compactness through free-part bounds, linear weak limits, nonlinear cross pairings and defect pairings.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitAParts.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**The held free part stays L² bounded.** Proposition `HeldFreeBoundStatement`: This proposition requires that a common bound on held-state size gives a uniform squared L² bound on the sum of the correction drift and its fractional power.

**Bounded linear states have weak limits.** Proposition `LinearStateWeakLimitStatement`: This proposition requires that energy-bounded linear states with uniformly L²-bounded drift and fractional power at convergent parameters admit a subsequence with lower semicontinuous energy, weak gradient convergence, local strong velocity convergence and weak convergence of the free part.

**Cross pairings pass to the limit.** Proposition `CrossPairingLimitStatement`: This proposition requires that under parameter convergence, bounded derivative energy, weak gradient convergence and local strong velocity convergence, the convection cross terms and correction convection converge against every solenoidal L² field.

**Defect pairings pass to the limit.** Proposition `DefectPairingLimitStatement`: This proposition requires that the defect of a valid fractional certificate varies continuously in pairing against every solenoidal L² field as the parameter converges within its box.

### Breakdown.FracCert.HeldStateLimitAProfile

Proves convergence of free-profile test pairings using continuity of the approximate profile and its weak fractional power.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitAProfile.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile-power test pairings converge.** Proposition `ProfilePowerTestLimitStatement`: This proposition requires that the approximate profile fractional power varies continuously in pairing against every compact test field as the certificate parameter converges within its box.

**Source namespace:** `Breakdown.SteadyCert.ProfileTestInternal`.

**Test fields are bounded and supported.** Proved result `test_bound`: Under the stated hypotheses, test fields are bounded and supported.

**Local matrix pairings are integrable.** Proved result `pair_int`: Under the stated hypotheses, local matrix-vector pairings are integrable.

**A constant matrix cut off to a ball.** Definition `cutoff`: This defines a field equal to the fixed vector L on the open ball of radius r and zero outside that ball.

**The matrix cutoff is measurable.** Proved result `cutoff_meas`: Under the stated hypotheses, the matrix cutoff is measurable.

**The matrix cutoff has finite energy.** Proved result `cutoff_sq`: Under the stated hypotheses, the matrix cutoff has finite energy.

**The cutoff preserves supported pairings.** Proved result `cutoff_pair`: Under the stated hypotheses, the cutoff preserves supported pairings.

**Local strong limits preserve pairings.** Proved result `fixed_pair_limit`: Under the stated hypotheses, local strong limits preserve test pairings.

**Fixed-matrix pairings are integrable.** Proved result `pair_int_fixed`: Under the stated hypotheses, fixed-matrix pairings are integrable.

**Convergent profile gradients are bounded.** Proved result `grad_sq_bound`: Under the stated hypotheses, convergent profile gradients stay bounded.

**Integrals split into profile terms.** Proved result `combine`: Under the stated hypotheses, integration distributes over profile terms.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile-power limits give free limits.** Proved result `profileFreeTestLimit_of`: Under the stated assumptions, this establishes that under convergence within the certificate parameter box, the approximate profile drift plus fractional power converges in pairing against every compact test field.

**Profile-power test limits hold.** Proved result `profilePowerTestLimit`: Under the stated assumptions, this establishes that the approximate profile fractional power varies continuously in pairing against every compact test field as the certificate parameter converges within its box.

### Breakdown.FracCert.HeldStateLimitATest

Turns certificate parameter continuity into local L² convergence of the profile and weak convergence of its gradients.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitATest.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile fields converge locally in L².** Proposition `ProfileLocalLimitStatement`: This proposition requires that the approximate profiles of a valid fractional certificate converge strongly in L² on every ball when their parameters converge within the box.

**Source namespace:** `Breakdown.SteadyCert.CrossTestInternal`.

**Differences of matrix columns lie in L².** Proved result `col_sub_memLp`: Under the stated hypotheses, differences of matrix columns lie in L².

**Matrix differences have finite energy.** Proved result `entrySq_sub_integrable`: Under the stated hypotheses, matrix difference energies are integrable.

**Strong matrix convergence implies weak.** Proved result `strong_weak`: Under the stated hypotheses, strong matrix convergence implies weak.

**Second-order fields have local energy.** Proved result `local_sq`: Under the stated hypotheses, second-order fields have local energy.

**Continuous fields have local energy.** Proved result `cont_sq`: Under the stated hypotheses, continuous fields have local energy.

**Profile gradients converge in energy.** Proved result `grad_tendsto`: Under the stated hypotheses, profile gradients converge in energy.

**Profile Hessians have finite L² energy.** Proved result `second_two_of`: Under the stated hypotheses, profile Hessians have finite L² energy.

**The profile is a second-order field.** Proved result `profile_second_order`: Under the stated hypotheses, the profile is a second-order field.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile fields converge locally in L².** Proved result `profileLocalLimit`: Under the stated assumptions, this establishes that the approximate profiles of a valid fractional certificate converge strongly in L² on every ball when their parameters converge within the box.

**Profile limits control cross-term tests.** Proved result `crossTestLimit_of`: Under the stated assumptions, this establishes that under parameter convergence, bounded derivative energy, weak gradient convergence and local strong L² velocity convergence, the three convection terms converge in pairing against every compact test field.

### Breakdown.FracCert.HeldStateLimitAWeak

Extends convergence against a dense class of test functions to all L² test fields using uniform bounds.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitAWeak.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert.WeakPairingInternal`.

**Dense tests determine weak limits.** Proved result `tendsto_inner_of_dense`: Under the stated hypotheses, dense tests determine bounded weak limits.

**Integral pairings equal L² pairings.** Proved result `pair_eq_inner`: Under the stated hypotheses, integral pairings equal L² pairings. Source: `Breakdown.FracCert.HeldStateLimitAWeak:47`.

**L² norms square to integrals.** Proved result `norm_toLp_sq`: Under the stated hypotheses, L² norms square to integrals.

**Test-field limits extend to L² tests.** Proved result `tendsto_pair_of_tests`: Under the stated hypotheses, test-field limits extend to L² tests.

### Breakdown.FracCert.HeldStateLimitB

Constructs the held-state limit by bounding each residual component and retaining the zero solenoidal pairing.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitB.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**L² fields pair integrably.** Proved result `pair_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.HeldStateLimitB:19`.

**The residual expands into profile terms.** Proved result `residual_expand`: Under the stated hypotheses, the residual expands into profile terms. Source: `Breakdown.FracCert.HeldStateLimitB:25`.

**The held residual lies in L².** Proved result `residual_memLp`: Under the stated hypotheses, the held residual lies in L². Source: `Breakdown.FracCert.HeldStateLimitB:39`.

**Multipliers split from the residual.** Proved result `residual_sum`: Under the stated hypotheses, multipliers split from the residual.

**Residual pairings split by multiplier.** Proved result `residual_pairing`: Under the stated hypotheses, residual pairings split by multiplier.

**Held residuals kill solenoidal tests.** Proved result `held_orthogonal`: Under the stated hypotheses, held residuals annihilate solenoidal fields. Source: `Breakdown.FracCert.HeldStateLimitB:76`.

**Certificate energy is nonnegative.** Proved result `energy_nonneg'`: Under the stated hypotheses, certificate energy is nonnegative.

**Size bounds each multiplier coordinate.** Proved result `multiplier_coord_bound`: Under the stated hypotheses, size bounds each multiplier coordinate.

**Uniform bounds give held-state limits.** Proved result `heldStateLimit_of_bounds`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a linear-state subsequential limit with lower semicontinuous energy, weakly convergent gradients and convergent zero-multiplier residual pairings against solenoidal L² fields.

**Second traces lie in L².** Proved result `trace_memLp'`: Under the stated hypotheses, second traces lie in L².

**Weak identification gives bounded limits.** Proved result `heldBoundedLimit_of`: Under the stated assumptions, this establishes that bounded held solutions with convergent parameters and multipliers have a linear-state subsequential limit with lower semicontinuous energy, weak gradient convergence and a residual annihilating all solenoidal L² fields.

### Breakdown.FracCert.HeldStateLimitBBound

Derives uniform bounds for the fractional power and drift of a bounded held solution.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitBBound.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldBoundInternal`.

**The free bounds interface is proved.** Proved result `freeBoundsProved`: Under the stated assumptions, this establishes that for 1<α<5/4, a free solution with L² forcing has separate power and drift norms bounded by the forcing norm, the stated trace-pairing energy identity and a uniform bound on the sum of square-root gradient and trace energies.

**L² norms obey the triangle inequality.** Proved result `norm_add_le'`: Under the stated hypotheses, L² norms obey the triangle inequality.

**Scaling multiplies L² norms by magnitude.** Proved result `norm_smul'`: Under the stated hypotheses, scaling multiplies L² norms by magnitude.

**The zero field has zero L² norm.** Proved result `norm_zero'`: Under the stated hypotheses, the zero field has zero L² norm.

**Finite L² sums have a norm bound.** Proved result `norm_sum_le'`: Under the stated hypotheses, finite L² sums have a norm bound.

**L² fields pair integrably.** Proved result `pair_integrable'`: Under the stated hypotheses, L² fields pair integrably.

**Negatives of gradients are gradients.** Proved result `gradient_neg'`: Under the stated hypotheses, negatives of gradients are gradients. Source: `Breakdown.FracCert.HeldStateLimitBBound:75`.

**The held residual lies in L².** Proved result `residual_memLp'`: Under the stated hypotheses, the held residual lies in L².

**Source namespace:** `Breakdown.SteadyCert`.

**Held drift and power have uniform bounds.** Proved result `heldUniformBound_of`: Under the stated assumptions, this establishes that a uniform bound on held-state size gives separate uniform L² bounds on the correction fractional power and rotating drift.

### Breakdown.FracCert.HeldStateLimitBExports

Closes the held-state compactness interface after supplying the solenoidal free-operator estimate.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitBExports.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert`.

**Solenoidal estimates give held limits.** Proved result `heldStateLimit_b`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a linear-state subsequential limit with lower semicontinuous energy, weakly convergent gradients and convergent zero-multiplier residual pairings against solenoidal L² fields.

**The held-state limit interface is proved.** Proved result `heldStateLimitProved`: Under the stated assumptions, this establishes that bounded held solutions at convergent parameters have a linear-state subsequential limit with lower semicontinuous energy, weakly convergent gradients and convergent zero-multiplier residual pairings against solenoidal L² fields.

### Breakdown.FracCert.HeldStateLimitBExtract

Reassembles weak coordinate limits into derivative tensors and identifies the limiting linear state and residual.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitBExtract.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.WeakFieldLimit`.

**A Hessian rebuilt from its entries.** Definition `entryOp`: This reconstructs a second-order operator from its indexed vector entries using the spatial coordinate functionals.

**Rebuilt Hessians recover their entries.** Proved result `entryOp_apply`: Under the stated hypotheses, rebuilt Hessians recover their entries.

**The rebuilt Hessian is measurable.** Proved result `entryOp_meas`: Under the stated hypotheses, the rebuilt Hessian is measurable.

**A Hessian rebuilt from operator columns.** Definition `opOp`: This reconstructs an operator-valued linear map from its three columns using the spatial coordinate functionals.

**Rebuilt Hessians recover their columns.** Proved result `opOp_apply`: Under the stated hypotheses, rebuilt Hessians recover their columns.

**The rebuilt operator field is measurable.** Proved result `opOp_meas`: Under the stated hypotheses, the rebuilt operator field is measurable.

**Source namespace:** `Breakdown.SteadyCert`.

**Closed weak limits identify held states.** Proved result `heldLimitIdentify_of`: Under the stated assumptions, this establishes that bounded held solutions with convergent parameters and multipliers have a linear-state subsequential limit whose gradient columns and second trace converge weakly and whose residual annihilates all solenoidal L² fields.

**Four weak closures give residual closure.** Proved result `heldLimitClosure_of`: Under the stated assumptions, this establishes that the specified simultaneous weak limits of the weighted velocity, derivative entries, power and drift of bounded held solutions form a limiting linear state whose residual annihilates all solenoidal L² fields.

### Breakdown.FracCert.HeldStateLimitBParts

States the separate weak closure contracts for held states, second derivatives, fractional powers, drift and residuals.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitBParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Held drift and power have uniform bounds.** Proposition `HeldUniformBoundStatement`: This proposition requires that a uniform bound on held-state size gives separate uniform L² bounds on the correction fractional power and rotating drift.

**Bounded held states have residual limits.** Proposition `HeldBoundedLimitStatement`: This proposition requires that bounded held solutions with convergent parameters and multipliers have a linear-state subsequential limit with lower semicontinuous energy, weak gradient convergence and a residual annihilating all solenoidal L² fields.

**Coordinate limits identify held states.** Proposition `HeldLimitIdentifyStatement`: This proposition requires that bounded held solutions with convergent parameters and multipliers have a linear-state subsequential limit whose gradient columns and second trace converge weakly and whose residual annihilates all solenoidal L² fields.

**Weak component limits close held states.** Proposition `HeldLimitClosureStatement`: This proposition requires that the specified simultaneous weak limits of the weighted velocity, derivative entries, power and drift of bounded held solutions form a limiting linear state whose residual annihilates all solenoidal L² fields.

**Second-order fields admit weak limits.** Proposition `SecondOrderWeakLimitStatement`: This proposition requires that under the stated uniform derivative bounds and weak L² convergence of weighted velocities and derivative entries, multiplying the limiting weighted velocity by radius gives a second-order field with the limiting derivatives.

**Weak fractional powers admit weak limits.** Proposition `WeakPowerLimitStatement`: This proposition requires that for 1<α<5/4, weak L² convergence of the inverse-radius velocity and of its weak fractional power preserves the weak-power relation after multiplication of the limiting velocity by radius.

**Weak drift limits stay in L².** Proposition `DriftWeakLimitStatement`: This proposition requires that under convergence of rotation rates and the stated simultaneous weak limits, the drift of the limiting second-order velocity is square integrable.

**The limiting residual annihilates tests.** Proposition `HeldResidualLimitStatement`: This proposition requires that under the boundedness and weak-convergence hypotheses for held solutions, the residual of the limiting linear state with the limiting multiplier annihilates every solenoidal L² field.

### Breakdown.FracCert.HeldStateLimitBWeak

Extracts simultaneous L² weak subsequences and proves lower semicontinuity of the weighted certificate energies.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldStateLimitBWeak.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.WeakFieldLimit`.

**Integral pairings equal L² pairings.** Proved result `pair_eq`: Under the stated hypotheses, integral pairings equal L² pairings.

**L² fields pair integrably.** Proved result `pair_integrable`: Under the stated hypotheses, L² fields pair integrably. Source: `Breakdown.FracCert.HeldStateLimitBWeak:24`.

**L² weak subsequences exist.** Proved result `exists_weak_subseq`: Under the stated hypotheses, bounded L² sequences have weak subsequences.

**Weighted energy is lower semicontinuous.** Proved result `weighted_lsc`: Under the stated hypotheses, weighted energy is lower semicontinuous.

**A matrix rebuilt from its columns.** Definition `colOp`: This reconstructs a spatial linear map from its three vector columns using the spatial coordinate functionals.

**Rebuilt matrices recover their columns.** Proved result `colOp_apply`: Under the stated hypotheses, rebuilt matrices recover their columns.

**The rebuilt matrix is measurable.** Proved result `colOp_meas`: Under the stated hypotheses, the rebuilt matrix is measurable.

**Matrix fields have weak subsequences.** Proved result `exists_weak_operator_subseq`: Under the stated hypotheses, matrix fields have weak subsequences.

**Column limits give matrix pairing limits.** Proved result `entryInner_tendsto`: Under the stated hypotheses, column limits give matrix pairing limits.

**Matrix energy is lower semicontinuous.** Proved result `weighted_entry_lsc`: Under the stated hypotheses, matrix energy is lower semicontinuous.

**Finite families share a weak subsequence.** Proved result `exists_weak_subseq_family`: Under the stated hypotheses, finite families share a weak subsequence.

### Breakdown.FracCert.HeldUnique

Subtracts two held solutions and uses the a priori and product estimates to prove uniqueness in the small-energy region.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldUnique.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldUniqueInternal`.

**Axial turns preserve differences.** Proved result `axialTurn_sub`: Under the stated hypotheses, axial turns preserve differences. Source: `Breakdown.FracCert.HeldUnique:16`.

**Drift fields preserve differences.** Proved result `drift_sub`: Under the stated hypotheses, drift fields preserve differences. Source: `Breakdown.FracCert.HeldUnique:20`.

**The second trace preserves differences.** Proved result `secondTrace_sub`: Under the stated hypotheses, the second trace preserves differences.

**The full linear field admits differences.** Proved result `full_sub`: Under the stated hypotheses, the full linear field admits differences.

**Quadratic differences factor.** Proved result `quad_split`: Under the stated hypotheses, quadratic differences split symmetrically.

**Matrix pairings preserve differences.** Proved result `entryInner_sub`: Under the stated hypotheses, matrix pairings preserve differences.

**Matrix-entry pairings are integrable.** Proved result `entryInner_int`: Under the stated hypotheses, matrix-entry pairings are integrable.

**The concrete L² norm is the Lp norm.** Proved result `l2Norm_eq`: Under the stated hypotheses, the concrete L² norm is the Lp norm. Source: `Breakdown.FracCert.HeldUnique:65`.

**Integral pairings equal L² pairings.** Proved result `l2Pair_eq`: Under the stated hypotheses, integral pairings equal L² pairings.

**The concrete L² norm is nonnegative.** Proved result `l2Norm_nonneg`: Under the stated hypotheses, the concrete L² norm is nonnegative. Source: `Breakdown.FracCert.HeldUnique:79`.

**The row maximum bounds all rows.** Proved result `rows_bound`: Under the stated hypotheses, the row maximum bounds all rows.

**The inverse bound is nonnegative.** Proved result `bound_nonneg`: Under the stated hypotheses, the inverse bound is nonnegative.

**inverse bound respects a common scale.** Proved result `bound_scale`: Under the stated hypotheses, the inverse bound respects a common scale.

**Test fields have finite L² energy.** Proved result `test_sq_int`: Under the stated hypotheses, test fields have finite L² energy.

**L² fields pair integrably with tests.** Proved result `l2_test_int`: Under the stated hypotheses, L² fields pair integrably with tests.

**Fractional-power tests pair integrably.** Proved result `six_power_int`: Under the stated hypotheses, fractional-power tests pair integrably.

**Source namespace:** `Breakdown.SteadyCert`.

**Weak fractional powers admit differences.** Proved result `weakPowerDifference`: Under the stated assumptions, this establishes that for 1<α<5/4, subtracting two second-order fields and their weak fractional powers preserves the weak fractional-power relation.

**Source namespace:** `Breakdown.SteadyCert.GradientDifferenceInternal`.

**Compact cutoffs give integrability.** Proved result `cut_int`: Under the stated hypotheses, compact cutoffs give integrability.

**Each basis vector has unit norm.** Proved result `unit_norm`: Under the stated hypotheses, each basis vector has unit norm.

**Gradient components have local energy.** Proved result `comp_sq_int`: Under the stated hypotheses, gradient components have local energy.

**Test derivatives are continuous.** Proved result `test_deriv_cont`: Under the stated hypotheses, test derivatives are continuous.

**Test derivatives have compact support.** Proved result `test_deriv_supp`: Under the stated hypotheses, test derivatives have compact support.

**Gradient potentials can be measurable.** Proved result `potential_regular`: Under the stated hypotheses, gradient potentials can be measurable.

**Source namespace:** `Breakdown.SteadyCert`.

**Gradient fields admit differences.** Proved result `gradientDifference`: Under the stated assumptions, this establishes that the difference of two weak gradient fields is a weak gradient field.

**Small held solutions are unique.** Proved result `heldUnique`: Under the stated assumptions, this establishes that two held solutions at the same parameter have equal velocities almost everywhere and equal multipliers when the sum of their square-root energies times the row and nonlinear product constants is less than one.

### Breakdown.FracCert.HeldUniqueParts

States the product and subtraction properties needed when comparing two held solutions.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldUniqueParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Symmetric convection products lie in L².** Proposition `ProductSquareStatement`: This proposition requires that the symmetric convection product of two second-order fields in the same symmetry class belongs to L².

**Gradient fields admit differences.** Proposition `GradientDifferenceStatement`: This proposition requires that the difference of two weak gradient fields is a weak gradient field.

**Weak fractional powers admit differences.** Proposition `WeakPowerDifferenceStatement`: This proposition requires that for 1<α<5/4, subtracting two second-order fields and their weak fractional powers preserves the weak fractional-power relation.

### Breakdown.FracCert.HeldWeakProfile

Turns a held solution with cancelled multipliers into a nonzero weak fractional profile by combining the approximate profile and its correction.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldWeakProfile.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldWeakProfileInternal`.

**The held equation expands as a profile.** Proved result `residual_eq`: Under the stated hypotheses, the held equation expands as a profile.

**L² fields pair integrably.** Proved result `integrable_inner_of`: Under the stated hypotheses, L² fields pair integrably.

**Source namespace:** `Breakdown.SteadyCert`.

**Cancelled held solutions give profiles.** Proved result `heldWeakProfile_of`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held solution within the certified radius whose corrected multiplier is zero yields a nontrivial weak rotating fractional profile.

**Weak-power tests give the profile bridge.** Proved result `heldWeakProfile_of_power`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held solution within the certified radius whose corrected multiplier is zero yields a nontrivial weak rotating fractional profile.

**The held-to-profile bridge follows.** Proved result `heldWeakProfile`: Under the stated assumptions, this establishes that for a valid fractional certificate, a held solution within the certified radius whose corrected multiplier is zero yields a nontrivial weak rotating fractional profile.

### Breakdown.FracCert.HeldWeakProfileParts

Provides the weak integration identities and square-integrability properties used to turn held solutions into weak profiles.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/HeldWeakProfileParts.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.SteadyCert`.

**Profile data admit the weak embedding.** Proposition `ProfileEmbedDataStatement`: This proposition requires that a valid certificate profile is measurable and in L⁶, has a measurable square-integrable weak gradient and has vanishing divergence almost everywhere.

**Corrected convection products lie in L².** Proposition `HeldQuadraticL2Statement`: This proposition requires that for a valid fractional certificate, the full convection of the approximate profile plus any admissible second-order correction belongs to L².

**Nice fields are solenoidal L² fields.** Proposition `NiceSolenoidalStatement`: This proposition requires that every nice physical test field is a square-integrable solenoidal field.

**Drift transfers to nice test fields.** Proposition `DriftNicePairingStatement`: This proposition requires that for α>0, an L⁶ field with square-integrable weak gradient transfers its rotating drift to the drift adjoint in pairings with nice test fields, with the adjoint pairing integrable.

**Weak powers transfer to nice tests.** Proposition `WeakPowerNiceStatement`: This proposition requires that for 1<α<5/4, the weak fractional-power identity extends from compact tests to nice test fields and the resulting velocity-power pairing is integrable.

**Source namespace:** `Breakdown.SteadyCert.HeldWeakProfilePartsInternal`.

**Integration by parts for smooth fields.** Proved result `test_ibp`: Under the stated hypotheses, smooth fields satisfy integration by parts.

**Gradient pairings expand by coordinate.** Proved result `inner_gradient`: Under the stated hypotheses, gradient pairings expand by coordinate.

**Derivatives commute with coordinates.** Proved result `coord_fderiv`: Under the stated hypotheses, differentiation commutes with coordinates.

**Weak gradients admit decaying tests.** Proved result `weak_component`: Under the stated hypotheses, weak gradients pair against decaying tests.

**Matrix entries control squared action.** Proved result `norm_apply_sq_le`: Under the stated hypotheses, matrix entries control squared action.

**A mixed product is bounded by cubes.** Proved result `weight_split`: Under the stated hypotheses, a mixed product is bounded by cubes.

**Decay gives integrability.** Proved result `decay_mul_integrable`: Under the stated hypotheses, decay turns power bounds into integrability.

**Weak vector identities extend to decay.** Proved result `weak_vector`: Under the stated hypotheses, weak vector identities extend to decay.

**Decaying fields pair integrably.** Proved result `inner_decay_integrable`: Under the stated hypotheses, decaying fields pair integrably.

**Integration by parts with linear weights.** Proved result `weighted_pair`: Under the stated hypotheses, linear weights admit integration by parts.

**Integrability survives addition.** Proved result `int_add`: Under the stated hypotheses, integrability survives addition.

**Integrability survives scalar factors.** Proved result `int_cmul`: Under the stated hypotheses, integrability survives scalar factors.

**Integrability survives subtraction.** Proved result `int_sub`: Under the stated hypotheses, integrability survives subtraction.

**Finite sums remain integrable.** Proved result `int_fsum`: Under the stated hypotheses, finite sums remain integrable.

**Axial turns preserve sums.** Proved result `axialTurn_add`: Under the stated hypotheses, axial turns preserve sums. Source: `Breakdown.FracCert.HeldWeakProfileParts:421`.

**Axial turns preserve scaling.** Proved result `axialTurn_smul`: Under the stated hypotheses, axial turns preserve scaling. Source: `Breakdown.FracCert.HeldWeakProfileParts:425`.

**The axial turn as a continuous map.** Definition `turnCLM`: This equips the infinitesimal axial turn with its continuous linear map structure.

**The spatial turn is (−x₂,x₁,0).** Proved result `turnCLM_apply`: The bundled continuous turn map sends (x₁,x₂,x₃) to (−x₂,x₁,0), agreeing with the axial generator.

**Axial turns do not increase norms.** Proved result `norm_axialTurn_le'`: Under the stated hypotheses, axial turns do not increase norms.

**Axial turns are skew-adjoint.** Proved result `inner_axialTurn`: Under the stated hypotheses, axial turns are skew-adjoint.

**A turn has zero diagonal entries.** Proved result `axialTurn_unit_self`: Under the stated hypotheses, a turn has zero diagonal entries.

**Linear maps expand in a basis.** Proved result `expand_apply`: Under the stated hypotheses, linear maps expand in a basis.

**Source namespace:** `Breakdown.SteadyCert`.

**Nice fields are solenoidal L² fields.** Proved result `niceSolenoidal`: Under the stated assumptions, this establishes that every nice physical test field is a square-integrable solenoidal field.

**Profile data admit the weak embedding.** Proved result `profileEmbedData`: Under the stated assumptions, this establishes that a valid certificate profile is measurable and in L⁶, has a measurable square-integrable weak gradient and has vanishing divergence almost everywhere.

**The corrected quadratic term lies in L².** Proved result `heldQuadraticL2_of`: Under the stated assumptions, this establishes that for a valid fractional certificate, the full convection of the approximate profile plus any admissible second-order correction belongs to L².

**Drift transfers to nice test fields.** Proved result `driftNicePairing`: Under the stated assumptions, this establishes that for α>0, an L⁶ field with square-integrable weak gradient transfers its rotating drift to the drift adjoint in pairings with nice test fields, with the adjoint pairing integrable.

**Weak powers transfer to nice tests.** Proved result `weakPowerNice`: Under the stated assumptions, this establishes that for 1<α<5/4, the weak fractional-power identity extends from compact tests to nice test fields and the resulting velocity-power pairing is integrable.

### Breakdown.FracCert.HeldZero

Uses the continuous multiplier map and the certificate enclosure to choose a parameter that cancels all held forces.

This belongs to the fractional certificate route: held solutions, multiplier cancellation and nontrivial profiles give an analogue of the a posteriori strategy in paper §7; its fractional conclusions are outside the paper's stated ordinary-dissipation argument.

Source: `lean/Breakdown/FracCert/HeldZero.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.SteadyCert.HeldZeroInternal`.

**Near-isometric matrices are invertible.** Proved result `det_isUnit_of_near`: Under the stated hypotheses, near-isometric matrices are invertible.

**Source namespace:** `Breakdown.SteadyCert`.

**A parameter cancels all held multipliers.** Proved result `heldZero`: Under the stated assumptions, this establishes that a valid fractional certificate admits a parameter in its box and a held solution within its certified radius whose corrected multiplier vector vanishes.

### Breakdown.FracCert.InverseSquare

Proves the inverse-square Hardy estimate by regularized integration by parts, cutoff approximation and mollification of weak gradients.

This is functional-analytic support for the fractional certificate route, including compactness, weak limits, symmetry or gradient decompositions as appropriate to the module; no exact correspondence with a numbered paper result is asserted.

Source: `lean/Breakdown/FracCert/InverseSquare.lean`. Imported by the ordinary and fractional cell endpoint modules.

**Source namespace:** `Breakdown.FracInternal`.

**The regularized weight has a derivative.** Proved result `weight_fderiv_apply`: Under the stated hypotheses, the regularized weight has a derivative.

**The squared norm has its derivative.** Proved result `normSq_fderiv_apply`: Under the stated hypotheses, squared norms have the expected derivative.

**Positive regularization gives smoothness.** Proved result `contDiff_weight`: Under the stated hypotheses, positive regularization gives smoothness.

**Coordinate squares sum to norm squared.** Proved result `sum_sq_coord`: Under the stated hypotheses, coordinate squares sum to norm squared.

**Compact continuous products are L¹.** Proved result `integrable_mul_of_support`: Under the stated hypotheses, compact continuous products are integrable.

**Young bounds weighted derivatives.** Proved result `neg_partial_le`: Under the stated hypotheses, young bounds the weighted derivative term.

**Weight divergence controls radial weight.** Proved result `weight_sum_ge`: Under the stated hypotheses, weight divergence controls inverse radius.

**The squared weight has a radial bound.** Proved result `sq_weight_le`: Under the stated hypotheses, the squared weight has a radial bound.

**The regularized Hardy bound holds.** Proved result `regularizedInverseSquare_le`: Under the stated hypotheses, the regularized Hardy bound holds.

**Cutoff derivatives lie in an annulus.** Proved result `fderiv_radialCutoff_ne`: Under the stated hypotheses, cutoff derivatives lie in an annulus.

**Sixth powers control squared values.** Proved result `sq_le_six_add`: Under the stated hypotheses, sixth powers control squared values.

**The cutoff energy tail tends to zero.** Proved result `cutoffTail`: Under the stated hypotheses, the cutoff energy tail tends to zero.

**Weighted squares obey a two-term bound.** Proved result `sq_add_le_weighted`: Under the stated hypotheses, weighted squares obey a two-term bound.

**Cutoff derivatives have an energy bound.** Proved result `entrySq_cutoff_le`: Under the stated hypotheses, cutoff derivatives satisfy an energy bound.

**Large cutoffs preserve derivative energy.** Proved result `cutoffEnergy`: Under the stated hypotheses, large cutoffs preserve derivative energy.

**Jensen bounds mollified norm powers.** Proved result `normPow_convolution_le`: Under the stated hypotheses, jensen bounds mollified norm powers.

**Mollification preserves weak derivatives.** Proved result `mollify_fderiv_apply`: Under the stated hypotheses, mollification preserves weak derivatives. Source: `Breakdown.FracCert.InverseSquare:467`.

**Smooth approximation controls energy.** Proved result `smoothApprox`: Under the stated hypotheses, smooth fields approximate without energy gain.

**Radial cutoffs are test functions.** Proved result `testScalar_cutoff`: Under the stated hypotheses, radial cutoffs are test functions.

**A test detects nonmeasurability.** Proved result `exists_test_not_measurable`: Under the stated hypotheses, a test detects nonmeasurability.

**Nonmeasurable columns force zero tests.** Proved result `partial_zero_of_not_measurable`: Under the stated hypotheses, nonmeasurable columns force zero tests.

**A measurable weak gradient can be chosen.** Proved result `measurableGradient_exists`: A weak-gradient field with integrable squared entries admits a measurable weak-gradient representative whose entrywise energy is no larger, under the stated velocity hypotheses.

**Compact smooth energy approximation.** Proved result `smoothCompactApprox`: Under the stated hypotheses, compact smooth fields approximate the energy.

**Source namespace:** `Breakdown.SteadyCert`.

**Matrix-entry energy is nonnegative.** Proved result `entrySq_nonneg'`: Under the stated hypotheses, matrix-entry energy is nonnegative. Source: `Breakdown.FracCert.InverseSquare:682`.

**Approximation gives the Hardy bound.** Proved result `inverseSquare_of_approx`: Under the stated hypotheses, approximation gives the Hardy bound.

**The inverse-square bound holds.** Proved result `inverseSquareBound`: Under the stated assumptions, this establishes that a measurable L⁶ velocity with square-integrable weak gradient has integrable ‖v(y)‖²/‖y‖² and its integral is at most four times the gradient energy.

### Breakdown.FracCert.KernelDecay

Builds derivative decay estimates for the projected fractional heat-divergence kernel by annular Fourier localization and dyadic summation.

This develops regularity or spatial decay for the fractional extension, supporting passage from a weak fractional profile to a classical decaying field; it is not an identification with a numbered ordinary-dissipation theorem in the paper.

Source: `lean/Breakdown/FracCert/KernelDecay.lean`. Imported by the fractional cell endpoint module.

**Source namespace:** `Breakdown.FracCert.KernelDecayInternal`.

**Exponential decay dominates polynomials.** Proved result `poly_exp_bound`: Under the stated hypotheses, exponential decay dominates polynomials.

**Compact sets bound derivatives uniformly.** Proved result `uniform_bound_on`: Under the stated hypotheses, compact sets bound derivatives uniformly.

**Exponential derivatives have exact norms.** Proved result `norm_iteratedFDeriv_exp_mul`: Under the stated hypotheses, exponential derivatives have exact norms.

**Localized heat symbols are bounded.** Proved result `piece_symbol_bound`: Under the stated hypotheses, localized heat symbols are bounded.

**The heat symbol obeys its scaling law.** Proved result `symbol_smul`: Under the stated hypotheses, the heat symbol obeys its scaling law.

**The heat kernel obeys its scaling law.** Proved result `kernel_smul`: Under the stated hypotheses, the heat kernel obeys its scaling law.

**Scaling combines the decay factors.** Proved result `scale_factor`: Under the stated hypotheses, scaling combines the decay factors.

**Unit-time decay gives all-time decay.** Proved result `decay_of_unit`: Under the stated hypotheses, unit-time decay gives all-time decay.

**The symbol rescales its heat time.** Proved result `symbol_smul_gen`: Under the stated hypotheses, the symbol rescales its heat time.

**Inverse transforms obey dilation.** Proved result `invTransform_smul_gen`: Under the stated hypotheses, inverse transforms obey dilation.

**Dilation controls derivative norms.** Proved result `norm_iteratedFDeriv_scale_le`: Under the stated hypotheses, dilation controls derivative norms.

**The localized heat-divergence symbol.** Definition `pieceSymbol`: This defines one localized projected-divergence symbol by multiplying its Fourier multiplier by the radial cutoff.

**Dyadic kernel pieces rescale.** Proved result `piece_kernel_eq`: Under the stated hypotheses, dyadic kernel pieces rescale.

**Radial heat weights are integrable.** Proved result `radial_integrable`: Under the stated hypotheses, radial heat weights are integrable.

**The heat symbol has a radial norm bound.** Proved result `symbol_norm_le`: Under the stated hypotheses, the heat symbol has a radial norm bound.

**The heat symbol is measurable.** Proved result `symbol_measurable`: Under the stated hypotheses, the heat symbol is measurable.

**All heat-symbol moments are integrable.** Proved result `symbol_moment`: Under the stated hypotheses, all heat-symbol moments are integrable.

**The heat-divergence kernel is smooth.** Proved result `kernel_contDiff`: Under the stated hypotheses, the heat-divergence kernel is smooth.

**Partial cutoff sums are at most one.** Proved result `cutoff_partial_le`: Under the stated hypotheses, partial cutoff sums are at most one.

**Cutoffs reconstruct the integral.** Proved result `hasSum_integral_cutoff`: Under the stated hypotheses, cutoff integrals reconstruct the integral.

**Fourier differentiation respects weights.** Proved result `powSMulRight_smul`: Under the stated hypotheses, Fourier derivative factors respect weights.

**The heat symbol is zero at the origin.** Proved result `symbol_zero`: Under the stated hypotheses, the heat symbol is zero at the origin.

**Kernel derivatives sum by dyadic pieces.** Proved result `kernel_hasSum`: Under the stated hypotheses, kernel derivatives sum by dyadic pieces.

**unit-time kernel has derivative decay.** Proved result `unit_bound`: Under the stated hypotheses, the unit-time kernel has derivative decay.

**Source namespace:** `Breakdown.FracCert`.

**The kernel decay interface follows.** Proved result `kernelDecay_of`: Under the stated assumptions, this establishes that for α>0, every positive-time projected heat-divergence kernel component is smooth and its nth derivative is bounded by C(t^(1/(2α))+‖x‖)^(−4−n).
