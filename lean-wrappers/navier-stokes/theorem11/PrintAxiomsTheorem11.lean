/-
NOT COMPILED at authoring. Run only after every imported wrapper builds.
The full physical endpoints are deliberately absent: they are not proved here.
-/
import Theorem11Solution
import Theorem11TorusHelpers
import Theorem11TorusRates
import Theorem11TorusConvergence
import Theorem11TorusMildExport
import Theorem11ContractFacts
import Theorem11GeometricRate
import Theorem11NormAssembly

#print axioms Theorem11Rate.norm_window
#print axioms Theorem11Rate.undo_quarter_scaling
#print axioms Theorem11Rate.power_error_small
#print axioms Theorem11Rate.late_rate
#print axioms Theorem11Rate.globalize_rate
#print axioms Theorem11GeometricRate.geometric_decay_exponent
#print axioms Theorem11GeometricRate.geometric_coefficient_eq
#print axioms Theorem11.finiteH1On_and_h1NormOn_eq_split
#print axioms Theorem11Core.norm_sq_eq_sum_partial
#print axioms Theorem11Core.gradient_reading
#print axioms Theorem11Core.mild_ne_zero_of_late_rate
#print axioms Theorem11Core.space_core
#print axioms Theorem11Core.local_velocity_unique
#print axioms Theorem11Core.partial_reading_of_smooth
#print axioms Theorem11Core.gradient_reading_of_smooth
#print axioms Theorem11Core.rescaled_gradient_reading
#print axioms Theorem11Core.local_physical_quantitative
#print axioms Theorem11.theorem11SpaceCore
#print axioms Theorem11.theorem11SpaceLocal
#print axioms Theorem11.theorem11SpaceSlabs
#print axioms Breakdown.Theorem11.Torus.norm_toV_eq_physicalH1
#print axioms Breakdown.Theorem11.Torus.approxPeriodic_eq_selfSimilar_on_innerBall
#print axioms Breakdown.Theorem11.Torus.local_fullH1_profile_error_le_periodic_error
#print axioms Breakdown.Theorem11.Torus.glued_eventual_two_sided_rate
#print axioms Breakdown.Theorem11.Torus.glued_approx_error_le_power
#print axioms Breakdown.Theorem11.Torus.rescaled_glued_approx_error_le_power
#print axioms Breakdown.Theorem11.Torus.torus_mild_blowup_of_profile
#print axioms Theorem11.comparisonField_one_zero
#print axioms Theorem11.rescaleAtOne_zero
#print axioms Theorem11.gradientNorm_eq_norm_of_sq_eq
