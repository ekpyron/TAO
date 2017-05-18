(*<*)
theory TAO_2_Semantics
imports TAO_1_Embedding "~~/src/HOL/Eisbach/Eisbach"
begin
(*>*)

section{* Semantics *}
text{* \label{TAO_Semantics} *}

subsection{* Definition *}
text{* \label{TAO_Semantics_Semantics} *}

locale Semantics
begin
  named_theorems semantics

  subsubsection{* Semantical Domains *}
  text{* \label{TAO_Semantics_Semantics_Domains} *}
  type_synonym R\<^sub>\<kappa> = "\<nu>"
  type_synonym R\<^sub>0 = "j\<Rightarrow>i\<Rightarrow>bool"
  type_synonym R\<^sub>1 = "\<upsilon>\<Rightarrow>R\<^sub>0"
  type_synonym R\<^sub>2 = "\<upsilon>\<Rightarrow>\<upsilon>\<Rightarrow>R\<^sub>0"
  type_synonym R\<^sub>3 = "\<upsilon>\<Rightarrow>\<upsilon>\<Rightarrow>\<upsilon>\<Rightarrow>R\<^sub>0"
  type_synonym W = i

  subsubsection{* Denotation Functions *}
  text{* \label{TAO_Semantics_Semantics_Denotations} *}

  lift_definition d\<^sub>\<kappa> :: "\<kappa>\<Rightarrow>R\<^sub>\<kappa> option" is id .
  lift_definition d\<^sub>0 :: "\<Pi>\<^sub>0\<Rightarrow>R\<^sub>0 option" is id .
  lift_definition d\<^sub>1 :: "\<Pi>\<^sub>1\<Rightarrow>R\<^sub>1 option" is id .
  lift_definition d\<^sub>2 :: "\<Pi>\<^sub>2\<Rightarrow>R\<^sub>2 option" is id .
  lift_definition d\<^sub>3 :: "\<Pi>\<^sub>3\<Rightarrow>R\<^sub>3 option" is id .

  subsubsection{* Actual World *}
  text{* \label{TAO_Semantics_Semantics_Actual_World} *}
  definition w\<^sub>0 where "w\<^sub>0 \<equiv> dw"

  subsubsection{* Exemplification Extensions *}
  text{* \label{TAO_Semantics_Semantics_Exemplification_Extensions} *}

  definition ex0 :: "R\<^sub>0\<Rightarrow>W\<Rightarrow>bool"
    where "ex0 \<equiv> \<lambda> F . F dj"
  definition ex1 :: "R\<^sub>1\<Rightarrow>W\<Rightarrow>(R\<^sub>\<kappa> set)"
    where "ex1 \<equiv> \<lambda> F w . { x . F (\<nu>\<upsilon> x) dj w }"
  definition ex2 :: "R\<^sub>2\<Rightarrow>W\<Rightarrow>((R\<^sub>\<kappa>\<times>R\<^sub>\<kappa>) set)"
    where "ex2 \<equiv> \<lambda> F w . { (x,y) . F (\<nu>\<upsilon> x) (\<nu>\<upsilon> y) dj w }"
  definition ex3 :: "R\<^sub>3\<Rightarrow>W\<Rightarrow>((R\<^sub>\<kappa>\<times>R\<^sub>\<kappa>\<times>R\<^sub>\<kappa>) set)"
    where "ex3 \<equiv> \<lambda> F w . { (x,y,z) . F (\<nu>\<upsilon> x) (\<nu>\<upsilon> y) (\<nu>\<upsilon> z) dj w }"

  subsubsection{* Encoding Extensions *}
  text{* \label{TAO_Semantics_Semantics_Encoding_Extension} *}

  definition en :: "R\<^sub>1\<Rightarrow>(R\<^sub>\<kappa> set)"
    where "en \<equiv> \<lambda> F . { x . case x of \<alpha>\<nu> y \<Rightarrow> (\<lambda> x . F x) \<in> y
                                       | _ \<Rightarrow> False }"

  subsubsection{* Collection of Semantical Definitions *}
  text{* \label{TAO_Semantics_Semantics_Definitions} *}

  named_theorems semantics_defs
  declare d\<^sub>0_def[semantics_defs] d\<^sub>1_def[semantics_defs]
          d\<^sub>2_def[semantics_defs] d\<^sub>3_def[semantics_defs]
          ex0_def[semantics_defs] ex1_def[semantics_defs]
          ex2_def[semantics_defs] ex3_def[semantics_defs]
          en_def[semantics_defs] d\<^sub>\<kappa>_def[semantics_defs]
          w\<^sub>0_def[semantics_defs]

  subsubsection{* Truth Conditions of Exemplification Formulas *}
  text{* \label{TAO_Semantics_Semantics_Exemplification} *}

  lemma T1_1[semantics]:
    "(w \<Turnstile> \<lparr>F,x\<rparr>) = (\<exists> r o\<^sub>1 . Some r = d\<^sub>1 F \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> o\<^sub>1 \<in> ex1 r w)"
    unfolding semantics_defs
    apply (simp add: meta_defs meta_aux rep_def proper_def)
    by (metis map_option_is_None option.collapse option.distinct(1) option.sel)

  lemma T1_2[semantics]:
    "(w \<Turnstile> \<lparr>F,x,y\<rparr>) = (\<exists> r o\<^sub>1 o\<^sub>2 . Some r = d\<^sub>2 F \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x
                               \<and> Some o\<^sub>2 = d\<^sub>\<kappa> y \<and> (o\<^sub>1, o\<^sub>2) \<in> ex2 r w)"
    unfolding semantics_defs
    apply (simp add: meta_defs meta_aux rep_def proper_def)
    by (metis map_option_is_None option.collapse option.distinct(1) option.sel)

  lemma T1_3[semantics]:
    "(w \<Turnstile> \<lparr>F,x,y,z\<rparr>) = (\<exists> r o\<^sub>1 o\<^sub>2 o\<^sub>3 . Some r = d\<^sub>3 F \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x
                                    \<and> Some o\<^sub>2 = d\<^sub>\<kappa> y \<and> Some o\<^sub>3 = d\<^sub>\<kappa> z
                                    \<and> (o\<^sub>1, o\<^sub>2, o\<^sub>3) \<in> ex3 r w)"
    unfolding semantics_defs
    apply (simp add: meta_defs meta_aux rep_def proper_def)
    by (metis map_option_is_None option.collapse option.distinct(1) option.sel)

  lemma T3[semantics]:
    "(w \<Turnstile> \<lparr>F\<rparr>) = (\<exists> r . Some r = d\<^sub>0 F \<and> ex0 r w)"
    unfolding semantics_defs
    apply (simp add: meta_defs meta_aux rep_def proper_def)
    by (metis (no_types, lifting) map_option_eq_Some option.sel)

  subsubsection{* Truth Conditions of Encoding Formulas *}
  text{* \label{TAO_Semantics_Semantics_Encoding} *}

  lemma T2[semantics]:
    "(w \<Turnstile> \<lbrace>x,F\<rbrace>) = (\<exists> r o\<^sub>1 . Some r = d\<^sub>1 F \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> o\<^sub>1 \<in> en r)"
    unfolding semantics_defs apply transfer apply simp
    by (metis not_None_eq option.map_ident option.sel proper.abs_eq rep.transfer)

  subsubsection{* Truth Conditions of Complex Formulas *}
  text{* \label{TAO_Semantics_Semantics_Complex_Formulas} *}

  lemma T4[semantics]: "(w \<Turnstile> \<^bold>\<not>\<psi>) = (\<not>(w \<Turnstile> \<psi>))"
    by (simp add: meta_defs meta_aux)

  lemma T5[semantics]: "(w \<Turnstile> \<psi> \<^bold>\<rightarrow> \<chi>) = (\<not>(w \<Turnstile> \<psi>) \<or> (w \<Turnstile> \<chi>))"
    by (simp add: meta_defs meta_aux)

  lemma T6[semantics]: "(w \<Turnstile> \<^bold>\<box>\<psi>) = (\<forall> v . (v \<Turnstile> \<psi>))"
    by (simp add: meta_defs meta_aux)

  lemma T7[semantics]: "(w \<Turnstile> \<^bold>\<A>\<psi>) = (dw \<Turnstile> \<psi>)"
    by (simp add: meta_defs meta_aux)

  lemma T8_\<nu>[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>\<nu> x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  lemma T8_0[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>0 x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  lemma T8_1[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>1 x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  lemma T8_2[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>2 x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  lemma T8_3[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>3 x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  lemma T8_\<o>[semantics]: "(w \<Turnstile> \<^bold>\<forall>\<^sub>\<o> x. \<psi> x) = (\<forall> x . (w \<Turnstile> \<psi> x))"
    by (simp add: meta_defs meta_aux)

  subsubsection{* Denotations of Descriptions  *}
  text{* \label{TAO_Semantics_Semantics_Descriptions} *}

  lemma D3[semantics]:
    "d\<^sub>\<kappa> (\<^bold>\<iota>x . \<psi> x) = (if (\<exists>x . (w\<^sub>0 \<Turnstile> \<psi> x) \<and> (\<forall> y . (w\<^sub>0  \<Turnstile> \<psi> y) \<longrightarrow> y = x))
                      then (Some (THE x . (w\<^sub>0 \<Turnstile> \<psi> x))) else None)"
    unfolding semantics_defs
    by (auto simp: meta_defs meta_aux)

  subsubsection{* Denotations of Lambda Expressions *}
  text{* \label{TAO_Semantics_Semantics_Lambda_Expressions} *}

  lemma D4_1[semantics]: "d\<^sub>1 (\<^bold>\<lambda> x . \<lparr>F\<^sup>P, x\<^sup>P\<rparr>) = d\<^sub>1 (F\<^sup>P)"
    by (simp add: meta_defs meta_aux rep_def proper_def totrm_def)
    
  lemma D4_2[semantics]: "d\<^sub>2 (\<^bold>\<lambda>\<^sup>2 (\<lambda> x y . \<lparr>F\<^sup>P, x\<^sup>P, y\<^sup>P\<rparr>)) = d\<^sub>2 (F\<^sup>P)"
    by (simp add: meta_defs meta_aux rep_def proper_def totrm_def)

  lemma D4_3[semantics]: "d\<^sub>3 (\<^bold>\<lambda>\<^sup>3 (\<lambda> x y z . \<lparr>F\<^sup>P, x\<^sup>P, y\<^sup>P, z\<^sup>P\<rparr>)) = d\<^sub>3 (F\<^sup>P)"
    by (simp add: meta_defs meta_aux rep_def proper_def totrm_def)

  lemma D5_1[semantics]:
    shows "\<And> w o\<^sub>1 r . Some r = d\<^sub>1 (\<^bold>\<lambda> x . (\<phi> (x\<^sup>P))) \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x
                      \<longrightarrow> (o\<^sub>1 \<in> ex1 r w) = (w \<Turnstile> \<phi> x)"
    unfolding semantics_defs
    apply simp apply transfer
    by (smt option.inject option.map_ident option.simps(3))

  lemma D5_2[semantics]:
    shows "\<And> w o\<^sub>1 o\<^sub>2 r . Some r = d\<^sub>2 (\<^bold>\<lambda>\<^sup>2 (\<lambda> x y . \<phi> (x\<^sup>P) (y\<^sup>P)))
                       \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> Some o\<^sub>2 = d\<^sub>\<kappa> y
                       \<longrightarrow> ((o\<^sub>1,o\<^sub>2) \<in> ex2 r w) = (w \<Turnstile> \<phi> x y)"
    unfolding semantics_defs
    apply simp apply transfer
    by (smt option.inject option.map_ident option.simps(3))

  lemma D5_3[semantics]:
    shows "\<And> w o\<^sub>1 o\<^sub>2 o\<^sub>3 r . Some r = d\<^sub>3 (\<^bold>\<lambda>\<^sup>3 (\<lambda> x y z . \<phi> (x\<^sup>P) (y\<^sup>P) (z\<^sup>P)))
                          \<and> Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> Some o\<^sub>2 = d\<^sub>\<kappa> y \<and> Some o\<^sub>3 = d\<^sub>\<kappa> z
                          \<longrightarrow> ((o\<^sub>1,o\<^sub>2,o\<^sub>3) \<in> ex3 r w) = (w \<Turnstile> \<phi> x y z)"
    unfolding semantics_defs
    apply simp apply transfer
    by (smt option.inject option.map_ident option.simps(3))

  lemma D6[semantics]: "(\<And> w r . Some r = d\<^sub>0 (\<^bold>\<lambda>\<^sup>0 \<phi>) \<longrightarrow> ex0 r w = (w \<Turnstile> \<phi>))"
    by (auto simp: meta_defs meta_aux semantics_defs)

  subsubsection{* Auxiliary Lemmata *}
  text{* \label{TAO_Semantics_Semantics_Auxiliary_Lemmata} *}

  lemma propex\<^sub>0: "\<exists> r . Some r = d\<^sub>0 (F\<^sup>P)"
    unfolding d\<^sub>0_def totrm_def by simp
  lemma propex\<^sub>1: "\<exists> r . Some r = d\<^sub>1 (F\<^sup>P)"
    unfolding d\<^sub>1_def totrm_def by simp
  lemma propex\<^sub>2: "\<exists> r . Some r = d\<^sub>2 (F\<^sup>P)"
    unfolding d\<^sub>2_def totrm_def by simp
  lemma propex\<^sub>3: "\<exists> r . Some r = d\<^sub>3 (F\<^sup>P)"
    unfolding d\<^sub>3_def totrm_def by simp
  lemma d\<^sub>\<kappa>_proper: "d\<^sub>\<kappa> (u\<^sup>P) = Some u"
    unfolding d\<^sub>\<kappa>_def by (simp add: totrm_def meta_aux)
  lemma ConcretenessSemantics1:
    "Some r = d\<^sub>1 (E!\<^sup>P) \<Longrightarrow> (\<exists> w . \<omega>\<nu> x \<in> ex1 r w)"
    unfolding semantics_defs Concrete_def
    by (simp add: meta_defs meta_aux totrm_def OrdinaryObjectsPossiblyConcreteAxiom)
  lemma ConcretenessSemantics2:
    "Some r = d\<^sub>1 (E!\<^sup>P) \<Longrightarrow> (x \<in> ex1 r w \<longrightarrow> (\<exists>y. x = \<omega>\<nu> y))"
    unfolding semantics_defs Concrete_def apply (simp add: meta_defs meta_aux totrm_def)
    by (metis \<nu>.exhaust \<upsilon>.exhaust \<upsilon>.simps(6) no_\<alpha>\<omega>)
  lemma d\<^sub>0_inject: "\<And>x y. d\<^sub>0 x = d\<^sub>0 y \<Longrightarrow> x = y"
    unfolding d\<^sub>0_def apply simp 
    by (metis eval\<o>_inject option.inj_map_strong)
  lemma d\<^sub>1_inject: "\<And>x y. d\<^sub>1 x = d\<^sub>1 y \<Longrightarrow> x = y"
    unfolding d\<^sub>1_def apply simp
    by (metis eval\<Omega>\<^sub>1_inverse option.inj_map_strong)
  lemma d\<^sub>2_inject: "\<And>x y. d\<^sub>2 x = d\<^sub>2 y \<Longrightarrow> x = y"
    unfolding d\<^sub>2_def apply simp
    by (metis eval\<Omega>\<^sub>2_inverse option.inj_map_strong)
  lemma d\<^sub>3_inject: "\<And>x y. d\<^sub>3 x = d\<^sub>3 y \<Longrightarrow> x = y"
    unfolding d\<^sub>3_def apply simp
    by (metis eval\<Omega>\<^sub>3_inverse option.inj_map_strong)
  lemma d\<^sub>\<kappa>_inject: "\<And>x y o\<^sub>1. Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> Some o\<^sub>1 = d\<^sub>\<kappa> y \<Longrightarrow> x = y"
  proof -
    fix x :: \<kappa> and y :: \<kappa> and o\<^sub>1 :: \<nu>
    assume "Some o\<^sub>1 = d\<^sub>\<kappa> x \<and> Some o\<^sub>1 = d\<^sub>\<kappa> y"
    thus "x = y" apply transfer by auto
  qed
end

subsection{* Introduction Rules for Proper Maps *}
text{* \label{TAO_Semantics_Proper} *}

text{*
\begin{remark}
  Introduction rules for proper maps are derived. In particular
  every map whose argument only occurs in exemplification
  expressions is proper.
\end{remark}
*}

named_theorems IsProper_intros

lemma IsProperInX_intro[IsProper_intros]:
  "IsProperInX (\<lambda> x . \<chi>
    (* one place *) (\<lambda> F . \<lparr>F,x\<rparr>)
    (* two place *) (\<lambda> F . \<lparr>F,x,x\<rparr>) (\<lambda> F a . \<lparr>F,x,a\<rparr>) (\<lambda> F a . \<lparr>F,a,x\<rparr>)
    (* three place three x *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
    (* three place two x *) (\<lambda> F a . \<lparr>F,x,x,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,x\<rparr>)
                            (\<lambda> F a . \<lparr>F,a,x,x\<rparr>)
    (* three place one x *) (\<lambda> F a b. \<lparr>F,x,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,x,b\<rparr>)
                            (\<lambda> F a b . \<lparr>F,a,b,x\<rparr>))"
  unfolding IsProperInX_def
  by (auto simp: meta_defs meta_aux)

lemma IsProperInXY_intro[IsProper_intros]:
  "IsProperInXY (\<lambda> x y . \<chi>
    (* only x *)
      (* one place *) (\<lambda> F . \<lparr>F,x\<rparr>)
      (* two place *) (\<lambda> F . \<lparr>F,x,x\<rparr>) (\<lambda> F a . \<lparr>F,x,a\<rparr>) (\<lambda> F a . \<lparr>F,a,x\<rparr>)
      (* three place three x *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
      (* three place two x *) (\<lambda> F a . \<lparr>F,x,x,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,x\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,x,x\<rparr>)
      (* three place one x *) (\<lambda> F a b. \<lparr>F,x,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,x,b\<rparr>)
                              (\<lambda> F a b . \<lparr>F,a,b,x\<rparr>)
    (* only y *)
      (* one place *) (\<lambda> F . \<lparr>F,y\<rparr>)
      (* two place *) (\<lambda> F . \<lparr>F,y,y\<rparr>) (\<lambda> F a . \<lparr>F,y,a\<rparr>) (\<lambda> F a . \<lparr>F,a,y\<rparr>)
      (* three place three y *) (\<lambda> F . \<lparr>F,y,y,y\<rparr>)
      (* three place two y *) (\<lambda> F a . \<lparr>F,y,y,a\<rparr>) (\<lambda> F a . \<lparr>F,y,a,y\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,y,y\<rparr>)
      (* three place one y *) (\<lambda> F a b. \<lparr>F,y,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,y,b\<rparr>)
                              (\<lambda> F a b . \<lparr>F,a,b,y\<rparr>)
    (* x and y *)
      (* two place *) (\<lambda> F . \<lparr>F,x,y\<rparr>) (\<lambda> F . \<lparr>F,y,x\<rparr>)
      (* three place (x,y) *) (\<lambda> F a . \<lparr>F,x,y,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,y\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,x,y\<rparr>)
      (* three place (y,x) *) (\<lambda> F a . \<lparr>F,y,x,a\<rparr>) (\<lambda> F a . \<lparr>F,y,a,x\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,y,x\<rparr>)
      (* three place (x,x,y) *) (\<lambda> F . \<lparr>F,x,x,y\<rparr>) (\<lambda> F . \<lparr>F,x,y,x\<rparr>)
                                (\<lambda> F . \<lparr>F,y,x,x\<rparr>)
      (* three place (x,y,y) *) (\<lambda> F . \<lparr>F,x,y,y\<rparr>) (\<lambda> F . \<lparr>F,y,x,y\<rparr>)
                                (\<lambda> F . \<lparr>F,y,y,x\<rparr>)
      (* three place (x,x,x) *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
      (* three place (y,y,y) *) (\<lambda> F . \<lparr>F,y,y,y\<rparr>))"
  unfolding IsProperInXY_def by (auto simp: meta_defs meta_aux)

lemma IsProperInXYZ_intro[IsProper_intros]:
  "IsProperInXYZ (\<lambda> x y z . \<chi>
    (* only x *)
      (* one place *) (\<lambda> F . \<lparr>F,x\<rparr>)
      (* two place *) (\<lambda> F . \<lparr>F,x,x\<rparr>) (\<lambda> F a . \<lparr>F,x,a\<rparr>) (\<lambda> F a . \<lparr>F,a,x\<rparr>)
      (* three place three x *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
      (* three place two x *) (\<lambda> F a . \<lparr>F,x,x,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,x\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,x,x\<rparr>)
      (* three place one x *) (\<lambda> F a b. \<lparr>F,x,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,x,b\<rparr>)
                              (\<lambda> F a b . \<lparr>F,a,b,x\<rparr>)
    (* only y *)
      (* one place *) (\<lambda> F . \<lparr>F,y\<rparr>)
      (* two place *) (\<lambda> F . \<lparr>F,y,y\<rparr>) (\<lambda> F a . \<lparr>F,y,a\<rparr>) (\<lambda> F a . \<lparr>F,a,y\<rparr>)
      (* three place three y *) (\<lambda> F . \<lparr>F,y,y,y\<rparr>)
      (* three place two y *) (\<lambda> F a . \<lparr>F,y,y,a\<rparr>) (\<lambda> F a . \<lparr>F,y,a,y\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,y,y\<rparr>)
      (* three place one y *) (\<lambda> F a b. \<lparr>F,y,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,y,b\<rparr>)
                              (\<lambda> F a b . \<lparr>F,a,b,y\<rparr>)
    (* only z *)
      (* one place *) (\<lambda> F . \<lparr>F,z\<rparr>)
      (* two place *) (\<lambda> F . \<lparr>F,z,z\<rparr>) (\<lambda> F a . \<lparr>F,z,a\<rparr>) (\<lambda> F a . \<lparr>F,a,z\<rparr>)
      (* three place three z *) (\<lambda> F . \<lparr>F,z,z,z\<rparr>)
      (* three place two z *) (\<lambda> F a . \<lparr>F,z,z,a\<rparr>) (\<lambda> F a . \<lparr>F,z,a,z\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,z,z\<rparr>)
      (* three place one z *) (\<lambda> F a b. \<lparr>F,z,a,b\<rparr>) (\<lambda> F a b. \<lparr>F,a,z,b\<rparr>)
                              (\<lambda> F a b . \<lparr>F,a,b,z\<rparr>)
    (* x and y *)
      (* two place *) (\<lambda> F . \<lparr>F,x,y\<rparr>) (\<lambda> F . \<lparr>F,y,x\<rparr>)
      (* three place (x,y) *) (\<lambda> F a . \<lparr>F,x,y,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,y\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,x,y\<rparr>)
      (* three place (y,x) *) (\<lambda> F a . \<lparr>F,y,x,a\<rparr>) (\<lambda> F a . \<lparr>F,y,a,x\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,y,x\<rparr>)
      (* three place (x,x,y) *) (\<lambda> F . \<lparr>F,x,x,y\<rparr>) (\<lambda> F . \<lparr>F,x,y,x\<rparr>)
                                (\<lambda> F . \<lparr>F,y,x,x\<rparr>)
      (* three place (x,y,y) *) (\<lambda> F . \<lparr>F,x,y,y\<rparr>) (\<lambda> F . \<lparr>F,y,x,y\<rparr>)
                                (\<lambda> F . \<lparr>F,y,y,x\<rparr>)
      (* three place (x,x,x) *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
      (* three place (y,y,y) *) (\<lambda> F . \<lparr>F,y,y,y\<rparr>)
    (* x and z *)
      (* two place *) (\<lambda> F . \<lparr>F,x,z\<rparr>) (\<lambda> F . \<lparr>F,z,x\<rparr>)
      (* three place (x,z) *) (\<lambda> F a . \<lparr>F,x,z,a\<rparr>) (\<lambda> F a . \<lparr>F,x,a,z\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,x,z\<rparr>)
      (* three place (z,x) *) (\<lambda> F a . \<lparr>F,z,x,a\<rparr>) (\<lambda> F a . \<lparr>F,z,a,x\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,z,x\<rparr>)
      (* three place (x,x,z) *) (\<lambda> F . \<lparr>F,x,x,z\<rparr>) (\<lambda> F . \<lparr>F,x,z,x\<rparr>)
                                (\<lambda> F . \<lparr>F,z,x,x\<rparr>)
      (* three place (x,z,z) *) (\<lambda> F . \<lparr>F,x,z,z\<rparr>) (\<lambda> F . \<lparr>F,z,x,z\<rparr>)
                                (\<lambda> F . \<lparr>F,z,z,x\<rparr>)
      (* three place (x,x,x) *) (\<lambda> F . \<lparr>F,x,x,x\<rparr>)
      (* three place (z,z,z) *) (\<lambda> F . \<lparr>F,z,z,z\<rparr>)
    (* y and z *)
      (* two place *) (\<lambda> F . \<lparr>F,y,z\<rparr>) (\<lambda> F . \<lparr>F,z,y\<rparr>)
      (* three place (y,z) *) (\<lambda> F a . \<lparr>F,y,z,a\<rparr>) (\<lambda> F a . \<lparr>F,y,a,z\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,y,z\<rparr>)
      (* three place (z,y) *) (\<lambda> F a . \<lparr>F,z,y,a\<rparr>) (\<lambda> F a . \<lparr>F,z,a,y\<rparr>)
                              (\<lambda> F a . \<lparr>F,a,z,y\<rparr>)
      (* three place (y,y,z) *) (\<lambda> F . \<lparr>F,y,y,z\<rparr>) (\<lambda> F . \<lparr>F,y,z,y\<rparr>)
                                (\<lambda> F . \<lparr>F,z,y,y\<rparr>)
      (* three place (y,z,z) *) (\<lambda> F . \<lparr>F,y,z,z\<rparr>) (\<lambda> F . \<lparr>F,z,y,z\<rparr>)
                                (\<lambda> F . \<lparr>F,z,z,y\<rparr>)
      (* three place (y,y,y) *) (\<lambda> F . \<lparr>F,y,y,y\<rparr>)
      (* three place (z,z,z) *) (\<lambda> F . \<lparr>F,z,z,z\<rparr>)
    (* x y z *)
      (* three place (x,...) *) (\<lambda> F . \<lparr>F,x,y,z\<rparr>) (\<lambda> F . \<lparr>F,x,z,y\<rparr>)
      (* three place (y,...) *) (\<lambda> F . \<lparr>F,y,x,z\<rparr>) (\<lambda> F . \<lparr>F,y,z,x\<rparr>)
      (* three place (z,...) *) (\<lambda> F . \<lparr>F,z,x,y\<rparr>) (\<lambda> F . \<lparr>F,z,y,x\<rparr>))"
  unfolding IsProperInXYZ_def
  by (auto simp: meta_defs meta_aux)    

method show_proper = (fast intro: IsProper_intros)

text{*
  The proving method @{method show_proper} is defined and is used in the subsequent
  theory whenever it is necessary to show that a map is proper.
*}

subsection{* Validity Syntax *}
text{* \label{TAO_Semantics_Validity} *}

(* disable list syntax [] to replace it with truth evaluation *)
(*<*) no_syntax "_list" :: "args \<Rightarrow> 'a list" ("[(_)]") (*>*) 
(*<*) no_syntax "__listcompr" :: "args \<Rightarrow> 'a list" ("[(_)]") (*>*) 

abbreviation validity_in :: "\<o>\<Rightarrow>i\<Rightarrow>bool" ("[_ in _]" [1]) where
  "validity_in \<equiv> \<lambda> \<phi> v . v \<Turnstile> \<phi>"
definition actual_validity :: "\<o>\<Rightarrow>bool" ("[_]" [1]) where
  "actual_validity \<equiv> \<lambda> \<phi> . dw \<Turnstile> \<phi>"
definition necessary_validity :: "\<o>\<Rightarrow>bool" ("\<box>[_]" [1]) where
  "necessary_validity \<equiv> \<lambda> \<phi> . \<forall> v . (v \<Turnstile> \<phi>)"

(*<*)
end
(*>*)
