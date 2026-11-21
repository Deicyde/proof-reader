# Library guide 12: Breakdown/CertCell

**Navier–Stokes pages:** [the paper](../navier-stokes-paper/paper.pdf) · [proof routes](../navier-stokes-routes/paper.md) · [routes in detail](../navier-stokes-route-details/paper.md) · library guide: [1](../navier-stokes-library-01/paper.md) [2](../navier-stokes-library-02/paper.md) [3](../navier-stokes-library-03/paper.md) [4](../navier-stokes-library-04/paper.md) [5](../navier-stokes-library-05/paper.md) [6](../navier-stokes-library-06/paper.md) [7](../navier-stokes-library-07/paper.md) [8](../navier-stokes-library-08/paper.md) [9](../navier-stokes-library-09/paper.md) [10](../navier-stokes-library-10/paper.md) [11](../navier-stokes-library-11/paper.md) **12** [13](../navier-stokes-library-13/paper.md) [14](../navier-stokes-library-14/paper.md) [15](../navier-stokes-library-15/paper.md) [16](../navier-stokes-library-16/paper.md) [17](../navier-stokes-library-17/paper.md) [18](../navier-stokes-library-18/paper.md) [19](../navier-stokes-library-19/paper.md) [20](../navier-stokes-library-20/paper.md) [21](../navier-stokes-library-21/paper.md) [22](../navier-stokes-library-22/paper.md) [23](../navier-stokes-library-23/paper.md) [24](../navier-stokes-library-24/paper.md) [25](../navier-stokes-library-25/paper.md) [26](../navier-stokes-library-26/paper.md) [27](../navier-stokes-library-27/paper.md) [28](../navier-stokes-library-28/paper.md) [29](../navier-stokes-library-29/paper.md) [30](../navier-stokes-library-30/paper.md)

*A plain title and a sentence for each declaration in `Breakdown.CertCell.ShapeJunction` to `Breakdown.CertCell.VelocitySixthIntegral` of Alpöge and Buckmaster's Lean at `ad53419de079eb8f95f60313473374624a348546`, in the authors' file order. Prepared with AI assistance. The authors have not reviewed it.*

Each paragraph names one declaration and says whether it is a definition, a proposition that the library defines (its name usually ends in `Holds` or `Statement`) or a proved result, then what it states. Click a paragraph to open its Lean on the right.

### Breakdown.CertCell.ShapeJunction

This file converts established shape facts and scalar-value symmetries into the admissibility and reflection clauses consumed by cell instances. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Admissible shapes from layer data.** Proved result. The layer's shape and scalar-value assumptions imply the shape admissibility requirements at every certified parameter. (`shapeAdmissible_of_layer`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeJunction.lean#L15)).

**Shape reflection from value symmetry.** Proved result. Reflection symmetry of the supplied scalar values gives the shape reflection requirements at every certified parameter. (`shapeFlip_of_values`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeJunction.lean#L28)).

### Breakdown.CertCell.ShapeKeyConj

This file proves that changing a harmonic key to its negative conjugates the corresponding complex field, including the spline amplitudes and radial phase. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Differentiation commutes with conjugacy.** Proved result. Differentiation commutes with conjugacy. (`conjKey_deriv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L16)).

**Radial scaling commutes with conjugacy.** Proved result. Radial scaling commutes with conjugacy. (`conjKey_radialScale`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L22)).

**Height derivatives respect conjugacy.** Proved result. Height differentiation respects conjugacy. (`conjKey_heightDeriv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L27)).

**Conjugacy reverses the radial phase.** Proved result. Conjugacy reverses the radial phase. (`conjKey_shiftedScale`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L31)).

**Polynomial weights are real.** Proved result. Polynomial weights are real. (`conjKey_weightPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L40)).

**Negating labels reverses time frequency.** Proved result. Negating labels reverses time frequency. (`conjKey_labelTime`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L44)).

**Angular frequency changes sign.** Proved result. Negating labels reverses angular frequency. (`conjKey_labelAzimuth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L49)).

**Negating keys conjugates their phase.** Proved result. Negating keys conjugates their phase. (`conjKey_keyPhase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L54)).

**Conjugated splines conjugate values.** Proved result. Conjugated splines conjugate values. (`conjKey_evalHalf`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L64)).

**Negating keys conjugates components.** Proved result. Negating keys conjugates components. (`conjKey_reducedComps`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L68)).

**Key fields obey complex conjugation.** Proved result. Key fields obey complex conjugation. (`keyConjugate`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyConj.lean#L145)).

### Breakdown.CertCell.ShapeKeyDivergence

This file makes the divergence cancellation in the two component formulas explicit and reduces divergence-free key fields to the spherical-frame formula and regularity contracts. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Type-one divergence terms cancel.** Proved result. Type-one divergence terms cancel. (`typeOne_reduced_cancel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L18)).

**Mixed partial derivatives agree.** Proved result. Mixed partial derivatives agree. (`mixed_partials`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L34)).

**Stream derivatives cancel.** Proved result. Stream derivatives cancel. (`partial_cancel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L75)).

**Type-two divergence terms cancel.** Proved result. Type-two divergence terms cancel. (`typeTwo_reduced_cancel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L91)).

**Zero divergence extends from a dense set.** Proved result. For a C¹ complex vector field, divergence vanishing wherever the second coordinate is nonzero implies divergence vanishing everywhere. (`divergence_of_dense`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L122)).

**Complex embedding preserves regularity.** Proved result. Embedding a real scalar function in the complex numbers preserves its specified order of continuous differentiability. (`ofReal_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L141)).

**C² gives differentiable derivatives.** Proved result. C² gives differentiable first derivatives. (`c2_deriv_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L144)).

**Polynomial weights are C².** Proved result. Polynomial weights are C². (`weightPoly_c2`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L148)).

**The polar factor is C².** Proved result. The polar factor is C². (`polarFactor_c2`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L151)).

**The axis factor is C².** Proved result. The axis factor is C². (`axisFactor_c2`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L154)).

**Phase slope is differentiable below 1.** Proved result. The phase slope is differentiable below 1. (`phaseSlope_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L157)).

**Joined splines are differentiable.** Proved result. Joined splines are differentiable. (`spline_differentiable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L175)).

**The radial spline derivative.** Proved result. For a spline joined to at least first order in both variables, its radial derivative is the evaluation of the radial derivative spline. (`spline_hasDerivAt_t`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L179)).

**The height spline derivative.** Proved result. For a spline joined to at least first order in both variables, its height derivative is the evaluation of the height derivative spline. (`spline_hasDerivAt_x`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L190)).

**Lift differentiability to the first axis.** Proved result. A function differentiable at t remains differentiable at every pair (t,x) when lifted to depend only on the first coordinate. (`fst_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L202)).

**Lift along the second coordinate.** Proved result. A function differentiable at x remains differentiable at every pair (t,x) when lifted to depend only on the second coordinate. (`snd_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L206)).

**Differentiable partials of C² functions.** Proved result. C² partial derivatives are differentiable. (`partials_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L210)).

**The stream value is C² below 1.** Proved result. The stream value is C² below 1. (`streamValue_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L235)).

**The weighted stream is C² below one.** Proved result. Below the chart edge, a valid C² stream spline gives a C² product with the radial weight and polar factor. (`typeTwo_product_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L249)).

**Type-two components are differentiable.** Proved result. Type-two components are differentiable. (`typeTwo_components_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L256)).

**Type-one components are differentiable.** Proved result. Type-one components are differentiable. (`typeOne_components_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L291)).

**Divergence in spherical coordinates.** Proposition definition. This proposition requires the spherical-frame divergence to be the phase divided by radius times the radial scaling term, twice the radial amplitude, the negative weighted height derivative, and the angular-frequency term where the second spatial coordinate is nonzero. (`FramedDivergenceFormula`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L359)).

**The key fields are divergence free.** Proved result. The key fields are divergence free. (`keyDivergenceFree_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyDivergence.lean#L372)).

### Breakdown.CertCell.ShapeKeyFlip

This file follows reflection through coordinates, phases, spline parity and reduced components until it gives the vector-field reflection law. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Reflection changes two coordinate signs.** Proved result. Reflection changes two coordinate signs. (`flipPoint_coords`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L16)).

**Reflection preserves the norm.** Proved result. Reflection preserves the norm. (`norm_of_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L19)).

**Reflection reverses normalized height.** Proved result. Reflection reverses normalized height. (`heightRatio_of_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L24)).

**Reflection preserves compactified radius.** Proved result. Reflection preserves compactified radius. (`chartCoord_of_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L28)).

**Reflected keys preserve phase.** Proved result. Reflected keys preserve phase. (`keyPhase_of_flipKey`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L32)).

**The polar factor is even.** Proved result. The polar factor is even. (`polarFactor_of_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L59)).

**The axis factor is even.** Proved result. The axis factor is even. (`axisFactor_of_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L63)).

**Radial differentiation respects flip.** Proved result. Radial differentiation respects reflection. (`shiftedScale_of_reflected`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L67)).

**Negated reflection keeps height slope.** Proved result. Negated reflection preserves height slope. (`heightDeriv_of_reflected_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L70)).

**Odd height profiles have even slopes.** Proved result. Odd height profiles have even slopes. (`heightDeriv_of_odd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L75)).

**Radial scaling preserves oddness.** Proved result. Radial scaling preserves oddness. (`shiftedScale_of_odd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L83)).

**Type-one reduced components.** Definition. The type-one reduced vector retains its radial and polar amplitudes and uses their divergence-canceling combination divided by angular frequency for the azimuthal component. (`compsOne`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L93)).

**Type-two reduced components.** Definition. The type-two reduced vector uses weighted stream derivatives for its radial and polar components and the weighted swirl value for its azimuthal component. (`compsTwo`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L97)).

**The type-one component expansion.** Proved result. A key with nonzero first label has type-one components built from the weighted radial and polar splines. (`reducedComps_of_typeOne`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L101)).

**The type-two component expansion.** Proved result. A key with zero first label has type-two components built from the stream function, its radial weight, and the swirl spline. (`reducedComps_of_typeTwo`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L109)).

**Type-one reflection changes two signs.** Proved result. Type-one reflection changes two signs. (`compsOne_of_reflected`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L116)).

**Odd type-two data give reflected signs.** Proved result. Odd type-two data give reflected signs. (`compsTwo_of_odd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L134)).

**Component signs give reflected vectors.** Proved result. Component signs give reflected vectors. (`keyVector_of_flipped_comps`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L157)).

**Type-two keys are fixed by reflection.** Proved result. Type-two keys are fixed by reflection. (`flipKey_of_typeTwo`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L175)).

**Equal spline values on a full mesh.** Proved result. Agreeing splines on a full mesh have equal evaluated values at every coordinate pair. (`evalHalf_of_agreeing`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L181)).

**Reflected agreement gives parity values.** Proved result. Reflected agreement gives parity values. (`evalHalf_of_reflect_agree`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L188)).

**Key fields satisfy reflection symmetry.** Proved result. Key fields satisfy reflection symmetry. (`keyFlip_holds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyFlip.lean#L196)).

### Breakdown.CertCell.ShapeKeyRotation

This file derives the angular Fourier phase acquired under axial rotation and checks the axis case separately. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Rotation gives the first coordinate.** Proved result. Rotation gives the first coordinate. (`rot_apply_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L17)).

**Rotation gives the second coordinate.** Proved result. Rotation gives the second coordinate. (`rot_apply_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L21)).

**Rotation fixes the third coordinate.** Proved result. Rotation fixes the third coordinate. (`rot_apply_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L25)).

**Rotation preserves the norm.** Proved result. Rotation preserves the norm. (`rot_norm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L28)).

**Rotation preserves normalized height.** Proved result. Rotation preserves normalized height. (`rot_heightRatio`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L34)).

**Rotation preserves compactified radius.** Proved result. Rotation preserves compactified radius. (`rot_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L37)).

**Axial points are fixed by rotation.** Proved result. Axial points are fixed by rotation. (`rot_of_axis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L41)).

**Plane rotation is complex multiplication.** Proved result. Plane rotation is complex multiplication. (`rot_plane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L48)).

**Rotated arguments give rotated phases.** Proved result. Rotated arguments give rotated phases. (`exp_arg_rotate`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L55)).

**Integer angular phases split.** Proved result. Integer angular phases split. (`phase_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L67)).

**Rotating keys adds their angular phase.** Proved result. Rotating keys adds their angular phase. (`rot_keyPhase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L75)).

**Third type-one axis component vanishes.** Proved result. The third type-one axis component vanishes. (`axis_third_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L92)).

**Positive order gives key rotation.** Proved result. Positive order gives key rotation. (`keyRotation_of_lowOrder_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L113)).

**Key fields satisfy rotation covariance.** Proved result. Key fields satisfy rotation covariance. (`keyRotation`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyRotation.lean#L144)).

### Breakdown.CertCell.ShapeKeyTime

This file identifies the scalar Fourier factor produced by time translation of a key field. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Time translation adds a Fourier phase.** Proved result. Time translation adds a Fourier phase. (`keyPhase_add_time`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyTime.lean#L11)).

**Key fields obey the time-shift law.** Proved result. Key fields obey the time-shift law. (`keyTimeShift_holds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKeyTime.lean#L20)).

### Breakdown.CertCell.ShapeKnotHessian

This file permits a Hessian representative to be set to zero on spline knots while preserving its almost-everywhere value, weak derivative meaning and symmetries. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Reflection closure of a knot set.** Proposition definition. A planar knot set is reflection closed when membership is unchanged by negating its height coordinate. (`IsMirrorClosed`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L17)).

**Rotations preserve the meridian point.** Proved result. Rotations preserve the meridian point. (`planeOf_axialRot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L19)).

**Reflection reverses meridian height.** Proved result. Reflection reverses meridian height. (`planeOf_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L27)).

**Rotation fixes the origin.** Proved result. Rotation fixes the origin. (`axialRot_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L33)).

**Reflection fixes the origin.** Proved result. Reflection fixes the origin. (`flipPoint_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L36)).

**Knot-zeroing commutes with mode Hessians.** Proved result. Knot-zeroing commutes with mode Hessians. (`modeHess_zeroOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L39)).

**Knot-zeroing preserves reflection.** Proved result. Knot-zeroing preserves reflection. (`flipModel_zeroOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L50)).

**Knot-zeroing keeps harmonic expansion.** Proved result. Knot-zeroing preserves harmonic expansion. (`harmonicExpansion_zeroOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L63)).

**Almost every point avoids null knots.** Proved result. Almost every spatial point avoids the lifted planar knot set when that set has zero volume. (`ae_not_knot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L76)).

**Knot-zeroing preserves values a.e..** Proved result. Setting the Hessian to zero on a null knot set leaves it unchanged almost everywhere. (`zeroOn_ae_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L80)).

**Knot-zeroing preserves weak Hessians.** Proved result. Setting the Hessian to zero on a null knot set preserves the weak second-derivative condition. (`weakHessianState_zeroOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotHessian.lean#L86)).

### Breakdown.CertCell.ShapeKnots

This file names the planar and spatial knot-nullity obligations and proves that the mirrored knot set is closed under reflection. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Nullity of planar shape knots.** Proposition definition. This proposition requires the planar knot set of valid shape parameters to have zero volume. (`ShapeKnotsNull`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnots.lean#L17)).

**Mirrored knots are reflection closed.** Proved result. Mirrored knots are reflection closed. (`mirrorKnots_closed`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnots.lean#L20)).

**Nullity of spatial shape knots.** Proposition definition. This proposition requires the spatial lift of the mirrored planar knot set to have zero volume for valid shape parameters. (`ShapeKnotsNullSpace`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnots.lean#L30)).

### Breakdown.CertCell.ShapeKnotsNull

This file covers the spline seams by finitely many coordinate planes, spheres and cones, then proves that the resulting spatial exceptional set has zero volume. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**The horizontal coordinate plane.** Definition. The horizontal plane is the set of points with third coordinate zero. (`flat`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L13)).

**A sphere described by a quadratic.** Definition. The sphere equation sets the sum of three squared coordinates equal to the squared radius parameter. (`sph`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L15)).

**A cone described by a quadratic.** Definition. The cone equation sets squared height equal to b squared times total squared radius. (`cone`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L17)).

**The norm squared is the coordinate sum.** Proved result. The norm squared is the coordinate sum. (`norm_sq_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L19)).

**Coordinate planes have zero volume.** Proved result. Coordinate planes have zero volume. (`coord_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L23)).

**The horizontal plane has zero volume.** Proved result. The horizontal plane has zero volume. (`flat_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L37)).

**Spheres have zero volume.** Proved result. Spheres have zero volume. (`sph_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L39)).

**A graph parameterizing a cone.** Definition. The cone graph keeps the horizontal coordinates and makes height equal to c times their Euclidean radius. (`lift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L46)).

**Cone graph is differentiable off-axis.** Proved result. The cone graph is differentiable off-axis. (`lift_differentiableOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L50)).

**Cone height from planar radius.** Proved result. The cone graph keeps the first two coordinates and sets the third to c times their Euclidean radius. (`lift_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L62)).

**Cones have zero volume.** Proved result. Cones have zero volume. (`cone_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L66)).

**Spline seams lifted to spheres and cones.** Definition. The lifted spline seams are spheres at radial breakpoints together with cones at height breakpoints. (`splineSet`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L117)).

**Lifted spline seams have zero volume.** Proved result. Lifted spline seams have zero volume. (`splineSet_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L120)).

**The union of a key's spline seams.** Definition. A key's seam set is the union of the radial, polar, stream, and swirl spline seams. (`keySet`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L124)).

**A key's seam set has zero volume.** Proved result. A key's seam set has zero volume. (`keySet_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L127)).

**The set covering all spatial knots.** Definition. The spatial knot cover combines two coordinate planes, the origin-profile edge sphere, and the seam sets of all supplied keys. (`bigSet`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L131)).

**The covering knot set has zero volume.** Proved result. The covering knot set has zero volume. (`bigSet_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L134)).

**Meridian and spatial radii agree.** Proved result. Meridian and spatial radii agree. (`planeNorm_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L138)).

**Shape knots lie in the covering set.** Proved result. Shape knots lie in the covering set. (`mem_bigSet`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L142)).

**Spatial shape knots have zero volume.** Proved result. Spatial shape knots have zero volume. (`shapeKnotsNullSpace`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeKnotsNull.lean#L188)).

### Breakdown.CertCell.ShapeLogPhase

This file checks the logarithmic radial phase, including its first three derivatives and the positivity needed for the shifted logarithm. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Open-set equality preserves derivatives.** Proved result. Open-set equality preserves derivatives. (`deriv_eq_of_eqOn_open`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L13)).

**The shifted coordinate is positive.** Proved result. The shifted coordinate is positive. (`shifted_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L21)).

**The logarithmic phase derivative.** Proved result. For positive c and t greater than −c, the derivative of rate/2 times log(1+t/c) is rate divided by 2(c+t). (`logPhase_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L25)).

**The shifted reciprocal derivative.** Proved result. For t greater than −c, the derivative of rate divided by 2(c+t) is −rate divided by 2(c+t)². (`inv_shift_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L40)).

**The shifted reciprocal-square derivative.** Proved result. For t greater than −c, the derivative of −rate divided by 2(c+t)² is rate divided by (c+t)³. (`inv_sq_shift_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L46)).

**A positive scale gives a radial phase.** Proved result. A positive scale gives a radial phase. (`radial_of_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L55)).

**The logarithmic phase is admissible.** Proved result. The logarithmic phase is admissible. (`logPhaseIsRadial`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeLogPhase.lean#L111)).

### Breakdown.CertCell.ShapeMeasurable

This file passes measurability from the scalar chart values and speed data to the bound data used by the cell-layer argument. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Scalar value data give measurable bounds.** Proved result. Measurability of chart bounds makes the epsilon and mu speeds and all supplied harmonic bounds measurable when they are identified with those chart evaluations. (`measurableBoundData_of_valueSets`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeMeasurable.lean#L17)).

**Bound entries give measurable bounds.** Proved result. A valid bound-value entry gives measurable speed and harmonic bound data at every certified parameter. (`boundsMeasurable_of_entry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeMeasurable.lean#L33)).

### Breakdown.CertCell.ShapeModeOrthogonal

This file evaluates the time and angular Fourier averages of finite real wave sums, including their conjugate-frequency contributions. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Circle averaging selects frequency zero.** Proved result. Circle integration selects zero frequency. (`circle_integral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L9)).

**Time integration selects zero frequency.** Proved result. Time integration selects zero frequency. (`line_integral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L32)).

**Angular averaging selects the zero mode.** Proved result. Angular integration selects the zero mode. (`inner_term`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L58)).

**Time integration removes nonzero modes.** Proved result. Time integration removes nonzero modes. (`outer_term`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L76)).

**Double averaging selects matching modes.** Proved result. Double averaging selects matching modes. (`double_sum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L82)).

**A real wave splits into conjugate waves.** Proved result. A real wave splits into conjugate waves. (`pointwise_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L126)).

**Two zero-frequency tests combine.** Proved result. Two zero-frequency tests combine. (`ite_two_pi`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L157)).

**Mode averaging selects wave coefficients.** Proved result. Mode averaging selects wave coefficients. (`modeAverage_of_waveSum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L165)).

**A real wave has two conjugate modes.** Proved result. A real wave has two conjugate modes. (`modeAverage_of_wave`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L204)).

**Velocity modes select wave coefficients.** Proved result. Velocity modes select wave coefficients. (`modeVel_of_waveSum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L213)).

**Gradient modes select wave coefficients.** Proved result. Gradient modes select wave coefficients. (`modeGrad_of_waveSum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L223)).

**Hessian modes select wave coefficients.** Proved result. Hessian modes select wave coefficients. (`modeSecondDeriv_of_waveSum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeModeOrthogonal.lean#L234)).

### Breakdown.CertCell.ShapeOriginProfile

This file treats the origin correction as a polynomial joined to a constant tail and proves its C² and local second-derivative Lipschitz properties. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Polynomial evaluation is smooth.** Proved result. Polynomial evaluation is smooth. (`polynomial_eval_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L11)).

**Clamping preserves a zero joining slope.** Proved result. Clamping preserves a zero joining slope. (`clamp_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L16)).

**The origin polynomial joins its tail.** Proved result. The origin polynomial joins its tail. (`join_value`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L39)).

**The joining first derivative vanishes.** Proved result. For a valid origin profile whose joining edge is below one, the polynomial first derivative vanishes at that edge. (`join_slope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L43)).

**The joining second derivative vanishes.** Proved result. For a valid origin profile whose joining edge is below one, the polynomial second derivative vanishes at that edge. (`join_curvature`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L47)).

**Origin profile is a clamped polynomial.** Proved result. The origin profile is a clamped polynomial. (`eval_eq_clamp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L51)).

**Differentiating the clamped profile.** Proved result. The derivative of an admissible clamped origin profile is its polynomial derivative evaluated at the smaller of the argument and the edge. (`eval_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L59)).

**Differentiate the clamped profile.** Proved result. For a valid joining edge below one, the profile derivative is its polynomial derivative evaluated at the argument clamped above by that edge. (`deriv_eq_clamp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L65)).

**The clamped derivative differentiates.** Proved result. For a valid joining edge below one, the profile derivative has derivative equal to the polynomial second derivative evaluated at the clamped argument. (`deriv_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L69)).

**The clamped second derivative.** Proved result. For a valid joining edge below one, the second derivative as a function is the polynomial second derivative composed with clamping at the edge. (`second_deriv_eq_clamp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L76)).

**The joined origin profile is C².** Proved result. An admissible origin profile whose edge is strictly below one is globally C² after its polynomial is clamped to the tail. (`eval_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L80)).

**Second derivative is locally Lipschitz.** Proved result. The second derivative is locally Lipschitz. (`second_deriv_slope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L90)).

**Polynomial profiles below the edge.** Proved result. When the profile edge equals one, the profile evaluation below one equals its polynomial evaluation. (`eval_eq_poly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L108)).

**Polynomial endpoint second derivatives.** Proved result. Endpoint second derivatives are polynomial. (`second_deriv_eq_poly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L113)).

**The origin profile satisfies regularity.** Proved result. An admissible origin profile is C² below one and its second derivative is Lipschitz on every centered closed interval with radius less than one. (`originProfileSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeOriginProfile.lean#L123)).

### Breakdown.CertCell.ShapeScalarStatements

This file specifies the rational Bernstein coefficient format for scalar weights and step bounds, including mesh validity, derivative joins, signs, defaults and reflection data. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Measurability and symmetry of minima.** Proposition definition. This proposition requires planar step minima to be measurable, invariant under axial rotations, and compatible with reflecting the step data. (`PlaneMinEvalFacts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L20)).

**Reflection of a chart bound.** Definition. Reflecting a chart bound mirrors its data and retains its radial power and origin value. (`mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L26)).

**Measurability and symmetry of bounds.** Proposition definition. This proposition requires chart-bound evaluations to be measurable, invariant under axial rotations, and compatible with reflected bound data. (`ChartBoundFacts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L30)).

**Integers over natural denominators.** Data structure. A fraction stores an integer numerator and a natural-number denominator without imposing positivity on the denominator. (`Frac`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L34)).

**The rational value of a fraction.** Definition. The value of a stored fraction is the rational quotient of its numerator and denominator using Lean's totalized division. (`val`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L40)).

**An integer represented as a fraction.** Definition. An integer is stored as a fraction with denominator one. (`ofInt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L42)).

**Addition of fraction representations.** Definition. Fraction addition uses the cross-sum numerator and the product denominator. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L44)).

**Multiplication of fractions.** Definition. Fraction multiplication multiplies the two numerators and the two denominators. (`mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L46)).

**Negation of a fraction representation.** Definition. Negating a fraction negates its numerator and retains its denominator. (`neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L48)).

**Subtraction of fraction representations.** Definition. Fraction subtraction adds the negated second fraction to the first. (`sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L50)).

**Natural powers of fractions.** Definition. Natural powers of stored fractions use denominator-one unity at exponent zero and repeated fraction multiplication. (`pow`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L52)).

**A finite sum of fractions.** Definition. A list of stored fractions is summed recursively from the denominator-one representation of zero. (`sum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L56)).

**Fraction lookup with an integer default.** Definition. Fraction lookup returns the requested list entry or the supplied integer represented with denominator one. (`fracAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L62)).

**A mesh with rational breakpoints.** Data structure. A rational mesh stores separate lists of fractional radial and height breakpoints. (`RationalMesh`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L64)).

**Rational mesh interpreted over the reals.** Definition. A rational mesh becomes a real tensor mesh by evaluating and casting each stored breakpoint. (`toMesh`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L70)).

**Valid ordered rational mesh data.** Proposition definition. Valid rational meshes have positive denominators, strictly increasing cross-products, and endpoints zero and one in both coordinates. (`IsValid`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L73)).

**The radial mesh cell count.** Definition. The radial cell count is the radial breakpoint-list length minus one, using natural subtraction. (`tCount`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L81)).

**The height mesh cell count.** Definition. The height cell count is the height breakpoint-list length minus one, using natural subtraction. (`xCount`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L83)).

**A radial cell width as a fraction.** Definition. A radial cell width subtracts adjacent fractional breakpoints with default endpoints zero and one. (`tWidth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L85)).

**A height cell width as a fraction.** Definition. A height cell width subtracts adjacent fractional breakpoints with default endpoints zero and one. (`xWidth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L87)).

**A Bernstein basis on a physical interval.** Definition. A physical-cell Bernstein basis substitutes the normalized affine coordinate (x−lo)/(hi−lo) into a Bernstein polynomial. (`cellBasisPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L91)).

**Coefficient lookup with zero default.** Definition. A missing row or column coefficient is interpreted as the denominator-one fraction zero. (`coefAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L95)).

**Tensor-product Bernstein cell polynomial.** Definition. A cell polynomial sums the stored coefficients against the product of radial and height Bernstein bases. (`cellPiecePoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L97)).

**Forward coefficient differences.** Definition. The order-o forward difference is the alternating binomial sum of the first o+1 coefficients. (`windowDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L101)).

**A width-scaled coefficient difference.** Definition. A scaled coefficient difference multiplies the forward difference by the descending degree factorial and the specified width to the derivative order. (`scaledDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L105)).

**Cross-product relation for fractions.** Proposition definition. The stored fraction relation equates numerator-denominator cross products without requiring nonzero denominators. (`FracEq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L108)).

**Cross-product equality is decidable.** Instance. Cross-product equality is decidable. (`unnamed instance at line 110`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L110)).

**One half of a coefficient scalar.** Data structure. One scalar half stores a rational tensor mesh, two polynomial degrees, and the coefficient arrays for its cells. (`CoefficientHalf`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L112)).

**The coefficients of one mesh cell.** Definition. Cell coefficient lookup returns the selected two-dimensional array or an empty array when either cell index is missing. (`cell`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L122)).

**Bernstein coefficients as a spline.** Definition. The coefficient half is interpreted as a spline whose cell pieces are its tensor-product Bernstein polynomials. (`toSpline`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L124)).

**Positive denominators for coefficients.** Proposition definition. Coefficient denominator positivity requires a positive denominator at every in-range cell and polynomial coefficient. (`CoefDenPos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L129)).

**Radial derivative matching clauses.** Proposition definition. Radial joining requires cross-multiplied finite differences from neighboring radial cells to match through the chosen derivative order. (`TJoins`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L132)).

**Height derivative matching clauses.** Proposition definition. Height joining requires cross-multiplied finite differences from neighboring height cells to match through the chosen derivative order. (`XJoins`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L137)).

**Nonnegative coefficient numerators.** Proposition definition. Coefficient nonnegativity requires every in-range stored numerator to be nonnegative. (`CoefNonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L142)).

**Constant coefficients below a breakpoint.** Proposition definition. The constant-region condition equates all coefficients of cells ending below the chosen breakpoint with one stored value. (`CoefConstantBelow`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L145)).

**Constant coefficients on the first edge.** Proposition definition. The initial-edge condition equates the radial-degree-zero coefficients in the first radial cells with one stored value. (`CoefFlatAtZero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L150)).

**Radial matching is decidable.** Instance. Radial matching is decidable. (`unnamed instance at line 153`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L153)).

**Height matching is decidable.** Instance. Height matching is decidable. (`unnamed instance at line 155`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L155)).

**Coefficient nonnegativity is decidable.** Instance. Coefficient nonnegativity is decidable. (`unnamed instance at line 157`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L157)).

**Denominator positivity is decidable.** Instance. Denominator positivity is decidable. (`unnamed instance at line 159`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L159)).

**Constant coefficient region is decidable.** Instance. A constant coefficient region is decidable. (`unnamed instance at line 161`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L161)).

**Initial flatness is decidable.** Instance. Initial flatness is decidable. (`unnamed instance at line 163`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L163)).

**Rational mesh validity is decidable.** Instance. Rational mesh validity is decidable. (`unnamed instance at line 167`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L167)).

**Upper and lower coefficient scalars.** Data structure. A coefficient scalar pairs upper and lower coefficient halves with a natural decay order. (`CoefficientScalar`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L169)).

**Coefficients as a chart scalar.** Definition. A coefficient scalar becomes a chart scalar by interpreting both halves as splines and retaining the decay order. (`toChartScalar`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L178)).

**Reflection swaps the two scalar halves.** Definition. Reflecting a coefficient scalar exchanges its upper and lower halves and preserves the decay order. (`mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L180)).

**Derivative matching across the plane.** Proposition definition. Plane joining matches cross-multiplied height differences across the two halves with a sign determined by derivative parity. (`PlaneJoins`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L182)).

**Plane matching is decidable.** Instance. Plane matching is decidable. (`unnamed instance at line 188`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L188)).

**All coefficient joining conditions.** Proposition structure. The joining package requires positive coefficient denominators, matching radial meshes and degrees, and all radial, height, and plane derivative joins. (`JoinClauses`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L190)).

**Nonnegativity in both scalar halves.** Proposition definition. Scalar coefficient nonnegativity combines positive denominators with nonnegative numerators in both halves. (`CoefNonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L202)).

**Constant core specified by coefficients.** Proposition definition. A constant-core certificate requires a positive core breakpoint present in the mesh and coefficients equal to one value below that breakpoint. (`CoefConstantCore`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L204)).

**Flatness at the origin by coefficients.** Proposition definition. The flat-origin certificate requires positive denominators and one common initial-edge value in both scalar halves. (`CoefFlat`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L209)).

**Rational step-function values.** Data structure. Step values consist of a rational mesh, upper and lower fractional cell values, and an integer decay order. (`StepValues`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L214)).

**Step values interpreted over the reals.** Definition. Step data are obtained by evaluating the rational mesh and the upper and lower cell fractions over the reals. (`toStepDatum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L224)).

**Reflection swaps upper and lower steps.** Definition. Reflecting step values exchanges their upper and lower arrays while preserving the mesh and decay order. (`mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L228)).

**Strictly positive rational step entries.** Proposition definition. Positive step entries require a valid mesh and strictly positive numerators and denominators in every in-range cell of both halves. (`EntriesPositive`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L230)).

**Step-entry positivity is decidable.** Instance. Step-entry positivity is decidable. (`unnamed instance at line 235`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L235)).

**Rational meshes give real tensor meshes.** Proposition definition. This proposition requires every valid rational mesh to evaluate to a valid real tensor mesh. (`MeshOfRational`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L239)).

**Coefficient joins give joined scalars.** Proposition definition. This proposition requires valid meshes and coefficient joining certificates to produce a joined chart scalar. (`JoinsOfCoefficients`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L242)).

**Coefficient signs imply nonnegativity.** Proposition definition. This proposition requires valid meshes and nonnegative coefficient certificates to produce nonnegative chart-scalar values. (`NonnegOfCoefficients`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L246)).

**Constant core from constant coefficients.** Proposition definition. This proposition requires matching valid radial meshes and a constant-core coefficient certificate to produce a constant chart-scalar core. (`CoreOfCoefficients`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L250)).

**Flat coefficients give origin flatness.** Proposition definition. This proposition requires valid meshes and flat initial-edge coefficients to produce a chart scalar flat at the origin. (`FlatOfCoefficients`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L254)).

**Positive entries give positive steps.** Proposition definition. This proposition requires strictly positive rational step entries to evaluate to a positive real step function. (`StepPositiveOfEntries`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L258)).

**Rational epsilon-block values.** Data structure. An epsilon block stores its mode set, coefficient weight, two shares, length, four time parameters, and scale as rational data. (`EpsValues`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L261)).

**Rational mu-block values.** Data structure. A mu block stores its mode set, coefficient weight, share and time step data, and the real parameter eta. (`MuValues`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L273)).

**Epsilon coefficients interpreted as data.** Definition. An epsilon value block is interpreted by converting its coefficient weight and every step array to real data. (`toGiven`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L280)).

**Mu coefficients interpreted as data.** Definition. A mu value block is interpreted by converting its coefficient weight and step arrays while preserving eta. (`toGiven`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L284)).

**Reflection of epsilon-block values.** Definition. Reflecting an epsilon block reflects its mode labels and mirrors its weight and every step array. (`mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L287)).

**Reflection of mu-block values.** Definition. Reflecting a mu block reflects its mode labels and mirrors its weight and step arrays while preserving eta. (`mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L291)).

**Rational values for all weight data.** Data structure. The rational weight package stores chart data, a fractional central radius, mode classes, coefficient weights, epsilon and mu blocks, and two real constants. (`RationalWeightValues`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L294)).

**Rational weights as real data.** Definition. The real weight package evaluates fractional radii, coefficient scalars, and block data while preserving the supplied class map and constants. (`toWeightValues`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L309)).

**Positive steps in an epsilon block.** Proposition definition. The epsilon positivity condition requires all eight step arrays in the block to have positive entries. (`StepsPositive`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L322)).

**Positive steps in a mu block.** Proposition definition. The mu positivity condition requires its share and time arrays to have positive entries. (`StepsPositive`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L326)).

**Shape requirements for rational weights.** Proposition structure. The rational weight shape conditions require a finite class type, valid charts and meshes, constants between zero and one, and decay orders zero, one, and two for the designated weights. (`WeightValuesShape`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L328)).

**Coefficient conditions for the weights.** Proposition structure. The weight coefficient package combines derivative joins, constant cores, flatness, nonnegativity, positive steps, positive eta, and invariance under negating mode labels. (`WeightCoefficientsGiven`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L344)).

**Reflection closure of rational weights.** Proposition structure. Rational reflection closure identifies reflected class weights and permutes the epsilon and mu blocks onto their mirrors. (`IsMirrorClosedRational`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L362)).

**Coefficient conditions validate weights.** Proved result. The rational-mesh, joining, sign, core, flatness, and positivity assumptions turn a weight package with the coefficient certificates into valid real weight data. (`isWeightValues_of_conditions`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L369)).

**Rational flip closure gives symmetry.** Proved result. Rational reflection closure gives symmetry. (`isFlipClosed_of_rational`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L423)).

**Reflection closure of bound-value sets.** Proposition structure. Mirrored bound-value sets require reflected harmonic labels, reflected amplitude bounds, and reflection-fixed supremum bounds. (`BoundValueSetsMirrorClosed`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L444)).

**Flip and rotation of bound functions.** Proposition structure. The bound symmetry package requires reflection compatibility and axial rotation invariance for amplitudes and supremum bounds. (`BoundValuesFlipFacts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L453)).

**Bound symmetry from mirrored values.** Proved result. Mirrored bound values give bound symmetry. (`boundValuesFlipFacts_of_mirror`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L466)).

**Mirrored speeds give speed symmetry.** Proved result. Mirrored speeds give speed symmetry. (`speedFacts_of_values`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeScalarStatements.lean#L490)).

### Breakdown.CertCell.ShapeSecondSymmetric

This file names symmetry of the chosen shape Hessian and transfers it from shape or jet entries to the cell-layer Hessian. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Symmetry of the shape Hessian.** Proposition definition. This proposition requires the shape Hessian to be unchanged when its two direction arguments are exchanged. (`FieldSecondSymmetric`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetric.lean#L11)).

**Shape entries give symmetric Hessians.** Proved result. Shape entries give symmetric Hessians. (`givenSecondSymmetric_of_entry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetric.lean#L15)).

**Jet entries give symmetric Hessians.** Proved result. Jet entries give symmetric Hessians. (`givenSecondSymmetric_of_jets`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetric.lean#L21)).

### Breakdown.CertCell.ShapeSecondSymmetricProof

This file proves symmetry of the totalized second Fréchet derivative and transfers it to the key and shape Hessians under the stated C¹ regularity. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**The totalized C¹ Hessian is symmetric.** Proved result. A C¹ function has a symmetric totalized second Fréchet derivative. (`secondDeriv_symmetric_of_contDiff_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetricProof.lean#L13)).

**Symmetric Hessians of regular keys.** Proved result. C¹ key fields with locally Lipschitz gradients have symmetric totalized second derivatives. (`keySecondDeriv_symmetric_of_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetricProof.lean#L21)).

**Shape Hessian symmetry from regularity.** Proved result. The key regularity assumptions imply symmetry of the assembled shape Hessian. (`fieldSecondSymmetric_of_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSecondSymmetricProof.lean#L33)).

### Breakdown.CertCell.ShapeSphericalDiv

This file expresses the divergence of a field written in the spherical frame, keeping the off-axis differentiability conditions explicit. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**A field in the spherical frame.** Definition. The spherical-frame field multiplies a radial, polar, and azimuthal amplitude combination by the key's complex phase. (`framedField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L15)).

**The framed field is a three-term sum.** Proved result. The framed field is a three-term sum. (`framedField_eq_frameSum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L24)).

**Spherical divergence away from the axis.** Proved result. Away from the axis, the divergence of a differentiable spherical-frame field equals phase divided by radius times the radial, weighted height, and angular-frequency contributions. (`complexDivergence_framedField_offAxis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L34)).

**A coordinate patch gives divergence.** Proved result. A coordinate patch gives divergence. (`complexDivergence_framedField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L145)).

**Framed fields differentiate off-axis.** Proved result. Framed fields differentiate off-axis. (`framedField_differentiableAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L156)).

**Spherical divergence of key fields.** Proved result. Away from the axis, the key-field divergence is the spherical divergence expression evaluated on its reduced components. (`complexDivergence_keyVector_offAxis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDiv.lean#L178)).

### Breakdown.CertCell.ShapeSphericalDivFrame

This file computes derivatives and divergences of the radial, polar and azimuthal frames, then combines them with the chart and phase chain rules. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Inner products are coordinate sums.** Proved result. Inner products are coordinate sums. (`inner_coords`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L17)).

**Coordinate squares give the norm squared.** Proved result. Coordinate squares give the norm squared. (`coords_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L20)).

**The norm derivative is a unit covector.** Proved result. At a nonzero point, the norm has Fréchet derivative given by the inner product with that point divided by its norm. (`norm_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L24)).

**Directional derivative of the norm.** Proved result. Away from zero, the directional derivative of the norm is the position-direction inner product divided by the position norm. (`norm_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L31)).

**Radial composition obeys the chain rule.** Proved result. Radial composition obeys the chain rule. (`radial_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L39)).

**Radial differentiability away from zero.** Proved result. Radial compositions differentiate off zero. (`radial_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L46)).

**Differentiating a coordinate.** Proved result. A coordinate derivative selects a component. (`coord_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L50)).

**Coordinates are differentiable.** Proved result. Coordinates are differentiable. (`coord_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L56)).

**Reciprocal norm differentiates off zero.** Proved result. The reciprocal norm differentiates off zero. (`inv_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L59)).

**The reciprocal norm derivative.** Proved result. Away from zero, the directional derivative of reciprocal radius is minus the inner product with the direction divided by radius cubed. (`inv_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L62)).

**The inverse-square norm differentiates.** Proved result. The reciprocal squared norm is differentiable at every nonzero point. (`inv_sq_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L68)).

**Divergence obeys the product rule.** Proved result. Divergence obeys the product rule. (`div_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L72)).

**Divergence is additive.** Proved result. Divergence is additive. (`div_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L88)).

**Adding constants preserves divergence.** Proved result. Constant vectors do not change divergence. (`div_add_const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L95)).

**The identity field has divergence three.** Proved result. The identity field has divergence three. (`div_id`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L100)).

**Constant fields have zero divergence.** Proved result. Constant fields have zero divergence. (`div_const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L105)).

**The radial frame field.** Definition. The radial frame field is the position vector divided by its norm. (`radialField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L109)).

**The scaled polar frame field.** Definition. The polar frame field is the position vector times height over radius squared, minus the third unit vector. (`polarField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L111)).

**The scaled azimuthal frame field.** Definition. The azimuthal frame field is the planar quarter-turn vector divided by total radius. (`azimField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L113)).

**The radial field matches its coordinates.** Proved result. The radial field matches its coordinates. (`radialField_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L115)).

**The polar field matches its coordinates.** Proved result. The polar field matches its coordinates. (`polarField_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L118)).

**Azimuthal field matches its coordinates.** Proved result. The azimuthal field matches its coordinates. (`azimField_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L121)).

**The radial field differentiates off zero.** Proved result. The radial field differentiates off zero. (`radialField_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L124)).

**The polar field differentiates off zero.** Proved result. The polar field differentiates off zero. (`polarField_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L127)).

**Azimuthal field differentiates off zero.** Proved result. The azimuthal field differentiates off zero. (`azimField_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L130)).

**Radial divergence is two over radius.** Proved result. Radial divergence is two over radius. (`div_radialField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L133)).

**The polar frame divergence.** Proved result. Away from zero, the polar-frame divergence is twice the third coordinate divided by radius squared. (`div_polarField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L141)).

**Zero azimuthal divergence off zero.** Proved result. The azimuthal frame has zero divergence away from the origin. (`div_azimField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L156)).

**The compactified radius derivative.** Proved result. For a positive chart length and a nonzero point, the compactified-radius derivative is the radial derivative multiplied by the chart length over the squared shifted radius. (`chartCoord_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L172)).

**The normalized height derivative.** Proved result. Away from zero, differentiating normalized height gives the third direction coordinate over radius minus the third position coordinate times the radial inner product over radius cubed. (`heightRatio_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L187)).

**The radial phase derivative.** Proved result. Composing an admissible radial phase with squared radius gives twice the radial inner product times the phase derivative. (`radialPhase_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L203)).

**The complex plane-coordinate derivative.** Proved result. The derivative of the complex horizontal coordinate sends a direction to its first coordinate plus i times its second coordinate. (`planeCoord_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L217)).

**The angle derivative off its branch cut.** Proved result. Where the first coordinate is positive or the second is nonzero, the angle derivative is the oriented planar area divided by cylindrical radius squared. (`pointAngle_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L229)).

**Negation adds the integer angular phase.** Proved result. Negation adds the integer angular phase. (`angularExp_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L254)).

**Angular waves differentiate off-axis.** Proved result. Angular waves differentiate off-axis. (`angularExp_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L277)).

**The key phase splits into two factors.** Proved result. The key phase splits into two factors. (`keyPhase_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L325)).

**Differentiate the key phase.** Proved result. Off the axis, the directional derivative of a key phase is i times that phase times the sum of its azimuthal frequency times the angular directional change and twice its radial phase index times the radial phase slope at squared radius times the position-direction inner product. (`keyPhase_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L335)).

**The two-variable chart chain rule.** Proved result. A differentiable two-variable chart composition differentiates as the sum of its two partial derivatives weighted by the chart-coordinate derivatives. (`comp_hasFDerivAt_chart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L356)).

**Real vectors embedded in complex space.** Definition. The complex lifting map embeds each coordinate of a real spatial vector into the complex numbers. (`liftVec`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L381)).

**Complex lifting preserves coordinates.** Proved result. Complex lifting preserves coordinates. (`liftVec_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L384)).

**Divergence of a complex weighted vector.** Proved result. The trace of the complex weighted-vector derivative is the scalar times the vector divergence plus the scalar derivative applied to the vector. (`cdiv_term`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L387)).

**Three linear maps have additive trace.** Proved result. Three linear maps have additive trace. (`sum_three_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSphericalDivFrame.lean#L400)).

### Breakdown.CertCell.ShapeSplineAgree

This file proves the equivalence laws for spline agreement and shows that agreement respects joining, conjugation, reflection and evaluation. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Reflection preserves scalar factors.** Proved result. Reflection preserves scalar factors. (`reflectPoly_C_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L15)).

**Polynomial reflection is an involution.** Proved result. Polynomial reflection is an involution. (`reflectPoly_reflectPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L20)).

**Reflection commutes with conjugation.** Proved result. Reflection commutes with conjugation. (`map_reflectPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L31)).

**Polynomial conjugation is an involution.** Proved result. Polynomial conjugation is an involution. (`map_conj_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L42)).

**A parity sign squares to one.** Proved result. A parity sign squares to one. (`sign_mul_self`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L48)).

**A parity sign is real.** Proved result. A parity sign is real. (`sign_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L51)).

**Reflection preserves the cell count.** Proved result. Reflection preserves the cell count. (`cellCount_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L54)).

**Spline agreement is reflexive.** Proved result. Spline agreement is reflexive. (`agrees_refl`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L57)).

**Spline agreement is symmetric.** Proved result. Spline agreement is symmetric. (`agrees_symm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L59)).

**Spline agreement is transitive.** Proved result. Spline agreement is transitive. (`agrees_trans`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L64)).

**Conjugation preserves spline agreement.** Proved result. Conjugation preserves spline agreement. (`agrees_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L72)).

**Reflection preserves spline agreement.** Proved result. Reflection preserves spline agreement. (`agrees_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L77)).

**Double conjugation gives agreement.** Proved result. Double conjugation gives agreement. (`agrees_conj_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L88)).

**Double reflection gives agreement.** Proved result. Double reflection gives agreement. (`agrees_reflect_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L91)).

**Spline reflection respects conjugation.** Proved result. Spline reflection commutes with conjugation. (`agrees_reflect_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L107)).

**Agreement transports spline joins.** Proved result. Agreement transports spline joins. (`joined_of_agrees`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L113)).

**Distinct endpoints require two breaks.** Proved result. Distinct endpoints require two breaks. (`two_le_length_of_ends`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L124)).

**A cell index is below the cell count.** Proved result. A cell index is below the cell count. (`cellIndex_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L135)).

**Agreement on a full mesh gives equality.** Proved result. Spline agreement on a full mesh gives equal evaluated values at every coordinate pair. (`evalHalf_of_agrees`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L141)).

**Spline agreement laws.** Proved result. Spline agreement is an equivalence relation compatible with reflection, conjugation, derivative joins, and evaluation on full meshes. (`splineAgreementRules`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineAgree.lean#L151)).

### Breakdown.CertCell.ShapeSplineConj

This file shows that complex conjugation commutes with polynomial partial derivatives, edge substitutions and evaluation at real coordinates. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Radial derivatives respect conjugacy.** Proved result. Radial derivatives commute with conjugacy. (`tDeriv_map_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L15)).

**Height derivatives respect conjugacy.** Proved result. Height derivatives commute with conjugacy. (`xDeriv_map_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L23)).

**First substitution respects conjugacy.** Proved result. First substitution commutes with conjugacy. (`atFirst_map_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L31)).

**Second substitution respects conjugacy.** Proved result. Second substitution respects conjugacy. (`atSecond_map_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L41)).

**Real evaluation commutes with conjugacy.** Proved result. Real evaluation commutes with conjugacy. (`eval_real_map_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L51)).

**Conjugation preserves joined splines.** Proved result. Conjugation preserves joined splines. (`splineConjugation`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineConj.lean#L62)).

### Breakdown.CertCell.ShapeSplineDeriv

This file identifies classical derivatives of joined splines with derivatives of the selected polynomial piece, including one-sided behavior at mesh breaks. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**The two polynomial partials commute.** Proved result. The two polynomial partials commute. (`pderiv_zero_one_comm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L17)).

**Height derivatives respect radial ones.** Proved result. Height derivatives commute with radial ones. (`xDeriv_pderiv_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L25)).

**Radial derivatives respect height ones.** Proved result. Radial derivatives commute with height ones. (`tDeriv_pderiv_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L31)).

**Height substitution keeps radial slopes.** Proved result. Height substitution preserves radial slopes. (`atSecond_pderiv_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L37)).

**Radial substitution keeps height slopes.** Proved result. Radial substitution preserves height slopes. (`atFirst_pderiv_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L46)).

**Fixing the first input preserves value.** Proved result. Fixing the first polynomial variable at c leaves its evaluation at (c,y) unchanged. (`eval_atFirst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L55)).

**Fixing the second input preserves value.** Proved result. Fixing the second polynomial variable at c leaves its evaluation at (y,c) unchanged. (`eval_atSecond`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L63)).

**Differentiate the first polynomial input.** Proved result. Differentiating a polynomial along its first real input gives its first polynomial partial derivative evaluated at the same point. (`hasDerivAt_eval_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L71)).

**Differentiate the second input.** Proved result. Differentiating a polynomial along its second real input gives its second polynomial partial derivative evaluated at the same point. (`hasDerivAt_eval_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L98)).

**Distinct endpoints need two breaks.** Proved result. Distinct endpoints need two breaks. (`two_le_length`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L125)).

**Cell indices stay within the mesh.** Proved result. Cell indices stay within the mesh. (`cellIndex_lt_count`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L135)).

**Cell indices are locally right constant.** Proved result. Cell indices are locally right constant. (`cellIndex_right`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L141)).

**Left cell indices count strict breaks.** Proved result. Left cell indices count strict breaks. (`cellIndex_left`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L158)).

**Ordered break counts are exact.** Proved result. Ordered break counts are exact. (`sorted_counts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L176)).

**Matching pieces have one derivative.** Proved result. Strictly ordered differentiable pieces whose values and first derivatives match at every internal breakpoint give the selected piecewise derivative everywhere. (`piecewise_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L198)).

**Derivatives and joins of splines.** Proved result. At a positive joining order, a joined spline differentiates to its corresponding derivative spline and loses one order of joining in that coordinate. (`splineDerivatives_holds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineDeriv.lean#L255)).

### Breakdown.CertCell.ShapeSplineReflect

This file reverses the height mesh and polynomial argument, accounting for the sign of each height derivative and the selected cell at a reflected breakpoint. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Evaluate a polynomial substitution.** Proved result. Evaluating a polynomial after polynomial substitution equals evaluating the original polynomial at the values of the substituted polynomials. (`eval_bind_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L15)).

**Reflection preserves scalar factors.** Proved result. Reflection preserves scalar factors. (`reflectPoly_C_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L22)).

**Radial partials commute with reflection.** Proved result. Radial partials commute with reflection. (`pderiv_zero_reflectPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L26)).

**Height partials change reflection sign.** Proved result. Height partials change reflection sign. (`pderiv_one_reflectPoly`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L38)).

**Radial derivatives respect reflection.** Proved result. Radial differentiation commutes with height reflection and preserves the scalar prefactor. (`tDeriv_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L53)).

**Height derivatives acquire parity signs.** Proved result. Reflecting the height coordinate multiplies its order-o derivative by the scalar prefactor times (-1)^o. (`xDeriv_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L61)).

**First substitution respects reflection.** Proved result. First substitution commutes with reflection. (`atFirst_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L71)).

**Reflected substitution in height.** Proved result. Second substitution reflects its argument. (`atSecond_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L77)).

**Polynomial reflection reverses height.** Proved result. Polynomial reflection reverses height. (`eval_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L83)).

**Substituting the evaluation point.** Proved result. Substituting the second real evaluation coordinate into a polynomial leaves its value at that coordinate pair unchanged. (`eval_atSecond_self`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L90)).

**Reflection preserves the cell count.** Proved result. Reflection preserves the cell count. (`cellCount_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L96)).

**Reflection reverses interior breaks.** Proved result. Reflection reverses interior breaks. (`interior_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L99)).

**Reflected indices count reversed breaks.** Proved result. Reflected indices count reversed breaks. (`cellIndex_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L104)).

**Breakpoint lookup under reflection.** Proved result. Reflecting a finite breakpoint list negates the entry at the reverse index. (`getD_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L113)).

**Opposite counts partition breakpoints.** Proved result. Opposite breakpoint counts split the list. (`count_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L118)).

**Ordered breakpoint endpoint counts.** Proved result. Ordered breakpoint counts include endpoints. (`sorted_filter_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L152)).

**Distinct endpoints need two breaks.** Proved result. Distinct endpoints need two breaks. (`breaks_two_le_length`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L167)).

**A cell index is below the cell count.** Proved result. Cell indices lie within the mesh. (`cellIndex_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L174)).

**Interior and shifted lookups agree.** Proved result. Interior lookup agrees with shifted lookup. (`getD_interior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L180)).

**Reflected splines have reflected values.** Proved result. Reflected splines have reflected values. (`evalHalf_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L188)).

**Reflection preserves spline joins.** Proved result. Reflection preserves spline joins. (`joined_reflect`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L227)).

**Reflection and joining of splines.** Proved result. Reflecting a joined spline preserves its joining orders and evaluates it at negated height with the selected parity sign. (`splineReflection`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineReflect.lean#L257)).

### Breakdown.CertCell.ShapeSplineSlope

This file bounds derivatives of the finitely many polynomial pieces on boxes and uses those bounds to obtain local Lipschitz control of a joined spline gradient. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Evaluation of the selected spline piece.** Definition. The piece evaluator chooses the two cell indices and evaluates that cell's bivariate polynomial at the given coordinates. (`pieceEval`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L18)).

**The selected cell is right locally fixed.** Proved result. The selected cell is right locally fixed. (`cellIndex_eventually_right`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L21)).

**Cell indices are bounded by the count.** Proved result. A selected cell index never exceeds the number of interior breakpoints. (`cellIndex_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L41)).

**First-variable polynomial derivatives.** Proved result. Differentiating polynomial evaluation in the first real variable evaluates the first polynomial partial derivative. (`polyEval_hasDerivAt_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L44)).

**Second-variable polynomial derivatives.** Proved result. Differentiating polynomial evaluation in the second real variable evaluates the second polynomial partial derivative. (`polyEval_hasDerivAt_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L79)).

**Right derivative of the first input.** Proved result. The right derivative in the first coordinate of the selected piecewise polynomial equals its selected first polynomial partial derivative. (`pieceEval_right_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L114)).

**Right derivative of the second input.** Proved result. The right derivative in the second coordinate of the selected piecewise polynomial equals its selected second polynomial partial derivative. (`pieceEval_right_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L123)).

**Pairs of vectors depend continuously.** Proved result. Pairs of vectors depend continuously. (`continuous_pairVec`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L132)).

**Cell-piece values are bounded on boxes.** Proved result. For every box |t|,|x|≤R, one nonnegative constant bounds all values of the selected polynomial pieces. (`pieceEval_bounded`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L140)).

**Slice bounds from derivative bounds.** Proved result. A continuous scalar function with right derivatives bounded by M on [−R,R] has value differences at most M times the distance between arguments in that interval. (`slice_diff_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L163)).

**Piece values are Lipschitz on boxes.** Proved result. If the selected polynomial pieces give a continuous function, their value differences on a box are bounded by a constant times the sum of coordinate differences. (`pieceEval_box`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L178)).

**Operator bounds from coordinate bounds.** Proved result. Coordinate directions bound operator norm. (`opNorm_le_axes`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L203)).

**Joined spline gradients are Lipschitz.** Proved result. Joined splines with at least first-order joins in both coordinates have Lipschitz gradients on every closed ball. (`joinedSplineGradSlopeBound_of_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSlope.lean#L221)).

### Breakdown.CertCell.ShapeSplineSmooth

This file glues matching polynomial pieces across ordered radial and height breaks to prove the regularity dictated by their joining orders. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Counting breaks at or below a point.** Definition. The breakpoint counter counts list entries at or below the argument. (`belowCount`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L19)).

**Ordered counting handles the first break.** Proved result. Ordered counting handles the first break. (`belowCount_cons`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L21)).

**Breakpoint counts do not exceed length.** Proved result. Breakpoint counts do not exceed length. (`belowCount_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L32)).

**No later breakpoint precedes the first.** Proved result. No later breakpoint precedes the first. (`belowCount_at`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L34)).

**Matching pieces glue continuously.** Proved result. Matching pieces glue continuously. (`glue_continuous`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L42)).

**Matching first derivatives glue.** Proved result. Matching first derivatives glue. (`glue_step`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L61)).

**Gluing preserves matching derivatives.** Proved result. Differentiable pieces selected by a continuous coordinate have the selected derivative when their values and derivatives match at every strictly ordered breakpoint. (`glue_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L92)).

**Evaluating bivariate real polynomials.** Definition. The polynomial evaluator embeds both real coordinates into the complex numbers before evaluating the bivariate polynomial. (`evP`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L125)).

**Polynomial derivative as a linear map.** Definition. The polynomial derivative map sums the two coordinate projections multiplied by the corresponding evaluated polynomial partials. (`dP`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L127)).

**Pair the partials with the direction.** Proved result. Applying the polynomial derivative to a direction gives the sum of each direction coordinate times the corresponding evaluated partial derivative. (`dP_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L131)).

**Polynomial derivatives from partials.** Proved result. A bivariate polynomial evaluated on real pairs has Fréchet derivative given by its two evaluated partial derivatives acting on the direction coordinates. (`evP_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L135)).

**Polynomial evaluation is continuous.** Proved result. Polynomial evaluation is continuous. (`evP_continuous`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L165)).

**Agreement on a line gives radial slopes.** Proved result. Agreement on a line gives radial slopes. (`evP_line_t`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L168)).

**Agreement on a line gives height slopes.** Proved result. Agreement on a line gives height slopes. (`evP_line_x`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L179)).

**Polynomial partial derivatives commute.** Proved result. Polynomial partial derivatives commute. (`pderiv_swap`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L190)).

**Height derivatives respect radial ones.** Proved result. Height derivatives commute with radial ones. (`xDeriv_pderiv_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L198)).

**Radial derivatives respect height ones.** Proved result. Radial derivatives commute with height ones. (`tDeriv_pderiv_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L206)).

**Evaluate polynomial substitution.** Proved result. Polynomial substitution can be evaluated by first evaluating the two substituted polynomials and then using their values as the inputs to the original polynomial. (`eval_bind_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L214)).

**Evaluation after fixing the first input.** Proved result. After fixing the first polynomial variable at c, evaluation gives the original polynomial at c and the second input coordinate. (`evP_atFirst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L221)).

**Evaluation after fixing the second input.** Proved result. After fixing the second polynomial variable at c, evaluation gives the original polynomial at the first input coordinate and c. (`evP_atSecond`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L228)).

**Radial joining gives equal edge values.** Proved result. Radial joining gives equal edge values. (`join_t`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L235)).

**Height joining gives equal edge values.** Proved result. Height joining gives equal edge values. (`join_x`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L240)).

**Tensor-piece derivative matching.** Proposition structure. The tensor joining package requires neighboring pieces to match the designated radial and height derivatives along their common edges. (`Joins`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L245)).

**Joining orders can be lowered.** Proved result. Joining orders can be lowered. (`mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L251)).

**Radial differentiation lowers join order.** Proved result. Radial differentiation lowers join order. (`first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L256)).

**Height differentiation lowers join order.** Proved result. Height differentiation lowers join order. (`second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L265)).

**The selected tensor-piece function.** Definition. The tensor-piece function selects its piece using the two breakpoint counts and evaluates that polynomial at the coordinate pair. (`spl`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L274)).

**Joined pieces give a continuous function.** Proved result. Joined pieces give a continuous function. (`spl_continuous`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L277)).

**First-order joins give a derivative.** Proved result. First-order joins in both coordinates make the tensor spline differentiable with the derivative of its selected polynomial piece. (`spl_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L300)).

**Regularity from spline joining orders.** Proved result. A tensor spline is Cⁿ when its strictly ordered pieces match derivatives through at least order n in both variables. (`spl_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L337)).

**Interior breakpoint lists preserve order.** Proved result. Interior breakpoint lists preserve order. (`inner_facts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L351)).

**Spline joins give tensor-piece joins.** Proved result. Spline joins give tensor-piece joins. (`joins_of_joined`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L369)).

**Joining orders give spline smoothness.** Proved result. A spline joined to orders a and b is continuously differentiable through order min(a,b). (`joinedSplineSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSplineSmooth.lean#L389)).

### Breakdown.CertCell.ShapeStatements

This file states the analytic contracts required of the shape construction and records how they feed the cell layer, the given field and the actuator data. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**C¹ fields with locally Lipschitz slopes.** Proposition structure. The key regularity condition requires C¹ regularity and a Lipschitz gradient on every closed ball centered at the origin. (`IsKeyFieldSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L17)).

**Inverse-radius decay through order two.** Proposition structure. The key decay condition bounds the value, first derivative, and totalized second derivative by inverse powers one, two, and three of one plus radius. (`IsKeyFieldDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L21)).

**The complex divergence.** Definition. Complex divergence is the sum of the three diagonal coordinate evaluations of the real Fréchet derivative. (`complexDivergence`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L25)).

**Admissibility of logarithmic phases.** Proposition definition. This proposition requires a logarithmic phase with positive base parameter to satisfy the radial-phase assumptions. (`LogPhaseIsRadial`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L28)).

**C² profiles with Lipschitz curvature.** Proposition definition. This proposition requires admissible origin profiles to be C² below one and to have Lipschitz second derivatives on closed intervals strictly below that edge. (`OriginProfileSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L31)).

**Regularity of joined splines.** Proposition definition. This proposition requires a spline joined to orders a and b to be C to order min(a,b). (`JoinedSplineSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L35)).

**Locally Lipschitz spline gradients.** Proposition definition. This proposition requires a spline with at least first-order joins in both variables to have Lipschitz gradient on each closed ball. (`JoinedSplineGradSlopeBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L39)).

**Classical derivatives of joined splines.** Proposition definition. This proposition identifies each coordinate derivative with its derivative spline and reduces the corresponding joining order by one. (`SplineDerivatives`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L43)).

**Reflection of joined splines.** Proposition definition. This proposition requires reflected splines to preserve joining orders and evaluate with the selected parity sign at negated height. (`SplineReflection`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L50)).

**Conjugation of joined splines.** Proposition definition. This proposition requires conjugating a spline to preserve joining orders and conjugate its evaluated values. (`SplineConjugation`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L55)).

**The laws of spline agreement.** Proposition definition. This proposition packages agreement as an equivalence compatible with reflection, conjugation, joining conditions, and evaluation on full meshes. (`SplineAgreementRules`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L59)).

**Jet splines have matching derivatives.** Proposition definition. This proposition requires valid radial and height jet axes to yield spline joining orders one less than their depths. (`JetSplineJoined`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L69)).

**Reflected jet coefficients give parity.** Proposition definition. This proposition requires reflection-fixed jet coefficients on a symmetric height axis to produce a spline agreeing with its parity reflection. (`JetReflection`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L73)).

**Conjugate reflection of jet coefficients.** Proposition definition. This proposition requires conjugate-reflection-fixed jet coefficients to produce a spline agreeing with its conjugate parity reflection. (`JetConjReflection`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L77)).

**Initial vanishing of jet splines.** Proposition definition. This proposition requires initial jet vanishing to make every first radial cell polynomial vanish on the initial edge. (`JetStartVanish`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L82)).

**Vanishing beyond the jet support edge.** Proposition definition. This proposition requires zero node and bubble coefficients beyond a breakpoint to give a spline vanishing from that breakpoint onward. (`JetSplineVanishesFrom`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L86)).

**Symmetry closure gives valid shape data.** Proposition definition. This proposition requires symmetry closure of valid given key data to yield valid time-field data. (`ClosureDataValid`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L92)).

**Type-one key regularity.** Proposition definition. This proposition requires keys with nonzero first label in valid shape data to have C¹ fields with gradients Lipschitz on closed balls. (`TypeOneKeySmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L96)).

**Type-two key regularity.** Proposition definition. This proposition requires keys with zero first label in valid shape data to have C¹ fields with gradients Lipschitz on closed balls. (`TypeTwoKeySmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L100)).

**Type-one key decay.** Proposition definition. This proposition requires valid nonzero-first-label keys to satisfy inverse-radius decay through second derivative order. (`TypeOneKeyDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L104)).

**Type-two key decay.** Proposition definition. This proposition requires valid zero-first-label keys to satisfy inverse-radius decay through second derivative order. (`TypeTwoKeyDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L108)).

**Zero divergence of key fields.** Proposition definition. This proposition requires every key field from valid shape and time-field data to have zero complex divergence. (`KeyDivergenceFree`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L112)).

**Time translation of key fields.** Proposition definition. This proposition requires translating time by τ to multiply each key field by its temporal Fourier phase at τ. (`KeyTimeShift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L116)).

**Rotation covariance of key fields.** Proposition definition. This proposition requires axial rotation of the argument to rotate the vector and multiply it by the key's angular Fourier phase. (`KeyRotation`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L121)).

**Reflection covariance of key fields.** Proposition definition. This proposition requires a reflected key at a reflected point to equal the reflected original vector. (`KeyFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L127)).

**Conjugation of key fields.** Proposition definition. This proposition requires negating a key to conjugate its field componentwise. (`KeyConjugate`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L131)).

**Joint regularity and time periodicity.** Proposition definition. This proposition requires joint C¹ regularity and time periodicity of the shape field together with almost-everywhere strong measurability and time periodicity of its Hessian. (`FieldJointSmooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L135)).

**Zero divergence of the shape field.** Proposition definition. This proposition requires the assembled shape field to have zero divergence at every time and point. (`FieldDivergenceFree`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L140)).

**The weak Hessian of the shape field.** Proposition definition. This proposition requires each column of the shape gradient to have the corresponding Hessian column as its weak gradient. (`FieldWeakHessian`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L144)).

**Uniform decay of the shape field.** Proposition definition. This proposition requires one time-uniform constant to bound the shape field, gradient, and Hessian with inverse-radius powers one, two, and three. (`FieldDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L149)).

**Symmetry invariance of shape fields.** Proposition definition. This proposition requires reflection symmetry and the two coupled time-rotation symmetries determined by the azimuthal order. (`FieldClassInvariant`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L154)).

**Flip covariance of the shape Hessian.** Proposition definition. This proposition requires reflecting the point and both Hessian directions to reflect the Hessian output. (`FieldHessFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L162)).

**Velocity modes of the shape field.** Proposition definition. This proposition identifies each shape velocity mode with the sum of key fields carrying that harmonic label. (`FieldModeFormula`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L166)).

**Finite harmonic expansion of shapes.** Proposition definition. This proposition requires the field and Hessian to admit a finite harmonic expansion over any negation-closed set covering the supplied harmonics. (`FieldHarmonicExpansion`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L170)).

**Compact spatial support of shape fields.** Proposition definition. This proposition requires compact time-field data to give a spatial support radius uniform in time. (`CompactFieldSupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L175)).

**Actuator shape requirements.** Proposition definition. This proposition requires compact valid shape data to satisfy the actuator's shape and label conditions. (`ActuatorShape`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L179)).

**The shape-analysis requirements.** Proposition structure. The shape-analysis package collects the phase, profile, spline, jet, key-field, symmetry, harmonic, support, and actuator requirements. (`ShapeParts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L183)).

**Weak Hessians from shape contracts.** Proved result. The shape-analysis assumptions supply a weak Hessian state with a uniform decay constant for valid shape data. (`weakHessianState_of_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L218)).

**Shape contracts give flip invariance.** Proved result. The shape-analysis assumptions imply reflection covariance of both the shape field and its Hessian. (`flipModel_of_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L225)).

**Shape entries matching the cell data.** Proposition structure. A valid shape entry identifies the model and actuators with the cell layer's fields, Hessians, azimuthal order, and harmonic labels. (`IsGivenShapeEntry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L230)).

**Shape facts needed by cell assembly.** Proposition structure. The layer shape package records actuator shape conditions, a reflection-invariant weak Hessian model, and a finite harmonic expansion spanning the model field. (`LayerShapeFacts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L245)).

**Shape entries establish assembly facts.** Proved result. A valid shape entry and the shape-analysis assumptions supply the model and actuator facts required by cell-layer assembly. (`layerShapeFacts_of_entry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L254)).

**Shape entries determine velocity modes.** Proved result. A valid shape entry identifies each model velocity mode with the sum of key fields carrying that harmonic label. (`givenModeFormula_of_entry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L271)).

**Valid data from symmetry closure.** Proved result. The shape-analysis assumptions make the symmetry closure of valid given keys into valid time-field data. (`givenData_valid_of_closure`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeStatements.lean#L278)).

### Breakdown.CertCell.ShapeSupport

This file states the explicit physical support radius obtained from a compactified radial edge and connects it with cell support coverage. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**The physical support radius.** Proposition definition. This proposition requires compact shape data with support edge t to vanish beyond the physical radius L t/(1−t), where L is the chart length. (`CompactFieldSupportRadius`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupport.lean#L15)).

**Shape support is in the cell region.** Proved result. Shape support lies within the cell region. (`actuatorSupportInCells_of_shape`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupport.lean#L19)).

### Breakdown.CertCell.ShapeSupportRadius

This file proves that a compactly supported spline has zero reduced components beyond its edge and converts that chart edge into a physical support radius. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Earlier interior breaks form a sublist.** Proved result. Earlier interior breaks form a sublist. (`take_prefix_inner`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L15)).

**Earlier breaks precede the chosen cell.** Proved result. Earlier break indices precede cell indices. (`index_le_cellIndex`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L20)).

**Ordering of later defaulted breaks.** Proved result. Later defaulted breaks remain above a break. (`break_le_getD`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L40)).

**Zero spline values beyond support.** Proved result. Spline values vanish beyond the support edge. (`evalHalf_zero_beyond`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L52)).

**Derivatives vanish on a zero tail.** Proved result. Derivatives vanish on a zero tail. (`deriv_zero_near`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L70)).

**The zero function has zero derivative.** Proved result. The zero function has zero derivative. (`deriv_zero_everywhere`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L76)).

**Zero type-one values beyond support.** Proved result. Type-one components vanish beyond support. (`reducedComps_radialPolar_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L81)).

**Zero type-two values beyond support.** Proved result. Type-two components vanish beyond support. (`reducedComps_streamSwirl_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L95)).

**Passing the support edge in the chart.** Proved result. Physical radius beyond the edge gives t>tb. (`edge_lt_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L110)).

**Key components vanish beyond the edge.** Proved result. Key components vanish beyond the edge. (`reducedComps_zero_past_edge`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L119)).

**Validity of the physical support radius.** Proved result. Compact shape data with an edge breakpoint vanish beyond the radius obtained by inverting the compactifying chart. (`compactFieldSupportRadius_holds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeSupportRadius.lean#L136)).

### Breakdown.CertCell.ShapeTypeOneDecay

This file develops quantitative calculus for far-field bounds and proves inverse-radius decay of a type-one key field and its first two derivatives. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**A Lipschitz bound on a set.** Proposition definition. A slope bound on a set bounds each value difference by the constant times the distance between the two points. (`SlopeBoundOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L26)).

**Unit-ball value and derivative bounds.** Proposition definition. Unit-ball data require differentiability, a value bound, a derivative bound, and a Lipschitz bound for the derivative on the ball. (`BallData`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L29)).

**Decay orders controlling two derivatives.** Proposition definition. Far decay of order a requires unit-ball value, derivative, and gradient-Lipschitz bounds with successive inverse-radius orders a, a+1, and a+2 beyond one fixed radius. (`FarDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L33)).

**Derivative bounds imply Lipschitz bounds.** Proved result. Differentiability and a derivative norm bound K throughout a ball imply a Lipschitz bound K throughout that ball. (`slopeBoundOn_of_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L37)).

**Equality transports Lipschitz bounds.** Proved result. Functions agreeing on a set share any Lipschitz constant valid for one of them on that set. (`slopeBoundOn_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L42)).

**Lipschitz bounds may be enlarged.** Proved result. A Lipschitz estimate remains valid after increasing its constant. (`slopeBoundOn_mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L46)).

**Lipschitz bounds add.** Proved result. The sum of two functions with Lipschitz constants K₁ and K₂ on the same set has constant K₁+K₂ there. (`slopeBoundOn_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L49)).

**Rank-one operator norms multiply.** Proved result. Rank-one operator norms multiply. (`norm_smulRight_le'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L57)).

**Ball bounds may be enlarged.** Proved result. Unit-ball value, derivative, and derivative-Lipschitz bounds remain valid when each of their three constants is increased. (`ballData_mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L65)).

**Ball bounds add.** Proved result. Adding two fields adds their unit-ball value, derivative, and derivative-Lipschitz constants. (`ballData_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L69)).

**Zero derivative bounds for constants.** Proved result. A constant field has unit-ball value bound equal to its norm and zero derivative and derivative-Lipschitz bounds. (`ballData_const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L79)).

**Pairing fields adds their ball bounds.** Proved result. Pairing two real fields gives unit-ball value, derivative, and derivative-Lipschitz bounds by adding the corresponding constants. (`ballData_prod`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L82)).

**Products obey a Lipschitz bound.** Proved result. Products obey a Lipschitz bound. (`slopeBoundOn_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L115)).

**Lipschitz bounds for rank-one maps.** Proved result. Rank-one operators obey a Lipschitz bound. (`slopeBoundOn_smulRight`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L131)).

**Products of fields bounded on balls.** Proved result. Products obey the ball-bound product rule. (`ballData_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L152)).

**Ball bounds for real rank-one maps.** Proved result. Real rank-one maps obey the product bound. (`slopeBoundOn_smulRightR`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L187)).

**Sums preserve decay order.** Proved result. The sum of two fields with remote unit-ball decay of order a retains value decay a, derivative decay a+1, and derivative-Lipschitz decay a+2. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L208)).

**Constants have order-zero decay.** Proved result. A constant field has bounded values and zero derivatives on all remote unit balls, giving far-decay order zero. (`const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L215)).

**Pointwise bounds from ball decay.** Proved result. Remote unit-ball decay of order a yields pointwise value, first derivative, and totalized second derivative bounds with inverse-radius powers a, a+1, and a+2. (`bounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L219)).

**Products add their decay orders.** Proved result. Multiplying a scalar field of far-decay order a by a vector field of order b gives order a+b, with one and two additional inverse-radius powers for derivative and derivative-Lipschitz bounds. (`smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L237)).

**The norm derivative is the unit covector.** Proved result. At a nonzero point, the derivative of the norm is the radial unit covector. (`norm_hasFDerivAt'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L265)).

**The norm derivative has norm one.** Proved result. The radial unit covector at a nonzero point has operator norm one. (`normMap_norm'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L280)).

**Distance between normalized directions.** Proved result. Normalized directions obey a distance bound. (`unit_sub_le'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L283)).

**Differentiate a radial composition.** Proved result. Away from zero, composing a differentiable radial profile with the norm gives the profile derivative times the radial unit covector. (`radial_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L304)).

**Spatial decay from radial derivatives.** Proved result. If a radial profile and its first two radial derivatives have successive inverse-radius orders a, a+1, and a+2 beyond a positive threshold, composition with spatial radius has the corresponding remote unit-ball bounds. (`radial_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L311)).

**Degree-zero homogeneity rescales slopes.** Proved result. For a field invariant under positive scaling, multiplying the evaluation point by a positive factor multiplies its derivative by the reciprocal factor wherever the stated derivative exists. (`hom_fderiv'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L399)).

**Decay of degree-zero homogeneous fields.** Proved result. A degree-zero homogeneous field differentiable off zero with locally Lipschitz gradient has bounded values, inverse-radius gradient bounds, and inverse-square gradient-Lipschitz bounds on remote unit balls. (`hom_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L411)).

**C² homogeneity gives order-zero decay.** Proved result. A degree-zero homogeneous field that is C² off zero has bounded values and successive inverse-radius and inverse-square derivative bounds on remote unit balls. (`hom_FD_of_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L470)).

**Ball bounds under composition.** Proved result. Composition obeys the ball-bound chain rule. (`ballData_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L481)).

**C¹ functions with Lipschitz gradients.** Proposition definition. The slope regularity condition requires C¹ regularity and a locally Lipschitz gradient. (`SlopeRegular`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L521)).

**Pairs preserve order-zero decay.** Proved result. Pairing two real fields with bounded remote values and inverse-radius and inverse-square derivative bounds preserves those three orders. (`prod`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L523)).

**Bounded chart composition keeps decay.** Proved result. Composing a C¹ chart function with locally Lipschitz gradient with an order-zero decaying map into the closed unit ball preserves bounded values and the first two inverse-radius derivative orders. (`comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L530)).

**Local Lipschitz bounds for bilinear maps.** Proved result. A continuous bilinear map applied to two locally Lipschitz functions is locally Lipschitz. (`locSlopeBound_bilin'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L571)).

**C² implies locally Lipschitz gradients.** Proved result. C² implies locally Lipschitz gradients. (`of_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L626)).

**Sums preserve gradient regularity.** Proved result. The sum of two C¹ functions with locally Lipschitz gradients has the same regularity. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L629)).

**Products preserve gradient regularity.** Proved result. The product of two complex C¹ functions with locally Lipschitz gradients has the same regularity. (`mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L637)).

**Joined splines have gradient regularity.** Proved result. A spline joined to at least first order in both variables is C¹ with locally Lipschitz gradient. (`spline`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L648)).

**Positive scaling fixes normalized height.** Proved result. Positive scaling fixes normalized height. (`heightRatio_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L661)).

**Scaling fixes normalized coordinates.** Proved result. Positive scaling fixes normalized coordinates. (`coord_div_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L668)).

**Positive scaling fixes the point angle.** Proved result. Positive scaling fixes the point angle. (`pointAngle_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L674)).

**Normalized coordinates are C² off zero.** Proved result. Normalized coordinates are C² off zero. (`coord_div_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L681)).

**Complex embedding keeps C² regularity.** Proved result. A real C² function at a point remains C² there after complex embedding. (`ofReal_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L687)).

**Positive scaling fixes the polar frame.** Proved result. Positive scaling fixes the polar frame. (`polarVecQ_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L691)).

**Scaling fixes the azimuthal frame.** Proved result. Positive scaling fixes the azimuthal frame. (`azimVecQ_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L700)).

**Normalized height is C² off zero.** Proved result. Normalized height is C² off zero. (`heightRatio_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L706)).

**Normalized height has order-zero decay.** Proved result. Normalized height has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`heightRatio_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L709)).

**The complex radial frame.** Definition. The complex radial frame embeds each real radial-vector component into the complex numbers. (`radialC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L712)).

**The complex polar frame.** Definition. The complex polar frame embeds each real scaled polar-vector component into the complex numbers. (`polarC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L714)).

**The complex azimuthal frame.** Definition. The complex azimuthal frame embeds each real scaled azimuthal-vector component into the complex numbers. (`azimC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L716)).

**The radial frame has order-zero decay.** Proved result. The complex radial frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`radialC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L718)).

**The polar frame has order-zero decay.** Proved result. The complex polar frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`polarC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L725)).

**The azimuthal frame has order-zero decay.** Proved result. The complex azimuthal frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`azimC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L739)).

**The axis-regularized angular wave.** Definition. The regularized angular wave multiplies the integer angular exponential by the axis-vanishing factor at normalized height. (`angularC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L751)).

**Angular waves have order-zero decay.** Proved result. The axis-regularized integer angular wave has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`angularC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L754)).

**The shifted reciprocal derivative.** Proved result. Away from a zero shifted denominator, the derivative of its reciprocal is minus its reciprocal square. (`invShift_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L759)).

**The shifted reciprocal-square derivative.** Proved result. Away from a zero shifted denominator, the derivative of its reciprocal square is minus twice its reciprocal cube. (`invShift_sq_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L764)).

**Reciprocal bounds under positive shifts.** Proved result. For positive radius and shift, every natural power of the shifted reciprocal is at most the same power of the unshifted reciprocal. (`invShift_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L769)).

**The radial tail has inverse-radius decay.** Proved result. For positive chart length, the complex chart tail has value, derivative, and derivative-Lipschitz bounds C/r, C/r², and C/r³ on unit balls centered at sufficiently large radius r. (`tailC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L773)).

**Compactified radius has order-zero decay.** Proved result. For positive chart length, compactified radius has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`chartC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L799)).

**Admissible phases have three derivatives.** Proved result. Admissible phases have three derivatives. (`phase_derivs`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L835)).

**An absolute-value product bound.** Proved result. An absolute-value product bound. (`abs_le_of_eq_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L859)).

**The square function has derivative 2r.** Proved result. The square function has derivative 2r. (`sq_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L863)).

**Squared arguments obey the chain rule.** Proved result. Squared arguments obey the chain rule. (`comp_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L866)).

**Two summands obey the triangle bound.** Proved result. Two summands obey the triangle bound. (`abs_lin2`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L870)).

**Three summands obey the triangle bound.** Proved result. Three summands obey the triangle bound. (`abs_lin3`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L873)).

**Decay bounds for radial oscillations.** Proved result. The exponential of an admissible radial phase has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`phaseC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L876)).

**Radial phase slopes have order-0 decay.** Proved result. Twice squared radius times the derivative of an admissible radial phase has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`slopeC_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L949)).

**The radial polynomial weight.** Definition. The radial polynomial weight is t to the low order times (1−t) to the tail order, embedded in the complex numbers. (`weightLow`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1007)).

**The derivative of the radial weight.** Definition. The polynomial-weight derivative is the product-rule sum for t to the low order times (1−t) to the high order. (`weightDeriv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1009)).

**The polynomial-weight product rule.** Proved result. Differentiating t to the low order times (1−t) to the high order gives the two product-rule terms stored in the weight derivative. (`wR_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1012)).

**Joined splines have radial derivatives.** Proved result. For joins of at least first order in both variables, the radial derivative at every real coordinate pair is the radial derivative spline evaluated at that pair. (`spline_t_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1018)).

**Joined splines have height derivatives.** Proved result. For joins of at least first order in both variables, the height derivative at every real coordinate pair is the height derivative spline evaluated at that pair. (`spline_x_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1029)).

**C² real data give regular complex data.** Proved result. Embedding a real C² function into the complex numbers gives a C¹ function with locally Lipschitz gradient. (`realC_reg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1040)).

**Constant complex data are regular.** Proved result. A constant complex function is C¹ and has a locally Lipschitz zero gradient. (`const_reg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1043)).

**Regular gradients of polynomial weights.** Proved result. The polynomial radial weight viewed as a two-variable function is C¹ with locally Lipschitz gradient. (`vT_reg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1045)).

**The weighted radial amplitude.** Definition. The weighted radial amplitude multiplies the radial spline value by the radial polynomial weight. (`radialPart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1048)).

**The weighted polar amplitude.** Definition. The weighted polar amplitude multiplies the polar spline value by the radial polynomial weight. (`polarPart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1050)).

**Azimuthal amplitude without phase slope.** Definition. The phase-free azimuthal amplitude combines radial differentiation and weighted polar-height differentiation, multiplied by i over the angular frequency. (`azimPart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1052)).

**The phase-slope azimuthal amplitude.** Definition. The phase-slope azimuthal amplitude multiplies the weighted radial spline by the phase label and the factor i squared over angular frequency. (`azimSlopePart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1059)).

**Regularity of four key amplitudes.** Proved result. The radial, polar, azimuthal, and phase-slope amplitudes are C¹ with locally Lipschitz gradients when their radial and polar splines have the required joins. (`parts_regular`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1062)).

**The radial component exposes its tail.** Proved result. The radial component exposes its tail. (`R0_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1081)).

**The polar component exposes its tail.** Proved result. The polar component exposes its tail. (`R1_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1090)).

**The azimuthal component exposes its tail.** Proved result. The azimuthal component exposes its tail. (`R2_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1099)).

**Normalized height is at most one.** Proved result. Normalized height has absolute value at most 1. (`abs_heightRatio_le'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1134)).

**Compactified radius and its tail.** Proved result. Compactified radius is one minus the tail. (`chartCoord_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1146)).

**Chart tail equals the reciprocal tail.** Proved result. For positive chart length L, the chart tail is L divided by physical radius plus L. (`one_sub_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1153)).

**Chart and physical phase slopes agree.** Proved result. For positive chart length, the chart phase slope equals twice squared physical radius times the radial phase derivative there. (`phaseSlope_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1157)).

**The full phase splits into three factors.** Proved result. The full phase splits into three factors. (`keyPhase_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1168)).

**The chart pair has order-zero decay.** Proved result. For positive chart length, the radial-height chart pair has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`chartPair_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1178)).

**The chart pair stays in the unit ball.** Proved result. The chart pair stays in the unit ball. (`chartPair_mem`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1188)).

**Inverse-radius decay of type-one keys.** Proved result. For valid type-one data with positive outer vanishing order and radial/polar joins (2,1) and (1,2), the key field has remote value, derivative, and gradient-Lipschitz bounds with inverse-radius powers one, two, and three. (`key_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1201)).

**Near and far control give global decay.** Proved result. C¹ regularity with gradients Lipschitz on closed balls combines with remote decay of order one to give global value and derivative bounds by C/(1+r), C/(1+r)², and C/(1+r)³. (`decay_of_farDecay`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1234)).

**Type-one decay from regularity.** Proved result. Type-one key regularity implies global inverse-radius decay of the field and its first two totalized derivatives with powers one, two, and three. (`typeOneKeyDecay_of_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneDecay.lean#L1282)).

### Breakdown.CertCell.ShapeTypeOneOff

This file proves C¹ regularity and local Lipschitz control of the type-one gradient on the punctured space, using the angular regularization factor. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Gradient regularity away from zero.** Proposition definition. Punctured gradient regularity requires C¹ regularity and a locally Lipschitz gradient on the complement of the origin. (`OffSlope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L19)).

**The punctured space is a neighborhood.** Proved result. The punctured space is a neighborhood. (`off_nhds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L22)).

**Punctured space means nonzero points.** Proved result. Punctured space means nonzero points. (`off_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L25)).

**C¹ gives local Lipschitz continuity.** Proved result. C¹ regularity on the punctured space gives local Lipschitz continuity on that same domain. (`locSlopeBound_of_c1`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L29)).

**C² gives gradient control off zero.** Proved result. C² regularity on punctured space gives C¹ regularity there with a locally Lipschitz gradient. (`offSlope_of_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L35)).

**Equality keeps local Lipschitz bounds.** Proved result. Equality on punctured space transfers local Lipschitz continuity from one function to the other. (`locSlopeBound_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L43)).

**Lipschitz control bounds nearby values.** Proved result. For a K-Lipschitz function, moving at most unit distance within its domain increases its norm by at most K. (`norm_le_near`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L53)).

**Local Lipschitz bounds for bilinear maps.** Proved result. Applying a continuous bilinear map to two locally Lipschitz functions on punctured space preserves local Lipschitz continuity there. (`locSlopeBound_bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L62)).

**C¹ functions differentiate off zero.** Proved result. C¹ functions differentiate off zero. (`diff_of_c1`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L99)).

**Bilinear maps keep punctured regularity.** Proved result. A continuous bilinear combination of two C¹ fields with locally Lipschitz gradients on punctured space retains that regularity. (`bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L103)).

**Sums preserve punctured regularity.** Proved result. Adding two C¹ fields with locally Lipschitz gradients on punctured space retains that regularity. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L113)).

**Differences keep punctured regularity.** Proved result. Subtracting two C¹ fields with locally Lipschitz gradients on punctured space retains that regularity. (`sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L120)).

**Products preserve punctured regularity.** Proved result. Multiplying two complex C¹ fields with locally Lipschitz gradients on punctured space retains that regularity. (`mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L127)).

**Product regularity away from zero.** Proved result. Scalar multiplication of C¹ scalar and vector fields with locally Lipschitz gradients on punctured space retains that regularity. (`smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L131)).

**Constants satisfy punctured regularity.** Proved result. A constant field is C¹ with a locally Lipschitz zero gradient on punctured space. (`const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L135)).

**Chart composition keeps gradient control.** Proved result. Composing a C¹ chart function whose gradient is Lipschitz on closed balls with a C² punctured-space chart gives a C¹ field with locally Lipschitz gradient off zero. (`plane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L139)).

**Complex lifting of punctured regularity.** Proved result. Complex embedding of a real C² field on punctured space gives a C¹ field with locally Lipschitz gradient there. (`ofReal_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L165)).

**Compactified radius is C² off zero.** Proved result. Compactified radius is C² off zero. (`chartCoord_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L168)).

**Normalized height is C² off zero.** Proved result. Normalized height is C² off zero. (`heightRatio_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L176)).

**Complex regularity of the frame.** Proved result. A real frame that is componentwise C³ off zero gives a complex C¹ vector field with locally Lipschitz gradient off zero. (`frame_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L180)).

**Radial oscillation is regular off zero.** Proved result. For admissible shape parameters, the radial phase exponential is C¹ with locally Lipschitz gradient away from zero. (`phase_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L186)).

**Recovering radius from the chart.** Proved result. Radius is recovered from chart coordinates. (`chartRadius_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L196)).

**Chart phase slopes equal physical slopes.** Proved result. For positive chart length, the chart phase slope equals twice squared physical radius times the radial phase derivative there. (`phaseSlope_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L207)).

**Radial phase slopes are regular off zero.** Proved result. For admissible shape parameters, the integer multiple of the chart-composed phase slope is C¹ with locally Lipschitz gradient away from zero. (`slope_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L212)).

**Polynomial weights are infinitely smooth.** Proved result. Polynomial weights are infinitely smooth. (`weight_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L227)).

**Chart weights are regular off zero.** Proved result. For positive chart length, a polynomial radial weight composed with compactified radius is C¹ with locally Lipschitz gradient off zero. (`weight_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L232)).

**Weight derivative regularity off zero.** Proved result. For positive chart length, the derivative of a polynomial radial weight composed with compactified radius is C¹ with locally Lipschitz gradient off zero. (`dweight_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L236)).

**Spline composition away from zero.** Proved result. A spline joined to at least first order in both coordinates composed with two C² punctured-space charts is C¹ with locally Lipschitz gradient off zero. (`spline_off`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L242)).

**Derivatives of radial spline slices.** Proved result. With at least first-order joins in both variables, radial differentiation evaluates the radial derivative spline. (`slice_t`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L249)).

**Derivatives of height spline slices.** Proved result. With at least first-order joins in both variables, height differentiation evaluates the height derivative spline. (`slice_x`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L260)).

**Factoring the radial component.** Proved result. For a nonzero-first-label key, the radial reduced component is the axis factor times the polynomial weight and radial spline. (`radialComp_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L271)).

**Factoring the polar component.** Proved result. For a nonzero-first-label key, the polar reduced component is the axis factor times the polynomial weight and polar spline. (`polarComp_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L276)).

**Expanding the azimuthal component.** Proved result. For a nonzero-first-label key with the required spline joins, the azimuthal component is i over the angular frequency times the radial, phase, divergence, and height-slope combination. (`azimComp_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L281)).

**The full phase splits into its factors.** Proved result. The full phase splits into its factors. (`keyPhase_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L321)).

**Type-one keys have punctured regularity.** Proved result. Under the angular C³ assumption and radial/polar joins (2,1) and (1,2), a nonzero-first-label key is C¹ with locally Lipschitz gradient on punctured space. (`keyVector_offSlope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L331)).

**Type-one keys are C¹ off the origin.** Proved result. Type-one keys are C¹ off the origin. (`typeOneKey_contDiffOn_off_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L369)).

**Lipschitz gradients on compact sets.** Proved result. Type-one gradients are Lipschitz on compacta. (`typeOneKey_slope_off_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L377)).

**Type-one Lipschitz gradients on annuli.** Proved result. Type-one gradients are Lipschitz on annuli. (`typeOneKey_slope_annulus_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L387)).

**Type-one keys satisfy off-origin bounds.** Proved result. Under the angular C³ assumption, valid type-one key fields are C¹ off zero and their gradients are Lipschitz on every compact set avoiding zero. (`typeOneKey_off_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOff.lean#L407)).

### Breakdown.CertCell.ShapeTypeOneOrigin

This file factors the type-one field into a quadratic angular zero and a controlled remainder, then uses rescaling to establish regularity at the origin. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Local derivative with Lipschitz control.** Proposition definition. Local gradient control means that a differentiable field has a Lipschitz derivative throughout some positive-radius neighborhood. (`TameAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L23)).

**Local gradient control bounds values.** Proved result. A derivative that is Lipschitz on a positive ball is bounded there, makes the function Lipschitz there, and bounds its values by the center value plus the derivative bound times the radius. (`tame_bounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L27)).

**C² functions have local gradient control.** Proved result. C² regularity at a point gives a neighborhood on which the function is differentiable and its derivative is Lipschitz. (`tame_of_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L55)).

**Local bounds from global regularity.** Proved result. A globally differentiable function with locally Lipschitz derivative has a differentiable neighborhood with Lipschitz derivative around every point. (`tame_of_global`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L65)).

**Local equality keeps gradient control.** Proved result. Agreement on a neighborhood transfers differentiability with a Lipschitz derivative on a smaller neighborhood. (`tame_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L73)).

**Sums preserve local gradient control.** Proved result. Adding functions that have differentiable neighborhoods with Lipschitz derivatives preserves that local regularity. (`tame_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L83)).

**Linear maps keep local gradient control.** Proved result. Applying a continuous linear map preserves differentiability with a Lipschitz derivative on a neighborhood. (`tame_clm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L99)).

**Composition keeps local gradient control.** Proved result. Composing two functions that are differentiable with Lipschitz derivatives near the relevant points preserves that local regularity. (`tame_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L109)).

**Products preserve local gradient control.** Proved result. Multiplying complex functions with differentiable neighborhoods and Lipschitz derivatives preserves that local regularity. (`tame_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L146)).

**Negation keeps local gradient control.** Proved result. Negating a function preserves differentiability with a Lipschitz derivative on a neighborhood. (`tame_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L181)).

**Differences keep local gradient control.** Proved result. Subtracting functions with differentiable neighborhoods and Lipschitz derivatives preserves that local regularity. (`tame_sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L184)).

**Local control gives a Lipschitz region.** Proved result. A local derivative witness gives an actual neighborhood where the function is differentiable and its Fréchet derivative has one Lipschitz constant. (`tame_region`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L188)).

**Insertion into one complex coordinate.** Definition. The coordinate insertion map places a complex scalar in one chosen vector component and zero in every other component. (`unitSlot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L196)).

**Coordinate control gives vector control.** Proved result. If each of the three complex coordinates has a differentiable neighborhood with Lipschitz derivative, the assembled vector field has such a neighborhood. (`tame_pi`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L199)).

**Local gradient bounds for joined splines.** Proved result. Under the spline regularity and gradient assumptions, a spline joined to at least first order in both coordinates has a differentiable neighborhood with Lipschitz gradient around every point. (`spline_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L208)).

**Joined splines are differentiable.** Proved result. Joined splines are differentiable. (`spline_diff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L220)).

**Local control of radial spline slopes.** Proved result. With radial joining order at least two and height joining order at least one, the radial spline derivative is differentiable with Lipschitz gradient on some neighborhood of every point. (`spline_tderiv_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L226)).

**Local control of height spline slopes.** Proved result. With radial joining order at least one and height joining order at least two, the height spline derivative is differentiable with Lipschitz gradient on some neighborhood of every point. (`spline_xderiv_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L237)).

**A C³ radial partial derivative is C².** Proved result. A C³ radial partial derivative is C². (`partial_t_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L248)).

**Local bounds for differentiated products.** Proved result. The radial derivative of a product has a differentiable neighborhood with Lipschitz gradient when the first factor is C³ and the second factor and its radial derivative have that local regularity. (`tderiv_mul_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L261)).

**The chart radius is C² below one.** Proved result. The chart radius is C² below one. (`chartRadius_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L277)).

**The phase slope is C² below one.** Proved result. The phase slope is C² below one. (`phaseSlope_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L282)).

**Two extra radial powers factor as t².** Proved result. Two extra radial powers factor as t². (`weightPoly_add_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L299)).

**Weighted polar powers are C³.** Proved result. Weighted polar powers are C³. (`weight_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L305)).

**Weighted polar factors are C³.** Proved result. Weighted polar factors are C³. (`weight_q_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L312)).

**Quadratic factors in type-one components.** Proved result. Type-one components contain a quadratic zero. (`typeOne_factor`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L319)).

**The complex horizontal coordinate.** Definition. The complex horizontal coordinate is the first real coordinate plus i times the second. (`planeOf`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L459)).

**A degree-two angular profile.** Definition. The planar angular profile multiplies squared planar radius by the integer angular exponential. (`planeMap`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L461)).

**The angular profile scales quadratically.** Proved result. The angular profile scales quadratically. (`planeMap_scale`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L464)).

**Plane coordinate is infinitely smooth.** Proved result. The plane coordinate is infinitely smooth. (`planeOf_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L471)).

**Plane coordinate respects scalar action.** Proved result. The plane coordinate respects scalar action. (`planeOf_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L478)).

**Polar factor is a normalized plane norm.** Proved result. The polar factor is a normalized plane norm. (`one_sub_heightRatio_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L483)).

**The regular factor near the origin.** Definition. The regular origin factor combines shifted inverse-radius-square decay, the temporal and radial phase, and the three frame amplitudes in rescaled coordinates. (`nearOriginProfile`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L498)).

**Near-origin factor has gradient control.** Proved result. If every amplitude component has locally Lipschitz derivative below the chart edge, each near-origin factor is differentiable with Lipschitz derivative near every point of nonnegative radial coordinate. (`nearOriginProfile_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L507)).

**Phase exposes the quadratic plane factor.** Proved result. The phase exposes the quadratic plane factor. (`keyPhase_factor`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L552)).

**The key field factors near the origin.** Proved result. The key field factors near the origin. (`keyVector_near_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L577)).

**The rescaled type-one key.** Definition. The rescaled type-one key multiplies the quadratic planar angular profile by the regular origin factor evaluated at scaled radius and normalized direction. (`scaledKey`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L597)).

**Reciprocal bound for coordinate scaling.** Proved result. The coordinate rescaling has norm at most 1/s. (`scaleT_norm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L602)).

**Quadratic scaling transfers derivatives.** Proved result. When the rescaled field is differentiable, at positive scale s and nonzero point w the quadratic scaling identity gives the field derivative as s² times the rescaled-field derivative at (s,w/s), applied with zero scale component and spatial direction divided by s. (`scaled_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L610)).

**Regularity under quadratic rescaling.** Proved result. A field vanishing at zero with a quadratic rescaling law and locally Lipschitz derivatives of its rescaled factor has zero derivative at zero, quadratic value growth, linear derivative growth, and a Lipschitz gradient on a positive ball. (`scaled_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L628)).

**Quadratic vanishing of type-one fields.** Proved result. Type-one fields vanish quadratically at zero. (`typeOneKey_origin_bounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L751)).

**Type-one gradient regularity at zero.** Proved result. Under the spline assumptions, a valid type-one key field is differentiable at zero and its gradient is Lipschitz on some positive closed ball around zero. (`typeOneKey_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneOrigin.lean#L803)).

### Breakdown.CertCell.ShapeTypeOneSmooth

This file glues the origin and punctured-space estimates to obtain C¹ key fields whose gradients are Lipschitz on every closed ball. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Origin and punctured regularity give C¹.** Proved result. C¹ regularity off zero, differentiability at zero, and a Lipschitz gradient on a positive closed ball imply global C¹ regularity. (`contDiff_one_of_off_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneSmooth.lean#L13)).

**Separated points give a distance bound.** Proved result. Separated points give a distance bound. (`dist_le_of_far`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneSmooth.lean#L30)).

**Local and exterior slope bounds combine.** Proved result. A continuous map Lipschitz on compact sets avoiding zero and on one positive ball is Lipschitz on every closed ball centered at zero. (`slope_bound_of_off_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneSmooth.lean#L50)).

**Joining origin and punctured regularity.** Proved result. Punctured C¹ regularity, Lipschitz gradient bounds on compact sets off zero, differentiability at zero, and one origin gradient bound imply C¹ key regularity with a Lipschitz gradient on every closed ball. (`isKeyFieldSmooth_of_off_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneSmooth.lean#L100)).

**Type-one regularity by gluing.** Proved result. The type-one origin and punctured-space estimates combine to make every valid type-one key C¹ with gradients Lipschitz on closed balls. (`typeOneKeySmooth_of_off_origin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeOneSmooth.lean#L111)).

### Breakdown.CertCell.ShapeTypeTwoDecay

This file combines bounded-region estimates with type-two far-field estimates to obtain global inverse-radius decay. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Near and far bounds give weighted decay.** Proved result. C¹ key regularity and an order-one far-field bound give global inverse-radius bounds of orders one, two, and three for the value and first two totalized derivatives. (`bound_near_or_far`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecay.lean#L13)).

**Type-two decay from regularity.** Proved result. Type-two key regularity combines with its far-field estimate to give global inverse-radius bounds of orders one, two, and three. (`typeTwoKeyDecay_of_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecay.lean#L37)).

### Breakdown.CertCell.ShapeTypeTwoDecayBall

This file develops the product, composition and comparison rules for quantitative bounds on a field and its gradient on unit balls. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**A Lipschitz bound on a set.** Proposition definition. The slope condition bounds value differences on the set by a constant times distance. (`SlopeOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L18)).

**Derivative bounds give a Lipschitz bound.** Proved result. A derivative norm bound K throughout a ball gives the same K as a Lipschitz constant for the function on that ball. (`slopeOn_of_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L21)).

**Lipschitz constants may be enlarged.** Proved result. Lipschitz constants may be enlarged. (`mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L26)).

**Lipschitz constants add.** Proved result. Lipschitz constants add. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L30)).

**Equality preserves Lipschitz bounds.** Proved result. Functions agreeing on a set share any Lipschitz bound valid there. (`congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L36)).

**Bilinear products obey a slope bound.** Proved result. Bilinear products obey a slope bound. (`bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L41)).

**Bounds on a field and its derivative.** Proposition structure. The unit-ball package stores differentiability, value and derivative bounds, and a Lipschitz bound for the derivative. (`BallBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L60)).

**Ball bounds may be enlarged.** Proved result. Increasing the value, derivative, and derivative-Lipschitz constants preserves a unit-ball bound. (`mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L66)).

**Ball bounds add.** Proved result. Adding two fields adds their unit-ball value, derivative, and derivative-Lipschitz constants. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L70)).

**Negation preserves ball bounds.** Proved result. Negating a field preserves its unit-ball value, derivative, and derivative-Lipschitz bounds. (`neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L79)).

**Bilinear products obey ball bounds.** Proved result. A norm-one bilinear combination has unit-ball bounds v₁v₂ for values, v₁d₂+d₁v₂ for derivatives, and 2d₁d₂+v₁l₂+l₁v₂ for derivative Lipschitz constants. (`bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L87)).

**Pairing fields adds ball bounds.** Proved result. Pairing two real fields adds their corresponding unit-ball value, derivative, and derivative-Lipschitz constants. (`pair`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L120)).

**Ball bounds under composition.** Proved result. Composition with an outer function bounded by c₀ whose derivative is bounded by c₁ and c₂-Lipschitz gives ball bounds c₀, c₁d, and c₂d²+c₁l. (`comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L142)).

**Local equality preserves ball bounds.** Proved result. Equality on an open neighborhood containing a unit ball transfers the value, derivative, and derivative-Lipschitz bounds on that ball. (`congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L166)).

**Far-field bounds through two derivatives.** Proposition definition. A far-field bound of order a requires successive inverse-radius bounds of orders a, a+1, and a+2 on unit balls centered beyond one radius. (`FarBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L178)).

**Nearby points have comparable radii.** Proved result. Nearby points have comparable radii. (`ball_norm_near`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L182)).

**Reciprocal bounds at comparable radii.** Proved result. If s is at least r/2 with positive r and nonnegative C, then C/sᵏ is at most 2ᵏC/rᵏ. (`pow_div_le_of_half`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L189)).

**Sums preserve far-field bounds.** Proved result. Adding two fields of far-field order a preserves the value order a and the derivative orders a+1 and a+2. (`add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L195)).

**Negation preserves far-field bounds.** Proved result. Negation preserves all three value, derivative, and derivative-Lipschitz far-field bounds. (`neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L203)).

**Bilinear products add decay orders.** Proved result. A bounded bilinear combination adds far-field value decay orders and retains the successive extra inverse-radius powers for its derivatives. (`bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L207)).

**A decay order can be weakened.** Proved result. A far-field bound of higher natural decay order implies any lower decay order. (`degree_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L234)).

**Constants have order-zero far bounds.** Proved result. A constant field has bounded remote values and zero derivative and derivative-Lipschitz constants. (`farBound_const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L240)).

**Eventual equality preserves far bounds.** Proved result. Fields agreeing beyond some radius share their far-field value, derivative, and derivative-Lipschitz order. (`congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L249)).

**Three tail bounds from order-one decay.** Proved result. Order-one far-field bounds give pointwise inverse-radius, inverse-square, and inverse-cube estimates for the value and first two totalized derivatives. (`bounds_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayBall.lean#L259)).

### Breakdown.CertCell.ShapeTypeTwoDecayChart

This file applies the far-field calculus to compactified coordinates, spherical frames and regular chart functions. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Pairs preserve order-zero far bounds.** Proved result. Pairing two real fields with bounded remote values and derivative orders one and two preserves those three bounds. (`pair`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L17)).

**Products add far-field decay orders.** Proved result. Multiplying scalar fields adds their far-field value orders and the corresponding derivative decay orders. (`mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L24)).

**Decay orders add under scalar products.** Proved result. Multiplying a scalar and a vector field adds their far-field value orders and the corresponding derivative decay orders. (`smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L29)).

**Larger powers improve reciprocal decay.** Proved result. For radius at least one, nonnegative shift and coefficient, and k≥m, c/(r+L)ᵏ is at most c/rᵐ. (`div_add_pow_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L34)).

**The radial formula for chart tails.** Proved result. For positive chart length L, one minus the compactified radius equals L divided by physical radius plus L. (`one_sub_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L39)).

**Compactified radius has order-0 bounds.** Proved result. For positive chart length, compactified radius has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L46)).

**The chart tail decays as inverse radius.** Proved result. For positive chart length, one minus compactified radius has value, derivative, and derivative-Lipschitz bounds C/r, C/r², and C/r³ on unit balls centered at sufficiently large radius r. (`farBound_weight`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L79)).

**Positive scaling fixes normalized height.** Proved result. Positive scaling fixes normalized height. (`heightRatio_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L115)).

**Positive scaling fixes coordinate ratios.** Proved result. Positive scaling fixes coordinate ratios. (`coord_div_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L119)).

**Coordinate ratios are C² off zero.** Proved result. Coordinate ratios are C² off zero. (`coord_div_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L123)).

**Normalized height is C² off zero.** Proved result. Normalized height is C² off zero. (`heightRatio_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L127)).

**Normalized height is at most one.** Proved result. Normalized height has absolute value at most 1. (`abs_heightRatio_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L130)).

**Normalized height has order-zero bounds.** Proved result. Normalized height has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_heightRatio`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L134)).

**Chart composition preserves far bounds.** Proved result. A C¹ chart function with Lipschitz gradient on the closed unit ball, composed with positive-length compactified radius and normalized height, has bounded remote values and derivative decay orders one and two. (`farBound_chart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L137)).

**C² chart functions have order-0 bounds.** Proved result. A C² chart function composed with positive-length compactified radius and normalized height has bounded remote values and derivative decay orders one and two. (`farBound_chart_smooth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L147)).

**The radial frame has order-zero bounds.** Proved result. The radial frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_radialFrame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L151)).

**Positive scaling fixes the polar frame.** Proved result. Positive scaling fixes the polar frame. (`polarVecQ_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L159)).

**The polar frame has order-zero bounds.** Proved result. The polar frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_polarFrame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L172)).

**Scaling fixes the azimuthal frame.** Proved result. Positive scaling fixes the azimuthal frame. (`azimVecQ_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L187)).

**Azimuthal frame has order-zero bounds.** Proved result. The azimuthal frame has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_azimFrame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayChart.lean#L195)).

### Breakdown.CertCell.ShapeTypeTwoDecayKey

This file uses the polynomial form of the origin profile near the outer chart edge to complete the type-two key decay estimate. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Joined spline charts have order-0 bounds.** Proved result. For positive chart length, composing a spline with joins of at least first order in both coordinates with the radial-height chart gives bounded remote values and derivative decay orders one and two. (`farBound_spline`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L22)).

**Both partial derivatives of the spline.** Proved result. A spline with at least first-order joins in both variables differentiates in each variable by evaluating the corresponding derivative spline. (`spline_partials`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L29)).

**Origin profile is polynomial near one.** Proved result. The origin profile is polynomial near one. (`origin_eq_poly_near_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L59)).

**Large radius approaches the chart edge.** Proved result. Large physical radius gives a near-one chart. (`chartCoord_gt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L68)).

**Complex embedding keeps C² regularity.** Proved result. Complex embedding of a real C² chart function preserves C² regularity. (`contDiff_ofReal_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L76)).

**Type-two keys have inverse-radius decay.** Proved result. A valid type-two key has remote unit-ball bounds of inverse-radius order one for its value, order two for its derivative, and order three for derivative Lipschitz constants. (`farBound_typeTwoKey`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayKey.lean#L79)).

### Breakdown.CertCell.ShapeTypeTwoDecayPhase

This file controls the radial phase and its slope at infinity and removes the angular phase from a type-two key. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Weighted bounds for phase derivatives.** Proved result. An admissible radial phase has its first three derivatives at every positive argument, with u times the first, u² times the second, and u³ times the third uniformly bounded in absolute value. (`radialPhase_derivs`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L15)).

**Squared arguments obey the chain rule.** Proved result. Squared arguments obey the chain rule. (`comp_sq_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L46)).

**Nonnegative factors keep absolute bounds.** Proved result. Multiplication by a nonnegative constant c turns an absolute bound |a|≤B into |ca|≤cB. (`abs_const_mul_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L51)).

**Recovering physical radius from charts.** Proved result. Chart radius recovers the physical radius. (`chartRadius_chartCoord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L55)).

**The phase slope has order-zero bounds.** Proved result. For admissible shape data, the integer-weighted chart phase slope has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_phaseSlope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L61)).

**Type-two phases have no angular factor.** Proved result. Type-two phases have no angular factor. (`keyPhase_typeTwo`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L136)).

**Type-two key phases have order-0 bounds.** Proved result. For valid zero-first-label keys, the time-radial phase has bounded values, derivative norm at most C/r, and derivative Lipschitz constant at most C/r² on unit balls centered at sufficiently large radius r. (`farBound_keyPhase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayPhase.lean#L141)).

### Breakdown.CertCell.ShapeTypeTwoDecayRadial

This file transports one-dimensional radial estimates and degree-zero homogeneity into spatial far-field derivative bounds. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Differentiate the norm off zero.** Proved result. At each nonzero point, the Fréchet derivative of the norm is the inner-product covector divided by that point’s norm. (`norm_hasFDerivAt_of_ne`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L17)).

**The normalized covector has norm one.** Proved result. The normalized covector has norm one. (`norm_unitMap`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L33)).

**Distance between normalized directions.** Proved result. Normalized directions obey a distance bound. (`unit_diff_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L36)).

**Far bounds from radial derivatives.** Proved result. Radial value and first-two-derivative bounds of successive orders a, a+1, and a+2 beyond a radius at least one give the same three far-field orders after composition with spatial radius. (`farBound_radial`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L56)).

**Homogeneity rescales derivatives.** Proved result. Homogeneity rescales derivatives. (`homog_fderiv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L122)).

**Degree-zero homogeneity gives far bounds.** Proved result. A C² field homogeneous of degree zero away from the origin has bounded remote values and inverse-radius and inverse-square derivative bounds. (`farBound_homog`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L134)).

**Unit-ball composition keeps far bounds.** Proved result. Composing an order-zero far-field map into the closed unit ball with a C¹ function whose gradient is Lipschitz there preserves its three far-field bounds. (`comp_unitBall`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L188)).

**Unit-ball gradient control from C².** Proved result. A C² chart function is C¹ and has a Lipschitz gradient on the closed unit ball. (`unitBall_of_contDiff_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoDecayRadial.lean#L224)).

### Breakdown.CertCell.ShapeTypeTwoOff

This file decomposes the type-two field into three explicit spherical components and proves C¹ and gradient Lipschitz bounds away from the origin. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**C¹ fields with local gradient bounds.** Proposition definition. Gradient regularity on a set means C¹ regularity there together with a locally Lipschitz Fréchet derivative. (`GradSlopeOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L21)).

**Equality keeps local Lipschitz bounds.** Proved result. Equality on a set transfers local Lipschitz continuity from one function to the other on that set. (`locSlopeBound_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L24)).

**Composition keeps local Lipschitz bounds.** Proved result. Composing locally Lipschitz functions preserves local Lipschitz continuity when the inner map sends the first domain into the second. (`locSlopeBound_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L33)).

**Smooth composition keeps local slopes.** Proved result. Smooth composition preserves local slopes. (`locSlopeBound_comp_global`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L43)).

**Local Lipschitz bounds for bilinear maps.** Proved result. A continuous bilinear combination of locally Lipschitz functions on a set is locally Lipschitz there. (`locSlopeBound_bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L49)).

**C¹ gives local Lipschitz control.** Proved result. A C¹ function on an open set is locally Lipschitz on that set. (`locSlopeBound_of_contDiffOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L101)).

**C² gives local gradient control.** Proved result. A C² function on an open set is C¹ there and has a locally Lipschitz gradient there. (`gradSlope_of_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L107)).

**Local equality keeps gradient control.** Proved result. Equality on an open set transfers C¹ regularity and a locally Lipschitz gradient to the equal function. (`gradSlope_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L113)).

**Sums preserve gradient control.** Proved result. Adding two C¹ functions with locally Lipschitz gradients on an open set preserves that regularity. (`gradSlope_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L119)).

**Bilinear maps preserve gradient control.** Proved result. A continuous bilinear combination of C¹ functions with locally Lipschitz gradients on an open set preserves that regularity. (`gradSlope_bilin`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L126)).

**Composition preserves gradient control.** Proved result. Composition preserves C¹ regularity and locally Lipschitz gradients on open domains when the inner map takes values in the outer domain. (`gradSlope_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L136)).

**Products preserve gradient control.** Proved result. Pointwise multiplication preserves C¹ regularity and locally Lipschitz gradients on an open set. (`gradSlope_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L148)).

**Scalar products keep gradient control.** Proved result. Pointwise scalar multiplication preserves C¹ regularity and locally Lipschitz gradients on an open set. (`gradSlope_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L152)).

**Negation preserves gradient control.** Proved result. Negation preserves C¹ regularity and a locally Lipschitz gradient on an open set. (`gradSlope_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L157)).

**Constants have gradient control.** Proved result. A constant field is C¹ with a locally Lipschitz zero gradient on every open set. (`gradSlope_const`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L163)).

**Complex embedding keeps gradient control.** Proved result. Embedding a real-valued function into the complex numbers preserves C¹ regularity and locally Lipschitz gradient on an open set. (`gradSlope_ofReal`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L166)).

**A uniform gradient bound on compact sets.** Proved result. Compactness gives a single gradient bound. (`gradSlope_slopeBound_of_compact`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L171)).

**Restricting gradient bounds to subsets.** Proved result. Restricting to a subset preserves C¹ regularity and local Lipschitz continuity of the gradient on the restricted set. (`gradSlope_mono`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L175)).

**The open strip of chart coordinates.** Definition. The chart band consists of coordinate pairs whose first coordinate lies strictly between minus one and one. (`chartBand`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L184)).

**The chart-coordinate strip is open.** Proved result. The chart-coordinate strip is open. (`chartBand_open`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L186)).

**The radial and height chart pair.** Definition. The chart pair combines compactified physical radius with normalized height. (`chartPair`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L188)).

**Compactified radius is in the strip.** Proved result. Compactified radius lies in the chart strip. (`chartCoord_mem`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L190)).

**Normalized coordinates are C² off zero.** Proved result. Normalized coordinates are C² off zero. (`ratio_cdAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L199)).

**Normalized height is C² off zero.** Proved result. Normalized height is C² off zero. (`height_cdAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L202)).

**The polar frame is C² off zero.** Proved result. The polar frame is C² off zero. (`polar_cdAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L204)).

**The azimuthal frame is C² off zero.** Proved result. The azimuthal frame is C² off zero. (`azim_cdAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L211)).

**Componentwise C² fields off zero.** Proved result. Componentwise C² regularity away from zero gives C² regularity of the complex vector field on punctured space. (`vecC_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L217)).

**The chart pair is C² off zero.** Proved result. The chart pair is C² off zero. (`chartPair_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L221)).

**Polynomial weights have every derivative.** Proved result. Polynomial weights have every derivative. (`weightPoly_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L229)).

**The phase slope is C² below one.** Proved result. The phase slope is C² below one. (`phaseSlope_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L233)).

**Type-two key phases are C².** Proved result. Type-two key phases are C². (`keyPhase_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L245)).

**Joined splines are C¹.** Proved result. Under the joined-spline regularity assumption, joins of at least first order in both variables give a C¹ spline evaluation. (`spline_cd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L267)).

**Joined splines have gradient control.** Proved result. Under the spline regularity assumptions, a spline joined to at least first order in both variables is C¹ with locally Lipschitz gradient on any chosen subset of its coordinate plane. (`spline_gs`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L271)).

**Height spline slices are differentiable.** Proved result. Height spline slices are differentiable. (`slice_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L280)).

**Radial spline slices are differentiable.** Proved result. Radial spline slices are differentiable. (`slice_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L285)).

**Origin-profile slope regularity.** Proved result. If the origin profile is C² below one with locally Lipschitz second derivative, its first derivative is C¹ with locally Lipschitz derivative on (−1,1). (`originDeriv_gs`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L292)).

**The type-two radial amplitude.** Definition. The type-two radial amplitude is the negative weighted height derivative of the polar-factor times the stream function. (`compZero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L307)).

**The type-two polar amplitude.** Definition. The type-two polar amplitude negates the weighted stream's radial scaling, phase-slope contribution, and twice its value. (`compOne`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L311)).

**The type-two azimuthal amplitude.** Definition. The type-two azimuthal amplitude is the radial polynomial weight times the swirl spline. (`compTwo`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L318)).

**The radial stream derivative.** Proved result. For a zero-first-label key with the required stream joins, the radial component is the expanded weighted height derivative of the stream expression. (`reduced_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L320)).

**The polar stream derivative.** Proved result. Below the chart edge, a zero-first-label key with C² origin data has the expanded radial-scaling and phase expression as its polar component. (`reduced_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L337)).

**The weighted swirl component.** Proved result. For a zero-first-label key, the azimuthal component is the polynomial weight times the swirl spline. (`reduced_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L355)).

**The complex radial frame.** Definition. The complex radial frame embeds the real radial-vector coordinates into the complex numbers. (`radialC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L365)).

**The complex polar frame.** Definition. The complex polar frame embeds the real scaled polar-vector coordinates into the complex numbers. (`polarC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L367)).

**The complex azimuthal frame.** Definition. The complex azimuthal frame embeds the real scaled azimuthal-vector coordinates into the complex numbers. (`azimC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L369)).

**Type-two fields are a framed sum.** Proved result. Type-two fields are a framed sum. (`keyVector_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L371)).

**Gradient control of type-two amplitudes.** Proved result. With stream joins (2,2), swirl joins (1,1), and the origin-profile estimates, all three type-two amplitudes are C¹ with locally Lipschitz gradients on the chart band. (`amplitude_gs`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L381)).

**Type-two keys are regular off the origin.** Proved result. Under the spline and origin-profile assumptions, a valid type-two key is C¹ away from zero and its gradient is Lipschitz on every bounded annulus with positive inner radius. (`typeTwoKey_offOrigin_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOff.lean#L452)).

### Breakdown.CertCell.ShapeTypeTwoOrigin

This file separates the affine type-two behavior at the origin from a quadratic remainder and proves local regularity of the remainder after rescaling. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**The affine axis field's coordinates.** Definition. The linear axis field keeps the first two coordinates and multiplies the third by minus two. (`linS`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L20)).

**A normalized radial component.** Definition. The normalized radial component divides the selected coordinate by the vector norm. (`radC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L22)).

**A normalized polar component.** Definition. The normalized polar component uses products with normalized height in the first two coordinates and normalized height squared minus one in the third. (`polC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L24)).

**A normalized azimuthal component.** Definition. The normalized azimuthal component is the planar quarter-turn divided by total radius, with zero third coordinate. (`azC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L27)).

**The rescaled type-two remainder.** Definition. The rescaled type-two remainder combines the linear-axis correction with the scaled quadratic remainder in the normalized spherical frame. (`scaledRem`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L29)).

**The linear part at the origin.** Definition. The leading origin field is the linear axis field multiplied by the negative axis coefficient divided by chart length. (`linPart`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L37)).

**A quadratic after removing linear terms.** Proved result. Removing the linear part leaves a quadratic. (`scaled_identity`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L39)).

**A linear factor from the origin value.** Proved result. A unit origin value exposes a linear factor. (`origin_quadratic`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L75)).

**The radial phase at zero angular label.** Proved result. For a zero-first-label key, the phase depends only on temporal frequency and the radial phase of squared radius. (`keyPhase_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L86)).

**The type-two key phase is C².** Proved result. The type-two key phase is C². (`keyPhase_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L92)).

**Polynomial evaluation is C².** Proved result. Polynomial evaluation is C². (`poly_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L103)).

**The profile quotient is polynomial.** Proved result. The profile quotient is polynomial. (`profQuot_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L106)).

**The slope quotient is C² below one.** Proved result. The slope quotient is C² below one. (`slopeQuot_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L113)).

**Remainder components have local control.** Proved result. With stream and quotient-stream joins (2,2) and swirl-quotient joins (2,1), each remainder component has a differentiable neighborhood with Lipschitz derivative below the chart edge. (`rem_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L128)).

**The rescaled remainder has local control.** Proved result. With stream and quotient-stream joins (2,2) and swirl-quotient joins (2,1), each rescaled remainder component is differentiable with Lipschitz derivative near every point with nonnegative scaling coordinate and nonzero direction vector. (`scaledRem_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L180)).

**Type-two keys are C¹ near the origin.** Proved result. Type-two keys are C¹ near the origin. (`typeTwoKey_near_origin_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOrigin.lean#L236)).

### Breakdown.CertCell.ShapeTypeTwoOriginScale

This file develops local derivative bounds stable under algebra and composition, then applies quadratic rescaling to control a gradient near zero. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Local derivative with Lipschitz control.** Proposition definition. Local gradient control means that the field has a Lipschitz derivative on some positive-radius ball around the point. (`TameAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L22)).

**Local gradient control bounds values.** Proved result. A derivative that is Lipschitz on a positive ball is bounded there, makes the function Lipschitz there, and bounds its values by the center value plus the derivative bound times the radius. (`tame_bounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L26)).

**C² functions have local gradient control.** Proved result. C² regularity at a point gives a neighborhood on which the function is differentiable and its derivative is Lipschitz. (`tame_of_contDiffAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L54)).

**A Lipschitz gradient gives local control.** Proved result. A differentiable function whose gradient is Lipschitz on every centered closed ball has a differentiable neighborhood with Lipschitz derivative around each point. (`tame_of_slope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L64)).

**Local equality keeps gradient control.** Proved result. Agreement on a neighborhood transfers differentiability with a Lipschitz derivative on a smaller neighborhood. (`tame_congr`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L78)).

**Sums preserve local gradient control.** Proved result. Adding functions that have differentiable neighborhoods with Lipschitz derivatives preserves that local regularity. (`tame_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L88)).

**Linear maps keep local gradient control.** Proved result. Applying a continuous linear map preserves differentiability with a Lipschitz derivative on a neighborhood. (`tame_clm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L104)).

**Composition keeps local gradient control.** Proved result. Composing two functions that are differentiable with Lipschitz derivatives near the relevant points preserves that local regularity. (`tame_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L114)).

**Products preserve local gradient control.** Proved result. Multiplying complex functions with differentiable neighborhoods and Lipschitz derivatives preserves that local regularity. (`tame_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L151)).

**Negation keeps local gradient control.** Proved result. Negating a function preserves differentiability with a Lipschitz derivative on a neighborhood. (`tame_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L186)).

**Differences keep local gradient control.** Proved result. Subtracting functions with differentiable neighborhoods and Lipschitz derivatives preserves that local regularity. (`tame_sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L189)).

**Local control gives a Lipschitz region.** Proved result. A local derivative witness gives an actual neighborhood where the function is differentiable and its Fréchet derivative has one Lipschitz constant. (`tame_region`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L193)).

**Coordinate control gives vector control.** Proved result. If all three complex coordinate functions have differentiable neighborhoods with Lipschitz derivatives, the assembled vector field has that local regularity. (`tame_pi`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L201)).

**Reciprocal bound for coordinate scaling.** Proved result. The coordinate rescaling has norm at most 1/s. (`scale_norm_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L214)).

**Quadratic scaling transfers derivatives.** Proved result. If the rescaled field is differentiable at (s,w/s), with s positive and w nonzero, the quadratic scaling identity gives the original field derivative as s² times that derivative applied in directions (0,h/s). (`scaled_hasFDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L222)).

**Lipschitz gradients by quadratic scaling.** Proved result. Quadratic scaling gives a Lipschitz gradient. (`scaled_fderiv_slope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginScale.lean#L240)).

### Breakdown.CertCell.ShapeTypeTwoOriginSplit

This file divides initial vanishing spline pieces by the radial coordinate and separates type-two components into linear and quadratic radial terms. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Positive lower bound for finite breaks.** Proved result. Finite positive breaks have a lower bound. (`pos_lower_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L21)).

**Near zero the first cell is selected.** Proved result. Near zero the first cell is selected. (`first_cell_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L32)).

**Multiplying after first substitution.** Proved result. First substitution respects multiplication. (`atFirst_mul_X`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L46)).

**Subtracting the initial value exposes t.** Proved result. Subtracting the initial value exposes t. (`sub_atFirst_dvd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L51)).

**Height substitution keeps the t factor.** Proved result. Height substitution preserves the t factor. (`atSecond_X0_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L71)).

**Height derivatives preserve the t factor.** Proved result. Height derivatives preserve the t factor. (`xDeriv_X0_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L75)).

**A spline quotient from initial vanishing.** Proved result. Initial vanishing gives a spline quotient. (`first_row_quotient`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L86)).

**Joined splines are differentiable.** Proved result. Joined splines are differentiable. (`spline_differentiable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L117)).

**Local gradient bounds for joined splines.** Proved result. Under the spline regularity assumptions, joins of at least first order in both coordinates give a differentiable neighborhood with Lipschitz gradient around every spline point. (`spline_tame`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L121)).

**Height derivatives of joined splines.** Proved result. A joined spline's height derivative evaluates the height derivative spline when both joining orders are at least one. (`spline_hasDerivAt_x`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L126)).

**Radial derivatives of joined splines.** Proved result. A joined spline's radial derivative evaluates the radial derivative spline when both joining orders are at least one. (`spline_hasDerivAt_t`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L137)).

**The radial tail polynomial.** Definition. The radial tail weight is (1−t) raised to its natural exponent and embedded in the complex numbers. (`wt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L148)).

**The derivative of the radial tail.** Definition. The tail derivative is minus the exponent times (1−t) raised to one lower natural exponent. (`wtDeriv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L150)).

**A finite geometric tail sum.** Definition. The geometric tail is the sum of the first e powers of 1−t. (`geomTail`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L152)).

**The origin-profile quotient.** Definition. The profile quotient subtracts the geometric tail and its t-weighted product with the origin quotient from that quotient. (`profQuot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L154)).

**The radial phase-slope quotient.** Definition. The phase-slope quotient is twice the squared chart-length-over-tail factor times t and the radial phase derivative at squared physical radius. (`slopeQuot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L157)).

**The full stream amplitude.** Definition. The full stream adds the axis coefficient times the origin polynomial and height to the stream spline. (`streamFull`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L160)).

**The radial derivative of the full stream.** Definition. The radial stream derivative combines the derivative of the origin polynomial with the radial derivative spline. (`streamFullT`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L163)).

**The leading reduced components.** Definition. The leading reduced components are −α(1−3x²), −3αx, and zero. (`leadComp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L166)).

**The quadratic remainder components.** Definition. The quadratic remainder separates the profile quotient, quotient stream spline, and swirl spline after removing the leading radial-order components. (`remComp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L168)).

**Splitting components by radial order.** Proved result. Type-two components split by radial order. (`reduced_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoOriginSplit.lean#L178)).

### Breakdown.CertCell.ShapeTypeTwoSmooth

This file combines the near-origin and annular estimates to finish the type-two key regularity contract. Appendix B, the construction and regularity of shape fields used in the cell coercivity route; supporting library for the shape construction around B.6–B.8.

**Origin and punctured C¹ regularity glue.** Proved result. A function C¹ on punctured space and on one positive-radius ball around zero is globally C¹. (`contDiff_of_punctured_and_ball`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoSmooth.lean#L15)).

**Slope bounds over a finite closed cover.** Proved result. If two closed sets cover a convex set and the function is K-Lipschitz on both, it is K-Lipschitz on the convex set. (`slopeBoundOn_of_closed_cover`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoSmooth.lean#L25)).

**Ball bounds from origin and annuli.** Proved result. Lipschitz bounds on every bounded positive-inner-radius annulus and one positive origin ball give a Lipschitz bound on every centered closed ball. (`slopeBoundOn_closedBall_of_annuli_and_ball`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoSmooth.lean#L45)).

**Local pieces give key-field regularity.** Proved result. C¹ regularity and Lipschitz gradient bounds on the punctured annuli and near the origin give a globally C¹ key field whose gradient is Lipschitz on each closed ball. (`keyFieldSmooth_of_pieces`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoSmooth.lean#L66)).

**Type-two regularity from its parts.** Proved result. C¹ regularity and Lipschitz gradient bounds near the origin and on every annulus combine into type-two key regularity on closed balls. (`typeTwoKeySmooth_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ShapeTypeTwoSmooth.lean#L78)).

### Breakdown.CertCell.SideTraceMatch

This file approximates asymmetric tent functions by smooth compactly supported tests to prove equality of weak side traces. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Smooth approximation to a positive part.** Definition. The kink profile multiplies its argument by the smooth transition from zero to one. (`kinkProfile`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L18)).

**The kink profile is infinitely smooth.** Proved result. The kink profile is infinitely smooth. (`kinkProfile_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L20)).

**The kink profile is zero below zero.** Proved result. The kink profile is zero below zero. (`kinkProfile_of_nonpos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L23)).

**The kink profile equals x above one.** Proved result. The kink profile equals x above one. (`kinkProfile_of_one_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L26)).

**The kink slope is zero below zero.** Proved result. The kink slope is zero below zero. (`deriv_kinkProfile_of_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L29)).

**The kink slope is one above one.** Proved result. The kink slope is one above one. (`deriv_kinkProfile_of_one_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L35)).

**The kink slope is globally bounded.** Proved result. One real constant bounds the absolute derivative of the kink profile at every real argument. (`deriv_kinkProfile_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L41)).

**The rescaled smooth kink.** Definition. The smooth kink at width ε is ε times the base kink evaluated at the argument divided by ε. (`kinkAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L55)).

**The rescaled kink is infinitely smooth.** Proved result. The rescaled kink is infinitely smooth. (`kinkAt_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L57)).

**Differentiating the rescaled kink.** Proved result. For positive smoothing width, the rescaled kink derivative is the profile derivative evaluated at the argument divided by that width. (`kinkAt_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L60)).

**The rescaled kink is zero below zero.** Proved result. The rescaled kink is zero below zero. (`kinkAt_of_nonpos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L72)).

**Rescaled kink equals x beyond its width.** Proved result. The rescaled kink equals x beyond its width. (`kinkAt_of_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L75)).

**The rescaled kink is bounded by |x|.** Proved result. For positive smoothing width, the absolute value of the rescaled kink is at most the absolute value of its argument. (`abs_kinkAt_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L80)).

**The step function at zero.** Definition. The step function is one for positive arguments and zero otherwise. (`unitStep`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L88)).

**The step function is monotone.** Proved result. The step function is monotone. (`unitStep_monotone`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L90)).

**Absolute bound for the step function.** Proved result. The step function has absolute value at most 1. (`abs_unitStep_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L99)).

**The positive part is bounded by |x|.** Proved result. The absolute value of the positive part of a real number is at most its absolute value. (`abs_max_zero_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L103)).

**The three-coefficient tent combination.** Definition. The tent combination uses the reciprocal left width, the negative sum of reciprocal widths, and the reciprocal right width. (`comb`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L109)).

**The tent combination has a uniform bound.** Proved result. The tent combination has a uniform bound. (`abs_comb_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L112)).

**A smooth approximation to a tent.** Definition. The smooth tent combines three shifted smooth kinks with the left and right reciprocal-width coefficients. (`tentApprox`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L132)).

**The piecewise linear tent function.** Definition. The piecewise linear tent uses the same three coefficients on positive parts at its left endpoint, peak, and right endpoint. (`tentFn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L135)).

**The piecewise constant tent slope.** Definition. The tent slope uses the same three coefficients on step functions at the left endpoint, peak, and right endpoint. (`tentSlope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L137)).

**The weak pairing with a tent function.** Definition. The weak tent pairing is the function times the tent slope plus its candidate derivative times the tent value. (`pairing`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L139)).

**Tent approximation is infinitely smooth.** Proved result. The tent approximation is infinitely smooth. (`tentApprox_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L142)).

**The three-term smooth tent slope.** Proved result. The tent-approximation derivative is the same three-term linear combination of rescaled kink slopes used to build the tent. (`tentApprox_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L149)).

**Compact support of tent approximations.** Proved result. The tent approximation vanishes outside support. (`tentApprox_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L163)).

**Tent support stays in a short interval.** Proved result. The tent support stays in a short interval. (`tentApprox_tsupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L178)).

**Uniform tent-approximation slope bounds.** Proved result. For positive tent widths and smoothing width, the absolute smooth-tent derivative is at most twice the sum of reciprocal tent widths times a global kink-slope bound. (`abs_deriv_tentApprox_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L184)).

**Interval width bounds point differences.** Proved result. The distance between two points strictly inside an interval is at most its width. (`abs_sub_le_width`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L190)).

**Uniform tent-approximation value bounds.** Proved result. Tent approximations have a uniform value bound. (`abs_tentApprox_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L195)).

**Tent function has a uniform value bound.** Proved result. The tent function has a uniform value bound. (`abs_tentFn_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L202)).

**The tent slope has a uniform bound.** Proved result. The tent slope has a uniform bound. (`abs_tentSlope_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L209)).

**The tent slope is measurable.** Proved result. The tent slope is measurable. (`tentSlope_measurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L213)).

**The tent function is continuous.** Proved result. The tent function is continuous. (`tentFn_continuous`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L222)).

**The smoothing scale is positive.** Proved result. The smoothing scale is positive. (`seq_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L226)).

**Smoothing scale is below its upper bound.** Proved result. The smoothing scale is below its upper bound. (`seq_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L228)).

**Smoothing scale eventually becomes small.** Proved result. The smoothing scale eventually becomes small. (`seq_eventually_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L232)).

**Smoothed kinks approach positive parts.** Proved result. Smoothed kinks eventually match positive parts. (`kinkAt_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L242)).

**Kink slopes eventually match the step.** Proved result. Kink slopes eventually match the step. (`kinkSlope_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L250)).

**Tent approximations stabilize pointwise.** Proved result. Tent approximations eventually match the tent. (`tentApprox_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L259)).

**Tent slopes stabilize pointwise.** Proved result. Tent slopes eventually match the step slope. (`deriv_tentApprox_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L265)).

**The pairing vanishes to the left.** Proved result. The pairing vanishes to the left. (`pairing_outer_left`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L272)).

**The pairing vanishes to the right.** Proved result. The pairing vanishes to the right. (`pairing_outer_right`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L287)).

**The lower weak tent pairing.** Proved result. On the lower side of the tent, the weak pairing is the function divided by the lower width plus its derivative times the increasing linear weight. (`pairing_lower`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L306)).

**The upper weak tent pairing.** Proved result. On the upper side of the tent, the weak pairing is the derivative times the decreasing linear weight minus the function divided by the upper width. (`pairing_upper`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L323)).

**The two weak tent pairings agree.** Proved result. The two weak tent pairings agree. (`tent_identity`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L345)).

**Lower side trace is an interval integral.** Proved result. The lower side trace is an interval integral. (`sideTrace_of_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L464)).

**Upper side trace is an interval integral.** Proved result. The upper side trace is an interval integral. (`sideTrace_of_gt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L470)).

**The two side traces match.** Proved result. The two side traces match. (`sideTraceMatch`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SideTraceMatch.lean#L492)).

### Breakdown.CertCell.SixthPowerStatements

This file names the line, three-slice, three-halves and sixth-power inequalities used to derive the Sobolev estimate for weak perturbations. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Smooth sixth-power gradient inequality.** Proposition definition. The smooth sixth-power condition bounds the squared L6 norm of a compactly supported C¹ vector field by C times its gradient energy. (`SmoothSixthPowerBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerStatements.lean#L14)).

**Scalar three-halves gradient inequality.** Proposition definition. The three-halves condition bounds the L to the power 3/2 norm of a compactly supported C¹ scalar field by C times the integral of its derivative norm. (`ThreeHalvesGradientBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerStatements.lean#L18)).

**The three-slice product inequality.** Proposition definition. The three-slice condition bounds the integral of the square root of three paired-coordinate functions by the square root of their three integrals multiplied together. (`TripleSliceBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerStatements.lean#L22)).

**A line integral bounds the point value.** Proposition definition. The line-gradient condition bounds the value of a compactly supported C¹ scalar field by half the integral of its absolute derivative along any coordinate line. (`LineGradientBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerStatements.lean#L27)).

### Breakdown.CertCell.SixthPowerWeak

This file mollifies a weak field, controls its sixth power by gradient energy and passes to shrinking kernels to prove the weak Sobolev bound. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The squared matrix norm is continuous.** Proved result. The squared matrix norm is continuous. (`continuous_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L10)).

**The squared matrix norm is nonnegative.** Proved result. The squared matrix norm is nonnegative. (`matSq_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L14)).

**Averaging bounds the squared norm.** Proved result. For a nonnegative integrable weight of mass one, the squared norm of its weighted vector average is at most the weighted average of squared norms when both integrals exist. (`sq_norm_integral_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L17)).

**The sixth power lies above its tangent.** Proved result. The sixth power lies above its tangent. (`sixth_le_tangent`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L38)).

**Averaging bounds the sixth power.** Proved result. For a nonnegative integrable weight of mass one, the sixth power of its weighted vector average is at most the weighted average of sixth powers when both integrals exist. (`sixth_norm_integral_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L48)).

**Mollify the weak-gradient column.** Proved result. Each coordinate derivative of convolution with a normalized smooth bump equals convolution of that bump with the corresponding weak-gradient column. (`fderiv_convolution_column`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L78)).

**Mollified fields obey the L6 bound.** Proved result. Under the smooth Sobolev estimate, normalized bump convolution of a weak-gradient field with finite sixth-power and gradient energies has sixth-power integral at most the cube of C times the original gradient energy. (`mollified_sixthPower_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L116)).

**A sequence of shrinking smooth bumps.** Definition. The nth smoothing bump has inner radius 1/(n+2) and outer radius 2/(n+2). (`shrinkingBump`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L192)).

**Weak sixth-power gradient bound follows.** Proved result. A nonnegative-constant compactly supported C¹ Sobolev bound transfers to weak-gradient fields with finite sixth-power and gradient-energy integrals using the same constant. (`sixthPowerGradientBound_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeak.lean#L198)).

### Breakdown.CertCell.SixthPowerWeakCutoff

This file introduces large-radius cutoffs and controls their gradient error by an L6 tail, allowing the compact-support estimate to extend to global fields. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Weighted squares control a sum.** Proved result. For positive δ, the squared norm of a+b is at most (1+δ) times the squared norm of a plus (1+1/δ) times the squared norm of b. (`norm_add_sq_le_weighted`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L9)).

**A linear bound by a shifted cubic.** Proved result. For nonnegative u and positive a, u is at most a plus u cubed divided by a squared. (`le_add_cube_div_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L20)).

**A cube-root bound gives a cube bound.** Proved result. A cube-root bound gives a cube bound. (`le_cube_of_rpow_third_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L31)).

**Coordinate unit vectors have norm one.** Proved result. Coordinate unit vectors have norm one. (`norm_unitVector_eq_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L40)).

**The squared matrix norm is continuous.** Proved result. The squared matrix norm is continuous. (`continuous_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L43)).

**The unit-radius cutoff bump.** Definition. The unit cutoff bump has inner radius one and outer radius two. (`unitBump`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L48)).

**A smooth cutoff at radius R.** Definition. The radius-R cutoff evaluates the unit bump after scaling space by the reciprocal of R. (`cutoff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L50)).

**The radial cutoff is C¹.** Proved result. The radial cutoff is C¹. (`cutoff_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L52)).

**The cutoff is nonnegative.** Proved result. The cutoff is nonnegative. (`cutoff_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L55)).

**The cutoff is at most one.** Proved result. The cutoff is at most one. (`cutoff_le_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L57)).

**The cutoff equals one on the inner ball.** Proved result. The cutoff equals one on the inner ball. (`cutoff_eq_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L59)).

**Cutoff is zero outside the outer ball.** Proved result. The cutoff is zero outside the outer ball. (`cutoff_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L66)).

**Cutoff derivatives use inverse scaling.** Proved result. The rescaled cutoff derivative is the unit-bump derivative at the reciprocally scaled point, precomposed with multiplication by the totalized reciprocal radius. (`fderiv_cutoff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L75)).

**The unit cutoff derivative is bounded.** Proved result. The derivative of the fixed unit cutoff has one finite norm bound valid throughout space. (`exists_fderiv_unitBump_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L82)).

**The cutoff derivative is bounded by M/R.** Proved result. At positive radius R, a global derivative bound M for the unit bump gives derivative bound M/R for its radial cutoff. (`norm_fderiv_cutoff_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L86)).

**Cutoff derivative vanishes below radius.** Proved result. For positive cutoff radius R, the cutoff derivative vanishes wherever the distance from the origin is strictly below R. (`fderiv_cutoff_eq_zero_of_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L100)).

**Cutoff derivative vanishes beyond 2R.** Proved result. For positive cutoff radius R, the cutoff derivative vanishes wherever the distance from the origin is strictly above twice R. (`fderiv_cutoff_eq_zero_of_gt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L107)).

**Cutting off gives compact support.** Proved result. Cutting off gives compact support. (`cutoff_smul_hasCompactSupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L114)).

**Gradient energy of a cutoff.** Proved result. Cutting off gives a gradient energy bound. (`matSq_fderiv_cutoff_smul_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L120)).

**Cutoff error has a L6 tail bound.** Proved result. The cutoff error has a sixth-power tail bound. (`integral_fderiv_cutoff_sq_mul_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L157)).

**L6 bounds on balls from cutoffs.** Proved result. Ball sixth powers obey the cutoff estimate. (`setIntegral_ball_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L225)).

**Smooth L6 bound extends globally.** Proved result. The smooth sixth-power bound extends globally. (`sixthPower_le_of_contDiff_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SixthPowerWeakCutoff.lean#L284)).

### Breakdown.CertCell.SmoothSixthPower

This file applies the scalar three-halves estimate to the fourth power of a vector norm and obtains the sixth-power bound with constant 4/3. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The Frobenius norm bounds operator norm.** Proved result. The operator norm of a spatial linear map is at most the square root of the sum of squared column norms. (`opNorm_le_sqrt_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SmoothSixthPower.lean#L9)).

**The quartic norm derivative is bounded.** Proved result. The derivative norm of the fourth power of a vector norm is at most four times its norm cubed. (`norm_fderiv_quartic_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SmoothSixthPower.lean#L23)).

**The squared matrix norm is nonnegative.** Proved result. The squared matrix norm is nonnegative. (`matSq_nonneg'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SmoothSixthPower.lean#L33)).

**Smooth Sobolev constant is four-thirds.** Proved result. The smooth Sobolev constant is four-thirds. (`smoothSixthPowerBound_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/SmoothSixthPower.lean#L36)).

### Breakdown.CertCell.StretchFlip

This file tracks coordinate signs through reflection of the gradient, curl and vorticity gradient, which is needed for evenness of the stretch density. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Reflection acts by coordinate signs.** Proved result. Reflection acts by coordinate signs. (`flipPoint_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L13)).

**The first reflection sign is positive.** Proved result. The first reflection sign is positive. (`frameSign_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L16)).

**The second reflection sign is negative.** Proved result. The second reflection sign is negative. (`frameSign_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L18)).

**The third reflection sign is negative.** Proved result. The third reflection sign is negative. (`frameSign_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L20)).

**Each reflection sign squares to one.** Proved result. Each reflection sign squares to one. (`frameSign_mul_self`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L22)).

**Unit vectors transform by flip signs.** Proved result. Unit vectors transform by reflection signs. (`flipPoint_unitVector`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L26)).

**Alternating symbols respect flip signs.** Proved result. Alternating symbols respect reflection signs. (`sign_symbol_pair`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L31)).

**Reflection as a continuous linear map.** Definition. The linear reflection fixes the first coordinate projection and negates the second and third coordinate projections. (`flipMap`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L35)).

**Linear flip matches point flip.** Proved result. The linear reflection matches point reflection. (`flipMap_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L40)).

**Reflect the point and derivative input.** Proved result. For a differentiable reflection-compatible field, reflecting the evaluation point and direction reflects the resulting derivative value. (`fderiv_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L43)).

**Two signs in matrix reflection.** Proved result. Reflected matrix entries acquire two signs. (`map_unit_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L56)).

**Three signs in Hessian reflection.** Proved result. Reflected Hessian entries acquire three signs. (`bilin_unit_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L61)).

**Curl is a signed coordinate sum.** Proved result. Curl is a signed coordinate sum. (`curlVec_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L70)).

**Curl transforms by reflection signs.** Proved result. Curl transforms by reflection signs. (`curlVec_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L74)).

**Vorticity gradients acquire two signs.** Proved result. Vorticity gradients acquire two signs. (`vortGrad_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchFlip.lean#L84)).

### Breakdown.CertCell.StretchMeanIntegral

This file proves integrability and reflection parity of the stretch form and converts its full space-time integral to the weighted half-plane average. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Reflection is an involution.** Proved result. Reflection is an involution. (`flip_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L24)).

**Flip reverses the height coordinate.** Proved result. Reflection reverses the height coordinate. (`flip_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L28)).

**Cylindrical coordinates preserve height.** Proved result. Cylindrical coordinates preserve height. (`cylF_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L31)).

**Meridian rotation gives cylinder points.** Proved result. Cylindrical points are rotated meridian points. (`cylF_eq_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L34)).

**The half-plane is measurable.** Proved result. The half-plane is measurable. (`measurableSet_halfPlane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L37)).

**The horizontal plane has zero volume.** Proved result. The horizontal plane has zero volume. (`coord_two_null`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L40)).

**Shifting a periodic angular integral.** Proved result. Periodic angular integrals can be shifted. (`lintegral_angle_shift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L50)).

**Flip folds the integral to a half-plane.** Proved result. Reflection folds the integral to a half-plane. (`lintegral_fold`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L64)).

**The space-time orbit map is measurable.** Proved result. The space-time orbit map is measurable. (`measurable_orbit`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L132)).

**Folding space-time into the half-plane.** Proved result. Space-time integration folds to the half-plane. (`lintegral_spacetime`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L141)).

**Orbit coordinates are positive a.e..** Proved result. Orbit coordinates are positive almost everywhere. (`ae_orbit_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L168)).

**Orbit coordinates preserve null sets.** Proved result. Orbit coordinates preserve null sets. (`qmp_orbit`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L177)).

**Folded space-time integrals agree.** Proved result. Folded space-time integrals agree. (`integral_spacetime`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L212)).

**The stretch form has an absolute bound.** Proved result. The stretch form has an absolute bound. (`abs_stretch_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L314)).

**Weighted sixth-power term is integrable.** Proved result. The weighted sixth-power term is integrable. (`sixth_weight_finite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L361)).

**The squared matrix norm is continuous.** Proved result. The squared matrix norm is continuous. (`continuous_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L410)).

**Stretch form has a nonnegative majorant.** Proved result. The stretch form has a nonnegative majorant. (`enorm_stretch_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L414)).

**The stretch form is integrable.** Proved result. The stretch form is integrable. (`stretch_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L430)).

**Stretch form is reflection-even a.e..** Proved result. The stretch form is reflection-even almost everywhere. (`stretch_flip_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L478)).

**The stretch mean has the folded integral.** Proved result. The stretch mean has the folded integral. (`stretchMeanIntegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchMeanIntegral.lean#L520)).

### Breakdown.CertCell.StretchTripleBound

This file bounds the stretch bilinear form using complex Cauchy-Schwarz estimates and the relation between curl and gradient energy. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Complex squared norms are nonnegative.** Proved result. Complex squared norms are nonnegative. (`cnormSq_nonneg_aux`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L11)).

**Cauchy-Schwarz bounds a complex pairing.** Proved result. The absolute value of a finite complex bilinear sum is at most the product of the two square-root sum-of-squares norms. (`norm_sum_mul_le_sqrt_cnormSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L14)).

**A square bound gives a norm bound.** Proved result. A square bound gives a norm bound. (`sqrt_le_mul_sqrt_of_le_sq_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L20)).

**Difference square is at most two squares.** Proved result. The squared norm of a complex difference is at most twice the sum of the two squared norms. (`norm_sub_sq_le_two_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L25)).

**Curl energy bounded by gradient energy.** Proved result. Curl energy is at most twice gradient energy. (`cnormSq_curlOfGrad_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L30)).

**The rotational stretch term is bounded.** Proved result. A curl-gradient operator bound γ gives a rotational stretch bound √2 γ/2 times the velocity and gradient square-energy norms. (`rotation_term_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L43)).

**Stretch bilinear form obeys its bound.** Proved result. The stretch bilinear form obeys its bound. (`stretchBilin_norm_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StretchTripleBound.lean#L83)).

### Breakdown.CertCell.StripDataFlipAxis

This file treats the radial axis in the strip reflection argument using weighted integrability and the independence of a weak trace from its outer height. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Side trace at zero is the upper trace.** Proved result. The side trace at zero is the upper trace. (`sideTrace_zero_eq_upperTrace`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L13)).

**Strip weight is continuous on its domain.** Proved result. The strip weight is continuous on its domain. (`weight_continuousOn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L26)).

**Weighted strip data are integrable.** Proved result. Weighted strip data are integrable. (`weighted_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L30)).

**Axis-weighted strip data are integrable.** Proved result. Axis-weighted strip data are integrable. (`axis_weighted_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L36)).

**Outer height does not change side traces.** Proved result. The side trace is independent of outer height. (`side_eq_at_heights`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L51)).

**Axis strip data obey reflection.** Proved result. Axis strip data obey reflection. (`stripDataFlipAxis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipAxis.lean#L64)).

### Breakdown.CertCell.StripDataFlipLinks

This file supplies rectangle integrability for the labeled fields and connects the height-trace identity with the strip reflection contract. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Mode fields are integrable on rectangles.** Proved result. Mode fields are integrable on rectangles. (`plane_rect_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipLinks.lean#L14)).

**The upper trace is independent of height.** Proved result. The upper trace is independent of height. (`trace_eq_at_heights`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipLinks.lean#L42)).

**Reflection of strip data.** Proved result. The plane-reflection, strip-trace, and height-derivative assumptions give reflection compatibility of the strip data. (`stripDataFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripDataFlipLinks.lean#L52)).

### Breakdown.CertCell.StripMomentTrace

This file proves the strip-moment trace contract from the underlying one-dimensional weak trace formulas. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Strip moments recover their trace.** Proved result. Strip moments recover their trace. (`stripMomentTrace`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripMomentTrace.lean#L13)).

### Breakdown.CertCell.StripTraceParts

This file obtains radial and height integration-by-parts formulas for strip moments from weak one-dimensional primitives, including the radial axis limit. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Supported test products are integrable.** Proved result. Supported test products are integrable. (`supported_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L13)).

**Recover the integral primitive a.e..** Proved result. On an open interval, an integrable function with the prescribed integrable weak derivative equals one constant plus the integral of that derivative from the lower endpoint, almost everywhere. (`weak_rep`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L26)).

**Primitive pairings integrate by parts.** Proved result. Primitive pairings integrate by parts. (`primitive_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L68)).

**The ramp derivative is the inverse width.** Proved result. The derivative of the linear ramp (x-o)/d is the constant 1/d, with totalized division. (`ramp_deriv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L146)).

**Traces from weak line pairings.** Proved result. Weak line pairings recover endpoint traces. (`line_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L151)).

**The reciprocal is not integrable at zero.** Proved result. The reciprocal is not integrable at zero. (`not_integrable_inv`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L207)).

**Radial weights remove the axis term.** Proved result. Radial weights remove the axis boundary term. (`axis_line_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L217)).

**Enclosing intervals symmetrically.** Proved result. Every interval lies in a symmetric interval. (`sym_box`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L364)).

**Iterated integrals of products.** Proved result. Product integrals equal iterated integrals. (`prod_iter`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L367)).

**Supported slice integrals are integrable.** Proved result. Supported slice integrals are integrable. (`slice_int`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L372)).

**Slicing product test pairings.** Proved result. Product test pairings separate into slices. (`slice_pair`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L379)).

**Height averages of radial weak pairs.** Proved result. A smooth compactly supported height cutoff gives a one-dimensional weak radial derivative identity by integrating both entries of the radial weak pair against the same cutoff. (`radial_slices`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L403)).

**Radial line boundary terms cancel.** Proved result. Radial line boundary terms cancel. (`radial_line`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L456)).

**Bounded sets lie in a symmetric interval.** Proved result. Bounded sets lie in a symmetric interval. (`bounded_box`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L536)).

**Slice identity passes to the rectangle.** Proved result. The slice identity passes to the rectangle. (`slice_core`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L543)).

**Radial strip pairings integrate by parts.** Proved result. Radial strip pairings integrate by parts. (`radial_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L614)).

**Weighted rectangle slices are integrable.** Proved result. Weighted rectangle slices are integrable. (`wslice`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L738)).

**Product integrals may reverse order.** Proved result. Product integrals may reverse order. (`prod_iter_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L764)).

**The reversed test pairing separates.** Proved result. The reversed test pairing separates. (`slice_pair_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L769)).

**Radial averages of height weak pairs.** Proved result. A smooth radial cutoff supported away from the axis gives a one-dimensional weak height derivative identity after both entries of the height weak pair are averaged against it. (`height_slices`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L797)).

**Height line boundary terms cancel.** Proved result. Height line boundary terms cancel. (`height_line`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L850)).

**The height identity passes to rectangles.** Proved result. The height identity passes to rectangles. (`height_core`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L880)).

**Height strip pairings integrate by parts.** Proved result. Height strip pairings integrate by parts. (`height_parts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/StripTraceParts.lean#L976)).

### Breakdown.CertCell.TailAngular

This file derives angular lower bounds from the rotation generators acting on velocity, gradient, curl and Hessian modes. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Angular mode inequalities a.e..** Proposition definition. This proposition requires the angular energy relations to hold almost everywhere in time and space for every mode of a positive-period perturbation. (`AngularModePointwise`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L19)).

**Complex square sum is the Euclidean norm.** Proved result. The complex square sum is the Euclidean norm. (`sqrt_cnormSq_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L30)).

**A norm lower bound from angular data.** Proved result. Angular identities give a lower norm bound. (`lower_of_identity`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L35)).

**Radius bounds angular contraction.** Proved result. The norm of angular contraction is at most cylindrical radius times the square root of the sum of squared matrix entries. (`contract_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L57)).

**The nonnegative angular gain is bounded.** Proved result. If the rotation-generator error has norm at most c times the field norm, the positive part of |k|−c times the field norm is at most cylindrical radius times the derivative square-energy norm. (`gain_max`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L80)).

**Bounding a squared difference.** Proved result. Difference squares obey the two-term bound. (`sq_norm_sub_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L91)).

**The first curl component is a difference.** Proved result. The first curl component is a difference. (`curlOfGrad_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L96)).

**Second curl component is a difference.** Proved result. The second curl component is a difference. (`curlOfGrad_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L100)).

**The third curl component is a difference.** Proved result. The third curl component is a difference. (`curlOfGrad_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L104)).

**Curl energy bounded by gradient energy.** Proved result. Curl energy is at most twice gradient energy. (`cnormSq_curlOfGrad_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L108)).

**The rotation generator on matrix entries.** Definition. The matrix rotation generator differentiates both the output-vector rotation and the inverse rotation of the input coordinate. (`pairGen`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L121)).

**The rotation generator on vectors.** Definition. The vector rotation generator records the components of the infinitesimal azimuthal field on coordinate unit vectors. (`vecGen`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L125)).

**The angular derivative law for curl.** Proved result. Curl obeys the angular differentiation law. (`curl_identity`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L127)).

**Angular mode bounds from derivatives.** Proved result. The mode derivative and rotation identities imply the angular energy inequalities almost everywhere in time and space for every mode of a positive-period perturbation. (`angularModePointwise_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngular.lean#L151)).

### Breakdown.CertCell.TailAngularPlane

This file transports almost-everywhere angular estimates from space to the meridian half-plane and checks the measurability needed for labeled mode integrals. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Meridian points are a two-coordinate sum.** Proved result. Meridian points are a two-coordinate sum. (`planePoint_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L20)).

**Meridian embedding is continuous.** Proved result. Meridian embedding is continuous. (`continuous_planePoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L24)).

**Rotated meridian points are cylindrical.** Proved result. Rotated meridian points are cylindrical. (`axialRot_planePoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L29)).

**The meridian orbit map is continuous.** Proved result. The meridian orbit map is continuous. (`continuous_orbitPlane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L35)).

**Cylindrical spatial integration.** Proved result. Space integration has cylindrical coordinates. (`lintegral_eq_cylindrical`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L47)).

**Good rotations for almost every meridian.** Proved result. Almost every meridian has a good rotation. (`ae_exists_rotation_planePoint_of_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L82)).

**Radius on the meridian section.** Proved result. At a positive-radius meridian point, cylindrical radius equals the first planar coordinate. (`cylRadius_planePoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L121)).

**Angular bounds descend to the plane.** Proved result. Almost-everywhere spatial angular energy inequalities imply the corresponding cylindrical weighted label inequalities almost everywhere on the half-plane. (`angularModeBounds_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L129)).

**Full turns leave rotations unchanged.** Proved result. Full turns leave rotations unchanged. (`axialRot_add_int_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L176)).

**A periodic null set is globally null.** Proved result. A periodic null set is globally null. (`volume_eq_zero_of_periodic`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L181)).

**Angular orbits avoid null sets a.e..** Proved result. Almost every angular orbit avoids a null set. (`ae_volume_rotation_planePoint_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L219)).

**Equal coordinate maps preserve null sets.** Proved result. Equal coordinate maps preserve null sets. (`quasiMeasurePreserving_of_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L249)).

**Meridian orbit map preserves null sets.** Proved result. The meridian orbit map preserves null sets. (`quasiMeasurePreserving_orbitPlane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L284)).

**Orbit averages are a.e. measurable.** Proved result. Orbit averages are almost-everywhere measurable. (`aestronglyMeasurable_orbitAverage`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L293)).

**Field measurability from coordinates.** Proved result. Measurable coordinates give measurable fields. (`aestronglyMeasurable_of_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L333)).

**Labeled fields are a.e. measurable.** Proved result. Labeled fields are almost-everywhere measurable. (`aestronglyMeasurable_labelFields`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailAngularPlane.lean#L340)).

### Breakdown.CertCell.TailCoefficients

This file compares mode coefficients with the uniform bounds recorded in a set of piece data. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**A logical indicator equals its bit value.** Proved result. A logical indicator equals its bit value. (`ind_eq_bit`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L13)).

**Logical indicators are nonnegative.** Proved result. Logical indicators are nonnegative. (`ind_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L19)).

**Boolean bit values are nonnegative.** Proved result. Boolean bit values are nonnegative. (`bit_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L23)).

**A bit preserves inequalities.** Proved result. A bit preserves inequalities. (`bit_mul_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L27)).

**The first amplitude is velocity.** Proved result. The first amplitude is velocity. (`ampOf_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L32)).

**The second amplitude is gradient.** Proved result. The second amplitude is gradient. (`ampOf_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L34)).

**The third amplitude is vorticity.** Proved result. The third amplitude is vorticity. (`ampOf_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L36)).

**Fourth amplitude is vorticity gradient.** Proved result. The fourth amplitude is vorticity gradient. (`ampOf_three`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L38)).

**Harmonic amplitude sums are nonnegative.** Proved result. Harmonic amplitude sums are nonnegative. (`harmonicSum_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L47)).

**Inward gradient sums are nonnegative.** Proved result. Inward gradient sums are nonnegative. (`inward_gradW_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L54)).

**Share coefficient obeys its upper bound.** Proved result. The share coefficient obeys its upper bound. (`shareHat_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L70)).

**Curl coefficient obeys its lower bound.** Proved result. The curl coefficient obeys its lower bound. (`curl_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L82)).

**Gradient coefficient lower bound.** Proved result. The gradient coefficient obeys its lower bound. (`grad_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L114)).

**Velocity coefficient lower bound.** Proved result. The velocity coefficient obeys its lower bound. (`vel_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L139)).

**Uniform coefficient lower bounds.** Proved result. Admissibility and valid set-piece coefficient bounds imply domination of the lower point coefficients on every designated mode and region. (`uniformCoefficientBounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailCoefficients.lean#L180)).

### Breakdown.CertCell.TailExteriorLinks

This file combines coefficient domination, cross-term absorption and inverse-square estimates to justify the exterior nonnegativity condition. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Stretch adjustments preserve domination.** Proved result. Stretch adjustments preserve domination. (`dominates_withStretch`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L22)).

**The cross term is absorbed by squares.** Proved result. The cross term is absorbed by squares. (`cross_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L76)).

**Absorbed coefficients satisfy the tests.** Proved result. Absorbed coefficients satisfy the tests. (`coeff_facts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L85)).

**Positive-part differences balance.** Proved result. Positive-part differences balance. (`ofReal_sub_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L106)).

**Controlling the negative integral part.** Proved result. An almost-everywhere density lower bound by γS−αV, the absorption relation α≤γc, and a finite inverse-square integral estimate bound the negative density integral by the positive one. (`lintegral_neg_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L116)).

**The plane radius is continuous.** Proved result. The plane radius is continuous. (`continuous_planeRadius`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L169)).

**Complex squared norms are continuous.** Proved result. Complex squared norms are continuous. (`continuous_cnormSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L173)).

**Complex squared norms are nonnegative.** Proved result. Complex squared norms are nonnegative. (`cnormSq_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L177)).

**Exterior bounds imply exterior soundness.** Proved result. Angular inequalities, pointwise quadratic tests, coefficient bounds, finite label-gradient energy, and ray and square inverse-square estimates imply the certified exterior negative-to-positive integral bound. (`exteriorConditionSound_of_bounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailExteriorLinks.lean#L184)).

### Breakdown.CertCell.TailFlipDecay

This file proves reflection parity of velocity modes and the sixth-power finiteness needed for the exterior approximation arguments. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Pulling a.e. facts back to orbits.** Proved result. Almost-everywhere facts pull back to orbits. (`ae_orbit_of_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L23)).

**Meridian rotation gives cylinder points.** Proved result. Cylindrical coordinates equal rotated points. (`cylArg_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L46)).

**Reflection reverses orbit angle.** Proved result. Reflection reverses orbit angle. (`rot_plane_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L51)).

**Rotation and reflection reverse signs.** Proved result. Rotation and reflection reverse signs. (`rot_neg_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L57)).

**Adding a full turn preserves rotation.** Proved result. Adding a full turn preserves rotation. (`axialRot_add_period`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L62)).

**Negated full turns preserve rotation.** Proved result. Negated full turns preserve rotation. (`axialRot_neg_add_period`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L65)).

**Reflection and angle reversal keep phase.** Proved result. Reflection and angle reversal preserve phase. (`expFactor_flip_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L70)).

**Mode flip gives coordinate sign changes.** Proved result. Mode reflection gives coordinate sign changes. (`modeVel_flip_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L76)).

**Time slices satisfy a sixth-power bound.** Proved result. Almost every time in the unit period has finite gradient energy and a sixth-power velocity bound controlled by the cube of that energy. (`slice_sixth_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L126)).

**Space-time orbit maps preserve null sets.** Proved result. Space-time orbit maps preserve null sets. (`orbit_qmp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L142)).

**Rotation keeps the sixth-power integral.** Proved result. Rotation preserves the sixth-power integral. (`rot_lintegral_sixth`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L171)).

**An orbit integral bounds each mode.** Proved result. A velocity-mode component is bounded by the integral of the field norm over its unit-time and full-angle orbit. (`modeVel_enorm_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L184)).

**Squared L6 norm is time integrable.** Proved result. The squared sixth-power norm is time integrable. (`velocity_sixth_square`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L210)).

**Finite sixth power of each velocity mode.** Proved result. Each velocity mode has finite sixth power. (`mode_sixth_finite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L232)).

**Labeled velocity modes obey reflection.** Proved result. Labeled velocity modes obey reflection. (`labelFlipEvenHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L375)).

**Time integrability of squared L6 norms.** Proposition definition. This proposition requires the squared spatial L6 norm of a perturbation to be integrable over the unit time period. (`VelocitySixthSquareIntegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L398)).

**L6 integrability of each velocity mode.** Proposition definition. This proposition requires each velocity mode at time zero to have finite spatial sixth-power integral. (`ModeVelSixthFinite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L402)).

**The time-integrated L6 bound is proved.** Proved result. For every perturbation, the squared spatial L6 norm is integrable over the unit time period. (`velocitySixthSquareIntegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L406)).

**Velocity-mode sixth powers are finite.** Proved result. Velocity-mode sixth powers are finite. (`modeVelSixthFinite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailFlipDecay.lean#L409)).

### Breakdown.CertCell.TailGradFinite

This file bounds the labeled gradient energy by space-time orbit averages and proves its weighted half-plane integral is finite. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Choosing an a.e. measurable majorant.** Proved result. An almost-everywhere measurable majorant exists. (`exists_measurable_ge`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L19)).

**A shifted period integral is bounded.** Proved result. For a nonnegative extended-valued 2π-periodic function, its integral over (0,2π] is at most twice its integral over (−π,π). (`lintegral_period_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L40)).

**Cylindrical coordinates are periodic.** Proved result. Cylindrical coordinates are periodic. (`cylPoint_add_two_pi`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L65)).

**Meridian rotation and cylindrical points.** Proved result. Meridian rotation gives cylindrical coordinates. (`axialRot_planePoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L68)).

**Cylindrical coordinates are measurable.** Proved result. Cylindrical coordinates are measurable. (`measurable_cylPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L73)).

**The cylindrical integral bound.** Proved result. For a measurable nonnegative extended-valued function, the cylindrical integral over the half-plane and one full turn is at most twice its spatial integral. (`cyl_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L77)).

**Matrix entry is bounded by operator norm.** Proved result. Every matrix entry obtained by rotating the input and output frames is bounded in absolute value by the original operator norm. (`norm_entry_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L107)).

**Columns bound the operator norm.** Proved result. Columns bound the operator norm. (`opNorm_le_sum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L116)).

**Matrix energy bounds operator norm.** Proved result. The square of the spatial operator norm is at most three times the sum of squared column norms. (`norm_sq_le_three_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L129)).

**Averaging bounds gradient-mode entries.** Proved result. A gradient-mode entry is bounded by 1/(2π) times the unit-time and full-angle integral of any pointwise operator-norm majorant. (`enorm_modeGrad_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L139)).

**Cauchy-Schwarz bounds a squared integral.** Proved result. The square of a nonnegative lower integral is at most the total measure times the lower integral of the square. (`sq_lintegral_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L164)).

**Orbit energy bounds label gradients.** Proved result. The labeled gradient square energy is bounded by 9/(2π) times the full-angle and unit-time integral of a measurable squared gradient majorant along its cylindrical orbit. (`labelGrad_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L177)).

**Finite weighted label-gradient energy.** Proved result. Label gradients have finite weighted energy. (`labelGradFinite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailGradFinite.lean#L225)).

### Breakdown.CertCell.TailPointwise

This file provides the elementary quadratic and angular-ratio inequalities used in the pointwise exterior test. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The quadratic test gives nonnegativity.** Proved result. The quadratic test gives nonnegativity. (`quadForm_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailPointwise.lean#L36)).

**Squaring the angular ratio bound.** Proved result. For positive radius and nonnegative frequency and amplitude, squaring the angular bound gives frequency squared times amplitude squared over radius squared at most the gradient variable squared. (`sq_ratio_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailPointwise.lean#L52)).

### Breakdown.CertCell.TailRayBound

This file proves a radial Hardy estimate on domains that begin once along each ray and transfers it from smooth compact fields to weak fields. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Measurable exterior cut once on each ray.** Proposition definition. A ray exterior is a measurable set whose intersection with each positive unit ray is either empty or an open tail starting at a positive radius. (`IsRayExterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L20)).

**Gradient applied in the radial direction.** Definition. The radial application of a linear map evaluates it on the unit radial direction. (`radialApply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L24)).

**The weak inverse-square estimate on rays.** Interface. This proposition bounds the inverse-radius-square energy of an L6 field with integrable weak-gradient energy on a ray exterior by four times its radial-gradient energy there. (`RadialRayStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L26)). Proof route: `Breakdown.CertCell.TailBand.radialRay`.

**A radial line obeys the Hardy bound.** Proved result. A radial line obeys the Hardy bound. (`line_sum`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L37)).

**The lower endpoint of exterior rays.** Proved result. An exterior ray integral starts at its radius. (`ray_cut`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L76)).

**Each exterior ray obeys the Hardy bound.** Proved result. Each exterior ray obeys the Hardy bound. (`dir_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L90)).

**Radial derivative energy is measurable.** Proved result. Radial derivative energy is measurable. (`slope_measurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L141)).

**Exterior Hardy bounds for compact fields.** Proved result. Compact fields obey the exterior Hardy bound. (`compact_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L147)).

**Weighted squares split a perturbation.** Proved result. Weighted squares split a perturbation. (`sq_le_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L158)).

**Matrix square energy is nonnegative.** Proved result. Matrix square energy is nonnegative. (`entrySq_nonneg'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L167)).

**Energy controls radial derivative errors.** Proved result. The squared difference of the two radial applications is at most the sum of squared matrix entries of the difference map. (`slope_diff_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L170)).

**Weak radial derivatives are measurable.** Proved result. Weak radial derivatives are measurable. (`slope_aesm`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L183)).

**Hardy bounds by smooth approximation.** Proved result. Smooth approximation transfers the Hardy bound. (`transfer`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L189)).

**Exterior Hardy bounds for smooth fields.** Proved result. Smooth fields obey the exterior Hardy bound. (`smooth_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayBound.lean#L267)).

### Breakdown.CertCell.TailRayModes

This file splits complex mode energy into real, imaginary, radial and angular pieces and prepares the cylindrical reduction of the ray estimate. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Real matrices act by coordinate sums.** Proved result. Real matrices act by coordinate sums. (`reMat_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L23)).

**Imaginary matrix action by coordinates.** Proved result. Imaginary matrices act by coordinate sums. (`imMat_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L27)).

**Real vectors select real coordinates.** Proved result. Real vectors select real coordinates. (`reVec_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L31)).

**Taking imaginary vector coordinates.** Proved result. Imaginary vectors select imaginary coordinates. (`imVec_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L35)).

**Norm square is three coordinate squares.** Proved result. The norm square is three coordinate squares. (`norm_sq_three`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L39)).

**Complex energy is six real squares.** Proved result. Complex energy is six real squares. (`cnormSq_three`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L43)).

**Real and imaginary energy splitting.** Proved result. Complex energy splits into real and imaginary. (`cnormSq_re_im`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L48)).

**Radial and angular row-energy bounds.** Proved result. At positive cylindrical radius, the squared radial projection plus squared angular projection of a real row is at most the row's squared Euclidean norm. (`row_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L53)).

**The angular matrix-row contraction.** Proved result. Contracting a complex matrix row with the angular direction gives its second entry times the first spatial coordinate minus its first entry times the second coordinate, separated into real and imaginary parts. (`contract_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L60)).

**Splitting each gradient row's energy.** Proved result. Each gradient row splits into two energies. (`grad_row`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L65)).

**Bounds for radial and angular energy.** Proved result. At positive cylindrical radius, real and imaginary radial-gradient energies plus cylindrical-normalized angular-contraction energy are at most the full complex matrix energy. (`grad_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L85)).

**Angular gain squares to an energy bound.** Proved result. Angular gain squares to an energy bound. (`gain_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L96)).

**Complex scaling rescales square energy.** Proved result. Complex scaling rescales square energy. (`cnormSq_const_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L129)).

**Rotation preserves complex vector energy.** Proved result. Rotation preserves complex vector energy. (`cnormSq_rotC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L133)).

**Inverse rotation transposes its matrix.** Proved result. Inverse rotation transposes its matrix. (`rot_transpose`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L138)).

**Rotation preserves complex matrix energy.** Proved result. Rotation preserves complex matrix energy. (`cnormSq_rotCMat`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L142)).

**Time shift adds a phase to mode averages.** Proved result. Time shift multiplies mode averages by phase. (`modeAverage_shift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L160)).

**Time shift keeps velocity-mode energy.** Proved result. Time shift preserves velocity-mode energy. (`cnormSq_modeVel_shift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L211)).

**Time shift keeps gradient-mode energy.** Proved result. Time shift preserves gradient-mode energy. (`cnormSq_modeGrad_shift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L224)).

**Inverse rotation recovers the meridian.** Proved result. Inverse rotation returns the meridian point. (`rot_cyl`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L239)).

**Plane coordinates of cylindrical points.** Proved result. Cylindrical points recover plane coordinates. (`pointPlane_cyl`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L246)).

**Cylindrical and meridian radii agree.** Proved result. Cylindrical and meridian radii agree. (`norm_cyl`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L252)).

**The meridian projection is measurable.** Proved result. The meridian projection is measurable. (`pointPlane_measurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L259)).

**Ray exterior regions are measurable.** Proved result. Ray exterior regions are measurable. (`planeRayRegion_measurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L263)).

**A ray region lifts to a spatial exterior.** Proved result. A ray region lifts to a spatial exterior. (`rayExterior_lift`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L271)).

**Planar reduction by axisymmetry.** Proved result. Axisymmetric integrals reduce to the plane. (`cyl_transfer`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L310)).

**Pulling back null sets through cylinders.** Proved result. A spatial property holding almost everywhere pulls back almost everywhere to the restricted cylindrical region. (`ae_region_of_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L337)).

**Complex square energies are nonnegative.** Proved result. Complex square energies are nonnegative. (`cnormSq_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L343)).

**A sixth-power bound gives L6 membership.** Proved result. A sixth-power bound gives L6 membership. (`memLp_six_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L346)).

**Matrix square energy is continuous.** Proved result. Matrix square energy is continuous. (`entrySq_cont`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L358)).

**Finite matrix energy gives integrability.** Proved result. Finite matrix energy gives integrability. (`integrable_entrySq_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L362)).

**Real and imaginary matrix energies.** Proved result. Matrix energy splits into real and imaginary. (`entrySq_re_im`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L370)).

**Complex energy bounds real matrices.** Proved result. The sum of squared entries of the real matrix part is at most the sum of squared absolute complex entries. (`entrySq_reMat_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L377)).

**Complex energy bounds imaginary matrices.** Proved result. The sum of squared entries of the imaginary matrix part is at most the sum of squared absolute complex entries. (`entrySq_imMat_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L382)).

**Complex energy bounds real vectors.** Proved result. The squared Euclidean norm of the real vector part is at most the sum of squared absolute complex components. (`reVec_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L387)).

**Complex energy bounds imaginary vectors.** Proved result. The squared Euclidean norm of the imaginary vector part is at most the sum of squared absolute complex components. (`imVec_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L391)).

**Choosing a slice with all weak data.** Proved result. One time slice simultaneously has real and imaginary weak mode gradients, the almost-everywhere angular derivative identity, and integrable velocity and gradient rotation orbits. (`slice_choice`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L396)).

**Rotation preserves velocity-mode energy.** Proved result. Rotation preserves velocity-mode energy. (`cnormSq_vel_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L442)).

**Rotation preserves gradient-mode energy.** Proved result. Rotation preserves gradient-mode energy. (`cnormSq_grad_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L450)).

**Ray regions stay in the upper half-plane.** Proved result. Ray regions lie in the positive half-plane. (`plane_sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L463)).

**Restricted integrals using indicators.** Proved result. Region indicators give restricted integrals. (`plane_integral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L466)).

**Exterior indicators keep measurability.** Proved result. Exterior indicators preserve measurability. (`indicator_aemeasurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L478)).

**Cylindrical radius is positive a.e..** Proved result. Cylindrical radius is positive almost everywhere. (`region_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailRayModes.lean#L484)).

### Breakdown.CertCell.TailSquareDensity

This file extends the square-exterior Hardy estimate to weak symmetric fields by radial cutoffs, symmetry-preserving convolution and shrinking exterior collars. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The lifted square exterior in space.** Definition. The spatial square exterior is the inverse image of the planar square exterior under cylindrical-radius and height projection. (`spaceSquareExterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L17)).

**Rotation and flip covariance of a field.** Proposition definition. An axial reflection field is covariant under every axial rotation and under the prescribed spatial reflection. (`IsAxialFlipField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L20)).

**Smooth square-exterior Hardy inequality.** Interface. This proposition bounds twice the inverse-radius-square energy of a compactly supported C¹ axial reflection field on the square exterior by its gradient energy there. (`SquareExteriorSpaceSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L24)). Proof route: `Breakdown.CertCell.TailBand.squareExteriorSpaceSmooth_of`.

**Weak square-exterior Hardy inequality.** Interface. This proposition requires the same square-exterior bound for weak-gradient fields with finite L6 and gradient energies and almost-everywhere rotation and reflection covariance. (`SquareExteriorSpaceWeakStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L30)). Proof route: `Breakdown.CertCell.TailBand.squareExteriorSpaceWeak_of`.

**Radial cutoffs keep the field symmetries.** Proved result. Radial cutoffs preserve the field symmetries. (`cutoff_smul_isAxialFlipField`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L39)).

**Sixth-power tails tend to zero.** Proved result. Sixth-power tails tend to zero. (`tail_sixth_tendsto`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L49)).

**Exterior bounds transferred by cutoffs.** Proved result. Cutting off extends the smooth exterior bound. (`cutoff_stage`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L66)).

**Coordinates of the square exterior.** Proved result. Membership in the spatial square exterior means positive cylindrical radius and height, with at least one exceeding the exterior threshold. (`mem_spaceSquareExterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L186)).

**The spatial square exterior is open.** Proved result. The spatial square exterior is open. (`isOpen_spaceSquareExterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L191)).

**A collar around the square exterior.** Definition. The exterior collar allows height down to −η while retaining the condition that cylindrical radius or height exceeds R. (`collar`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L202)).

**The exterior collar is open.** Proved result. The exterior collar is open. (`isOpen_collar`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L205)).

**Nearby points enter the exterior collar.** Proved result. Nearby points enter the exterior collar. (`mem_collar_of_near`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L210)).

**Regularity by symmetric mollification.** Proved result. Positive-scale radial convolution of an L6 weak-gradient field with almost-everywhere rotation and reflection symmetry is C¹, remains L6, and has those symmetries everywhere. (`weakGradient_smoothing`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L223)).

**Collar bounds for mollified energy.** Proved result. When twice the smoothing scale is at most the collar width, smoothed gradient energy outside the enlarged square is at most the original weak-gradient energy in the exterior collar. (`smoothing_energy_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L252)).

**Weak square-exterior inequality follows.** Proved result. The smooth square-exterior inequality extends to weak-gradient fields with finite L6 and gradient energies and almost-everywhere axial and reflection symmetry. (`squareExteriorSpaceWeak_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareDensity.lean#L324)).

### Breakdown.CertCell.TailSquareModes

This file applies the spatial square-exterior estimate to the real and imaginary parts of zero-azimuth modes and transports it to the labeled half-plane fields. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Real vectors select real coordinates.** Proved result. Real vectors select real coordinates. (`reVec_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L24)).

**Taking imaginary vector coordinates.** Proved result. Imaginary vectors select imaginary coordinates. (`imVec_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L27)).

**Real matrices act by coordinate sums.** Proved result. Real matrices act by coordinate sums. (`reMat_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L30)).

**Imaginary matrix action by coordinates.** Proved result. Imaginary matrices act by coordinate sums. (`imMat_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L34)).

**Real and imaginary energy splitting.** Proved result. Complex energy splits into real and imaginary. (`cnormSq_eq_re_im`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L38)).

**A phase can be removed from real vectors.** Proved result. A phase can be removed from real vectors. (`reVec_unphase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L43)).

**Removing phase from imaginary vectors.** Proved result. A phase can be removed from imaginary vectors. (`imVec_unphase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L51)).

**Phase can be removed from real matrices.** Proved result. A phase can be removed from real matrices. (`reMat_unphase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L59)).

**Removing phase from imaginary matrices.** Proved result. A phase can be removed from imaginary matrices. (`imMat_unphase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L69)).

**Real parts commute with rotation.** Proved result. Real parts commute with rotation. (`reVec_rotC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L79)).

**Imaginary parts commute with rotation.** Proved result. Imaginary parts commute with rotation. (`imVec_rotC`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L84)).

**Vector rotation respects complex scalars.** Proved result. Vector rotation respects complex scalars. (`rotC_const_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L89)).

**Matrix rotation respects complex scalars.** Proved result. Matrix rotation respects complex scalars. (`rotCMat_const_mul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L95)).

**Composing vector rotations.** Proved result. Vector rotations compose by angle addition. (`rotC_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L101)).

**Composing matrix rotations.** Proved result. Matrix rotations compose by angle addition. (`rotCMat_add`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L106)).

**Flip in the complex coordinate frame.** Definition. Complex frame reflection multiplies each vector component by the corresponding real reflection sign. (`frameFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L112)).

**Frame reflection is an involution.** Proved result. Frame reflection is an involution. (`frameFlip_frameFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L114)).

**Frame reflection reverses rotation angle.** Proved result. Frame reflection reverses rotation angle. (`rotC_frameFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L118)).

**Real parts commute with frame reflection.** Proved result. Real parts commute with frame reflection. (`reVec_frameFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L126)).

**Imaginary parts respect frame reflection.** Proved result. Imaginary parts commute with frame reflection. (`imVec_frameFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L130)).

**A good slice of a full-measure product.** Proved result. A property depending only on the second variable holds almost everywhere when it holds almost everywhere on a positive-measure product. (`ae_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L134)).

**Second coordinate is nonzero a.e..** Proved result. The second coordinate is nonzero almost everywhere. (`ae_ne_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L139)).

**Scalar multiples preserve weak gradients.** Proved result. Scalar multiples preserve weak gradients. (`weak_smul`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L145)).

**Linear combinations keep weak gradients.** Proved result. Linear combinations preserve weak gradients. (`weak_comb`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L158)).

**Velocity-mode rotation on a common set.** Proved result. Velocity modes rotate on a common full set. (`good_vel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L163)).

**Gradient-mode rotation on a common set.** Proved result. Gradient modes rotate on a common full set. (`good_grad`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L180)).

**Rotation covariance along orbits.** Proved result. Rotation covariance propagates along an orbit. (`good_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L197)).

**Mode field reflects almost everywhere.** Proved result. The mode field reflects almost everywhere. (`flip_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L202)).

**Unit complex phases preserve energy.** Proved result. Unit complex phases preserve energy. (`cnormSq_phase`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L241)).

**Matrix square energy is nonnegative.** Proved result. Matrix square energy is nonnegative. (`matSq_nonneg'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L245)).

**Complex energy bounds real vectors.** Proved result. The squared Euclidean norm of the real vector part is at most the full complex component square energy. (`reVec_sq_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L248)).

**Complex energy bounds imaginary vectors.** Proved result. The squared Euclidean norm of the imaginary vector part is at most the full complex component square energy. (`imVec_sq_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L252)).

**Dominated fields have finite sixth power.** Proved result. Dominated fields have finite sixth power. (`sixth_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L256)).

**Gradient modes have finite total energy.** Proved result. Gradient modes have finite total energy. (`modeGrad_finite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L262)).

**Composition keeps finite matrix energy.** Proved result. Composition preserves finite matrix energy. (`matSq_lintegral_finite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L284)).

**The flipped harmonic at azimuth zero.** Proved result. Zero-azimuth labels share the flipped harmonic. (`labelHarmonic_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L289)).

**A positive angular factor cancels.** Proved result. A positive angular factor cancels. (`cancel_two_pi`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L297)).

**Meridian embedding keeps squared radius.** Proved result. Meridian embedding preserves squared radius. (`norm_planePoint_sq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L303)).

**Square-exterior bound passes to modes.** Proved result. The square-exterior bound passes to modes. (`modeSquareInverseSquare_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareModes.lean#L312)).

### Breakdown.CertCell.TailSquareSmooth

This file proves the axial and transverse square-exterior inequalities by integrating two multiplier identities over a pair of rectangles. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The axial square-exterior inequality.** Interface. The axial planar exterior condition bounds twice the radius-weighted inverse-square energy by gradient energy for compactly supported C¹ functions vanishing on the horizontal boundary. (`SquareExteriorAxialSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L13)). Proof route: `Breakdown.CertCell.TailBand.squareExteriorAxialSmoothStatement`.

**Transverse square-exterior inequality.** Interface. The transverse planar exterior condition adds the cylindrical inverse-square energy to the gradient bound for compactly supported C¹ functions vanishing on the axis. (`SquareExteriorTransverseSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L19)). Proof route: `Breakdown.CertCell.TailBand.squareExteriorTransverseSmoothStatement`.

**Both smooth square-exterior inequalities.** Interface. The smooth square-exterior package requires both the axial and transverse planar inequalities. (`SquareExteriorSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L25)). Proof route: `Breakdown.CertCell.TailBand.squareExteriorSmoothStatement`.

**First slice derivative is a partial.** Proved result. For a differentiable two-variable function, the derivative of its first-coordinate slice equals its Fréchet derivative applied to (1,0). (`partial_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L28)).

**Second slice derivative is a partial.** Proved result. For a differentiable two-variable function, the derivative of its second-coordinate slice equals its Fréchet derivative applied to (0,1). (`partial_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L34)).

**First-coordinate slices differentiate.** Proved result. First-coordinate slices differentiate. (`line_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L40)).

**Second-coordinate slices differentiate.** Proved result. Second-coordinate slices differentiate. (`line_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L45)).

**Rectangle divergence boundary integrals.** Proved result. Rectangle divergence gives boundary integrals. (`box_divergence`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L50)).

**Weighted squares bound the cross term.** Proved result. Weighted squares bound the cross term. (`quad_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L92)).

**The first axial multiplier derivative.** Proved result. For positive height, the radial derivative of −2r²/(r²+z²) is −4rz²/(r²+z²)². (`axial_deriv_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L101)).

**The second axial multiplier derivative.** Proved result. For positive height, differentiating r(r²−z²)/(z(r²+z²)) gives the axial multiplier's height term used in the rectangle estimate. (`axial_deriv_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L110)).

**First transverse multiplier derivative.** Proved result. Away from the planar origin, the radial derivative of (z²−r²)/(r²+z²) is −4rz²/(r²+z²)². (`cross_deriv_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L122)).

**Second transverse multiplier derivative.** Proved result. Away from the planar origin, the height derivative of −2rz/(r²+z²) is −2r(r²−z²)/(r²+z²)². (`cross_deriv_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L131)).

**Axial multiplier gives a pointwise bound.** Proved result. The axial multiplier gives a pointwise bound. (`axial_pointwise`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L140)).

**The transverse multiplier bound.** Proved result. The transverse multiplier gives a pointwise bound. (`cross_pointwise`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L160)).

**Plane radius squared is a coordinate sum.** Proved result. Plane radius squared is a coordinate sum. (`sq_planeRadius`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L180)).

**Measurability of truncated exteriors.** Proved result. Truncated exterior regions are measurable. (`measurableSet_exterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L183)).

**Zero values beyond compact support.** Proved result. Compact support supplies a threshold beyond which either large positive coordinate forces both the function and its totalized derivative to vanish. (`support_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L190)).

**A height bound from plane vanishing.** Proved result. Vanishing on the plane gives a height bound. (`plane_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L205)).

**A radial bound from axis vanishing.** Proved result. Vanishing on the axis gives a radial bound. (`axis_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L211)).

**Integrability on bounded regions.** Proved result. Bounded data on a finite region are integrable. (`integrableOn_bounded`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L217)).

**Truncated exterior splits into two boxes.** Proved result. The truncated exterior splits into two boxes. (`split_exterior`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L232)).

**The interval integral of zero.** Proved result. A zero integrand has zero interval integral. (`iint_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L262)).

**Boundary line integrals are finite.** Proved result. Boundary line integrals are finite. (`line_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L265)).

**Exterior bounds from two rectangles.** Proved result. Two rectangle identities bound the exterior. (`two_box`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L272)).

**The square exterior is measurable.** Proved result. The square exterior is measurable. (`measurableSet_square`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L314)).

**Weighted gradient energy is integrable.** Proved result. Weighted gradient energy is integrable. (`grad_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L319)).

**Radial inverse-square term is integrable.** Proved result. The radial inverse-square term is integrable. (`ratio_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L328)).

**Integrability of cylindrical weights.** Proved result. The cylindrical inverse-square term is integrable. (`axis_integrable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L346)).

**From real integrals to lower integrals.** Proved result. The real integral estimate gives a lower integral bound. (`to_lintegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L369)).

**The axial square-exterior inequality.** Proved result. For positive exterior radius, twice the weighted inverse-square integral is bounded by the radial and height derivative energies of a compactly supported C¹ function vanishing on the horizontal boundary. (`axial_main`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L384)).

**Transverse square-exterior inequality.** Proved result. For positive exterior radius, the transverse inverse-square estimate adds the cylindrical inverse-square term to gradient energy for compactly supported C¹ functions vanishing on the axis. (`transverse_main`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L512)).

**The axial exterior estimate.** Proved result. The axial square-exterior inverse-square estimate holds for compactly supported C¹ functions vanishing on the horizontal boundary. (`squareExteriorAxialSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L589)).

**The transverse exterior estimate.** Proved result. The transverse square-exterior inverse-square estimate holds for compactly supported C¹ functions vanishing on the axis. (`squareExteriorTransverseSmoothStatement`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmooth.lean#L598)).

### Breakdown.CertCell.TailSquareSmoothing

This file constructs a radial unit-mass smoothing kernel that preserves rotations and reflection, together with the energy and cutoff bounds needed for weak limits. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The scalar bump profile.** Definition. The scalar bump profile has inner radius one and outer radius four before composition with squared spatial radius. (`profile`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L17)).

**A radial smooth bump from squared radius.** Definition. The radial bump evaluates the scalar bump profile at the squared spatial norm. (`roundBump`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L19)).

**The radial bump is infinitely smooth.** Proved result. The radial bump is infinitely smooth. (`roundBump_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L21)).

**The radial bump is nonnegative.** Proved result. The radial bump is nonnegative. (`roundBump_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L24)).

**The radial bump is at most one.** Proved result. The radial bump is at most one. (`roundBump_le_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L26)).

**The radial bump equals one inside.** Proved result. The radial bump equals one throughout the closed unit ball. (`roundBump_eq_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L28)).

**The radial bump vanishes outside.** Proved result. The radial bump vanishes outside. (`roundBump_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L34)).

**The radial bump has compact support.** Proved result. The radial bump has compact support. (`roundBump_hasCompactSupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L40)).

**The radial bump at scale s.** Definition. The scaled radial bump evaluates the unscaled bump at the position divided by s. (`scaledBump`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L44)).

**The scaled bump is infinitely smooth.** Proved result. The scaled bump is infinitely smooth. (`scaledBump_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L46)).

**Linear isometries keep the scaled bump.** Proved result. Linear isometries preserve the scaled bump. (`scaledBump_isometry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L49)).

**The scaled bump equals one inside.** Proved result. For positive scale s, the scaled bump equals one throughout the closed ball of radius s. (`scaledBump_eq_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L53)).

**The scaled bump vanishes outside.** Proved result. The scaled bump vanishes outside. (`scaledBump_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L59)).

**The scaled bump has compact support.** Proved result. The scaled bump has compact support. (`scaledBump_hasCompactSupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L65)).

**The total mass of the radial bump.** Definition. The bump mass is the spatial integral of the unscaled radial bump. (`bumpMass`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L69)).

**The radial bump has positive mass.** Proved result. The radial bump has positive mass. (`bumpMass_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L71)).

**The normalized radial smoothing kernel.** Definition. The normalized smoothing kernel divides the scaled radial bump by s cubed times the unscaled bump mass. (`roundKernel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L75)).

**Smoothing kernel is infinitely smooth.** Proved result. The smoothing kernel is infinitely smooth. (`roundKernel_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L77)).

**The smoothing kernel is nonnegative.** Proved result. The smoothing kernel is nonnegative. (`roundKernel_nonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L80)).

**The smoothing kernel has compact support.** Proved result. The smoothing kernel has compact support. (`roundKernel_hasCompactSupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L83)).

**Linear isometries preserve the kernel.** Proved result. Linear isometries preserve the kernel. (`roundKernel_isometry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L87)).

**The smoothing kernel has mass one.** Proved result. The smoothing kernel has mass one. (`roundKernel_integral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L91)).

**The smoothing kernel bound.** Proved result. For positive scale s, the normalized radial smoothing kernel is at most the reciprocal of s cubed times the unscaled bump mass. (`roundKernel_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L99)).

**Nonzero kernel values lie in radius 2s.** Proved result. Nonzero kernel values lie within radius 2s. (`norm_lt_of_roundKernel_ne`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L103)).

**Smoothing converges almost everywhere.** Proved result. Smoothing converges almost everywhere. (`ae_tendsto_roundKernel`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L108)).

**Matrix square energy is nonnegative.** Proved result. Matrix square energy is nonnegative. (`matSq_nonneg'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L142)).

**Matrix square energy is continuous.** Proved result. Matrix square energy is continuous. (`continuous_matSq'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L145)).

**Averages obey the squared-norm bound.** Proved result. Averages obey the squared-norm bound. (`sq_norm_average_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L149)).

**Sixth powers lie above their tangent.** Proved result. Sixth powers lie above their tangent. (`sixth_le_tangent'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L170)).

**Averages obey the sixth-power bound.** Proved result. Averages obey the sixth-power bound. (`sixth_norm_average_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L180)).

**Smooth the weak-gradient columns.** Proved result. For a smooth compactly supported kernel, each coordinate derivative of the smoothed field equals convolution with the corresponding weak-gradient column. (`fderiv_smoothing_column`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L210)).

**Smoothing bounds gradient energy.** Proved result. A nonnegative smooth compactly supported kernel of mass one bounds the smoothed weak-gradient energy by the convolution of the original gradient energy. (`matSq_fderiv_smoothing_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L243)).

**Smoothing bounds sixth powers.** Proved result. A nonnegative smooth compactly supported kernel of mass one bounds the sixth power of the smoothed field by the smoothed sixth power when both the field and its sixth power are locally integrable. (`norm_smoothing_sixth_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L279)).

**Smoothing respects linear isometries.** Proved result. Smoothing commutes with linear isometries. (`smoothing_isometry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L292)).

**Coordinate signs of point reflection.** Proved result. The spatial reflection fixes the first coordinate and negates the second and third coordinates. (`flipPoint_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L306)).

**Coordinate equalities determine a vector.** Proved result. Coordinate equalities determine a vector. (`flipPoint_ext`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L310)).

**Point reflection as a linear map.** Definition. The point reflection is packaged as a real linear map. (`flipLinear`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L314)).

**Point reflection is an involution.** Proved result. Point reflection is an involution. (`flipPoint_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L327)).

**Point reflection preserves the norm.** Proved result. Point reflection preserves the norm. (`norm_flipPoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L332)).

**Point reflection as a linear isometry.** Definition. The norm-preserving involutive point reflection is packaged as a linear isometric equivalence. (`flipIsometry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L337)).

**Flip isometry matches the point map.** Proved result. The reflection isometry matches the point map. (`flipIsometry_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L341)).

**Axial rotation as a linear isometry.** Proved result. Axial rotation has a linear-isometry model. (`exists_rotationIsometry`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L343)).

**Scaled bumps are rotation invariant.** Proved result. Scaled bumps are rotation invariant. (`scaledBump_axialRot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L346)).

**Scaled bumps are reflection invariant.** Proved result. Scaled bumps are reflection invariant. (`scaledBump_flip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L350)).

**Bump derivatives use inverse scaling.** Proved result. The scaled bump derivative is the original bump derivative at the reciprocally scaled point, precomposed with multiplication by the totalized reciprocal scale. (`fderiv_scaledBump`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L353)).

**The unscaled bump derivative is bounded.** Proved result. The derivative of the unscaled radial bump has a single global finite norm bound. (`exists_fderiv_roundBump_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L360)).

**Scaled bump derivative is bounded by M/s.** Proved result. At positive scale s, a derivative bound M for the unscaled radial bump gives bound M/s for the scaled bump derivative. (`norm_fderiv_scaledBump_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L364)).

**Bump derivative vanishes below its scale.** Proved result. For positive scale s, the scaled bump derivative vanishes at every point of norm strictly less than s. (`fderiv_scaledBump_eq_zero_of_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L378)).

**Bump derivative vanishes beyond 2s.** Proved result. For positive scale s, the scaled bump derivative vanishes at every point of norm strictly greater than twice s. (`fderiv_scaledBump_eq_zero_of_gt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L385)).

**Weighted squares split an error.** Proved result. Weighted squares split an error. (`norm_add_sq_le_split`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L392)).

**A cutoff has a controlled gradient cost.** Proved result. For positive δ, multiplying a C¹ field by the cutoff bounds gradient energy by (1+δ) times the field's gradient energy plus 3(1+1/δ) times cutoff-gradient squared times field-norm squared. (`matSq_fderiv_cutoff_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L403)).

**A linear bound by a shifted cubic.** Proved result. For nonnegative u and positive a, u is at most a plus u cubed divided by a squared. (`le_add_cube_div_sq'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L441)).

**Cutoff gradient error has a tail bound.** Proved result. The cutoff gradient error has a tail bound. (`integral_fderiv_scaledBump_sq_mul_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L452)).

**Cylindrical radius is one-Lipschitz.** Proved result. Cylindrical radius is one-Lipschitz. (`axialRadius_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L520)).

**Distance bounds coordinate increases.** Proved result. A coordinate of one point is at most the same coordinate of another point plus the distance between them. (`coord_sub_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L545)).

**Cylindrical radius is continuous.** Proved result. Cylindrical radius is continuous. (`continuous_axialRadius`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L551)).

**Coordinate projection is continuous.** Proved result. Coordinate projection is continuous. (`continuous_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L554)).

**Coordinate planes have zero volume.** Proved result. Coordinate planes have zero volume. (`volume_coord_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareSmoothing.lean#L557)).

### Breakdown.CertCell.TailSquareTransfer

This file lifts the planar axial and transverse inequalities to three-dimensional fields using cylindrical integration and the symmetry-imposed boundary zeros. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Axial rotation as a bounded linear map.** Definition. The axial rotation is packaged as a continuous linear map through its linear isometry. (`rotL`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L25)).

**Linear rotation matches point rotation.** Proved result. The linear rotation matches point rotation. (`rotL_apply`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L27)).

**Negative rotation is a left inverse.** Proved result. Negative rotation is a left inverse. (`rot_neg_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L29)).

**Negative rotation is a right inverse.** Proved result. Negative rotation is a right inverse. (`rot_rot_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L32)).

**The meridian embedding as a linear map.** Definition. The meridian embedding sends a planar pair to radius times the first unit vector plus height times the third. (`planeL`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L35)).

**The meridian embedding is linear.** Proved result. The meridian embedding is linear. (`planePoint_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L39)).

**The first meridian coordinate is radius.** Proved result. The first meridian coordinate is radius. (`planePoint_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L43)).

**The second spatial coordinate is zero.** Proved result. The second spatial coordinate is zero. (`planePoint_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L46)).

**The third meridian coordinate is height.** Proved result. The third meridian coordinate is height. (`planePoint_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L49)).

**The radial plane basis embeds as e₀.** Proved result. The radial plane basis embeds as e₀. (`planeL_fst`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L52)).

**The height plane basis embeds as e₂.** Proved result. The height plane basis embeds as e₂. (`planeL_snd`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L55)).

**The plane square exterior is measurable.** Proved result. The plane square exterior is measurable. (`measurableSet_planeSquare`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L58)).

**Spatial square exterior is measurable.** Proved result. The spatial square exterior is measurable. (`measurableSet_spaceSquare`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L65)).

**The square exterior has positive radius.** Proved result. The square exterior has positive radius. (`planeSquare_sub`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L69)).

**Rotations preserve the spatial exterior.** Proved result. Rotations preserve the spatial exterior. (`mem_spaceSquare_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L72)).

**Meridian embedding of exterior regions.** Proved result. Meridian embedding preserves exterior membership. (`planePoint_mem`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L79)).

**Cylindrical reduction by axisymmetry.** Proved result. Axisymmetric integrals reduce cylindrically. (`lintegral_cyl_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L84)).

**Rotation preserves meridian projection.** Proved result. Rotation preserves meridian projection. (`pointPlane_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L106)).

**Projecting positive meridian points back.** Proved result. Positive-radius meridian points project back. (`pointPlane_planePoint`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L112)).

**Meridian projection is measurable.** Proved result. Meridian projection is measurable. (`measurable_pointPlane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L116)).

**Point angle reconstructs a spatial point.** Proved result. Point angle reconstructs a spatial point. (`rot_pointAngle`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L120)).

**The axis has zero planar measure.** Proved result. Almost every planar point has nonzero first coordinate. (`ae_ne_line`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L139)).

**Lifting a.e. plane facts to space.** Proved result. A property holding almost everywhere in the positive-radius plane holds almost everywhere after cylindrical projection from space. (`ae_pointPlane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L145)).

**Rotation-invariant spatial facts descend.** Proved result. An axial-rotation-invariant property holding almost everywhere in space holds almost everywhere on the positive-radius meridian section. (`ae_planePoint_of_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L174)).

**Reducing exterior integrals to the plane.** Proved result. Exterior spatial integrals reduce to the plane. (`lintegral_spaceSquare_ae`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L187)).

**Matrix square energy is continuous.** Proved result. Matrix square energy is continuous. (`continuous_matSq_map`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L214)).

**The meridian radius is continuous.** Proved result. The meridian radius is continuous. (`continuous_planeRadius`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L217)).

**Vector square norm is a coordinate sum.** Proved result. Vector square norm is a coordinate sum. (`norm_sq_coord`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L221)).

**Matrix energy as a sum over columns.** Proved result. Matrix square energy is a sum over columns. (`matSq_three`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L225)).

**Rotating the first unit vector backward.** Proved result. Rotation by minus θ sends the first basis vector to cos θ times the first basis vector minus sin θ times the second. (`rot_neg_e0`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L229)).

**Rotating the second unit vector backward.** Proved result. Rotation by minus θ sends the second basis vector to sin θ times the first basis vector plus cos θ times the second. (`rot_neg_e1`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L234)).

**Inverse rotation fixes e₂.** Proved result. Inverse rotation fixes e₂. (`rot_neg_e2`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L239)).

**Rotation conjugacy keeps matrix energy.** Proved result. Rotation conjugacy preserves matrix energy. (`matSq_conj`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L243)).

**Rotation covariance transports gradients.** Proved result. Rotation covariance transports gradients. (`fderiv_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L255)).

**Rotation has its angular tangent.** Proved result. At angle zero, differentiating axial rotation of (y₀,y₁,y₂) gives the vector (-y₁,y₀,0). (`hasDerivAt_rot`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L267)).

**Covariance from angular differentiation.** Proved result. Angular field differentiation gives covariance. (`fderiv_perp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L279)).

**Angular gradient energy on the meridian.** Proved result. For a differentiable rotation-covariant field at nonzero meridian radius, the angular derivative's squared norm is the sum of the first two component squares divided by radius squared. (`col_one`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L292)).

**Plane restriction is linear composition.** Proved result. Plane restriction is linear composition. (`plane_comp`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L306)).

**Differentiate a meridian restriction.** Proved result. Restricting a differentiable field to the meridian plane differentiates it in the embedded direction (q₁,0,q₂) and then takes the selected output component. (`fderiv_plane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L312)).

**Plane restrictions of C¹ fields are C¹.** Proved result. Plane restrictions of C¹ fields are C¹. (`contDiff_plane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L320)).

**Plane restrictions keep compact support.** Proved result. Plane restrictions preserve compact support. (`compact_plane`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L325)).

**Reflection reverses the third coordinate.** Proved result. Reflection reverses the third coordinate. (`flipPoint_two`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L335)).

**Axial fields vanish on the flip plane.** Proved result. Axial fields vanish on the reflection plane. (`axial_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L338)).

**Half-turns fix points on the axis.** Proved result. Half-turns fix points on the axis. (`rot_pi_axis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L348)).

**Transverse components vanish on the axis.** Proved result. Transverse components vanish on the axis. (`trans_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L352)).

**Weighted square integrand is measurable.** Proved result. The weighted square integrand is measurable. (`measurable_square_term`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L361)).

**Three coordinate inequalities sum.** Proved result. Three coordinate inequalities sum. (`three_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L366)).

**Spatial bounds from planar estimates.** Proved result. The axial and transverse planar inverse-square estimates combine through cylindrical integration to bound twice the spatial square-exterior inverse-square energy by gradient energy. (`squareExteriorSpaceSmooth_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailSquareTransfer.lean#L376)).

### Breakdown.CertCell.TailStatements

This file states the tail absorption, angular, coefficient, off-mode and exterior contracts used to control the unresolved part of the cell form. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The tail budget remainder.** Definition. The tail remainder subtracts absorbed gradient, curl, velocity, potential, and leakage charges from the Hessian and curl-gradient tail gains. (`remainder`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L23)).

**Absorption of unresolved-mode tails.** Proposition definition. This proposition requires certified tail gains and nonnegative tail energies to bound the remainder below by the negative low-mode velocity charge. (`TailAbsorption`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L30)).

**The five-energy quadratic form.** Definition. The point quadratic combines five squared energy variables and subtracts the gradient-velocity cross term. (`quad`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L42)).

**Coefficient bounds with cross terms.** Proposition definition. Coefficient domination means lower bounds for all five square coefficients and an upper bound for the subtracted cross coefficient. (`Dominates`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L46)).

**Pointwise quadratic nonnegativity test.** Proposition definition. This proposition requires passing pointwise coefficient tests and angular relations to make the five-energy quadratic nonnegative at positive radius. (`PointwiseQuadraticTest`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L56)).

**Pointwise coefficients from modes.** Definition. Mode coefficients become pointwise coefficients by matching the five energy terms and setting the cross coefficient to zero. (`ofMode`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L60)).

**Point coefficients for a labeled mode.** Definition. The point coefficients of a labeled mode are the coefficients obtained from the piece weights, harmonic bounds, scalar weight, and azimuthal order. (`modeCoef`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L68)).

**The quadratic density of a labeled mode.** Definition. The labeled quadratic evaluates the point quadratic on square roots of mode Hessian, curl-gradient, gradient, curl, and velocity energies. (`labelQuad`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L72)).

**Mode density as a labeled quadratic.** Proved result. Mode density equals the labeled quadratic. (`modeTerm_eq_labelQuad`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L86)).

**Angular mode bounds on the half-plane.** Proposition definition. This proposition requires angular mode relations to hold almost everywhere on the half-plane for perturbations of positive period. (`AngularModeBounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L96)).

**Finite weighted label-gradient energy.** Proposition definition. This proposition requires every labeled mode gradient to have finite cylindrical-weighted square energy on the half-plane. (`LabelGradFinite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L103)).

**Uniform coefficient lower bounds.** Proposition definition. This proposition requires admissible weights and valid set-piece bounds to give coefficient domination throughout the specified mode set and region. (`UniformCoefficientBounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L114)).

**Soundness of off-mode conditions.** Proposition definition. This proposition requires certified off-mode conditions to make their charged densities nonnegative almost everywhere in the certified region. (`OffModeConditionSound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L122)).

**Reflection parity of a labeled velocity.** Proposition definition. Label reflection parity relates reflected-height velocity modes to the flipped harmonic label with the coordinate frame signs, almost everywhere on the half-plane. (`IsFlipEven`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L131)).

**Symmetry gives label reflection parity.** Interface. This proposition requires inclusion of the prescribed reflection symmetry to give almost-everywhere label reflection parity for positive-period perturbations. (`LabelFlipEvenHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L135)). Proof route: `Breakdown.CertCell.TailBand.labelFlipEvenHolds`.

**The ray-exterior inverse-square estimate.** Proposition definition. This proposition bounds cylindrical-weighted inverse-square velocity energy in a ray exterior by gradient energy, with a constant depending on angular frequency. (`ModeRayInverseSquare`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L139)).

**Square-exterior inverse-square estimate.** Proposition definition. This proposition bounds twice the cylindrical-weighted inverse-square energy on a square exterior by gradient energy for zero-angular-frequency modes with reflection parity. (`ModeSquareInverseSquare`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L146)).

**Soundness of exterior conditions.** Proposition definition. This proposition requires certified exterior conditions, including reflection parity in the zero-frequency square case, to bound the negative density integral by the positive one. (`ExteriorConditionSound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L153)).

**Soundness from angular coefficient data.** Proved result. Angular mode inequalities, the pointwise quadratic test, and uniform coefficient domination imply nonnegative charged off-mode densities almost everywhere in their certified regions. (`offModeConditionSound_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TailStatements.lean#L164)).

### Breakdown.CertCell.ThreeHalves

This file combines line estimates in three coordinate directions and the three-slice inequality to prove the scalar three-halves gradient bound. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**A spatial point from three coordinates.** Definition. The coordinate constructor makes the three-dimensional Euclidean vector with the supplied first, second, and third coordinates. (`pt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L9)).

**The coordinate map preserves volume.** Proved result. The coordinate map preserves volume. (`pt_preserving`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L11)).

**Coordinate substitution is measurable.** Proved result. Coordinate substitution is measurable. (`measurable_pt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L26)).

**First-axis translation changes x only.** Proved result. First-axis translation changes x only. (`pt_add_first`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L31)).

**Second-axis translation changes y only.** Proved result. Second-axis translation changes y only. (`pt_add_second`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L35)).

**Third-axis translation changes z only.** Proved result. Third-axis translation changes z only. (`pt_add_third`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L39)).

**Spatial points are coordinate basis sums.** Proved result. Spatial points are coordinate basis sums. (`pt_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L43)).

**Spatial integration is a triple integral.** Proved result. Spatial integration is a triple integral. (`lintegral_space_eq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L48)).

**The two inner integrals may be swapped.** Proved result. The two inner integrals may be swapped. (`swap_inner`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L58)).

**The two outer integrals may be swapped.** Proved result. The two outer integrals may be swapped. (`swap_outer`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L65)).

**Real and lower integrals of positives.** Proved result. For a nonnegative real function, its real integral embedded into the nonnegative extended reals is at most its lower integral. (`ofReal_integral_le_lintegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L73)).

**Coordinate sum is bounded by the norm.** Proved result. The sum of the absolute values of a linear functional on the three unit coordinate vectors is at most the square root of three times its operator norm. (`sum_abs_apply_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L80)).

**Three-halves gradient estimate is proved.** Proved result. The three-slice and coordinate-line estimates bound the L to the power 3/2 norm of a compactly supported C¹ scalar function by its derivative L1 norm divided by 2√3. (`threeHalvesGradientBound_of`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/ThreeHalves.lean#L106)).

### Breakdown.CertCell.TopStatements

This file assembles the signed half-plane form, exterior terms, row and pair shares, normalized pressure and gauge-fixed tree state into the final cell-layer coercivity clause. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**The scalar terms in the coercive form.** Definition. The scalar form combines the weighted multiplier square and subtracts actuator pairings, row energy, and pin energy. (`formScalarWith`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L34)).

**Half-plane bound with separate constants.** Proposition definition. The half-plane condition requires a finite negative form part and the signed integral inequality with separate form and multiplier coercivity constants. (`HalfPlaneFormBoundWith`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L47)).

**The half-plane coercivity bound.** Proposition definition. The chosen half-plane bound uses the layer's coercivity for both the form and multiplier constants. (`HalfPlaneFormBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L59)).

**The real value of the signed form.** Definition. The real signed form value is the positive part minus the negative part minus the scalar form divided by 4π. (`formValueWith`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L62)).

**Finiteness of the negative form part.** Proposition definition. Negative-form finiteness requires the negative part to be finite for every admissible parameter and perturbation. (`FormNegFinite`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L68)).

**Nonnegativity of the signed form value.** Proposition definition. Form nonnegativity requires a nonnegative real signed value for admissible forcing whenever the positive form part is finite. (`FormValueNonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L72)).

**The form value of an admissible tuple.** Definition. An admissible tuple's value evaluates the signed form on its velocity, derivatives, multipliers, and forcing. (`value`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L80)).

**Uniform mode-coefficient lower bounds.** Proposition definition. The coefficient lower-bound condition uses one constant for all modes and points, with the velocity coefficient multiplied by radius squared. (`CoefficientLowerBounds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L84)).

**Coefficient bounds give finite negatives.** Interface. This proposition requires coefficient lower bounds and a weak Hessian model to make the negative form finite when the azimuthal order is at least one. (`FormNegFiniteHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L97)). Proof route: `Breakdown.CertCell.formNegFinite`.

**A signed bound from form nonnegativity.** Proved result. Finite negative form and nonnegative real form value imply the signed half-plane inequality, including the case of an infinite positive part. (`halfPlaneFormBoundWith_of_value`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L102)).

**The actuator-multiplier pairing identity.** Interface. This proposition equates the period pairing of an actuator and multiplier field with the corresponding multiplier right-hand expression under admissibility and actuator assumptions. (`ActuatorPairingHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L128)). Proof route: `Breakdown.CertCell.actuatorPairing_of_solenoidal_and_gradient`, `Breakdown.CertCell.actuatorPairing_holds`.

**The positive exterior contribution.** Definition. The positive exterior contribution sums positive labeled densities and the positive averaged stretching density over the half-plane exterior. (`extPos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L137)).

**The negative exterior contribution.** Definition. The negative exterior contribution sums negative labeled densities and the negative averaged stretching density over the half-plane exterior. (`extNeg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L142)).

**Averaging the forcing with its flip.** Definition. Reflection averaging takes half the sum of the forcing and its reflected input-and-output field. (`flipAverage`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L147)).

**Zero off-mode negative cell terms.** Proposition definition. The off-mode condition requires every cell's negative off-mode contribution to be zero for admissible parameters and perturbations. (`OffModesVanish`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L159)).

**A finite nonnegative exterior term.** Proposition definition. Exterior nonnegativity requires the negative exterior contribution to be finite and at most the positive contribution. (`ExteriorNonneg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L163)).

**Row shares recover the global row term.** Proposition definition. Row-share matching identifies the sum of cell row shares with the coercivity-weighted global row square divided by 4π. (`RowSharesMatch`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L167)).

**Pair shares are at most global pairing.** Proposition definition. Pair-share control bounds the cell pairings by actuator and pin pairings, a multiplier error budget, and strain slack. (`PairSharesBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L171)).

**Credit leaves are at most cell credits.** Proposition definition. Credit-leaf control bounds twice the sum of credit quadratic forms by the cell credit shares. (`CreditLeavesBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L178)).

**Recovery of a periodic pressure gradient.** Proposition definition. Pressure recovery requires the reflected forcing residual after subtracting the perturbation, diffusion, coupling, and actuator terms to be a periodic pressure gradient. (`PressureRecovered`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L183)).

**Initial state bounds from cell estimates.** Interface. This proposition combines cell form bounds, exterior and off-mode control, shares, credits, and the multiplier error budget into the initial state bound. (`InitialStateHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L195)). Proof route: `Breakdown.CertCell.Assembly.initialStateHolds_of_split`, `Breakdown.CertCell.Assembly.initialStateHolds_of_formSplit`, `Breakdown.CertCell.initialState_closed`.

**Tree reduction gives form nonnegativity.** Proposition definition. Tree reduction is the implication from pressure recovery and the initial state bound to nonnegativity of the real signed form. (`TreeReduction`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L205)).

**Row shares from instance rows.** Interface. This proposition requires the instance row-class theorem, a valid instance entry, and a mode-class symmetry to imply global row-share matching. (`RowSharesOfInstanceHolds`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L208)). Proof route: `Breakdown.CertCell.Internal.RowShares.rowSharesOfInstance_of_regular`, `Breakdown.CertCell.rowSharesOfInstance`.

**The chosen pressure-gradient field.** Definition. The chosen pressure field is the reflection-averaged forcing minus the perturbation, diffusion, model coupling, and actuator residual. (`chosenPressure`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L213)).

**A potential normalized by its ball mean.** Definition. The head potential subtracts the average of the selected potential over the unit ball. (`headPotential`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L218)).

**The normalized potential's pressure mode.** Definition. The head pressure mode takes the layout's pressure Fourier mode of the mean-normalized potential. (`headPressure`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L221)).

**Cell-head data with normalized pressure.** Definition. Head data replace pressure-segment moments with moments of the mean-normalized pressure potential and retain the other true layout data. (`headData`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L224)).

**Complex head data from real harmonics.** Definition. Complex harmonic head data add the cosine-tuple data to i times the sine-tuple data. (`headHarmonic`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L229)).

**Values of all skeleton keys.** Definition. Skeleton values evaluate velocity, gradient, pressure, corner, and stream moments, with the private placeholder assigned zero. (`keyValue`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L233)).

**Complex harmonic skeleton-key values.** Definition. Complex harmonic skeleton values add the cosine-tuple value to i times the sine-tuple value. (`keyHarmonic`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L250)).

**The matrix of deleted-key gauge values.** Definition. The gauge matrix evaluates each gauge direction on each deleted skeleton key. (`gaugeMatrix`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L259)).

**Gauge coefficients by matrix inversion.** Definition. Gauge coefficients are the negative inverse-matrix contraction of the deleted-key harmonic values. (`fieldGauge`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L262)).

**Gauge coefficients of admissible tuples.** Definition. An admissible tuple's gauge coefficients use its velocity and derivatives together with the chosen pressure residual. (`gaugeValue`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L267)).

**The head vector for a cell.** Definition. A cell head vector inserts harmonic head data and multiplier coordinates and assigns zero to the other index branches. (`fieldHead`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L270)).

**The gauge-shifted cell-head vector.** Definition. The shifted cell-head vector adds the gauge coefficients times the corresponding gauge directions. (`fieldShifted`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L276)).

**The gauge-shifted skeleton-key value.** Definition. The shifted skeleton value adds the gauge coefficients times their skeleton-key directions to the harmonic key value. (`fieldKey`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L281)).

**Real values of selected tree data.** Definition. Tree data select a real or imaginary shifted cell value, a multiplier coordinate, or a shifted skeleton value, and default to zero when none applies. (`fieldData`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L286)).

**Cell-head state of an admissible tuple.** Definition. The head state evaluates the cell-head vector on an admissible tuple and its chosen pressure field. (`headState`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L300)).

**The shifted state of an admissible tuple.** Definition. The shifted state evaluates the gauge-shifted cell-head vector on an admissible tuple and its chosen pressure field. (`shiftedState`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L304)).

**The actual real data in the tree.** Definition. The true tree data evaluate the selected real tree coordinates on an admissible tuple. (`trueData`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L308)).

**The signed-state tree certificate.** Definition. The signed-state certificate combines the tree's slaved and free coordinates, base point, true data, free map, and quadratic tree. (`certificate`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L311)).

**A valid tree state from initial bounds.** Proposition definition. This proposition requires pressure recovery and the initial bound to produce a nonpositive base value and a valid signed state for every tree front. (`TreeStateFromInitial`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L324)).

**Form nonnegativity from the tree state.** Proved result. A certified tree satisfying the tree conditions and the initial-to-state implication turns recovered pressure and the initial bound into nonnegative signed form value. (`treeReduction_of_tree`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L333)).

**The cell-level assembly junctions.** Proposition structure. The cell junction package requires vanishing off-modes, a nonnegative exterior, pressure recovery, cell residual bounds, and a tree state from the initial bound. (`CellJunctions`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L342)).

**Coefficient bounds from entry conditions.** Proved result. Certified coefficient entries, matching coercivity, and uniform weak admissibility yield one uniform lower bound for all mode coefficients, weighting the velocity coefficient by radius squared. (`coefficientLowerBounds_of_entries`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L350)).

**Junction facts for a whole cell layer.** Proposition structure. The layer junction package records admissibility, reflection, actuator shapes, and a reflection-invariant weak Hessian model. (`LayerJunctionFacts`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L383)).

**Instance consequences of cell hypotheses.** Proved result. Cell hypotheses give instance consequences. (`instanceConsequences_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L391)).

**Uniform admissibility from cell data.** Proved result. Cell hypotheses give uniform admissibility. (`admissible_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L396)).

**The pair-share error budget.** Proved result. Cell hypotheses give a pair-share error budget. (`pairSharesBound_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L406)).

**Cell hypotheses bound the credit leaves.** Proved result. Cell hypotheses bound the credit leaves. (`creditLeavesBound_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L419)).

**Cell hypotheses identify the density.** Proved result. Cell hypotheses identify the density. (`densityIdentity_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L485)).

**Cell hypotheses give all layer junctions.** Proved result. Cell hypotheses give all layer junctions. (`layerJunctionFacts_of_hypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L500)).

**The row-rest clause from cell data.** Proved result. The cell hypothesis gives the row-rest clause. (`rowRestClause_of_cellHypothesis`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L509)).

**The cell layer gives extended coercivity.** Proved result. The cell layer gives extended coercivity. (`extendedCoerciveClause_of_cellLayer`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TopStatements.lean#L526)).

### Breakdown.CertCell.TraceFlip

This file derives reflection of weak traces from the established trace-matching contract. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Weak traces respect reflection.** Proved result. Weak traces respect reflection. (`traceFlip`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceFlip.lean#L11)).

### Breakdown.CertCell.TraceHeight

This file represents a weak height derivative by an absolutely continuous primitive and shows that the trace formula recovers its integration constant. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Linear components keep the weak identity.** Proved result. Linear components preserve the weak identity. (`weak_identity_component`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L15)).

**Interior intervals inherit integrability.** Proved result. Interior intervals inherit integrability. (`interval_integrable_inside`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L48)).

**Primitives for weak derivatives a.e..** Proved result. Weak height derivatives have primitives almost everywhere. (`weak_primitive_representative`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L54)).

**Primitive integral has a linear weight.** Proved result. The primitive integral has a linear weight. (`integral_primitive_eq_weighted`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L76)).

**Primitive constants from upper traces.** Proved result. The upper trace recovers the primitive constant. (`upperTrace_primitive`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L114)).

**Weak height traces from primitives.** Proved result. A weak height derivative recovers the height-trace relation through its almost-everywhere primitive. (`traceHeight`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceHeight.lean#L143)).

### Breakdown.CertCell.TraceMatch

This file approximates a symmetric hat function by smooth tests to show that weak traces taken from opposite sides agree. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Smooth approximation to positive parts.** Definition. The ramp profile multiplies its argument by the smooth transition from zero to one. (`rampProfile`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L14)).

**The ramp profile is infinitely smooth.** Proved result. The ramp profile is infinitely smooth. (`rampProfile_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L16)).

**The ramp profile is zero below zero.** Proved result. The ramp profile is zero below zero. (`rampProfile_of_nonpos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L19)).

**The ramp profile equals z above one.** Proved result. The ramp profile equals z above one. (`rampProfile_of_one_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L22)).

**The ramp derivative is zero below zero.** Proved result. The ramp derivative is zero below zero. (`deriv_rampProfile_of_neg`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L25)).

**The ramp derivative is one above one.** Proved result. The ramp derivative is one above one. (`deriv_rampProfile_of_one_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L31)).

**The ramp derivative is globally bounded.** Proved result. The absolute derivative of the ramp profile has one finite bound valid on the whole real line. (`deriv_rampProfile_bound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L37)).

**The rescaled smooth ramp.** Definition. The smooth ramp at width ε is ε times the base ramp evaluated at the argument divided by ε. (`rampAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L51)).

**The rescaled ramp is infinitely smooth.** Proved result. The rescaled ramp is infinitely smooth. (`rampAt_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L53)).

**Differentiating the rescaled ramp.** Proved result. For positive smoothing width, the rescaled ramp derivative is the profile derivative at the argument divided by that width. (`rampAt_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L56)).

**The rescaled ramp is zero below zero.** Proved result. The rescaled ramp is zero below zero. (`rampAt_of_nonpos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L68)).

**Rescaled ramp equals z beyond its width.** Proved result. The rescaled ramp equals z beyond its width. (`rampAt_of_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L71)).

**The rescaled ramp is bounded by |z|.** Proved result. For positive smoothing width, the absolute value of the rescaled ramp is at most the absolute value of its argument. (`abs_rampAt_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L76)).

**The step function at zero.** Definition. The step function is one for positive arguments and zero otherwise. (`stepFn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L84)).

**The step function is monotone.** Proved result. The step function is monotone. (`stepFn_monotone`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L86)).

**The smooth symmetric hat approximation.** Definition. The smooth symmetric hat takes the second centered difference of the smooth ramp and divides by the hat width. (`hatApprox`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L95)).

**The piecewise linear symmetric hat.** Definition. The piecewise linear hat takes the second centered difference of the positive-part function and divides by the hat width. (`hatFn`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L98)).

**Piecewise constant symmetric hat slope.** Definition. The hat slope takes the second centered difference of the step function and divides by the hat width. (`hatSlope`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L100)).

**The weak pairing with a symmetric hat.** Definition. The weak hat pairing is the function times the hat slope plus its candidate derivative times the hat value. (`hatPairing`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L102)).

**The smooth hat is infinitely smooth.** Proved result. The smooth hat is infinitely smooth. (`hatApprox_contDiff`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L105)).

**The three-term smooth hat slope.** Proved result. The smooth hat derivative is the difference of three shifted ramp slopes with coefficients one, minus two, and one, divided by the hat width. (`hatApprox_hasDerivAt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L112)).

**The three-term smooth hat derivative.** Proved result. The derivative of the smooth hat equals its three shifted ramp derivatives with coefficients one, minus two, and one, divided by the hat width. (`deriv_hatApprox`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L126)).

**Smooth hat vanishes outside its support.** Proved result. The smooth hat vanishes outside its support. (`hatApprox_eq_zero`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L131)).

**A support interval for the smooth hat.** Proved result. For positive hat and smoothing widths, the smooth hat's support is contained in [−h,h+ε]. (`hatApprox_tsupport`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L142)).

**Uniform smooth hat derivative bounds.** Proved result. For positive hat and smoothing widths, a global ramp-slope bound M gives smooth-hat derivative bound 4M/h. (`abs_deriv_hatApprox_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L148)).

**The smooth hat has a uniform bound.** Proved result. The smooth hat has a uniform bound. (`abs_hatApprox_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L157)).

**The smoothing scale is positive.** Proved result. The smoothing scale is positive. (`seq_pos`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L169)).

**Smoothing scale is below its upper bound.** Proved result. The smoothing scale is below its upper bound. (`seq_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L171)).

**Smoothing scale eventually becomes small.** Proved result. The smoothing scale eventually becomes small. (`seq_eventually_lt`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L175)).

**Smooth ramps approach the positive part.** Proved result. Smooth ramps eventually match the positive part. (`rampAt_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L185)).

**Ramp derivatives approach the step.** Proved result. Ramp derivatives eventually match the step. (`rampSlope_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L193)).

**Smooth hats approach the hat function.** Proved result. Smooth hats eventually match the hat function. (`hatApprox_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L202)).

**Smooth hat slopes approach the hat slope.** Proved result. Smooth hat slopes eventually match the hat slope. (`deriv_hatApprox_eventually`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L208)).

**The hat pairing vanishes on the left.** Proved result. The hat pairing vanishes on the left. (`hatPairing_outer_left`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L215)).

**The hat pairing vanishes on the right.** Proved result. The hat pairing vanishes on the right. (`hatPairing_outer_right`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L228)).

**The lower weak hat pairing.** Proved result. On the negative half of a positive-width hat, the pairing is the derivative times 1+z/h plus the value divided by h. (`hatPairing_lower`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L241)).

**The upper weak hat pairing.** Proved result. On the positive half of a positive-width hat, the pairing is the derivative times 1−z/h minus the value divided by h. (`hatPairing_upper`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L257)).

**Absolute bound for the step function.** Proved result. The step function has absolute value at most 1. (`abs_stepFn_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L272)).

**The hat slope has a uniform bound.** Proved result. The hat slope has a uniform bound. (`abs_hatSlope_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L276)).

**The hat function has a uniform bound.** Proved result. The hat function has a uniform bound. (`abs_hatFn_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L284)).

**The hat slope is measurable.** Proved result. The hat slope is measurable. (`hatSlope_measurable`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L290)).

**The hat function is continuous.** Proved result. The hat function is continuous. (`hatFn_continuous`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L297)).

**Weak upper and lower traces match.** Proved result. Weak upper and lower traces match. (`traceMatch`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TraceMatch.lean#L301)).

### Breakdown.CertCell.TripleSlice

This file proves the three-slice product estimate by repeated Cauchy-Schwarz for nonnegative integrals. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Cauchy-Schwarz for square-root products.** Proved result. For almost-everywhere measurable nonnegative extended-valued functions, the integral of their square-root product is at most the product of the square roots of their integrals. (`lintegral_sqrt_mul_sqrt_le`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TripleSlice.lean#L9)).

**The three-slice product bound is proved.** Proved result. For three nonnegative measurable functions depending on the coordinate pairs, the triple integral of their square-root product is at most the square root of the product of their three planar integrals. (`tripleSliceBound`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/TripleSlice.lean#L20)).

### Breakdown.CertCell.VelocitySixthIntegral

This file converts the weak sixth-power Sobolev bound into time integrability of the velocity L6 norm. Appendix B, weak cell calculus, exterior estimates, and the cell-to-tree coercivity route; the file is supporting library rather than a separate numbered paper claim.

**Matrix square energy is continuous.** Proved result. Matrix square energy is continuous. (`continuous_matSq`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L15)).

**Matrix square energy is nonnegative.** Proved result. Matrix square energy is nonnegative. (`matSq_nonneg'`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L19)).

**A sixth-root bound using a cube root.** Proved result. For every nonnegative extended-real number, its sixth root is at most one plus its cube root. (`rpow_sixth_le_one_add_rpow_third`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L23)).

**Real and finite positive integrals agree.** Proved result. Finite positive integrals match real integrals. (`ofReal_integral_eq_lintegral_of_lt_top`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L29)).

**Gradient energy controls the sixth root.** Proved result. The weak sixth-power estimate bounds the spatial L6 norm by one plus the nonnegative part of its constant times total weak-gradient energy when both energies are finite. (`sixth_root_le_of_gradient`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L35)).

**Finite time-integrated velocity L6 norm.** Proved result. The time-integrated velocity L6 norm is finite. (`velocitySixthIntegral`; [source](https://github.com/tristanbuckmaster/navier-stokes/blob/ad53419de079eb8f95f60313473374624a348546/lean/Breakdown/CertCell/VelocitySixthIntegral.lean#L52)).
