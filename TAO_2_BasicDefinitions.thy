(*<*)
theory TAO_2_BasicDefinitions
imports TAO_1_Embedding
begin
(*>*)

section{* Basic Definitions *}

subsection{* Derived Connectives *}

definition diamond::"\<o>\<Rightarrow>\<o>" ("\<^bold>\<diamond>_" [62] 63) where
  "diamond \<equiv> \<lambda> \<phi> . \<^bold>\<not>\<^bold>\<box>\<^bold>\<not>\<phi>"
definition conj::"\<o>\<Rightarrow>\<o>\<Rightarrow>\<o>" (infixl "\<^bold>&" 53) where
  "conj \<equiv> \<lambda> x y . \<^bold>\<not>(x \<^bold>\<rightarrow> \<^bold>\<not>y)"
definition disj::"\<o>\<Rightarrow>\<o>\<Rightarrow>\<o>" (infixl "\<^bold>\<or>" 52) where
  "disj \<equiv> \<lambda> x y . \<^bold>\<not>x \<^bold>\<rightarrow> y"
definition equiv::"\<o>\<Rightarrow>\<o>\<Rightarrow>\<o>" (infixl "\<^bold>\<equiv>" 51) where
  "equiv \<equiv> \<lambda> x y . (x \<^bold>\<rightarrow> y) \<^bold>& (y \<^bold>\<rightarrow> x)"

named_theorems conn_defs
declare diamond_def[conn_defs] conj_def[conn_defs]
        disj_def[conn_defs] equiv_def[conn_defs]

subsection{* Abstract and Ordinary Objects *}

definition Ordinary :: "\<Pi>\<^sub>1" ("O!") where "Ordinary \<equiv> \<^bold>\<lambda>x. \<^bold>\<diamond>\<lparr>E!,x\<^sup>P\<rparr>"
definition Abstract :: "\<Pi>\<^sub>1" ("A!") where "Abstract \<equiv> \<^bold>\<lambda>x. \<^bold>\<not>\<^bold>\<diamond>\<lparr>E!,x\<^sup>P\<rparr>"

subsection{* Identity Definitions *}

definition basic_identity\<^sub>E::"\<Pi>\<^sub>2" where
  "basic_identity\<^sub>E \<equiv> \<^bold>\<lambda>\<^sup>2 (\<lambda> x y . \<lparr>O!,x\<^sup>P\<rparr> \<^bold>& \<lparr>O!,y\<^sup>P\<rparr>
                         \<^bold>& \<^bold>\<box>(\<^bold>\<forall>\<^sub>1 F. \<lparr>F,x\<^sup>P\<rparr> \<^bold>\<equiv> \<lparr>F,y\<^sup>P\<rparr>))"

definition basic_identity\<^sub>E_infix::"\<kappa>\<Rightarrow>\<kappa>\<Rightarrow>\<o>" (infixl "\<^bold>=\<^sub>E" 63) where
  "x \<^bold>=\<^sub>E y \<equiv> \<lparr>basic_identity\<^sub>E, x, y\<rparr>"

definition basic_identity\<^sub>\<kappa> (infixl "\<^bold>=\<^sub>\<kappa>" 63) where
  "basic_identity\<^sub>\<kappa> \<equiv> \<lambda> x y . (x \<^bold>=\<^sub>E y) \<^bold>\<or> \<lparr>A!,x\<rparr> \<^bold>& \<lparr>A!,y\<rparr>
                             \<^bold>& \<^bold>\<box>(\<^bold>\<forall>\<^sub>1 F. \<lbrace>x,F\<rbrace> \<^bold>\<equiv> \<lbrace>y,F\<rbrace>)"

definition basic_identity\<^sub>1 (infixl "\<^bold>=\<^sub>1" 63) where
  "basic_identity\<^sub>1 \<equiv> \<lambda> F G . \<^bold>\<box>(\<^bold>\<forall>\<^sub>\<nu> x. \<lbrace>x\<^sup>P,F\<rbrace> \<^bold>\<equiv> \<lbrace>x\<^sup>P,G\<rbrace>)"

definition basic_identity\<^sub>2 :: "\<Pi>\<^sub>2\<Rightarrow>\<Pi>\<^sub>2\<Rightarrow>\<o>" (infixl "\<^bold>=\<^sub>2" 63) where
  "basic_identity\<^sub>2 \<equiv> \<lambda> F G .  \<^bold>\<forall>\<^sub>\<nu> x. ((\<^bold>\<lambda>y. \<lparr>F,x\<^sup>P,y\<^sup>P\<rparr>) \<^bold>=\<^sub>1 (\<^bold>\<lambda>y. \<lparr>G,x\<^sup>P,y\<^sup>P\<rparr>))
                                  \<^bold>& ((\<^bold>\<lambda>y. \<lparr>F,y\<^sup>P,x\<^sup>P\<rparr>) \<^bold>=\<^sub>1 (\<^bold>\<lambda>y. \<lparr>G,y\<^sup>P,x\<^sup>P\<rparr>))"

definition basic_identity\<^sub>3::"\<Pi>\<^sub>3\<Rightarrow>\<Pi>\<^sub>3\<Rightarrow>\<o>" (infixl "\<^bold>=\<^sub>3" 63) where
  "basic_identity\<^sub>3 \<equiv> \<lambda> F G . \<^bold>\<forall>\<^sub>\<nu> x y. (\<^bold>\<lambda>z. \<lparr>F,z\<^sup>P,x\<^sup>P,y\<^sup>P\<rparr>) \<^bold>=\<^sub>1 (\<^bold>\<lambda>z. \<lparr>G,z\<^sup>P,x\<^sup>P,y\<^sup>P\<rparr>)
                                   \<^bold>& (\<^bold>\<lambda>z. \<lparr>F,x\<^sup>P,z\<^sup>P,y\<^sup>P\<rparr>) \<^bold>=\<^sub>1 (\<^bold>\<lambda>z. \<lparr>G,x\<^sup>P,z\<^sup>P,y\<^sup>P\<rparr>)
                                   \<^bold>& (\<^bold>\<lambda>z. \<lparr>F,x\<^sup>P,y\<^sup>P,z\<^sup>P\<rparr>) \<^bold>=\<^sub>1 (\<^bold>\<lambda>z. \<lparr>G,x\<^sup>P,y\<^sup>P,z\<^sup>P\<rparr>)"

definition basic_identity\<^sub>\<o>::"\<o>\<Rightarrow>\<o>\<Rightarrow>\<o>" (infixl "\<^bold>=\<^sub>\<o>" 63) where
  "basic_identity\<^sub>\<o> \<equiv> \<lambda> F G . (\<^bold>\<lambda>y. F) \<^bold>=\<^sub>1 (\<^bold>\<lambda>y. G)"

(*<*)
end
(*>*)
