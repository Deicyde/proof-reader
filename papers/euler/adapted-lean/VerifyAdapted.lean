import Adapted

/-! Verification of every indexed target, declaration kind and axiom set. -/

#check Adapted.S1.theorem_1_1
#check Adapted.S1.remark_1_2
#check Adapted.S1.lemma_1_3
#check Adapted.S2.lemma_2_1
#check Adapted.S2.lemma_2_2
#check Adapted.S2.lemma_2_3
#check Adapted.S2.lemma_2_4
#check Adapted.S2.lemma_2_5
#check Adapted.S2.lemma_2_6
#check Adapted.S2.lemma_2_7
#check Adapted.S2.proposition_2_8
#check Adapted.S3.lemma_3_1
#check Adapted.S4.lemma_4_1
#check Adapted.S4.theorem_4_2
#check Adapted.S5.proposition_5_1
#check Adapted.S5.proposition_5_2
#check Adapted.S5.lemma_5_3
#check Adapted.S5.proposition_5_4
#check Adapted.S5.lemma_5_5
#check Adapted.S5.theorem_5_6
#check Adapted.S5.lemma_5_7
#check Adapted.S5.lemma_5_8
#check Adapted.S5.lemma_5_9
#check Adapted.S5.lemma_5_10
#check Adapted.S5.proposition_5_11
#check Adapted.S6.lemma_6_1
#check Adapted.S7.theorem_7_1
#check Adapted.S8.proposition_8_1
#check Adapted.S8.proposition_8_2
#check Adapted.S8.corollary_8_3
#check Adapted.S8.proposition_8_4
#check Adapted.SA.theorem_A_1
#check Adapted.SA.lemma_A_2
#check Adapted.SB.lemma_B_1
#check Adapted.SD.eq_D_2
#check Adapted.SD.lemma_D_1
#check Adapted.SD.lemma_D_2
#check Adapted.SD.lemma_D_3
#check Adapted.S8.section8_setting
#check Adapted.S5.eq_5_59
#check Adapted.S5.eq_5_13
#check Adapted.S5.eq_5_14
example : Prop := Adapted.S7.theorem_7_1

open Lean in
run_cmd do
  let env ← getEnv
  match env.find? `Adapted.S1.theorem_1_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S1.theorem_1_1"
  match env.find? `Adapted.S1.remark_1_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S1.remark_1_2"
  match env.find? `Adapted.S1.lemma_1_3 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S1.lemma_1_3"
  match env.find? `Adapted.S2.lemma_2_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_1"
  match env.find? `Adapted.S2.lemma_2_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_2"
  match env.find? `Adapted.S2.lemma_2_3 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_3"
  match env.find? `Adapted.S2.lemma_2_4 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_4"
  match env.find? `Adapted.S2.lemma_2_5 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_5"
  match env.find? `Adapted.S2.lemma_2_6 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_6"
  match env.find? `Adapted.S2.lemma_2_7 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.lemma_2_7"
  match env.find? `Adapted.S2.proposition_2_8 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S2.proposition_2_8"
  match env.find? `Adapted.S3.lemma_3_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S3.lemma_3_1"
  match env.find? `Adapted.S4.lemma_4_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S4.lemma_4_1"
  match env.find? `Adapted.S4.theorem_4_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S4.theorem_4_2"
  match env.find? `Adapted.S5.proposition_5_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.proposition_5_1"
  match env.find? `Adapted.S5.proposition_5_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.proposition_5_2"
  match env.find? `Adapted.S5.lemma_5_3 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_3"
  match env.find? `Adapted.S5.proposition_5_4 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.proposition_5_4"
  match env.find? `Adapted.S5.lemma_5_5 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_5"
  match env.find? `Adapted.S5.theorem_5_6 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.theorem_5_6"
  match env.find? `Adapted.S5.lemma_5_7 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_7"
  match env.find? `Adapted.S5.lemma_5_8 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_8"
  match env.find? `Adapted.S5.lemma_5_9 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_9"
  match env.find? `Adapted.S5.lemma_5_10 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.lemma_5_10"
  match env.find? `Adapted.S5.proposition_5_11 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.proposition_5_11"
  match env.find? `Adapted.S6.lemma_6_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S6.lemma_6_1"
  match env.find? `Adapted.S7.theorem_7_1 with
  | some (.defnInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S7.theorem_7_1"
  match env.find? `Adapted.S8.proposition_8_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S8.proposition_8_1"
  match env.find? `Adapted.S8.proposition_8_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S8.proposition_8_2"
  match env.find? `Adapted.S8.corollary_8_3 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S8.corollary_8_3"
  match env.find? `Adapted.S8.proposition_8_4 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S8.proposition_8_4"
  match env.find? `Adapted.SA.theorem_A_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SA.theorem_A_1"
  match env.find? `Adapted.SA.lemma_A_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SA.lemma_A_2"
  match env.find? `Adapted.SB.lemma_B_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SB.lemma_B_1"
  match env.find? `Adapted.SD.eq_D_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SD.eq_D_2"
  match env.find? `Adapted.SD.lemma_D_1 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SD.lemma_D_1"
  match env.find? `Adapted.SD.lemma_D_2 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SD.lemma_D_2"
  match env.find? `Adapted.SD.lemma_D_3 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.SD.lemma_D_3"
  match env.find? `Adapted.S8.section8_setting with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S8.section8_setting"
  match env.find? `Adapted.S5.eq_5_59 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.eq_5_59"
  match env.find? `Adapted.S5.eq_5_13 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.eq_5_13"
  match env.find? `Adapted.S5.eq_5_14 with
  | some (.thmInfo _) => pure ()
  | _ => throwError "Unexpected declaration kind: Adapted.S5.eq_5_14"
  match env.find? `Adapted.S1.theorem_1_1 with
  | some (.thmInfo info) =>
    if info.type.isForall then throwError "The main theorem has an unexpected parameter"
  | _ => throwError "The main theorem is missing"
  logInfo "All 42 declaration kinds match TARGETS.json; the main theorem has no outer parameters."

#print axioms Adapted.S1.theorem_1_1
#print axioms Adapted.S1.remark_1_2
#print axioms Adapted.S1.lemma_1_3
#print axioms Adapted.S2.lemma_2_1
#print axioms Adapted.S2.lemma_2_2
#print axioms Adapted.S2.lemma_2_3
#print axioms Adapted.S2.lemma_2_4
#print axioms Adapted.S2.lemma_2_5
#print axioms Adapted.S2.lemma_2_6
#print axioms Adapted.S2.lemma_2_7
#print axioms Adapted.S2.proposition_2_8
#print axioms Adapted.S3.lemma_3_1
#print axioms Adapted.S4.lemma_4_1
#print axioms Adapted.S4.theorem_4_2
#print axioms Adapted.S5.proposition_5_1
#print axioms Adapted.S5.proposition_5_2
#print axioms Adapted.S5.lemma_5_3
#print axioms Adapted.S5.proposition_5_4
#print axioms Adapted.S5.lemma_5_5
#print axioms Adapted.S5.theorem_5_6
#print axioms Adapted.S5.lemma_5_7
#print axioms Adapted.S5.lemma_5_8
#print axioms Adapted.S5.lemma_5_9
#print axioms Adapted.S5.lemma_5_10
#print axioms Adapted.S5.proposition_5_11
#print axioms Adapted.S6.lemma_6_1
#print axioms Adapted.S8.proposition_8_1
#print axioms Adapted.S8.proposition_8_2
#print axioms Adapted.S8.corollary_8_3
#print axioms Adapted.S8.proposition_8_4
#print axioms Adapted.SA.theorem_A_1
#print axioms Adapted.SA.lemma_A_2
#print axioms Adapted.SB.lemma_B_1
#print axioms Adapted.SD.eq_D_2
#print axioms Adapted.SD.lemma_D_1
#print axioms Adapted.SD.lemma_D_2
#print axioms Adapted.SD.lemma_D_3
#print axioms Adapted.S8.section8_setting
#print axioms Adapted.S5.eq_5_59
#print axioms Adapted.S5.eq_5_13
#print axioms Adapted.S5.eq_5_14
