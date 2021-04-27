theory AOT_NaturalNumbers
  imports AOT_PLM AOT_PossibleWorlds
  abbrevs one-to-one = \<open>\<^sub>1\<^sub>-\<^sub>1\<close>
      and onto = \<open>\<^sub>o\<^sub>n\<^sub>t\<^sub>o\<close>
begin
 
AOT_define one_one_cor :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> _\<close>)
  one_one_cor: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> G \<equiv>\<^sub>d\<^sub>f R\<down> & F\<down> & G\<down> &
                                   \<forall>x ([F]x \<rightarrow> \<exists>!y([G]y & [R]xy)) &
                                   \<forall>y ([G]y \<rightarrow> \<exists>!x([F]x & [R]xy))\<close>

AOT_define fFG_1 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<longrightarrow> _\<close>)
  fFG_1: \<open>R |: F \<longrightarrow> G \<equiv>\<^sub>d\<^sub>f R\<down> & F\<down> & G\<down> & \<forall>x ([F]x \<rightarrow> \<exists>!y([G]y & [R]xy))\<close>

AOT_define fFG_2 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longrightarrow> _\<close>)
  fFG_2: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow> G \<equiv>\<^sub>d\<^sub>f R |: F \<longrightarrow> G & \<forall>x\<forall>y\<forall>z (([F]x & [F]y & [G]z) \<rightarrow> ([R]xz & [R]yz \<rightarrow> x = y))\<close>

AOT_define fFG_3 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o _\<close>)
  fFG_3: \<open>R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G \<equiv>\<^sub>d\<^sub>f R |: F \<longrightarrow> G & \<forall>y ([G]y \<rightarrow> \<exists>x([F]x & [R]xy))\<close>

AOT_define fFG_4 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o _\<close>)
  fFG_4: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G \<equiv>\<^sub>d\<^sub>f R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow> G & R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close>

AOT_theorem eq_1_1: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> G \<equiv> R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close>
proof(rule "\<equiv>I"; rule "\<rightarrow>I")
  AOT_assume \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> G\<close>
  AOT_hence A: \<open>\<forall>x ([F]x \<rightarrow> \<exists>!y([G]y & [R]xy))\<close> and B: \<open>\<forall>y ([G]y \<rightarrow> \<exists>!x([F]x & [R]xy))\<close>
    using "\<equiv>\<^sub>d\<^sub>fE"[OF one_one_cor] "&E" by blast+
  AOT_have C: \<open>R |: F \<longrightarrow> G\<close>
  proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF fFG_1]; rule "&I")
    AOT_show \<open>R\<down> & F\<down> & G\<down>\<close> using cqt_2_const_var[axiom_inst] "&I" by metis
  next
    AOT_show \<open>\<forall>x ([F]x \<rightarrow> \<exists>!y([G]y & [R]xy))\<close> by (rule A)
  qed
  AOT_show \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close>
  proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF fFG_4]; rule "&I")
    AOT_show \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow> G\<close>
    proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF fFG_2]; rule "&I")
      AOT_show \<open>R |: F \<longrightarrow> G\<close> using C.
    next
      AOT_show \<open>\<forall>x\<forall>y\<forall>z ([F]x & [F]y & [G]z \<rightarrow> ([R]xz & [R]yz \<rightarrow> x = y))\<close>
      proof(rule GEN; rule GEN; rule GEN; rule "\<rightarrow>I"; rule "\<rightarrow>I")
        fix x y z
        AOT_assume 1: \<open>[F]x & [F]y & [G]z\<close>
        moreover AOT_assume 2: \<open>[R]xz & [R]yz\<close>
        ultimately AOT_have 3: \<open>\<exists>!x ([F]x & [R]xz)\<close> using B "&E" "\<forall>E" "\<rightarrow>E" by fast
        AOT_show \<open>x = y\<close>
          by (rule uni_most[THEN "\<rightarrow>E", OF 3, THEN "\<forall>E"(2)[where \<beta>=x],
                            THEN "\<forall>E"(2)[where \<beta>=y], THEN "\<rightarrow>E"])
             (metis "&I" "&E" 1 2)
      qed
    qed
  next
    AOT_show \<open>R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close>
    proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF fFG_3]; rule "&I")
      AOT_show \<open>R |: F \<longrightarrow> G\<close> using C.
    next
      AOT_show \<open>\<forall>y ([G]y \<rightarrow> \<exists>x ([F]x & [R]xy))\<close>
      proof(rule GEN; rule "\<rightarrow>I")
        fix y
        AOT_assume \<open>[G]y\<close>
        AOT_hence \<open>\<exists>!x ([F]x & [R]xy)\<close> using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
        AOT_hence \<open>\<exists>x ([F]x & [R]xy & \<forall>\<beta> (([F]\<beta> & [R]\<beta>y) \<rightarrow> \<beta> = x))\<close>
          using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
        then AOT_obtain x where \<open>[F]x & [R]xy\<close> using "\<exists>E"[rotated] "&E" by blast
        AOT_thus \<open>\<exists>x ([F]x & [R]xy)\<close> by (rule "\<exists>I")
      qed
    qed
  qed
next
  AOT_assume \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close>
  AOT_hence \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow> G\<close> and \<open>R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>o G\<close> using "\<equiv>\<^sub>d\<^sub>fE"[OF fFG_4] "&E" by blast+
  AOT_hence C: \<open>R |: F \<longrightarrow> G\<close>
    and D: \<open>\<forall>x\<forall>y\<forall>z ([F]x & [F]y & [G]z \<rightarrow> ([R]xz & [R]yz \<rightarrow> x = y))\<close>
    and E: \<open>\<forall>y ([G]y \<rightarrow> \<exists>x ([F]x & [R]xy))\<close>
    using "\<equiv>\<^sub>d\<^sub>fE"[OF fFG_2] "\<equiv>\<^sub>d\<^sub>fE"[OF fFG_3] "&E" by blast+
  AOT_show \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> G\<close>
  proof(rule one_one_cor[THEN "\<equiv>\<^sub>d\<^sub>fI"]; safe intro!: "&I" cqt_2_const_var[axiom_inst])
    AOT_show \<open>\<forall>x ([F]x \<rightarrow> \<exists>!y ([G]y & [R]xy))\<close>
      using "\<equiv>\<^sub>d\<^sub>fE"[OF fFG_1, OF C] "&E" by blast
  next
    AOT_show \<open>\<forall>y ([G]y \<rightarrow> \<exists>!x ([F]x & [R]xy))\<close>
    proof (rule "GEN"; rule "\<rightarrow>I")
      fix y
      AOT_assume 0: \<open>[G]y\<close>
      AOT_hence \<open>\<exists>x ([F]x & [R]xy)\<close> using E "\<forall>E" "\<rightarrow>E" by fast
      then AOT_obtain a where a_prop: \<open>[F]a & [R]ay\<close> using "\<exists>E"[rotated] by blast
      moreover AOT_have \<open>\<forall>z ([F]z & [R]zy \<rightarrow> z = a)\<close>
      proof (rule GEN; rule "\<rightarrow>I")
        fix z
        AOT_assume \<open>[F]z & [R]zy\<close>
        AOT_thus \<open>z = a\<close>
          using D[THEN "\<forall>E"(2)[where \<beta>=z], THEN "\<forall>E"(2)[where \<beta>=a],
                  THEN "\<forall>E"(2)[where \<beta>=y], THEN "\<rightarrow>E", THEN "\<rightarrow>E"]
                a_prop 0 "&E" "&I" by metis
      qed
      ultimately AOT_have \<open>\<exists>x ([F]x & [R]xy & \<forall>z ([F]z & [R]zy \<rightarrow> z = x))\<close>
        using "&I" "\<exists>I"(2) by fast
      AOT_thus \<open>\<exists>!x ([F]x & [R]xy)\<close>
        using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] by fast
    qed
  qed
qed


AOT_register_restricted_type
  Ordinary: \<open>O!\<kappa>\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<exists>x O!x\<close>
      by (meson "B\<diamond>" T_S5_fund_1 o_objects_exist_1 vdash_properties_10)
  }
next
  AOT_modally_strict {
    AOT_show \<open>O!\<kappa> \<rightarrow> \<kappa>\<down>\<close> for \<kappa>
      by (simp add: deduction_theorem russell_axiom_exe_1.\<psi>_denotes_asm)
  }
qed
AOT_register_variable_names
  Ordinary: u v r t s
interpretation Ordinary: AOT_rigid_restriction_condition \<open>\<lambda>\<kappa>. \<guillemotleft>O!\<kappa>\<guillemotright>\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<box>(O!x \<rightarrow> \<box>O!x)\<close> for x
      by (simp add: RN oa_facts_1)
  }
qed

AOT_theorem equi_1: \<open>\<exists>!u \<phi>{u} \<equiv>\<^sub>d\<^sub>f \<exists>u (\<phi>{u} & \<forall>v (\<phi>{v} \<rightarrow> v =\<^sub>E u))\<close>
proof(rule AOT_sem_equiv_defI) (* NOTE: appeal to semantics to accommodate PLMs double definition *)
  AOT_modally_strict {
    AOT_assume \<open>\<exists>!u \<phi>{u}\<close>
    AOT_hence \<open>\<exists>!x (O!x & \<phi>{x})\<close>.
    AOT_hence \<open>\<exists>x (O!x & \<phi>{x} & \<forall>\<beta> (O!\<beta> & \<phi>{\<beta>} \<rightarrow> \<beta> = x))\<close>
      using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
    then AOT_obtain x where x_prop: \<open>O!x & \<phi>{x} & \<forall>\<beta> (O!\<beta> & \<phi>{\<beta>} \<rightarrow> \<beta> = x)\<close> using "\<exists>E"[rotated] by blast
    {
      fix \<beta>
      AOT_assume beta_ord: \<open>O!\<beta>\<close>
      moreover AOT_assume \<open>\<phi>{\<beta>}\<close>
      ultimately AOT_have \<open>\<beta> = x\<close> using x_prop[THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=\<beta>]] "&I" "\<rightarrow>E" by blast
      AOT_hence \<open>\<beta> =\<^sub>E x\<close>
        using ord_eq_E_eq[THEN "\<rightarrow>E", OF "\<or>I"(1)[OF beta_ord], THEN qml_2[axiom_inst, THEN "\<rightarrow>E"], THEN "\<equiv>E"(1)]
        by blast
    }
    AOT_hence \<open>(O!\<beta> \<rightarrow> (\<phi>{\<beta>} \<rightarrow> \<beta> =\<^sub>E x))\<close> for \<beta>
      using "\<rightarrow>I" by blast
    AOT_hence \<open>\<forall>\<beta>(O!\<beta> \<rightarrow> (\<phi>{\<beta>} \<rightarrow> \<beta> =\<^sub>E x))\<close>
      by (rule GEN)
    AOT_hence \<open>O!x & \<phi>{x} & \<forall>y (O!y \<rightarrow> (\<phi>{y} \<rightarrow> y =\<^sub>E x))\<close>
      using x_prop[THEN "&E"(1)] "&I" by blast
    AOT_hence \<open>O!x & (\<phi>{x} & \<forall>y (O!y \<rightarrow> (\<phi>{y} \<rightarrow> y =\<^sub>E x)))\<close>
      using "&E" "&I" by meson
    AOT_thus \<open>\<exists>u (\<phi>{u} & \<forall>v (\<phi>{v} \<rightarrow> v =\<^sub>E u))\<close>
      using "\<exists>I" by fast
  }
next
  AOT_modally_strict {
    AOT_assume \<open>\<exists>u (\<phi>{u} & \<forall>v (\<phi>{v} \<rightarrow> v =\<^sub>E u))\<close>
    AOT_hence \<open>\<exists>x (O!x & (\<phi>{x} & \<forall>y (O!y \<rightarrow> (\<phi>{y} \<rightarrow> y =\<^sub>E x))))\<close>
      by blast
    then AOT_obtain x where x_prop: \<open>O!x & (\<phi>{x} & \<forall>y (O!y \<rightarrow> (\<phi>{y} \<rightarrow> y =\<^sub>E x)))\<close>
      using "\<exists>E"[rotated] by blast
    AOT_have \<open>\<forall>y ([O!]y & \<phi>{y} \<rightarrow> y = x)\<close>
    proof(rule GEN; rule "\<rightarrow>I")
      fix y
      AOT_assume \<open>O!y & \<phi>{y}\<close>
      AOT_hence \<open>y =\<^sub>E x\<close> using x_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=y]]
        using "\<rightarrow>E" "&E" by blast
      AOT_thus \<open>y = x\<close>
        using ord_eq_E_eq[THEN "\<rightarrow>E", OF "\<or>I"(2)[OF x_prop[THEN "&E"(1)]], THEN qml_2[axiom_inst, THEN "\<rightarrow>E"], THEN "\<equiv>E"(2)] by blast
    qed
    AOT_hence \<open>[O!]x & \<phi>{x} & \<forall>y ([O!]y & \<phi>{y} \<rightarrow> y = x)\<close> using x_prop "&E" "&I" by meson
    AOT_hence \<open>\<exists>x ([O!]x & \<phi>{x} & \<forall>y ([O!]y & \<phi>{y} \<rightarrow> y = x))\<close> by (rule "\<exists>I")
    AOT_hence \<open>\<exists>!x (O!x & \<phi>{x})\<close>
      by (rule uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    AOT_thus \<open>\<exists>!u \<phi>{u}\<close>.
  }
qed

AOT_define equi_2 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E _\<close>)
  equi_2: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G \<equiv>\<^sub>d\<^sub>f R\<down> & F\<down> & G\<down> &
                               \<forall>u ([F]u \<rightarrow> \<exists>!v([G]v & [R]uv)) &
                               \<forall>v ([G]v \<rightarrow> \<exists>!u([F]u & [R]uv))\<close>

AOT_define equi_3 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (infixl "\<approx>\<^sub>E" 50)
  equi_3: \<open>F \<approx>\<^sub>E G \<equiv>\<^sub>d\<^sub>f \<exists>R (R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G)\<close>

(* TODO: not in PLM *)
AOT_theorem eq_den_1: \<open>\<Pi>\<down>\<close> if \<open>\<Pi> \<approx>\<^sub>E \<Pi>'\<close>
proof -
  AOT_have \<open>\<exists>R (R |: \<Pi> \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E \<Pi>')\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] that by blast
  then AOT_obtain R where \<open>R |: \<Pi> \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E \<Pi>'\<close> using "\<exists>E"[rotated] by blast
  AOT_thus \<open>\<Pi>\<down>\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
qed
(* TODO: not in PLM *)
AOT_theorem eq_den_2: \<open>\<Pi>'\<down>\<close> if \<open>\<Pi> \<approx>\<^sub>E \<Pi>'\<close>
proof -
  AOT_have \<open>\<exists>R (R |: \<Pi> \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E \<Pi>')\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] that by blast
  then AOT_obtain R where \<open>R |: \<Pi> \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E \<Pi>'\<close> using "\<exists>E"[rotated] by blast
  AOT_thus \<open>\<Pi>'\<down>\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
qed

AOT_theorem eq_part_1: \<open>F \<approx>\<^sub>E F\<close>
proof (safe intro!: "&I" GEN "\<rightarrow>I" cqt_2_const_var[axiom_inst] "\<equiv>\<^sub>d\<^sub>fI"[OF equi_3] "\<equiv>\<^sub>d\<^sub>fI"[OF equi_2] "\<exists>I"(1))
  fix x
  AOT_assume 1: \<open>O!x\<close>
  AOT_assume 2: \<open>[F]x\<close>
  AOT_show \<open>\<exists>!v ([F]v & x =\<^sub>E v)\<close>
  proof(rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"]; rule "\<exists>I"(2)[where \<beta>=x]; safe dest!: "&E"(2) intro!:  "&I" "\<rightarrow>I" 1 2 GEN ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF 1])
    AOT_show \<open>v =\<^sub>E x\<close> if \<open>x =\<^sub>E v\<close> for v
      by (metis that ord_eq_Eequiv_2[THEN "\<rightarrow>E"])
  qed
next
  fix y
  AOT_assume 1: \<open>O!y\<close>
  AOT_assume 2: \<open>[F]y\<close>
  AOT_show \<open>\<exists>!u ([F]u & u =\<^sub>E y)\<close>
    by(safe dest!: "&E"(2) intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=y]
            "&I" "\<rightarrow>I" 1 2 GEN ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF 1])
qed(auto simp: eq_E_denotes)


AOT_theorem eq_part_2: \<open>F \<approx>\<^sub>E G \<rightarrow> G \<approx>\<^sub>E F\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>F \<approx>\<^sub>E G\<close>
  AOT_hence \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close> using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain R where \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close> using "\<exists>E"[rotated] by blast
  AOT_hence 0: \<open>R\<down> & F\<down> & G\<down> & \<forall>u ([F]u \<rightarrow> \<exists>!v([G]v & [R]uv)) &
                            \<forall>v ([G]v \<rightarrow> \<exists>!u([F]u & [R]uv))\<close> using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast

  AOT_have \<open>[\<lambda>xy [R]yx]\<down> & G\<down> & F\<down> & \<forall>u ([G]u \<rightarrow> \<exists>!v([F]v & [\<lambda>xy [R]yx]uv)) &
                            \<forall>v ([F]v \<rightarrow> \<exists>!u([G]u & [\<lambda>xy [R]yx]uv))\<close>
  proof (AOT_subst \<open>\<lambda> \<kappa> \<kappa>' . \<guillemotleft>[\<lambda>xy [R]yx]\<kappa>\<kappa>'\<guillemotright>\<close> \<open>\<lambda> \<kappa> \<kappa>' . \<guillemotleft>[R]\<kappa>'\<kappa>\<guillemotright>\<close>;
         (safe intro!: "&I" cqt_2_const_var[axiom_inst] 0[THEN "&E"(2)] 0[THEN "&E"(1), THEN "&E"(2)]; cqt_2_lambda)?)
    AOT_modally_strict {
      AOT_have \<open>[\<lambda>xy [R]yx]xy\<close> if \<open>[R]yx\<close> for y x
        by(rule betaC_2_a; cqt_2_lambda ; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3 that)
      moreover AOT_have \<open>[R]yx\<close> if \<open>[\<lambda>xy [R]yx]xy\<close> for y x
        using betaC_1_a[where \<phi>="\<lambda>(x,y). _ (x,y)" and \<kappa>\<^sub>1\<kappa>\<^sub>n="(_,_)", simplified, OF that, simplified].
      ultimately AOT_show \<open>[\<lambda>xy [R]yx]\<alpha>\<beta> \<equiv> [R]\<beta>\<alpha>\<close> for \<alpha> \<beta>
        by (metis deduction_theorem intro_elim_2)
    }
  qed
  AOT_hence \<open>[\<lambda>xy [R]yx] |: G \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E F\<close> using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] by blast
  AOT_hence \<open>\<exists>R R |: G \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E F\<close> by (rule "\<exists>I"(1)) cqt_2_lambda
  AOT_thus \<open>G \<approx>\<^sub>E F\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"] by blast
qed

(* TODO: not in PLM *)
AOT_theorem eq_part_2': \<open>\<Pi> \<approx>\<^sub>E \<Pi>' \<rightarrow> \<Pi>' \<approx>\<^sub>E \<Pi>\<close>
  using eq_part_2[unvarify F G] eq_den_1 eq_den_2 "\<rightarrow>I" by meson
declare eq_part_2'[THEN "\<rightarrow>E", sym]

AOT_theorem eq_part_3: \<open>(F \<approx>\<^sub>E G & G \<approx>\<^sub>E H) \<rightarrow> F \<approx>\<^sub>E H\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>F \<approx>\<^sub>E G & G \<approx>\<^sub>E H\<close>
  then AOT_obtain R\<^sub>1 and R\<^sub>2 where
       \<open>R\<^sub>1 |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
   and \<open>R\<^sub>2 |: G \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E H\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" "\<exists>E"[rotated] by metis
  AOT_hence \<theta>: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v([G]v & [R\<^sub>1]uv)) & \<forall>v ([G]v \<rightarrow> \<exists>!u([F]u & [R\<^sub>1]uv))\<close>
        and \<xi>: \<open>\<forall>u ([G]u \<rightarrow> \<exists>!v([H]v & [R\<^sub>2]uv)) & \<forall>v ([H]v \<rightarrow> \<exists>!u([G]u & [R\<^sub>2]uv))\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(2)]
          equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(1), THEN "&E"(2)]
          "&I" by blast+
  AOT_have \<open>\<exists>R R = [\<lambda>xy O!x & O!y & \<exists>v ([G]v & [R\<^sub>1]xv & [R\<^sub>2]vy)]\<close>
    by (rule free_thms_3_b) cqt_2_lambda_inst_prover
  then AOT_obtain R where R_def: \<open>R = [\<lambda>xy O!x & O!y & \<exists>v ([G]v & [R\<^sub>1]xv & [R\<^sub>2]vy)]\<close>
    using "\<exists>E"[rotated] by blast
  AOT_have 1: \<open>\<exists>!v (([H]v & [R]uv))\<close> if a: \<open>[O!]u\<close> and b: \<open>[F]u\<close> for u
  proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF equi_1])
    AOT_obtain b where b_prop: \<open>[O!]b & ([G]b & [R\<^sub>1]ub & \<forall>v ([G]v & [R\<^sub>1]uv \<rightarrow> v =\<^sub>E b))\<close>
      using \<theta>[THEN "&E"(1), THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF a b, THEN "\<equiv>\<^sub>d\<^sub>fE"[OF equi_1]]
            "\<exists>E"[rotated] by blast
    AOT_obtain c where c_prop: "[O!]c & ([H]c & [R\<^sub>2]bc & \<forall>v ([H]v & [R\<^sub>2]bv \<rightarrow> v =\<^sub>E c))"
      using \<xi>[THEN "&E"(1), THEN "\<forall>E"(2)[where \<beta>=b], THEN "\<rightarrow>E", OF b_prop[THEN "&E"(1)], THEN "\<rightarrow>E",
          OF b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)], THEN "\<equiv>\<^sub>d\<^sub>fE"[OF equi_1]]
    "\<exists>E"[rotated] by blast
    AOT_show \<open>\<exists>v ([H]v & [R]uv & \<forall>v' ([H]v' & [R]uv' \<rightarrow> v' =\<^sub>E v))\<close>
    proof (rule_tac \<beta>=c in "\<exists>I"(2); safe intro!: "&I" GEN "\<rightarrow>I")
      AOT_show \<open>O!c\<close> using c_prop "&E" by blast
    next
      AOT_show \<open>[H]c\<close> using c_prop "&E" by blast
    next
      AOT_have 0: \<open>[O!]u & [O!]c & \<exists>v ([G]v & [R\<^sub>1]uv & [R\<^sub>2]vc)\<close>
        by (safe intro!: "&I" a c_prop[THEN "&E"(1)] "\<exists>I"(2)[where \<beta>=b] b_prop[THEN "&E"(1)]
                     b_prop[THEN "&E"(2), THEN "&E"(1)] c_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)])
      AOT_show \<open>[R]uc\<close>
        apply (rule "=E"[rotated, OF R_def[symmetric]])
        apply (rule betaC_2_a; cqt_2_lambda)
        by (auto simp: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3 0)
    next
      fix x
      AOT_assume ordx: \<open>O!x\<close>
      AOT_assume \<open>[H]x & [R]ux\<close>
      AOT_hence hx: \<open>[H]x\<close> and \<open>[R]ux\<close> using "&E" by blast+
      AOT_hence \<open>[\<lambda>xy O!x & O!y & \<exists>v ([G]v & [R\<^sub>1]xv & [R\<^sub>2]vy)]ux\<close>
        using "=E"[rotated, OF R_def] by fast
      AOT_hence \<open>O!u & O!x & \<exists>v ([G]v & [R\<^sub>1]uv & [R\<^sub>2]vx)\<close>
        by (rule betaC_1_a[where \<phi>="\<lambda>(\<kappa>,\<kappa>'). _ \<kappa> \<kappa>'" and \<kappa>\<^sub>1\<kappa>\<^sub>n="(_,_)", simplified])
      then AOT_obtain z where z_prop: \<open>O!z & ([G]z & [R\<^sub>1]uz & [R\<^sub>2]zx)\<close>
        using "&E" "\<exists>E"[rotated] by blast
      AOT_hence \<open>z =\<^sub>E b\<close> using b_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=z]]
        using "&E" "\<rightarrow>E" by metis
      AOT_hence \<open>z = b\<close> by (metis eq_E_simple_2[THEN "\<rightarrow>E"])
      AOT_hence \<open>[R\<^sub>2]bx\<close> using z_prop[THEN "&E"(2), THEN "&E"(2)] "=E" by fast
      AOT_thus \<open>x =\<^sub>E c\<close>
        using c_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=x], THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ordx]
              hx "&I" by blast
    qed
  qed
  AOT_have 2: \<open>\<exists>!u (([F]u & [R]uv))\<close> if a: \<open>[O!]v\<close> and b: \<open>[H]v\<close> for v
  proof (rule "\<equiv>\<^sub>d\<^sub>fI"[OF equi_1])
    AOT_obtain b where b_prop: \<open>[O!]b & ([G]b & [R\<^sub>2]bv & \<forall>u ([G]u & [R\<^sub>2]uv \<rightarrow> u =\<^sub>E b))\<close>
      using \<xi>[THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF a b, THEN "\<equiv>\<^sub>d\<^sub>fE"[OF equi_1]]
            "\<exists>E"[rotated] by blast
    AOT_obtain c where c_prop: "[O!]c & ([F]c & [R\<^sub>1]cb & \<forall>v ([F]v & [R\<^sub>1]vb \<rightarrow> v =\<^sub>E c))"
      using \<theta>[THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=b], THEN "\<rightarrow>E", OF b_prop[THEN "&E"(1)], THEN "\<rightarrow>E",
          OF b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)], THEN "\<equiv>\<^sub>d\<^sub>fE"[OF equi_1]]
    "\<exists>E"[rotated] by blast
    AOT_show \<open>\<exists>u ([F]u & [R]uv & \<forall>v' ([F]v' & [R]v'v \<rightarrow> v' =\<^sub>E u))\<close>
    proof (rule_tac \<beta>=c in "\<exists>I"(2); safe intro!: "&I" GEN "\<rightarrow>I")
      AOT_show \<open>O!c\<close> using c_prop "&E" by blast
    next
      AOT_show \<open>[F]c\<close> using c_prop "&E" by blast
    next
      AOT_have 0: \<open>[O!]c & [O!]v & \<exists>u ([G]u & [R\<^sub>1]cu & [R\<^sub>2]uv)\<close>
        by (safe intro!: "&I" a c_prop[THEN "&E"(1)] "\<exists>I"(2)[where \<beta>=b] b_prop[THEN "&E"(1)]
                     b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
                     b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)]
                     c_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)])
      AOT_show \<open>[R]cv\<close>
        apply (rule "=E"[rotated, OF R_def[symmetric]])
        apply (rule betaC_2_a; cqt_2_lambda)
        by (auto simp: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3 0)
    next
      fix x
      AOT_assume ordx: \<open>O!x\<close>
      AOT_assume \<open>[F]x & [R]xv\<close>
      AOT_hence hx: \<open>[F]x\<close> and \<open>[R]xv\<close> using "&E" by blast+
      AOT_hence \<open>[\<lambda>xy O!x & O!y & \<exists>v ([G]v & [R\<^sub>1]xv & [R\<^sub>2]vy)]xv\<close>
        using "=E"[rotated, OF R_def] by fast
      AOT_hence \<open>O!x & O!v & \<exists>u ([G]u & [R\<^sub>1]xu & [R\<^sub>2]uv)\<close>
        by (rule betaC_1_a[where \<phi>="\<lambda>(\<kappa>,\<kappa>'). _ \<kappa> \<kappa>'" and \<kappa>\<^sub>1\<kappa>\<^sub>n="(_,_)", simplified])
      then AOT_obtain z where z_prop: \<open>O!z & ([G]z & [R\<^sub>1]xz & [R\<^sub>2]zv)\<close>
        using "&E" "\<exists>E"[rotated] by blast
      AOT_hence \<open>z =\<^sub>E b\<close> using b_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=z]]
        using "&E" "\<rightarrow>E" "&I" by metis
      AOT_hence \<open>z = b\<close> by (metis eq_E_simple_2[THEN "\<rightarrow>E"])
      AOT_hence \<open>[R\<^sub>1]xb\<close> using z_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)] "=E" by fast
      AOT_thus \<open>x =\<^sub>E c\<close>
        using c_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=x], THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ordx]
              hx "&I" by blast
    qed
  qed
  AOT_show \<open>F \<approx>\<^sub>E H\<close>
    by (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"];
        rule "\<exists>I"(2)[where \<beta>=R];
        cqt_2_lambda?;
        safe intro!: 1 2 "&I" equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I";
        cqt_2_lambda?)
qed
AOT_theorem eq_part_3': \<open>\<Pi> \<approx>\<^sub>E \<Pi>''\<close> if \<open>\<Pi> \<approx>\<^sub>E \<Pi>'\<close> and \<open>\<Pi>' \<approx>\<^sub>E \<Pi>''\<close>
  using eq_part_3[unvarify F G H, THEN "\<rightarrow>E"] eq_den_1 eq_den_2 "\<rightarrow>I" "&I"
  by (metis that(1) that(2))
declare eq_part_3'[trans]

AOT_theorem eq_part_4: \<open>F \<approx>\<^sub>E G \<equiv> \<forall>H (H \<approx>\<^sub>E F \<equiv> H \<approx>\<^sub>E G)\<close>
proof(rule "\<equiv>I"; rule "\<rightarrow>I")
  AOT_assume 0: \<open>F \<approx>\<^sub>E G\<close>
  AOT_hence 1: \<open>G \<approx>\<^sub>E F\<close> using eq_part_2[THEN "\<rightarrow>E"] by blast
  AOT_show \<open>\<forall>H (H \<approx>\<^sub>E F \<equiv> H \<approx>\<^sub>E G)\<close>
  proof (rule GEN; rule "\<equiv>I"; rule "\<rightarrow>I")
    AOT_show \<open>H \<approx>\<^sub>E G\<close> if \<open>H \<approx>\<^sub>E F\<close> for H using 0
      by (meson con_dis_i_e_1 eq_part_3 that vdash_properties_6)
  next
    AOT_show \<open>H \<approx>\<^sub>E F\<close> if \<open>H \<approx>\<^sub>E G\<close> for H using 1
      by (metis con_dis_i_e_1 eq_part_3 that vdash_properties_6)
  qed
next
  AOT_assume \<open>\<forall>H (H \<approx>\<^sub>E F \<equiv> H \<approx>\<^sub>E G)\<close>
  AOT_hence \<open>F \<approx>\<^sub>E F \<equiv> F \<approx>\<^sub>E G\<close> using "\<forall>E" by blast
  AOT_thus \<open>F \<approx>\<^sub>E G\<close> using eq_part_1 "\<equiv>E" by blast
qed

(* TODO_IMPORTANT: PLM states right-to-left direction as well without proof! *)
AOT_theorem eq_part_5: \<open>F \<approx>\<^sub>E G \<rightarrow> \<forall>H ([\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G)\<close>
proof(rule "\<rightarrow>I")
  AOT_assume 0: \<open>F \<approx>\<^sub>E G\<close>
  AOT_hence \<open>\<forall>H (H \<approx>\<^sub>E F \<equiv> H \<approx>\<^sub>E G)\<close>
    using eq_part_4[THEN "\<equiv>E"(1), OF 0] by blast
  AOT_have \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G\<close> for H
    by (rule "\<forall>E"(1)[OF eq_part_4[THEN "\<equiv>E"(1), OF 0]]) cqt_2_lambda
  AOT_thus \<open>\<forall>H ([\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G)\<close> by (rule GEN)
qed

AOT_define equi_rem_1 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> ("_ |: _ \<longrightarrow>E _")
  equi_rem_1: \<open>R |: F \<longrightarrow>E G \<equiv>\<^sub>d\<^sub>f R\<down> & F\<down> & G\<down> & \<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close>

AOT_define equi_rem_2 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> ("_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E _")
  equi_rem_2: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E G \<equiv>\<^sub>d\<^sub>f R |: F \<longrightarrow>E G & \<forall>t\<forall>u\<forall>v (([F]t & [F]u & [G]v) \<rightarrow> ([R]tv & [R]uv \<rightarrow> t =\<^sub>E u))\<close>

AOT_define equi_rem_3 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> ("_ |: _ \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE _")
  equi_rem_3: \<open>R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G \<equiv>\<^sub>d\<^sub>f R |: F \<longrightarrow>E G & \<forall>v ([G]v \<rightarrow> \<exists>u ([F]u & [R]uv))\<close>

AOT_define equi_rem_4 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> ("_ |: _ \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE _")
  equi_rem_4: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G \<equiv>\<^sub>d\<^sub>f R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E G & R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close>

AOT_theorem equi_rem_thm: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G \<equiv> R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close>
proof -
  AOT_have \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G \<equiv> R |: [\<lambda>x O!x & [F]x] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> [\<lambda>x O!x & [G]x]\<close>
  proof(safe intro!: "\<equiv>I" "\<rightarrow>I" "&I")
    AOT_assume \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
    AOT_hence \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> and \<open>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close>
      using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
    AOT_hence a: \<open>O!u \<rightarrow> ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> and b: \<open>O!v \<rightarrow> ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close> for u v
      using "\<forall>E"(2) by blast+
    AOT_have \<open>([\<lambda>x [O!]x & [F]x]x \<rightarrow> \<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]xy))\<close> for x
      apply (AOT_subst \<open>\<guillemotleft>[\<lambda>x [O!]x & [F]x]x\<guillemotright>\<close> \<open>\<guillemotleft>[O!]x & [F]x\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      apply (AOT_subst \<open>\<lambda> \<kappa> . \<guillemotleft>[\<lambda>x [O!]x & [G]x]\<kappa>\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>[O!]\<kappa> & [G]\<kappa>\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      apply (AOT_subst \<open>\<lambda>\<kappa> . \<guillemotleft>O!\<kappa> & [G]\<kappa> & [R]x\<kappa>\<guillemotright>\<close> \<open>\<lambda>\<kappa> .  \<guillemotleft>O!\<kappa> & ([G]\<kappa> & [R]x\<kappa>)\<guillemotright>\<close>)
       apply (meson intro_elim_3_f oth_class_taut_2_b oth_class_taut_3_a)
      apply (rule "\<rightarrow>I") apply (frule "&E"(1)) apply (drule "&E"(2))
      by (fact a[THEN "\<rightarrow>E", THEN "\<rightarrow>E", of x])
    AOT_hence A: \<open>\<forall>x ([\<lambda>x [O!]x & [F]x]x \<rightarrow> \<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]xy))\<close> by (rule GEN)
    AOT_have \<open>([\<lambda>x [O!]x & [G]x]y \<rightarrow> \<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xy))\<close> for y
      apply (AOT_subst \<open>\<guillemotleft>[\<lambda>x [O!]x & [G]x]y\<guillemotright>\<close> \<open>\<guillemotleft>[O!]y & [G]y\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      apply (AOT_subst \<open>\<lambda> \<kappa> . \<guillemotleft>[\<lambda>x [O!]x & [F]x]\<kappa>\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>[O!]\<kappa> & [F]\<kappa>\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      apply (AOT_subst \<open>\<lambda>\<kappa> . \<guillemotleft>O!\<kappa> & [F]\<kappa> & [R]\<kappa>y\<guillemotright>\<close> \<open>\<lambda>\<kappa> .  \<guillemotleft>O!\<kappa> & ([F]\<kappa> & [R]\<kappa>y)\<guillemotright>\<close>)
       apply (meson intro_elim_3_f oth_class_taut_2_b oth_class_taut_3_a)
      apply (rule "\<rightarrow>I") apply (frule "&E"(1)) apply (drule "&E"(2))
      by (fact b[THEN "\<rightarrow>E", THEN "\<rightarrow>E", of y])
    AOT_hence B: \<open>\<forall>y ([\<lambda>x [O!]x & [G]x]y \<rightarrow> \<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xy))\<close> by (rule GEN)
    AOT_show \<open>R |: [\<lambda>x [O!]x & [F]x] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> [\<lambda>x [O!]x & [G]x]\<close>
      by (safe intro!: one_one_cor[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] A B)
          cqt_2_lambda+
  next
    AOT_assume \<open>R |: [\<lambda>x [O!]x & [F]x] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> [\<lambda>x [O!]x & [G]x]\<close>
    AOT_hence a: \<open>([\<lambda>x [O!]x & [F]x]x \<rightarrow> \<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]xy))\<close> and 
              b: \<open>([\<lambda>x [O!]x & [G]x]y \<rightarrow> \<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xy))\<close> for x y
      using one_one_cor[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" "\<forall>E"(2) by blast+
    AOT_have \<open>O!u \<rightarrow> ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> for u
    proof (safe intro!: "\<rightarrow>I")
      AOT_assume ou: \<open>O!u\<close>
      AOT_assume fu: \<open>[F]u\<close>
      AOT_have 0: \<open>[\<lambda>x [O!]x & [F]x]u\<close>
        by (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] ou fu "&I")
      AOT_show \<open>\<exists>!v ([G]v & [R]uv)\<close>
        apply (AOT_subst \<open>\<lambda>\<kappa>. \<guillemotleft>[O!]\<kappa> & ([G]\<kappa> & [R]u\<kappa>)\<guillemotright>\<close> \<open>\<lambda>\<kappa>. \<guillemotleft>([O!]\<kappa> & [G]\<kappa>) & [R]u\<kappa>\<guillemotright>\<close>)
         apply (simp add: oth_class_taut_2_b)
        apply (AOT_subst_rev \<open>\<lambda>\<kappa>. \<guillemotleft>[\<lambda>x [O!]x & [G]x]\<kappa>\<guillemotright>\<close> \<open>\<lambda>\<kappa>. \<guillemotleft>[O!]\<kappa> & [G]\<kappa>\<guillemotright>\<close>)
         apply (rule beta_C_meta[THEN "\<rightarrow>E"])
         apply cqt_2_lambda
        using a[THEN "\<rightarrow>E", OF 0] by blast
    qed
    AOT_hence A: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> by (rule GEN)
    AOT_have \<open>O!v \<rightarrow> ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close> for v
    proof (safe intro!: "\<rightarrow>I")
      AOT_assume ou: \<open>O!v\<close>
      AOT_assume gu: \<open>[G]v\<close>
      AOT_have 0: \<open>[\<lambda>x [O!]x & [G]x]v\<close>
        by (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] ou gu "&I")
      AOT_show \<open>\<exists>!u ([F]u & [R]uv)\<close>
        apply (AOT_subst \<open>\<lambda>\<kappa>. \<guillemotleft>[O!]\<kappa> & ([F]\<kappa> & [R]\<kappa>v)\<guillemotright>\<close> \<open>\<lambda>\<kappa>. \<guillemotleft>([O!]\<kappa> & [F]\<kappa>) & [R]\<kappa>v\<guillemotright>\<close>)
         apply (simp add: oth_class_taut_2_b)
        apply (AOT_subst_rev \<open>\<lambda>\<kappa>. \<guillemotleft>[\<lambda>x [O!]x & [F]x]\<kappa>\<guillemotright>\<close> \<open>\<lambda>\<kappa>. \<guillemotleft>[O!]\<kappa> & [F]\<kappa>\<guillemotright>\<close>)
         apply (rule beta_C_meta[THEN "\<rightarrow>E"])
         apply cqt_2_lambda
        using b[THEN "\<rightarrow>E", OF 0] by blast
    qed
    AOT_hence B: \<open>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close> by (rule GEN)
    AOT_show \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
      by (safe intro!: equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" A B cqt_2_const_var[axiom_inst])
  qed
  also AOT_have \<open>\<dots> \<equiv> R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close>
  proof(safe intro!: "\<equiv>I" "\<rightarrow>I" "&I")
    AOT_assume \<open>R |: [\<lambda>x [O!]x & [F]x] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> [\<lambda>x [O!]x & [G]x]\<close>
    AOT_hence a: \<open>([\<lambda>x [O!]x & [F]x]x \<rightarrow> \<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]xy))\<close> and 
              b: \<open>([\<lambda>x [O!]x & [G]x]y \<rightarrow> \<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xy))\<close> for x y
      using one_one_cor[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" "\<forall>E"(2) by blast+
    AOT_show \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close>
    proof (safe intro!: equi_rem_4[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" equi_rem_3[THEN "\<equiv>\<^sub>d\<^sub>fI"]
                        equi_rem_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] equi_rem_1[THEN "\<equiv>\<^sub>d\<^sub>fI"]
                        cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
      fix u
      AOT_assume ou: \<open>O!u\<close>
      AOT_assume fu: \<open>[F]u\<close>
      AOT_have 0: \<open>[\<lambda>x [O!]x & [F]x]u\<close>
        by (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] ou fu "&I")
      AOT_hence 1: \<open>\<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]uy)\<close> using a[THEN "\<rightarrow>E"] by blast
      AOT_show \<open>\<exists>!v ([G]v & [R]uv)\<close>
        apply (AOT_subst \<open>\<lambda> \<kappa> . \<guillemotleft>[O!]\<kappa> & ([G]\<kappa> & [R]u\<kappa>)\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>([O!]\<kappa> & [G]\<kappa>) & [R]u\<kappa>\<guillemotright>\<close>)
         apply (simp add: oth_class_taut_2_b)
        apply (AOT_subst_rev  \<open>\<lambda> \<kappa> . \<guillemotleft>[\<lambda>x [O!]x & [G]x]\<kappa>\<guillemotright>\<close>  \<open>\<lambda> \<kappa> . \<guillemotleft>[O!]\<kappa> & [G]\<kappa>\<guillemotright>\<close>)
         apply (rule beta_C_meta[THEN "\<rightarrow>E"])
         apply cqt_2_lambda
        by (fact 1)
    next
      fix t u v
      AOT_assume ot: \<open>O!t\<close> and ou: \<open>O!u\<close> and ov: \<open>O!v\<close> and ftu_gv: \<open>[F]t & [F]u & [G]v\<close> and rtv_tuv: \<open>[R]tv & [R]uv\<close>
      AOT_have oft: \<open>[\<lambda>x O!x & [F]x]t\<close>
        by (rule betaC_2_a; cqt_2_lambda)
           (auto simp: cqt_2_const_var[axiom_inst] ot ftu_gv[THEN "&E"(1), THEN "&E"(1)] intro!: "&I")
      AOT_have ofu: \<open>[\<lambda>x O!x & [F]x]u\<close>
        by (rule betaC_2_a; cqt_2_lambda)
           (auto simp: cqt_2_const_var[axiom_inst] ou ftu_gv[THEN "&E"(1), THEN "&E"(2)] intro!: "&I")
      AOT_have ogv: \<open>[\<lambda>x O!x & [G]x]v\<close>
        by (rule betaC_2_a; cqt_2_lambda)
           (auto simp: cqt_2_const_var[axiom_inst] ov ftu_gv[THEN "&E"(2)] intro!: "&I")
      AOT_hence \<open>\<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xv)\<close>
        using b[THEN "\<rightarrow>E"] by blast
      then AOT_obtain a where a_prop: \<open>[\<lambda>x [O!]x & [F]x]a & [R]av & \<forall>x (([\<lambda>x [O!]x & [F]x]x & [R]xv) \<rightarrow> x = a)\<close>
        using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by blast
      AOT_hence ua: \<open>u = a\<close> using ofu rtv_tuv[THEN "&E"(2)] "\<forall>E"(2) "\<rightarrow>E" "&I" "&E"(2) by blast
      moreover AOT_have ta: \<open>t = a\<close> using a_prop oft rtv_tuv[THEN "&E"(1)] "\<forall>E"(2) "\<rightarrow>E" "&I" "&E"(2) by blast
      ultimately AOT_have \<open>t = u\<close> by (metis "rule=E" id_sym)
      AOT_thus \<open>t =\<^sub>E u\<close> using "rule=E" id_sym ord_eq_Eequiv_1 ou ta ua vdash_properties_10 by fast
    next
      fix u
      AOT_assume ou: \<open>O!u\<close> and fu: \<open>[F]u\<close>
      AOT_have \<open>[\<lambda>x O!x & [F]x]u\<close>
        by (rule betaC_2_a; cqt_2_lambda)
            (auto simp: cqt_2_const_var[axiom_inst] ou fu intro!: "&I")
      AOT_hence \<open>\<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]uy)\<close>
        using a[THEN "\<rightarrow>E"] by blast
      then AOT_obtain a where a_prop: \<open>[\<lambda>x [O!]x & [G]x]a & [R]ua & \<forall>x (([\<lambda>x [O!]x & [G]x]x & [R]ux) \<rightarrow> x = a)\<close>
        using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by blast
      AOT_have \<open>O!a & [G]a\<close>
        by (rule betaC_1_a) (auto simp: a_prop[THEN "&E"(1), THEN "&E"(1)])
      AOT_hence \<open>O!a\<close> and \<open>[G]a\<close> using "&E" by blast+
      moreover AOT_have \<open>\<forall>v ([G]v & [R]uv \<rightarrow> v =\<^sub>E a)\<close>
      proof(safe intro!: GEN "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
        fix v
        AOT_assume ov: \<open>O!v\<close> and gv: \<open>[G]v\<close> and ruv: \<open>[R]uv\<close>
        AOT_have \<open>[\<lambda>x [O!]x & [G]x]v\<close>
          by (rule betaC_2_a; cqt_2_lambda)
             (auto simp: cqt_2_const_var[axiom_inst] ov gv intro!: "&I")
        AOT_hence \<open>v = a\<close> using a_prop[THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF "&I"] ruv by blast
        AOT_thus \<open>v =\<^sub>E a\<close> using "rule=E" ord_eq_Eequiv_1 ov vdash_properties_10 by fast
      qed
      ultimately AOT_have \<open>O!a & ([G]a & [R]ua & \<forall>v' ([G]v' & [R]uv' \<rightarrow> v' =\<^sub>E a))\<close>
        using "\<exists>I" "&I" a_prop[THEN "&E"(1), THEN "&E"(2)] by simp
      AOT_hence \<open>\<exists>v ([G]v & [R]uv & \<forall>v' ([G]v' & [R]uv' \<rightarrow> v' =\<^sub>E v))\<close> by (rule "\<exists>I")
      AOT_thus \<open>\<exists>!v ([G]v & [R]uv)\<close>
        by (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    next
      fix v
      AOT_assume ov: \<open>O!v\<close> and gv: \<open>[G]v\<close>
      AOT_have \<open>[\<lambda>x O!x & [G]x]v\<close>
        by (rule betaC_2_a; cqt_2_lambda)
            (auto simp: cqt_2_const_var[axiom_inst] ov gv intro!: "&I")
      AOT_hence \<open>\<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xv)\<close> using b[THEN "\<rightarrow>E"] by blast
      then AOT_obtain a where a_prop: \<open>[\<lambda>x [O!]x & [F]x]a & [R]av & \<forall>y ([\<lambda>x [O!]x & [F]x]y & [R]yv \<rightarrow> y = a)\<close>
        using "uniqueness_1"[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "\<exists>E"[rotated]] by blast
      AOT_have \<open>O!a & [F]a\<close>
        by (rule betaC_1_a) (auto simp: a_prop[THEN "&E"(1), THEN "&E"(1)])
      AOT_hence \<open>O!a & ([F]a & [R]av)\<close> using a_prop[THEN "&E"(1), THEN "&E"(2)] "&E" "&I" by metis
      AOT_thus \<open>\<exists>u ([F]u & [R]uv)\<close> by (rule "\<exists>I")
    qed
  next
    AOT_assume \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close>
    AOT_hence 1: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E G\<close> and 2: \<open>R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close> using equi_rem_4[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
    AOT_hence 3: \<open>R |: F \<longrightarrow>E G\<close> and A: \<open>\<forall>t \<forall>u \<forall>v ([F]t & [F]u & [G]v \<rightarrow> ([R]tv & [R]uv \<rightarrow> t =\<^sub>E u))\<close>
      using equi_rem_2[THEN "\<equiv>\<^sub>d\<^sub>fE", OF 1] "&E" by blast+
    AOT_hence B: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> using equi_rem_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
    AOT_have C: \<open>\<forall>v ([G]v \<rightarrow> \<exists>u ([F]u & [R]uv))\<close> using equi_rem_3[THEN "\<equiv>\<^sub>d\<^sub>fE", OF 2] "&E" by blast
    AOT_show \<open>R |: [\<lambda>x [O!]x & [F]x] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow> [\<lambda>x [O!]x & [G]x]\<close>
    proof (rule one_one_cor[THEN "\<equiv>\<^sub>d\<^sub>fI"]; safe intro!: "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
      AOT_show \<open>[\<lambda>x [O!]x & [F]x]\<down>\<close> by cqt_2_lambda
    next
      AOT_show \<open>[\<lambda>x [O!]x & [G]x]\<down>\<close> by cqt_2_lambda
    next
      fix x
      AOT_assume 1: \<open>[\<lambda>x [O!]x & [F]x]x\<close>
      AOT_have \<open>O!x & [F]x\<close>
        by (rule betaC_1_a) (auto simp: 1)
      AOT_hence \<open>\<exists>!v ([G]v & [R]xv)\<close>
        using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E"] "&E" by blast
      then AOT_obtain y where y_prop: \<open>O!y & ([G]y & [R]xy & \<forall>u ([G]u & [R]xu \<rightarrow> u =\<^sub>E y))\<close>
        using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by fastforce
      AOT_have \<open>[\<lambda>x O!x & [G]x]y\<close>
        by (rule betaC_2_a; cqt_2_lambda)
           (auto simp: cqt_2_const_var[axiom_inst] y_prop[THEN "&E"(1)]
                       y_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)] intro!: "&I")
      moreover AOT_have \<open>\<forall>z ([\<lambda>x O!x & [G]x]z & [R]xz \<rightarrow> z = y)\<close>
      proof(safe intro!: GEN "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
        fix z
        AOT_assume 1: \<open>[\<lambda>x [O!]x & [G]x]z\<close>
        AOT_have 2: \<open>O!z & [G]z\<close>
          by (rule betaC_1_a) (auto simp: 1)
        moreover AOT_assume \<open>[R]xz\<close>
        ultimately AOT_have \<open>z =\<^sub>E y\<close>
          using y_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", rotated, OF "&I"] "&E"
          by blast
        AOT_thus \<open>z = y\<close> using 2[THEN "&E"(1)] by (metis eq_E_simple_2 vdash_properties_10)
      qed
      ultimately AOT_have \<open>[\<lambda>x O!x & [G]x]y & [R]xy & \<forall>z ([\<lambda>x O!x & [G]x]z & [R]xz \<rightarrow> z = y)\<close>
        using y_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)] "&I" by auto
      AOT_hence \<open>\<exists>y ([\<lambda>x O!x & [G]x]y & [R]xy & \<forall>z ([\<lambda>x O!x & [G]x]z & [R]xz \<rightarrow> z = y))\<close>
        by (rule "\<exists>I")
      AOT_thus \<open>\<exists>!y ([\<lambda>x [O!]x & [G]x]y & [R]xy)\<close>
        using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] by fast
    next
      fix y
      AOT_assume 1: \<open>[\<lambda>x [O!]x & [G]x]y\<close>
      AOT_have oy_gy: \<open>O!y & [G]y\<close>
        by (rule betaC_1_a) (auto simp: 1)
      AOT_hence \<open>\<exists>u ([F]u & [R]uy)\<close>
        using C[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E"] "&E" by blast
      then AOT_obtain x where x_prop: \<open>O!x & ([F]x & [R]xy)\<close>
        using "\<exists>E"[rotated] by blast
      AOT_have ofx: \<open>[\<lambda>x O!x & [F]x]x\<close>
        by (rule betaC_2_a; cqt_2_lambda)
           (auto simp: cqt_2_const_var[axiom_inst] x_prop[THEN "&E"(1)]
                       x_prop[THEN "&E"(2), THEN "&E"(1)] intro!: "&I")
      AOT_have \<open>\<exists>\<alpha> ([\<lambda>x [O!]x & [F]x]\<alpha> & [R]\<alpha>y & \<forall>\<beta> ([\<lambda>x [O!]x & [F]x]\<beta> & [R]\<beta>y \<rightarrow> \<beta> = \<alpha>))\<close>
      proof (safe intro!: "\<exists>I"(2)[where \<beta>=x] "&I" GEN "\<rightarrow>I")
        AOT_show \<open>[\<lambda>x O!x & [F]x]x\<close> using ofx.
      next
        AOT_show \<open>[R]xy\<close> using x_prop[THEN "&E"(2), THEN "&E"(2)].
      next
        fix z
        AOT_assume 1: \<open>[\<lambda>x [O!]x & [F]x]z & [R]zy\<close>
        AOT_have oz_fz: \<open>O!z & [F]z\<close>
          by (rule betaC_1_a) (auto simp: 1[THEN "&E"(1)])
        AOT_have \<open>z =\<^sub>E x\<close>
          using A[THEN "\<forall>E"(2)[where \<beta>=z], THEN "\<rightarrow>E", THEN "\<forall>E"(2)[where \<beta>=x], THEN "\<rightarrow>E", THEN "\<forall>E"(2)[where \<beta>=y], THEN "\<rightarrow>E",
                THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF oz_fz[THEN "&E"(1)], OF x_prop[THEN "&E"(1)], OF oy_gy[THEN "&E"(1)], OF "&I", OF "&I",
                OF oz_fz[THEN "&E"(2)], OF x_prop[THEN "&E"(2), THEN "&E"(1)], OF oy_gy[THEN "&E"(2)], OF "&I",
                OF 1[THEN "&E"(2)], OF x_prop[THEN "&E"(2), THEN "&E"(2)]].
        AOT_thus \<open>z = x\<close>
          by (metis eq_E_simple_2 vdash_properties_10)
      qed
      AOT_thus \<open>\<exists>!x ([\<lambda>x [O!]x & [F]x]x & [R]xy)\<close>
        by (rule uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    qed
  qed
  finally show ?thesis.
qed

AOT_define eqE :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (infixl \<open>\<equiv>\<^sub>E\<close> 50)
  eqE: \<open>F \<equiv>\<^sub>E G \<equiv>\<^sub>d\<^sub>f F\<down> & G\<down> & \<forall>u ([F]u \<equiv> [G]u)\<close>

AOT_theorem apE_eqE_1: \<open>F \<equiv>\<^sub>E G \<rightarrow> F \<approx>\<^sub>E G\<close>
proof(rule "\<rightarrow>I")
  AOT_assume 0: \<open>F \<equiv>\<^sub>E G\<close>
  AOT_have \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
  proof (rule_tac \<tau>="\<guillemotleft>(=\<^sub>E)\<guillemotright>" in "\<exists>I"(1);
        safe intro!: equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" eq_E_denotes cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I" equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    fix u
    AOT_assume ordu: \<open>O!u\<close>
    AOT_assume Fu: \<open>[F]u\<close>
    AOT_hence Gu: \<open>[G]u\<close>
      using "\<equiv>\<^sub>d\<^sub>fE"[OF eqE, OF 0, THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=u], THEN "\<rightarrow>E", THEN "\<equiv>E"(1)]
            ordu Fu by blast
    AOT_show \<open>\<exists>v ([G]v & u =\<^sub>E v & \<forall>v' ([G]v' & u =\<^sub>E v' \<rightarrow> v' =\<^sub>E v))\<close>
      by (rule_tac \<beta>=u in "\<exists>I"(2); safe intro!: "&I" GEN "\<rightarrow>I" ordu Gu ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF ordu] ord_eq_Eequiv_2[THEN "\<rightarrow>E"] dest!: "&E"(2))
  next
    fix v
    AOT_assume ordv: \<open>O!v\<close>
    AOT_assume Gv: \<open>[G]v\<close>
    AOT_hence Fv: \<open>[F]v\<close>
      using "\<equiv>\<^sub>d\<^sub>fE"[OF eqE, OF 0, THEN "&E"(2), THEN "\<forall>E"(2)[where \<beta>=v], THEN "\<rightarrow>E", THEN "\<equiv>E"(2)]
            ordv Gv by blast
    AOT_show \<open>\<exists>u ([F]u & u =\<^sub>E v & \<forall>v' ([F]v' & v' =\<^sub>E v \<rightarrow> v' =\<^sub>E u))\<close>
      by (rule_tac \<beta>=v in "\<exists>I"(2); safe intro!: "&I" GEN "\<rightarrow>I" ordv Fv ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF ordv] ord_eq_Eequiv_2[THEN "\<rightarrow>E"] dest!: "&E"(2))
  qed
  AOT_thus \<open>F \<approx>\<^sub>E G\<close>
    by (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"])
qed

AOT_theorem apE_eqE_2: \<open>(F \<approx>\<^sub>E G & G \<equiv>\<^sub>E H) \<rightarrow> F \<approx>\<^sub>E H\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>F \<approx>\<^sub>E G & G \<equiv>\<^sub>E H\<close>
  AOT_hence \<open>F \<approx>\<^sub>E G\<close> and \<open>G \<approx>\<^sub>E H\<close>
    using apE_eqE_1[THEN "\<rightarrow>E"] "&E" by blast+
  AOT_thus \<open>F \<approx>\<^sub>E H\<close>
    by (metis con_dis_taut_5 eq_part_3 vdash_properties_10)
qed

(* TODO_IMPORTANT: PLM states right-to-left direction as well without proof earlier than here! *)
AOT_theorem eq_part_5': \<open>F \<approx>\<^sub>E G \<equiv> \<forall>H ([\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G)\<close>
proof(rule "\<equiv>I"; rule "\<rightarrow>I")
  AOT_assume 0: \<open>F \<approx>\<^sub>E G\<close>
  AOT_thus \<open>\<forall>H ([\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G)\<close> by (rule eq_part_5[THEN "\<rightarrow>E"])
next
  AOT_assume 0: \<open>\<forall>H ([\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F \<equiv> [\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G)\<close>
  AOT_obtain H where \<open>Rigidifies(H,F)\<close> using rigid_der_3 "\<exists>E" by metis
  AOT_hence H: \<open>Rigid(H) & \<forall>x ([H]x \<equiv> [F]x)\<close>
    using df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  AOT_have H_rigid: \<open>\<box>\<forall>x ([H]x \<rightarrow> \<box>[H]x)\<close> using H[THEN "&E"(1), THEN df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)].
  AOT_hence \<open>\<forall>x \<box>([H]x \<rightarrow> \<box>[H]x)\<close>
    using BFs_2 vdash_properties_10 by blast
  AOT_hence \<open>\<box>([H]x \<rightarrow> \<box>[H]x)\<close> for x using "\<forall>E"(2) by blast
  AOT_hence rigid: \<open>[H]x \<equiv> \<^bold>\<A>[H]x\<close> for x
     by (metis intro_elim_3_f oth_class_taut_3_a sc_eq_fur_2 vdash_properties_10)
  AOT_have \<open>H \<equiv>\<^sub>E F\<close>
  proof (safe intro!: eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
    AOT_show \<open>[H]u \<equiv> [F]u\<close> for u using H[THEN "&E"(2)] "\<forall>E"(2) by fast
  qed
  AOT_hence \<open>H \<approx>\<^sub>E F\<close>
    by (rule apE_eqE_2[THEN "\<rightarrow>E", OF "&I", rotated])
       (simp add: eq_part_1)
  AOT_hence F_approx_H: \<open>F \<approx>\<^sub>E H\<close>
    by (metis eq_part_2 vdash_properties_10)
  moreover AOT_have H_eq_act_H: \<open>H \<equiv>\<^sub>E [\<lambda>z \<^bold>\<A>[H]z]\<close>
  proof (safe intro!: eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
    AOT_show \<open>[\<lambda>z \<^bold>\<A>[H]z]\<down>\<close> by cqt_2_lambda
  next
    AOT_show \<open>[H]u \<equiv> [\<lambda>z \<^bold>\<A>[H]z]u\<close> for u
      apply (AOT_subst \<open>\<guillemotleft>[\<lambda>z \<^bold>\<A>[H]z]u\<guillemotright>\<close> \<open>\<guillemotleft>\<^bold>\<A>[H]u\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      using rigid by blast
  qed
  AOT_have a: \<open>F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[H]z]\<close>
    apply (rule apE_eqE_2[unvarify H, THEN "\<rightarrow>E"])
     apply cqt_2_lambda
    using F_approx_H H_eq_act_H "&I" by blast
  AOT_hence \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F\<close>
    apply (rule eq_part_2[unvarify G, THEN "\<rightarrow>E", rotated])
    by cqt_2_lambda
  AOT_hence b: \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E G\<close>
    by (rule 0[THEN "\<forall>E"(1), THEN "\<equiv>E"(1), rotated]) (rule cqt_2_const_var[axiom_inst]) 
  AOT_show \<open>F \<approx>\<^sub>E G\<close>
    by (rule eq_part_3[unvarify G, THEN "\<rightarrow>E", rotated, OF "&I", OF a, OF b])
       cqt_2_lambda
qed


AOT_theorem empty_approx_1: \<open>(\<not>\<exists>u [F]u & \<not>\<exists>v [H]v) \<rightarrow> F \<approx>\<^sub>E H\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume 0: \<open>\<not>\<exists>u [F]u\<close> and 1: \<open>\<not>\<exists>v [H]v\<close>
  AOT_have \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([H]v & [R]uv))\<close> for R
  proof(rule GEN; rule "\<rightarrow>I"; rule "\<rightarrow>I"; rule raa_cor_1)
    fix u
    AOT_assume \<open>O!u\<close> and \<open>[F]u\<close>
    AOT_hence \<open>\<exists>u [F]u\<close> using "\<exists>I"(2) "&I" by fast
    AOT_thus \<open>\<exists>u [F]u & \<not>\<exists>u [F]u\<close> using 0 "&I" by blast
  qed
  moreover AOT_have \<open>\<forall>v ([H]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close> for R
  proof(rule GEN; rule "\<rightarrow>I"; rule "\<rightarrow>I"; rule raa_cor_1)
    fix v
    AOT_assume \<open>O!v\<close> and \<open>[H]v\<close>
    AOT_hence \<open>\<exists>v [H]v\<close> using "\<exists>I"(2) "&I" by fast
    AOT_thus \<open>\<exists>v [H]v & \<not>\<exists>v [H]v\<close> using 1 "&I" by blast
  qed
  (* TODO: PLM: incorrectly states R |: F \<longrightarrow> H instead *)
  ultimately AOT_have \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E H\<close> for R
    apply (safe intro!: equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" GEN cqt_2_const_var[axiom_inst])
    using "\<forall>E" by blast+
  AOT_hence \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E H\<close> by (rule "\<exists>I")
  AOT_thus \<open>F \<approx>\<^sub>E H\<close>
    by (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"])
qed

AOT_theorem empty_approx_2: \<open>(\<exists>u [F]u & \<not>\<exists>v [H]v) \<rightarrow> \<not>(F \<approx>\<^sub>E H)\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2); rule raa_cor_2)
  AOT_assume 1: \<open>\<exists>u [F]u\<close> and 2: \<open>\<not>\<exists>v [H]v\<close>
  AOT_obtain b where b_prop: \<open>O!b & [F]b\<close> using 1 "\<exists>E"[rotated] by blast
  AOT_assume \<open>F \<approx>\<^sub>E H\<close>
  AOT_hence \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E H\<close>
    by (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"])
  then AOT_obtain R where \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E H\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<theta>: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([H]v & [R]uv))\<close> and \<open>\<forall>v ([H]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_have \<open>\<exists>!v ([H]v & [R]bv)\<close> for u
    using \<theta>[THEN "\<forall>E"(2)[where \<beta>=b], THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF b_prop[THEN "&E"(1)], OF b_prop[THEN "&E"(2)]].
  AOT_hence \<open>\<exists>v ([H]v & [R]bv & \<forall>u ([H]u & [R]bu \<rightarrow> u =\<^sub>E v))\<close>
    by (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"])
  then AOT_obtain x where \<open>O!x & ([H]x & [R]bx & \<forall>u ([H]u & [R]bu \<rightarrow> u =\<^sub>E x))\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>O!x & [H]x\<close> using "&E" "&I" by blast
  AOT_hence \<open>\<exists>v [H]v\<close> by (rule "\<exists>I")
  AOT_thus \<open>\<exists>v [H]v & \<not>\<exists>v [H]v\<close> using 2 "&I" by blast
qed

AOT_define F_minus_u :: \<open>\<Pi> \<Rightarrow> \<tau> \<Rightarrow> \<Pi>\<close> ("_\<^sup>-\<^sup>_")
  F_minus_u: \<open>[F]\<^sup>-\<^sup>x =\<^sub>d\<^sub>f [\<lambda>z [F]z & z \<noteq>\<^sub>E x]\<close>

(* TODO: not in PLM *)
AOT_theorem F_minus_u_den: \<open>[F]\<^sup>-\<^sup>x\<down>\<close>
  by (rule "=\<^sub>d\<^sub>fI"(1)[OF F_minus_u, where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified]; cqt_2_lambda)

AOT_theorem eqP':
  assumes ou: \<open>O!u\<close> and ov: \<open>O!v\<close>
  shows \<open>F \<approx>\<^sub>E G & [F]u & [G]v \<rightarrow> [F]\<^sup>-\<^sup>u \<approx>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
proof (rule "\<rightarrow>I"; frule "&E"(2); drule "&E"(1); frule "&E"(2); drule "&E"(1))
  AOT_assume \<open>F \<approx>\<^sub>E G\<close>
  AOT_hence \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain R where R_prop: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close> using "\<exists>E"[rotated] by blast
  AOT_hence A: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> and B: \<open>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_have \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close> using equi_rem_thm[THEN "\<equiv>E"(1), OF R_prop].
  AOT_hence \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E G & R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close> using equi_rem_4[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  AOT_hence C: \<open>\<forall>t\<forall>u\<forall>v (([F]t & [F]u & [G]v) \<rightarrow> ([R]tv & [R]uv \<rightarrow> t =\<^sub>E u))\<close>
    using equi_rem_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
  AOT_assume fu: \<open>[F]u\<close>
  AOT_assume gv: \<open>[G]v\<close>
  AOT_have \<open>[\<lambda>z [\<Pi>]z & z \<noteq>\<^sub>E \<kappa>]\<down>\<close> for \<Pi> \<kappa> by cqt_2_lambda
  note \<Pi>_minus_\<kappa>I = rule_id_def_2_b_2[where \<tau>=\<open>(\<lambda>(\<Pi>, \<kappa>). \<guillemotleft>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<guillemotright>)\<close>, simplified, OF F_minus_u, simplified, OF this]
   and \<Pi>_minus_\<kappa>E = rule_id_def_2_a_2[where \<tau>=\<open>(\<lambda>(\<Pi>, \<kappa>). \<guillemotleft>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<guillemotright>)\<close>, simplified, OF F_minus_u, simplified, OF this]
  AOT_have \<Pi>_minus_\<kappa>_den: \<open>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<down>\<close> for \<Pi> \<kappa> (* TODO: PLM: quietly dismissed *)
    by (rule \<Pi>_minus_\<kappa>I) cqt_2_lambda+
  {
    fix R
    AOT_assume R_prop: \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
    AOT_hence A: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> and B: \<open>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close>
      using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
    AOT_have \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close> using equi_rem_thm[THEN "\<equiv>E"(1), OF R_prop].
    AOT_hence \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E G & R |: F \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<close> using equi_rem_4[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
    AOT_hence C: \<open>\<forall>t\<forall>u\<forall>v (([F]t & [F]u & [G]v) \<rightarrow> ([R]tv & [R]uv \<rightarrow> t =\<^sub>E u))\<close>
      using equi_rem_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast

    AOT_assume Ruv: \<open>[R]uv\<close>
    AOT_have \<open>R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
    proof(safe intro!: equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] \<Pi>_minus_\<kappa>_den GEN "\<rightarrow>I")
      fix u'
      AOT_assume ou': \<open>O!u'\<close>
      AOT_assume \<open>[[F]\<^sup>-\<^sup>u]u'\<close>
      AOT_hence 0: \<open>[\<lambda>z [F]z & z \<noteq>\<^sub>E u]u'\<close> using \<Pi>_minus_\<kappa>E by fast
      AOT_have 0: \<open>[F]u' & u' \<noteq>\<^sub>E u\<close>
        by (rule betaC_1_a[where \<kappa>\<^sub>1\<kappa>\<^sub>n="AOT_term_of_var u'"]) (fact 0)
      AOT_have \<open>\<exists>!v ([G]v & [R]u'v)\<close>
        using A[THEN "\<forall>E"(2)[where \<beta>=u'], THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ou', OF 0[THEN "&E"(1)]].
      then AOT_obtain v' where v'_prop: \<open>O!v' & ([G]v' & [R]u'v' & \<forall> t ([G]t & [R]u't \<rightarrow> t =\<^sub>E v'))\<close>
        using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by fastforce

      AOT_show \<open>\<exists>!v' ([[G]\<^sup>-\<^sup>v]v' & [R]u'v')\<close>
      proof (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"]; rule_tac \<beta>=v' in "\<exists>I"(2); safe intro!: "&I" GEN "\<rightarrow>I")
        AOT_show \<open>O!v'\<close> using v'_prop "&E" by blast
      next
        AOT_show \<open>[[G]\<^sup>-\<^sup>v]v'\<close>
        proof (rule \<Pi>_minus_\<kappa>I; rule betaC_2_a; cqt_2_lambda;
               safe intro!: cqt_2_const_var[axiom_inst] "&I" thm_neg_eq_E[THEN "\<equiv>E"(2)])
          AOT_show \<open>[G]v'\<close> using v'_prop "&E" by blast
        next
          AOT_show \<open>\<not>v' =\<^sub>E v\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>v' =\<^sub>E v\<close>
            AOT_hence \<open>v' = v\<close> by (metis eq_E_simple_2 vdash_properties_10)
            AOT_hence Ruv': \<open>[R]uv'\<close> using "rule=E" Ruv id_sym by fast
            AOT_have \<open>u' =\<^sub>E u\<close>
              by (rule C[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<forall>E"(2),
                          THEN "\<rightarrow>E", THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ou', OF ou, OF v'_prop[THEN "&E"(1)]];
                   safe intro!: "&I" 0[THEN "&E"(1)] fu v'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
                                Ruv' v'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)])
            moreover AOT_have \<open>\<not>(u' =\<^sub>E u)\<close>
              using "0" con_dis_i_e_2_b intro_elim_3_a thm_neg_eq_E by blast
            ultimately AOT_show \<open>u' =\<^sub>E u & \<not>u' =\<^sub>E u\<close> using "&I" by blast
          qed
        qed
      next
        AOT_show \<open>[R]u'v'\<close> using v'_prop "&E" by blast
      next
        fix t
        AOT_assume ot: \<open>O!t\<close> and t_prop: \<open>[[G]\<^sup>-\<^sup>v]t & [R]u't\<close>
        AOT_have gt_t_noteq_v: \<open>[G]t & t \<noteq>\<^sub>E v\<close>
          apply (rule betaC_1_a[where \<kappa>\<^sub>1\<kappa>\<^sub>n="AOT_term_of_var t"])
          apply (rule \<Pi>_minus_\<kappa>E)
          by (fact t_prop[THEN "&E"(1)])
        AOT_show \<open>t =\<^sub>E v'\<close>
          using v'_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ot, THEN "\<rightarrow>E",
                        OF "&I", OF gt_t_noteq_v[THEN "&E"(1)], OF t_prop[THEN "&E"(2)]].
      qed
    next
      fix v'
      AOT_assume ov': \<open>O!v'\<close>
      AOT_assume G_minus_v_v': \<open>[[G]\<^sup>-\<^sup>v]v'\<close>
      AOT_have gt_t_noteq_v: \<open>[G]v' & v' \<noteq>\<^sub>E v\<close>
        apply (rule betaC_1_a[where \<kappa>\<^sub>1\<kappa>\<^sub>n="AOT_term_of_var v'"])
        apply (rule \<Pi>_minus_\<kappa>E)
        by (fact G_minus_v_v')
      AOT_have \<open>\<exists>!u([F]u & [R]uv')\<close> using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ov', OF gt_t_noteq_v[THEN "&E"(1)]].
      then AOT_obtain u' where u'_prop: \<open>O!u' & ([F]u' & [R]u'v' & \<forall>t ([F]t & [R]tv' \<rightarrow> t =\<^sub>E u'))\<close>
        using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by fastforce
      AOT_show \<open>\<exists>!u' ([[F]\<^sup>-\<^sup>u]u' & [R]u'v')\<close>
      proof (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"]; rule_tac \<beta>=u' in "\<exists>I"(2);
             safe intro!: "&I" GEN "\<rightarrow>I" u'_prop[THEN "&E"(1)] u'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)])
        AOT_show \<open>[[F]\<^sup>-\<^sup>u]u'\<close>
        proof (rule \<Pi>_minus_\<kappa>I; rule betaC_2_a; cqt_2_lambda;
               safe intro!: cqt_2_const_var[axiom_inst] "&I" thm_neg_eq_E[THEN "\<equiv>E"(2)]
                            u'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)];
               rule raa_cor_2)
          AOT_assume u'_eq_u: \<open>u' =\<^sub>E u\<close>
          AOT_hence \<open>u' = u\<close>
            using eq_E_simple_2 vdash_properties_10 by blast
          AOT_hence Ru'v: \<open>[R]u'v\<close> using "rule=E" Ruv id_sym by fast
          AOT_have \<open>v' \<noteq>\<^sub>E v\<close>
            using con_dis_i_e_2_b gt_t_noteq_v by blast
          AOT_hence v'_noteq_v: \<open>\<not>(v' =\<^sub>E v)\<close> by (metis intro_elim_3_a thm_neg_eq_E)
          AOT_have \<open>\<exists>u ([G]u & [R]u'u & \<forall>v ([G]v & [R]u'v \<rightarrow> v =\<^sub>E u))\<close>
            using A[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF u'_prop[THEN "&E"(1)],
                             OF u'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)],
                             THEN equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"]].
          then AOT_obtain t where t_prop: \<open>O!t & ([G]t & [R]u't & \<forall>v ([G]v & [R]u'v \<rightarrow> v =\<^sub>E t))\<close>
            using "\<exists>E"[rotated] by blast
          AOT_have \<open>v =\<^sub>E t\<close> if \<open>O!v\<close> and \<open>[G]v\<close> and \<open>[R]u'v\<close> for v
            using t_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF that(1), THEN "\<rightarrow>E", OF "&I", OF that(2), OF that(3)].
          AOT_hence \<open>v' =\<^sub>E t\<close> and \<open>v =\<^sub>E t\<close>
            by (auto simp: ov' gt_t_noteq_v[THEN "&E"(1)] u'_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)] Ru'v ov gv)
          AOT_hence \<open>v' =\<^sub>E v\<close> using "rule=E" eq_E_simple_2 id_sym vdash_properties_10 by fast
          AOT_thus \<open>v' =\<^sub>E v & \<not>v' =\<^sub>E v\<close> using v'_noteq_v "&I" by blast
        qed
      next
        fix t
        AOT_assume ot: \<open>O!t\<close>
        AOT_assume 0: \<open>[[F]\<^sup>-\<^sup>u]t & [R]tv'\<close>
        moreover AOT_have \<open>[F]t & t \<noteq>\<^sub>E u\<close>
          apply (rule betaC_1_a[where \<kappa>\<^sub>1\<kappa>\<^sub>n="AOT_term_of_var t"])
          apply (rule \<Pi>_minus_\<kappa>E)
          by (fact 0[THEN "&E"(1)])
        ultimately AOT_show \<open>t =\<^sub>E u'\<close>
          using u'_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ot, THEN "\<rightarrow>E", OF "&I"]
                "&E" by blast
      qed
    qed
    AOT_hence \<open>\<exists>R R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close> by (rule "\<exists>I")
  } note 1 = this
  moreover {
    AOT_assume not_Ruv: \<open>\<not>[R]uv\<close>
    AOT_have \<open>\<exists>!v ([G]v & [R]uv)\<close> using A[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ou, OF fu].
    then AOT_obtain b where b_prop: \<open>O!b & ([G]b & [R]ub & \<forall>t([G]t & [R]ut \<rightarrow> t =\<^sub>E b))\<close>
      using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by fastforce
    AOT_hence ob: \<open>O!b\<close> and gb: \<open>[G]b\<close> and Rub: \<open>[R]ub\<close> using "&E" by blast+
    AOT_have \<open>O!t \<rightarrow> ([G]t & [R]ut \<rightarrow> t =\<^sub>E b)\<close> for t using b_prop "&E"(2) "\<forall>E"(2) by blast
    AOT_hence b_unique: \<open>t =\<^sub>E b\<close> if \<open>O!t\<close> and \<open>[G]t\<close> and \<open>[R]ut\<close> for t
      by (metis con_dis_taut_5 modus_tollens_1 reductio_aa_1 that)
    AOT_have not_v_eq_b: \<open>\<not>(v =\<^sub>E b)\<close>
    proof(rule raa_cor_2)
      AOT_assume \<open>v =\<^sub>E b\<close>
      AOT_hence 0: \<open>v = b\<close> by (metis eq_E_simple_2 vdash_properties_10)
      AOT_have \<open>[R]uv\<close> using b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)] "rule=E"[rotated, OF 0[symmetric]] by fast
      AOT_thus \<open>[R]uv & \<not>[R]uv\<close> using not_Ruv "&I" by blast
    qed
    AOT_have not_b_eq_v: \<open>\<not>(b =\<^sub>E v)\<close>
      using modus_tollens_1 not_v_eq_b ord_eq_Eequiv_2 by blast
    AOT_have \<open>\<exists>!u ([F]u & [R]uv)\<close> using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ov, OF gv].
    then AOT_obtain a where a_prop: \<open>O!a & ([F]a & [R]av & \<forall>t([F]t & [R]tv \<rightarrow> t =\<^sub>E a))\<close>
      using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "\<exists>E"[rotated] by fastforce
    AOT_hence oa: \<open>O!a\<close> and fa: \<open>[F]a\<close> and Rav: \<open>[R]av\<close> using "&E" by blast+
    AOT_have \<open>O!t \<rightarrow> ([F]t & [R]tv \<rightarrow> t =\<^sub>E a)\<close> for t using a_prop "&E" "\<forall>E"(2) by blast
    AOT_hence a_unique: \<open>t =\<^sub>E a\<close> if \<open>O!t\<close> and \<open>[F]t\<close> and \<open>[R]tv\<close> for t
      by (metis con_dis_taut_5 modus_tollens_1 reductio_aa_1 that) 
    AOT_have not_u_eq_a: \<open>\<not>(u =\<^sub>E a)\<close>
    proof(rule raa_cor_2)
      AOT_assume \<open>u =\<^sub>E a\<close>
      AOT_hence 0: \<open>u = a\<close> by (metis eq_E_simple_2 vdash_properties_10)
      AOT_have \<open>[R]uv\<close> using a_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)] "rule=E"[rotated, OF 0[symmetric]] by fast
      AOT_thus \<open>[R]uv & \<not>[R]uv\<close> using not_Ruv "&I" by blast
    qed
    AOT_have not_a_eq_u: \<open>\<not>(a =\<^sub>E u)\<close>
      using modus_tollens_1 not_u_eq_a ord_eq_Eequiv_2 by blast
    let ?R = \<open>\<guillemotleft>[\<lambda>u'v' (u' \<noteq>\<^sub>E u & v' \<noteq>\<^sub>E v & [R]u'v') \<or> (u' =\<^sub>E a & v' =\<^sub>E b) \<or> (u' =\<^sub>E u & v' =\<^sub>E v)]\<guillemotright>\<close>
    AOT_have \<open>[\<guillemotleft>?R\<guillemotright>]\<down>\<close> by cqt_2_lambda
    AOT_hence \<open>\<exists> \<beta> \<beta> = [\<guillemotleft>?R\<guillemotright>]\<close> using free_thms_1 intro_elim_3_a by fast
    then AOT_obtain R\<^sub>1 where R\<^sub>1_def: \<open>R\<^sub>1 = [\<guillemotleft>?R\<guillemotright>]\<close> using "\<exists>E"[rotated] by blast
    AOT_have Rxy1: \<open>[R]xy\<close> if \<open>[R\<^sub>1]xy\<close> and \<open>x \<noteq>\<^sub>E u\<close> and \<open>x \<noteq>\<^sub>E a\<close> for x y
    proof -
      AOT_have 0: \<open>[\<guillemotleft>?R\<guillemotright>]xy\<close>
        by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact that(1))
      AOT_have \<open>(x \<noteq>\<^sub>E u & y \<noteq>\<^sub>E v & [R]xy) \<or> (x =\<^sub>E a & y =\<^sub>E b) \<or> (x =\<^sub>E u & y =\<^sub>E v)\<close>
        using betaC_1_a[OF 0] by simp
      AOT_hence \<open>x \<noteq>\<^sub>E u & y \<noteq>\<^sub>E v & [R]xy\<close> using that(2,3)
        by (metis con_dis_i_e_4_c con_dis_taut_1 intro_elim_3_a modus_tollens_1 thm_neg_eq_E)
      AOT_thus \<open>[R]xy\<close> using "&E" by blast+
    qed
    AOT_have Rxy2: \<open>[R]xy\<close>  if \<open>[R\<^sub>1]xy\<close> and \<open>y \<noteq>\<^sub>E v\<close> and \<open>y \<noteq>\<^sub>E b\<close> for x y
    proof -
      AOT_have 0: \<open>[\<guillemotleft>?R\<guillemotright>]xy\<close>
        by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact that(1))
      AOT_have \<open>(x \<noteq>\<^sub>E u & y \<noteq>\<^sub>E v & [R]xy) \<or> (x =\<^sub>E a & y =\<^sub>E b) \<or> (x =\<^sub>E u & y =\<^sub>E v)\<close>
        using betaC_1_a[OF 0] by simp
      AOT_hence \<open>x \<noteq>\<^sub>E u & y \<noteq>\<^sub>E v & [R]xy\<close> using that(2,3)
        by (metis con_dis_i_e_4_c con_dis_taut_2 intro_elim_3_a modus_tollens_1 thm_neg_eq_E)
      AOT_thus \<open>[R]xy\<close> using "&E" by blast+
    qed
    AOT_have R\<^sub>1xy: \<open>[R\<^sub>1]xy\<close> if \<open>[R]xy\<close> and \<open>x \<noteq>\<^sub>E u\<close> and \<open>y \<noteq>\<^sub>E v\<close> for x y
      apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
      apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
      using that con_dis_i_e_1 con_dis_i_e_3_a by presburger
    AOT_have R\<^sub>1ab: \<open>[R\<^sub>1]ab\<close>
      apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
      apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
      by (meson a_prop b_prop con_dis_i_e_1 con_dis_i_e_2_a con_dis_i_e_3_a con_dis_i_e_3_b ord_eq_Eequiv_1 vdash_properties_10)
    AOT_have R\<^sub>1uv: \<open>[R\<^sub>1]uv\<close>
      apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
      apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
      by (meson con_dis_i_e_1 con_dis_i_e_3_b ord_eq_Eequiv_1 ou ov vdash_properties_10)
    moreover AOT_have \<open>R\<^sub>1 |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
    proof (safe intro!: equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
      fix u'
      AOT_assume ou': \<open>O!u'\<close>
      AOT_assume fu': \<open>[F]u'\<close>
      {
        AOT_assume not_u'_eq_u: \<open>\<not>(u' =\<^sub>E u)\<close> and not_u'_eq_a: \<open>\<not>(u' =\<^sub>E a)\<close>
        AOT_hence u'_noteq_u: \<open>u' \<noteq>\<^sub>E u\<close> and u'_noteq_a: \<open>u' \<noteq>\<^sub>E a\<close> by (metis intro_elim_3_b thm_neg_eq_E)+
        AOT_have \<open>\<exists>!v ([G]v & [R]u'v)\<close> using A[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ou', OF fu'].
        AOT_hence \<open>\<exists>v ([G]v & [R]u'v & \<forall>t ([G]t & [R]u't \<rightarrow> t =\<^sub>E v))\<close>
          using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by simp
        then AOT_obtain v' where v'_prop: \<open>O!v' & ([G]v' & [R]u'v' & \<forall>t ([G]t & [R]u't \<rightarrow> t =\<^sub>E v'))\<close>
          using "\<exists>E"[rotated] by blast
        AOT_hence ov': \<open>O!v'\<close> and gv': \<open>[G]v'\<close> and Ru'v': \<open>[R]u'v'\<close>
          using "&E" by blast+
        AOT_have not_v'_eq_v: \<open>\<not>v' =\<^sub>E v\<close>
        proof (rule raa_cor_2)
          AOT_assume \<open>v' =\<^sub>E v\<close>
          AOT_hence \<open>v' = v\<close> by (metis eq_E_simple_2 vdash_properties_6)
          AOT_hence Ru'v: \<open>[R]u'v\<close> using "rule=E" Ru'v' by fast
          AOT_have \<open>u' =\<^sub>E a\<close> using a_unique[OF ou', OF fu', OF Ru'v].
          AOT_thus \<open>u' =\<^sub>E a & \<not>u' =\<^sub>E a\<close> using not_u'_eq_a "&I" by blast
        qed
        AOT_hence v'_noteq_v: \<open>v' \<noteq>\<^sub>E v\<close>
          using intro_elim_3_b thm_neg_eq_E by blast
        AOT_have \<open>\<forall>t ([G]t & [R]u't \<rightarrow> t =\<^sub>E v')\<close> using v'_prop "&E" by blast
        AOT_hence \<open>O!t \<rightarrow> ([G]t & [R]u't \<rightarrow> t =\<^sub>E v')\<close> for t using "\<forall>E"(2) by blast
        AOT_hence v'_unique: \<open>t =\<^sub>E v'\<close> if \<open>O!t\<close> and \<open>[G]t\<close> and \<open>[R]u't\<close> for t
          by (metis con_dis_i_e_1 that vdash_properties_10)

        AOT_have \<open>O!v' & ([G]v' & [R\<^sub>1]u'v' & \<forall>t ([G]t & [R\<^sub>1]u't \<rightarrow> t =\<^sub>E v'))\<close>
        proof (safe intro!: "&I" ov' gv' R\<^sub>1xy Ru'v' u'_noteq_u u'_noteq_a GEN "\<rightarrow>I" thm_neg_eq_E[THEN "\<equiv>E"(2)] not_v'_eq_v)
          fix t
          AOT_assume 0: \<open>O!t\<close>
          AOT_assume 1: \<open>[G]t & [R\<^sub>1]u't\<close>
          AOT_have \<open>[R]u't\<close> using Rxy1[OF 1[THEN "&E"(2)], OF u'_noteq_u, OF u'_noteq_a].
          AOT_thus \<open>t =\<^sub>E v'\<close>
            using v'_unique[OF 0] 1[THEN "&E"(1)] by blast
        qed
        AOT_hence \<open>\<exists>v ([G]v & [R\<^sub>1]u'v & \<forall>t ([G]t & [R\<^sub>1]u't \<rightarrow> t =\<^sub>E v))\<close>
          by (rule "\<exists>I")
        AOT_hence \<open>\<exists>!v ([G]v & [R\<^sub>1]u'v)\<close>
          by (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
      }
      moreover {
        AOT_assume 0: \<open>u' =\<^sub>E u\<close>
        AOT_hence u'_eq_u: \<open>u' = u\<close>
          using eq_E_simple_2 vdash_properties_6 by blast
        AOT_have \<open>\<exists>!v ([G]v & [R\<^sub>1]u'v)\<close>
        proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=v] "&I" GEN "\<rightarrow>I" ov gv)
          AOT_show \<open>[R\<^sub>1]u'v\<close>
            apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
            apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
            by (safe intro!: "\<or>I"(2) "&I" 0 ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF ov])
        next
          fix v'
          AOT_assume \<open>O!v'\<close>
          AOT_assume \<open>[G]v' & [R\<^sub>1]u'v'\<close>
          AOT_hence 0: \<open>[R\<^sub>1]uv'\<close> using "rule=E"[rotated, OF u'_eq_u] "&E"(2) by fast
          AOT_have 1: \<open>[\<guillemotleft>?R\<guillemotright>]uv'\<close>
            by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact 0)
          AOT_have 2: \<open>(u \<noteq>\<^sub>E u & v' \<noteq>\<^sub>E v & [R]uv') \<or> (u =\<^sub>E a & v' =\<^sub>E b) \<or> (u =\<^sub>E u & v' =\<^sub>E v)\<close>
            using betaC_1_a[OF 1] by simp
          AOT_have \<open>\<not>u \<noteq>\<^sub>E u\<close>
            using intro_elim_3_d modus_tollens_1 ord_eq_Eequiv_1 ou reductio_aa_2 thm_neg_eq_E by blast
          AOT_hence \<open>\<not>((u \<noteq>\<^sub>E u & v' \<noteq>\<^sub>E v & [R]uv') \<or> (u =\<^sub>E a & v' =\<^sub>E b))\<close>
            using not_u_eq_a by (metis con_dis_i_e_4_b con_dis_taut_1 modus_tollens_1 reductio_aa_1)
          AOT_hence \<open>(u =\<^sub>E u & v' =\<^sub>E v)\<close> using 2 by (metis con_dis_i_e_4_b)
          AOT_thus \<open>v' =\<^sub>E v\<close> using "&E" by blast
        qed
      }
      moreover {
        AOT_assume 0: \<open>u' =\<^sub>E a\<close>
        AOT_hence u'_eq_a: \<open>u' = a\<close>
          using eq_E_simple_2 vdash_properties_10 by blast
        AOT_have \<open>\<exists>!v ([G]v & [R\<^sub>1]u'v)\<close>
        proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=b] "&I" GEN "\<rightarrow>I" b_prop[THEN "&E"(1)]
                            b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)])
          AOT_show \<open>[R\<^sub>1]u'b\<close>
            apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
            apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
            apply (rule "\<or>I"(1); rule "\<or>I"(2); rule "&I")
             apply (fact 0)
            using b_prop con_dis_i_e_2_a ord_eq_Eequiv_1 vdash_properties_10 by blast
        next
          fix v'
          AOT_assume ov': \<open>O!v'\<close>
          AOT_assume gv'_R1u'v': \<open>[G]v' & [R\<^sub>1]u'v'\<close>
          AOT_hence 0: \<open>[R\<^sub>1]av'\<close> using u'_eq_a by (meson "rule=E" con_dis_i_e_2_b)
          AOT_have 1: \<open>[\<guillemotleft>?R\<guillemotright>]av'\<close>
            by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact 0)
          AOT_have \<open>(a \<noteq>\<^sub>E u & v' \<noteq>\<^sub>E v & [R]av') \<or> (a =\<^sub>E a & v' =\<^sub>E b) \<or> (a =\<^sub>E u & v' =\<^sub>E v)\<close>
            using betaC_1_a[OF 1] by simp
          moreover {
            AOT_assume 0: \<open>a \<noteq>\<^sub>E u & v' \<noteq>\<^sub>E v & [R]av'\<close>
            AOT_have \<open>\<exists>!v ([G]v & [R]u'v)\<close> using A[THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou', THEN "\<rightarrow>E", OF fu'].
            AOT_hence \<open>\<exists>!v ([G]v & [R]av)\<close> using u'_eq_a "rule=E" by fast
            AOT_hence \<open>\<exists>v ([G]v & [R]av & \<forall>t ([G]t & [R]at \<rightarrow> t =\<^sub>E v))\<close>
              using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by fast
            then AOT_obtain s where s_prop: \<open>O!s & ([G]s & [R]as & \<forall>t ([G]t & [R]at \<rightarrow> t =\<^sub>E s))\<close> using "\<exists>E"[rotated] by blast
            AOT_have \<open>v' =\<^sub>E s\<close> using s_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ov']
                                     gv'_R1u'v'[THEN "&E"(1)] 0[THEN "&E"(2)]
              by (metis con_dis_i_e_1 vdash_properties_10)
            moreover AOT_have \<open>v =\<^sub>E s\<close> using s_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ov]
                                    gv Rav by (metis con_dis_i_e_1 vdash_properties_10)
            ultimately AOT_have \<open>v' =\<^sub>E v\<close>
              by (metis con_dis_i_e_1 ord_eq_Eequiv_2 ord_eq_Eequiv_3 vdash_properties_10)
            moreover AOT_have \<open>\<not>(v' =\<^sub>E v)\<close> using 0[THEN "&E"(1), THEN "&E"(2)] by (metis intro_elim_3_a thm_neg_eq_E) 
            ultimately AOT_have \<open>v' =\<^sub>E b\<close> by (metis raa_cor_3)
          }
          moreover {
            AOT_assume \<open>a =\<^sub>E u & v' =\<^sub>E v\<close>
            AOT_hence \<open>v' =\<^sub>E b\<close> by (metis con_dis_i_e_2_a not_a_eq_u reductio_aa_1)
          }
          ultimately AOT_show \<open>v' =\<^sub>E b\<close> by (metis con_dis_i_e_2_b con_dis_i_e_4_c reductio_aa_1) 
        qed
      }
      ultimately AOT_show \<open>\<exists>!v ([G]v & [R\<^sub>1]u'v)\<close> by (metis raa_cor_1)
    next
      fix v'
      AOT_assume ov': \<open>O!v'\<close>
      AOT_assume gv': \<open>[G]v'\<close>
      {
        AOT_assume not_v'_eq_v: \<open>\<not>(v' =\<^sub>E v)\<close> and not_v'_eq_b: \<open>\<not>(v' =\<^sub>E b)\<close>
        AOT_hence v'_noteq_v: \<open>v' \<noteq>\<^sub>E v\<close> and v'_noteq_b: \<open>v' \<noteq>\<^sub>E b\<close> by (metis intro_elim_3_b thm_neg_eq_E)+
        AOT_have \<open>\<exists>!u ([F]u & [R]uv')\<close> using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF ov', OF gv'].
        AOT_hence \<open>\<exists>u ([F]u & [R]uv' & \<forall>t ([F]t & [R]tv' \<rightarrow> t =\<^sub>E u))\<close>
          using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by simp
        then AOT_obtain u' where u'_prop: \<open>O!u' & ([F]u' & [R]u'v' & \<forall>t ([F]t & [R]tv' \<rightarrow> t =\<^sub>E u'))\<close>
          using "\<exists>E"[rotated] by blast
        AOT_hence ou': \<open>O!u'\<close> and fu': \<open>[F]u'\<close> and Ru'v': \<open>[R]u'v'\<close>
          using "&E" by blast+
        AOT_have not_u'_eq_u: \<open>\<not>u' =\<^sub>E u\<close>
        proof (rule raa_cor_2)
          AOT_assume \<open>u' =\<^sub>E u\<close>
          AOT_hence \<open>u' = u\<close> by (metis eq_E_simple_2 vdash_properties_6)
          AOT_hence Ruv': \<open>[R]uv'\<close> using "rule=E" Ru'v' by fast
          AOT_have \<open>v' =\<^sub>E b\<close> using b_unique[OF ov', OF gv', OF Ruv'].
          AOT_thus \<open>v' =\<^sub>E b & \<not>v' =\<^sub>E b\<close> using not_v'_eq_b "&I" by blast
        qed
        AOT_hence u'_noteq_u: \<open>u' \<noteq>\<^sub>E u\<close>
          using intro_elim_3_b thm_neg_eq_E by blast
        AOT_have \<open>\<forall>t ([F]t & [R]tv' \<rightarrow> t =\<^sub>E u')\<close> using u'_prop "&E" by blast
        AOT_hence \<open>O!t \<rightarrow> ([F]t & [R]tv' \<rightarrow> t =\<^sub>E u')\<close> for t using "\<forall>E"(2) by blast
        AOT_hence u'_unique: \<open>t =\<^sub>E u'\<close> if \<open>O!t\<close> and \<open>[F]t\<close> and \<open>[R]tv'\<close> for t
          by (metis con_dis_i_e_1 that vdash_properties_10)

        AOT_have \<open>O!u' & ([F]u' & [R\<^sub>1]u'v' & \<forall>t ([F]t & [R\<^sub>1]tv' \<rightarrow> t =\<^sub>E u'))\<close>
        proof (safe intro!: "&I" ov' gv' R\<^sub>1xy Ru'v' u'_noteq_u GEN "\<rightarrow>I" thm_neg_eq_E[THEN "\<equiv>E"(2)] not_v'_eq_v fu' ou')
          fix t
          AOT_assume 0: \<open>O!t\<close>
          AOT_assume 1: \<open>[F]t & [R\<^sub>1]tv'\<close>
          AOT_have \<open>[R]tv'\<close> using Rxy2[OF 1[THEN "&E"(2)], OF v'_noteq_v, OF v'_noteq_b].
          AOT_thus \<open>t =\<^sub>E u'\<close>
            using u'_unique[OF 0] 1[THEN "&E"(1)] by blast
        qed
        AOT_hence \<open>\<exists>u ([F]u & [R\<^sub>1]uv' & \<forall>t ([F]t & [R\<^sub>1]tv' \<rightarrow> t =\<^sub>E u))\<close>
          by (rule "\<exists>I")
        AOT_hence \<open>\<exists>!u ([F]u & [R\<^sub>1]uv')\<close>
          by (rule equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
      }
      moreover {
        AOT_assume 0: \<open>v' =\<^sub>E v\<close>
        AOT_hence u'_eq_u: \<open>v' = v\<close>
          using eq_E_simple_2 vdash_properties_6 by blast
        AOT_have \<open>\<exists>!u ([F]u & [R\<^sub>1]uv')\<close>
        proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=u] "&I" GEN "\<rightarrow>I" ou fu)
          AOT_show \<open>[R\<^sub>1]uv'\<close>
            apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
            apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
            by (safe intro!: "\<or>I"(2) "&I" 0 ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF ou])
        next
          fix u'
          AOT_assume \<open>O!u'\<close>
          AOT_assume \<open>[F]u' & [R\<^sub>1]u'v'\<close>
          AOT_hence 0: \<open>[R\<^sub>1]u'v\<close> using "rule=E"[rotated, OF u'_eq_u] "&E"(2) by fast
          AOT_have 1: \<open>[\<guillemotleft>?R\<guillemotright>]u'v\<close>
            by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact 0)
          AOT_have 2: \<open>(u' \<noteq>\<^sub>E u & v \<noteq>\<^sub>E v & [R]u'v) \<or> (u' =\<^sub>E a & v =\<^sub>E b) \<or> (u' =\<^sub>E u & v =\<^sub>E v)\<close>
            using betaC_1_a[OF 1, simplified] by simp
          AOT_have \<open>\<not>v \<noteq>\<^sub>E v\<close>
            using intro_elim_3_d modus_tollens_1 ord_eq_Eequiv_1 ov reductio_aa_2 thm_neg_eq_E by blast
          AOT_hence \<open>\<not>((u' \<noteq>\<^sub>E u & v \<noteq>\<^sub>E v & [R]u'v) \<or> (u' =\<^sub>E a & v =\<^sub>E b))\<close>
            by (metis con_dis_i_e_2_a con_dis_i_e_2_b con_dis_i_e_4_c not_v_eq_b raa_cor_3)
          AOT_hence \<open>(u' =\<^sub>E u & v =\<^sub>E v)\<close> using 2 by (metis con_dis_i_e_4_b)
          AOT_thus \<open>u' =\<^sub>E u\<close> using "&E" by blast
        qed
      }
      moreover {
        AOT_assume 0: \<open>v' =\<^sub>E b\<close>
        AOT_hence v'_eq_b: \<open>v' = b\<close>
          using eq_E_simple_2 vdash_properties_10 by blast
        AOT_have \<open>\<exists>!u ([F]u & [R\<^sub>1]uv')\<close>
        proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=a] "&I" GEN "\<rightarrow>I" b_prop[THEN "&E"(1)]
                            b_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)] oa fa)
          AOT_show \<open>[R\<^sub>1]av'\<close>
            apply (rule "rule=E"[rotated, OF R\<^sub>1_def[symmetric]])
            apply (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
            apply (rule "\<or>I"(1); rule "\<or>I"(2); rule "&I")
            using Rav a_unique fa oa apply presburger
            by (fact 0)
        next
          fix u'
          AOT_assume ou': \<open>O!u'\<close>
          AOT_assume fu'_R1u'v': \<open>[F]u' & [R\<^sub>1]u'v'\<close>
          AOT_hence 0: \<open>[R\<^sub>1]u'b\<close> using v'_eq_b by (meson "rule=E" con_dis_i_e_2_b)
          AOT_have 1: \<open>[\<guillemotleft>?R\<guillemotright>]u'b\<close>
            by (rule "rule=E"[rotated, OF R\<^sub>1_def]) (fact 0)
          AOT_have \<open>(u' \<noteq>\<^sub>E u & b \<noteq>\<^sub>E v & [R]u'b) \<or> (u' =\<^sub>E a & b =\<^sub>E b) \<or> (u' =\<^sub>E u & b =\<^sub>E v)\<close>
            using betaC_1_a[OF 1, simplified] by simp
          moreover {
            AOT_assume 0: \<open>u' \<noteq>\<^sub>E u & b \<noteq>\<^sub>E v & [R]u'b\<close>
            AOT_have \<open>\<exists>!u ([F]u & [R]uv')\<close> using B[THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ov', THEN "\<rightarrow>E", OF gv'].
            AOT_hence \<open>\<exists>!u ([F]u & [R]ub)\<close> using v'_eq_b "rule=E" by fast
            AOT_hence \<open>\<exists>u ([F]u & [R]ub & \<forall>t ([F]t & [R]tb \<rightarrow> t =\<^sub>E u))\<close>
              using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by fast
            then AOT_obtain s where s_prop: \<open>O!s & ([F]s & [R]sb & \<forall>t ([F]t & [R]tb \<rightarrow> t =\<^sub>E s))\<close> using "\<exists>E"[rotated] by blast
            AOT_have \<open>u' =\<^sub>E s\<close> using s_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou']
                                     fu'_R1u'v'[THEN "&E"(1)] 0[THEN "&E"(2)]
              by (metis con_dis_i_e_1 vdash_properties_10)
            moreover AOT_have \<open>u =\<^sub>E s\<close> using s_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou]
                                    fu Rub by (metis con_dis_i_e_1 vdash_properties_10)
            ultimately AOT_have \<open>u' =\<^sub>E u\<close>
              by (metis con_dis_i_e_1 ord_eq_Eequiv_2 ord_eq_Eequiv_3 vdash_properties_10)
            moreover AOT_have \<open>\<not>(u' =\<^sub>E u)\<close> using 0[THEN "&E"(1), THEN "&E"(1)] by (metis intro_elim_3_a thm_neg_eq_E) 
            ultimately AOT_have \<open>u' =\<^sub>E a\<close> by (metis raa_cor_3)
          }
          moreover {
            AOT_assume \<open>u' =\<^sub>E u & b =\<^sub>E v\<close>
            AOT_hence \<open>u' =\<^sub>E a\<close> by (metis con_dis_i_e_2_b not_b_eq_v reductio_aa_1)
          }
          ultimately AOT_show \<open>u' =\<^sub>E a\<close> by (metis con_dis_i_e_2_a con_dis_i_e_4_c reductio_aa_1) 
        qed
      }
      ultimately AOT_show \<open>\<exists>!u ([F]u & [R\<^sub>1]uv')\<close> by (metis raa_cor_1)
    qed
    ultimately AOT_have \<open>\<exists>R R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close> using 1 by blast
  }
  ultimately AOT_have \<open>\<exists>R R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close> using R_prop by (metis reductio_aa_2) 
  AOT_thus \<open>[F]\<^sup>-\<^sup>u \<approx>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
    by (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"])
qed

AOT_theorem P'_eq:
  assumes Ou: \<open>O!u\<close> and Ov: \<open>O!v\<close>
  shows \<open>[F]\<^sup>-\<^sup>u \<approx>\<^sub>E [G]\<^sup>-\<^sup>v & [F]u & [G]v \<rightarrow> F \<approx>\<^sub>E G\<close>
proof(safe intro!: "\<rightarrow>I"; frule "&E"(1); drule "&E"(2); frule "&E"(1); drule "&E"(2))
  AOT_have \<open>[\<lambda>z [\<Pi>]z & z \<noteq>\<^sub>E \<kappa>]\<down>\<close> for \<Pi> \<kappa> by cqt_2_lambda
  note \<Pi>_minus_\<kappa>I = rule_id_def_2_b_2[where \<tau>=\<open>(\<lambda>(\<Pi>, \<kappa>). \<guillemotleft>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<guillemotright>)\<close>, simplified, OF F_minus_u, simplified, OF this]
   and \<Pi>_minus_\<kappa>E = rule_id_def_2_a_2[where \<tau>=\<open>(\<lambda>(\<Pi>, \<kappa>). \<guillemotleft>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<guillemotright>)\<close>, simplified, OF F_minus_u, simplified, OF this]
  AOT_have \<Pi>_minus_\<kappa>_den: \<open>[\<Pi>]\<^sup>-\<^sup>\<kappa>\<down>\<close> for \<Pi> \<kappa> (* TODO: PLM: quietly dismissed *)
    by (rule \<Pi>_minus_\<kappa>I) cqt_2_lambda+

  AOT_have \<Pi>_minus_\<kappa>E1: \<open>[\<Pi>]\<kappa>'\<close> and \<Pi>_minus_\<kappa>E2: \<open>\<kappa>' \<noteq>\<^sub>E \<kappa>\<close> if \<open>[[\<Pi>]\<^sup>-\<^sup>\<kappa>]\<kappa>'\<close> for \<Pi> \<kappa> \<kappa>'
  proof -
    AOT_have \<open>[\<lambda>z [\<Pi>]z & z \<noteq>\<^sub>E \<kappa>]\<kappa>'\<close> using \<Pi>_minus_\<kappa>E that by fast
    AOT_hence \<open>[\<Pi>]\<kappa>' & \<kappa>' \<noteq>\<^sub>E \<kappa>\<close> by (rule betaC_1_a)
    AOT_thus \<open>[\<Pi>]\<kappa>'\<close> and \<open>\<kappa>' \<noteq>\<^sub>E \<kappa>\<close> using "&E" by blast+
  qed
  AOT_have \<Pi>_minus_\<kappa>I': \<open>[[\<Pi>]\<^sup>-\<^sup>\<kappa>]\<kappa>'\<close> if \<open>[\<Pi>]\<kappa>'\<close> and \<open>\<kappa>' \<noteq>\<^sub>E \<kappa>\<close> for \<Pi> \<kappa> \<kappa>'
  proof -
    AOT_have \<kappa>'_den: \<open>\<kappa>'\<down>\<close>  by (metis russell_axiom_exe_1.\<psi>_denotes_asm that(1))
    AOT_have \<open>[\<lambda>z [\<Pi>]z & z \<noteq>\<^sub>E \<kappa>]\<kappa>'\<close> by (rule betaC_2_a; cqt_2_lambda; safe intro!: \<kappa>'_den "&I" that)
    AOT_thus \<open>[[\<Pi>]\<^sup>-\<^sup>\<kappa>]\<kappa>'\<close> using \<Pi>_minus_\<kappa>I by fast
  qed

  AOT_assume Gv: \<open>[G]v\<close>
  AOT_assume Fu: \<open>[F]u\<close>
  AOT_assume \<open>[F]\<^sup>-\<^sup>u \<approx>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
  AOT_hence \<open>\<exists>R R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
    using equi_3[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain R where R_prop: \<open>R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [G]\<^sup>-\<^sup>v\<close> using "\<exists>E"[rotated] by blast
  AOT_hence Fact1: \<open>\<forall>r([[F]\<^sup>-\<^sup>u]r \<rightarrow> \<exists>!s ([[G]\<^sup>-\<^sup>v]s & [R]rs))\<close> and Fact1': \<open>\<forall>s([[G]\<^sup>-\<^sup>v]s \<rightarrow> \<exists>!r ([[F]\<^sup>-\<^sup>u]r & [R]rs))\<close>
    using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_have \<open>R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE [G]\<^sup>-\<^sup>v\<close>
    using equi_rem_thm[unvarify F G, OF \<Pi>_minus_\<kappa>_den, OF \<Pi>_minus_\<kappa>_den, THEN "\<equiv>E"(1), OF R_prop].
  AOT_hence \<open>R |: [F]\<^sup>-\<^sup>u \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>E [G]\<^sup>-\<^sup>v & R |: [F]\<^sup>-\<^sup>u \<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE [G]\<^sup>-\<^sup>v\<close> using equi_rem_4[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  AOT_hence Fact2: \<open>\<forall>r\<forall>s\<forall>t(([[F]\<^sup>-\<^sup>u]r & [[F]\<^sup>-\<^sup>u]s & [[G]\<^sup>-\<^sup>v]t) \<rightarrow> ([R]rt & [R]st \<rightarrow> r =\<^sub>E s))\<close>
    using equi_rem_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast

  let ?R = \<open>\<guillemotleft>[\<lambda>xy ([[F]\<^sup>-\<^sup>u]x & [[G]\<^sup>-\<^sup>v]y & [R]xy) \<or> (x =\<^sub>E u & y =\<^sub>E v)]\<guillemotright>\<close>
  AOT_have R_den: \<open>\<guillemotleft>?R\<guillemotright>\<down>\<close> by cqt_2_lambda

  AOT_show \<open>F \<approx>\<^sub>E G\<close>
  proof(safe intro!: equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(1)[where \<tau>="?R"] R_den equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
    fix r
    AOT_assume Or: \<open>O!r\<close>
    AOT_assume Fr: \<open>[F]r\<close>
    {
      AOT_assume not_r_eq_u: \<open>\<not>(r =\<^sub>E u)\<close>
      AOT_hence r_noteq_u: \<open>r \<noteq>\<^sub>E u\<close>
        using intro_elim_3_b thm_neg_eq_E by blast
      AOT_have \<open>[[F]\<^sup>-\<^sup>u]r\<close>
        by(rule \<Pi>_minus_\<kappa>I; rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] "&I" Fr r_noteq_u)
      AOT_hence \<open>\<exists>!s ([[G]\<^sup>-\<^sup>v]s & [R]rs)\<close> using Fact1[THEN "\<forall>E"(2)] "\<rightarrow>E" Or by blast
      AOT_hence \<open>\<exists>s ([[G]\<^sup>-\<^sup>v]s & [R]rs & \<forall>t ([[G]\<^sup>-\<^sup>v]t & [R]rt \<rightarrow> t =\<^sub>E s))\<close>
        using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by simp
      then AOT_obtain s where s_prop: \<open>O!s & ([[G]\<^sup>-\<^sup>v]s & [R]rs & \<forall>t ([[G]\<^sup>-\<^sup>v]t & [R]rt \<rightarrow> t =\<^sub>E s))\<close>
        using "\<exists>E"[rotated] by blast
      AOT_hence Os: \<open>O!s\<close> and G_minus_v_s: \<open>[[G]\<^sup>-\<^sup>v]s\<close> and Rrs: \<open>[R]rs\<close> using "&E" by blast+
      AOT_have s_unique: \<open>t =\<^sub>E s\<close> if \<open>O!t\<close> and \<open>[[G]\<^sup>-\<^sup>v]t\<close> and \<open>[R]rt\<close> for t
        using s_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF that(1), THEN "\<rightarrow>E", OF "&I", OF that(2,3)].
      AOT_have Gs: \<open>[G]s\<close> using \<Pi>_minus_\<kappa>E1[OF G_minus_v_s].
      AOT_have s_noteq_v: \<open>s \<noteq>\<^sub>E v\<close> using \<Pi>_minus_\<kappa>E2[OF G_minus_v_s].
      AOT_have \<open>\<exists>s ([G]s & [\<guillemotleft>?R\<guillemotright>]rs & (\<forall>t ([G]t & [\<guillemotleft>?R\<guillemotright>]rt \<rightarrow> t =\<^sub>E s)))\<close>
      proof(safe intro!: "\<exists>I"(2)[where \<beta>=s] "&I" Os Gs GEN "\<rightarrow>I")
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]rs\<close>
          by (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3;
              safe intro!: "&I" "\<or>I"(1) \<Pi>_minus_\<kappa>I' Fr Gs s_noteq_v Rrs r_noteq_u)
      next
        fix t
        AOT_assume Ot: \<open>O!t\<close>
        AOT_assume 0: \<open>[G]t & [\<guillemotleft>?R\<guillemotright>]rt\<close>
        AOT_hence \<open>([[F]\<^sup>-\<^sup>u]r & [[G]\<^sup>-\<^sup>v]t & [R]rt) \<or> (r =\<^sub>E u & t =\<^sub>E v)\<close>
          using betaC_1_a[OF 0[THEN "&E"(2)], simplified] by blast
        AOT_hence 1: \<open>[[F]\<^sup>-\<^sup>u]r & [[G]\<^sup>-\<^sup>v]t & [R]rt\<close>
          using not_r_eq_u by (metis con_dis_i_e_2_a con_dis_i_e_4_c reductio_aa_1)
        AOT_show \<open>t =\<^sub>E s\<close> using s_unique[OF Ot] 1 "&E" by blast
      qed
    }
    moreover {
      AOT_assume r_eq_u: \<open>r =\<^sub>E u\<close>
      AOT_have \<open>\<exists>s ([G]s & [\<guillemotleft>?R\<guillemotright>]rs & (\<forall>t ([G]t & [\<guillemotleft>?R\<guillemotright>]rt \<rightarrow> t =\<^sub>E s)))\<close>
      proof(safe intro!: "\<exists>I"(2)[where \<beta>=v] "&I" Ov Gv GEN "\<rightarrow>I")
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]rv\<close>
          by (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
             (safe intro!: "&I" "\<or>I"(2) \<Pi>_minus_\<kappa>I' Fr r_eq_u ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Ov])
      next
        fix t
        AOT_assume \<open>O!t\<close>
        AOT_assume 0: \<open>[G]t & [\<guillemotleft>?R\<guillemotright>]rt\<close>
        AOT_hence \<open>([[F]\<^sup>-\<^sup>u]r & [[G]\<^sup>-\<^sup>v]t & [R]rt) \<or> (r =\<^sub>E u & t =\<^sub>E v)\<close>
          using betaC_1_a[OF 0[THEN "&E"(2)], simplified] by blast
        AOT_hence \<open>r =\<^sub>E u & t =\<^sub>E v\<close>
          using r_eq_u \<Pi>_minus_\<kappa>E2 by (metis con_dis_i_e_2_a con_dis_i_e_4_b intro_elim_3_a reductio_aa_1 thm_neg_eq_E)
        AOT_thus \<open>t =\<^sub>E v\<close> using "&E" by blast
      qed
    }
    ultimately AOT_show \<open>\<exists>!s ([G]s & [\<guillemotleft>?R\<guillemotright>]rs)\<close> using reductio_aa_2 equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] by fast
  next
    fix s
    AOT_assume Os: \<open>[O!]s\<close>
    AOT_assume Gs: \<open>[G]s\<close>

    {
      AOT_assume not_s_eq_v: \<open>\<not>(s =\<^sub>E v)\<close>
      AOT_hence s_noteq_v: \<open>s \<noteq>\<^sub>E v\<close>
        using intro_elim_3_b thm_neg_eq_E by blast
      AOT_have \<open>[[G]\<^sup>-\<^sup>v]s\<close>
        by (rule \<Pi>_minus_\<kappa>I; rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] "&I" Gs s_noteq_v)
      AOT_hence \<open>\<exists>!r ([[F]\<^sup>-\<^sup>u]r & [R]rs)\<close> using Fact1'[THEN "\<forall>E"(2)] "\<rightarrow>E" Os by blast
      AOT_hence \<open>\<exists>r ([[F]\<^sup>-\<^sup>u]r & [R]rs & \<forall>t ([[F]\<^sup>-\<^sup>u]t & [R]ts \<rightarrow> t =\<^sub>E r))\<close>
        using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by simp
      then AOT_obtain r where r_prop: \<open>O!r & ([[F]\<^sup>-\<^sup>u]r & [R]rs & \<forall>t ([[F]\<^sup>-\<^sup>u]t & [R]ts \<rightarrow> t =\<^sub>E r))\<close>
        using "\<exists>E"[rotated] by blast
      AOT_hence Or: \<open>O!r\<close> and F_minus_u_r: \<open>[[F]\<^sup>-\<^sup>u]r\<close> and Rrs: \<open>[R]rs\<close> using "&E" by blast+
      AOT_have r_unique: \<open>t =\<^sub>E r\<close> if \<open>O!t\<close> and \<open>[[F]\<^sup>-\<^sup>u]t\<close> and \<open>[R]ts\<close> for t
        using r_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF that(1), THEN "\<rightarrow>E", OF "&I", OF that(2,3)].
      AOT_have Fr: \<open>[F]r\<close> using \<Pi>_minus_\<kappa>E1[OF F_minus_u_r].
      AOT_have r_noteq_u: \<open>r \<noteq>\<^sub>E u\<close> using \<Pi>_minus_\<kappa>E2[OF F_minus_u_r].
      AOT_have \<open>\<exists>r ([F]r & [\<guillemotleft>?R\<guillemotright>]rs & (\<forall>t ([F]t & [\<guillemotleft>?R\<guillemotright>]ts \<rightarrow> t =\<^sub>E r)))\<close>
      proof(safe intro!: "\<exists>I"(2)[where \<beta>=r] "&I" Or Fr GEN "\<rightarrow>I")
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]rs\<close>
          by (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3;
              safe intro!: "&I" "\<or>I"(1) \<Pi>_minus_\<kappa>I' Fr Gs s_noteq_v Rrs r_noteq_u)
      next
        fix t
        AOT_assume Ot: \<open>O!t\<close>
        AOT_assume 0: \<open>[F]t & [\<guillemotleft>?R\<guillemotright>]ts\<close>
        AOT_hence \<open>([[F]\<^sup>-\<^sup>u]t & [[G]\<^sup>-\<^sup>v]s & [R]ts) \<or> (t =\<^sub>E u & s =\<^sub>E v)\<close>
          using betaC_1_a[OF 0[THEN "&E"(2)], simplified] by blast
        AOT_hence 1: \<open>[[F]\<^sup>-\<^sup>u]t & [[G]\<^sup>-\<^sup>v]s & [R]ts\<close>
          using not_s_eq_v by (metis con_dis_i_e_2_b con_dis_i_e_4_c reductio_aa_1)
        AOT_show \<open>t =\<^sub>E r\<close> using r_unique[OF Ot] 1 "&E" by blast
      qed
    }
    moreover {
      AOT_assume s_eq_v: \<open>s =\<^sub>E v\<close>
      AOT_have \<open>\<exists>r ([F]r & [\<guillemotleft>?R\<guillemotright>]rs & (\<forall>t ([F]t & [\<guillemotleft>?R\<guillemotright>]ts \<rightarrow> t =\<^sub>E r)))\<close>
      proof(safe intro!: "\<exists>I"(2)[where \<beta>=u] "&I" Ou Fu GEN "\<rightarrow>I")
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]us\<close>
          by (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
             (safe intro!: "&I" "\<or>I"(2) \<Pi>_minus_\<kappa>I' Gs s_eq_v ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Ou])
      next
        fix t
        AOT_assume \<open>O!t\<close>
        AOT_assume 0: \<open>[F]t & [\<guillemotleft>?R\<guillemotright>]ts\<close>
        AOT_hence 1: \<open>([[F]\<^sup>-\<^sup>u]t & [[G]\<^sup>-\<^sup>v]s & [R]ts) \<or> (t =\<^sub>E u & s =\<^sub>E v)\<close>
          using betaC_1_a[OF 0[THEN "&E"(2)], simplified] by blast
        moreover AOT_have \<open>\<not>([[F]\<^sup>-\<^sup>u]t & [[G]\<^sup>-\<^sup>v]s & [R]ts)\<close>
        proof (rule raa_cor_2)
          AOT_assume \<open>([[F]\<^sup>-\<^sup>u]t & [[G]\<^sup>-\<^sup>v]s & [R]ts)\<close>
          AOT_hence \<open>[[G]\<^sup>-\<^sup>v]s\<close> using "&E" by blast
          AOT_thus \<open>s =\<^sub>E v & \<not>(s =\<^sub>E v)\<close>
            by (metis \<Pi>_minus_\<kappa>E2 intro_elim_3_d reductio_aa_1 s_eq_v thm_neg_eq_E)
        qed
        ultimately AOT_have \<open>t =\<^sub>E u & s =\<^sub>E v\<close>
          by (metis con_dis_i_e_4_b)
        AOT_thus \<open>t =\<^sub>E u\<close> using "&E" by blast
      qed
    }
    ultimately AOT_show \<open>\<exists>!r ([F]r & [\<guillemotleft>?R\<guillemotright>]rs)\<close>
      using "\<equiv>\<^sub>d\<^sub>fI" equi_1 reductio_aa_2 by fast
  qed
qed

AOT_act_theorem eq_part_act_1: \<open>[\<lambda>z \<^bold>\<A>[F]z] \<equiv>\<^sub>E F\<close>
proof (safe intro!: eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
  AOT_show \<open>[\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> by cqt_2_lambda
next
  fix u
  AOT_assume \<open>O!u\<close>
  AOT_have \<open>[\<lambda>z \<^bold>\<A>[F]z]u \<equiv> \<^bold>\<A>[F]u\<close>
    by (rule beta_C_meta[THEN "\<rightarrow>E"]) cqt_2_lambda
  also AOT_have \<open>\<dots> \<equiv> [F]u\<close>
    using act_conj_act_4 logic_actual[act_axiom_inst, THEN "\<rightarrow>E"] by blast
  finally AOT_show \<open>[\<lambda>z \<^bold>\<A>[F]z]u \<equiv> [F]u\<close>.
qed

AOT_act_theorem eq_part_act_2: \<open>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E F\<close>
  by (safe intro!: apE_eqE_1[unvarify F, THEN "\<rightarrow>E"] eq_part_act_1) cqt_2_lambda

AOT_theorem approx_cont_1: \<open>\<exists>F\<exists>G \<diamond>(F \<approx>\<^sub>E G & \<diamond>\<not>F \<approx>\<^sub>E G)\<close>
proof -
  let ?P = \<open>\<guillemotleft>[\<lambda>x E!x & \<not>\<^bold>\<A>E!x]\<guillemotright>\<close>
  AOT_have \<open>\<diamond>q\<^sub>0 & \<diamond>\<not>q\<^sub>0\<close> by (metis q\<^sub>0_prop)
  AOT_hence 1: \<open>\<diamond>\<exists>x(E!x & \<not>\<^bold>\<A>E!x) & \<diamond>\<not>\<exists>x(E!x & \<not>\<^bold>\<A>E!x)\<close>
    by (rule q\<^sub>0_def[THEN "=\<^sub>d\<^sub>fE"(2), rotated])
       (simp add: log_prop_prop_2)
  AOT_have \<theta>: \<open>\<diamond>\<exists>x [\<guillemotleft>?P\<guillemotright>]x & \<diamond>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
    apply (AOT_subst \<open>\<lambda>\<kappa> . \<guillemotleft>[\<guillemotleft>?P\<guillemotright>]\<kappa>\<guillemotright>\<close> \<open>\<lambda>\<kappa> . \<guillemotleft>E!\<kappa> & \<not>\<^bold>\<A>E!\<kappa>\<guillemotright>\<close>)
     apply (rule beta_C_meta[THEN "\<rightarrow>E"]; cqt_2_lambda)
    by (fact 1)
  show ?thesis
  proof (rule_tac \<tau>=\<open>\<guillemotleft>[L]\<^sup>-\<guillemotright>\<close> in "\<exists>I"(1); (rule_tac \<tau>=\<open>?P\<close> in "\<exists>I"(1))?)
    AOT_have \<open>\<diamond>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>] & \<diamond>\<not>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
    proof (rule "&I"; rule "RM\<diamond>"[THEN "\<rightarrow>E"]; (rule "\<rightarrow>I")?)
      AOT_modally_strict {
        AOT_assume A: \<open>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
        AOT_show \<open>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
        proof (safe intro!: empty_approx_1[unvarify F H, THEN "\<rightarrow>E"] rel_neg_T_3 "&I")
          AOT_show \<open>[\<guillemotleft>?P\<guillemotright>]\<down>\<close> by cqt_2_lambda
        next
          AOT_show \<open>\<not>\<exists>u [L\<^sup>-]u\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>u [L\<^sup>-]u\<close>
            then AOT_obtain u where \<open>O!u & [L\<^sup>-]u\<close> using "\<exists>E"[rotated] by blast
            moreover AOT_have \<open>\<not>[L\<^sup>-]u\<close>
              using thm_noncont_e_e_2[THEN contingent_properties_2[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)]
              by (metis qml_2 rule_ui_3 vdash_properties_10 vdash_properties_1_b)
            ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis con_dis_taut_2 modus_tollens_1 raa_cor_3)
          qed
        next
          AOT_show \<open>\<not>\<exists>v [\<guillemotleft>?P\<guillemotright>]v\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>v [\<guillemotleft>?P\<guillemotright>]v\<close>
            then AOT_obtain u where \<open>O!u & [\<guillemotleft>?P\<guillemotright>]u\<close> using "\<exists>E"[rotated] by blast
            AOT_hence \<open>[\<guillemotleft>?P\<guillemotright>]u\<close> using "&E" by blast
            AOT_hence \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> by (rule "\<exists>I")
            AOT_thus \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x & \<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using A "&I" by blast
          qed
        qed
      }
    next
      AOT_show \<open>\<diamond>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using \<theta> "&E" by blast
    next
      AOT_modally_strict {
        AOT_assume A: \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
        AOT_have B: \<open>\<not>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [L]\<^sup>-\<close>
        proof (safe intro!: empty_approx_2[unvarify F H, THEN "\<rightarrow>E"] rel_neg_T_3 "&I")
          AOT_show \<open>[\<guillemotleft>?P\<guillemotright>]\<down>\<close> by cqt_2_lambda
        next
          AOT_obtain x where Px: \<open>[\<guillemotleft>?P\<guillemotright>]x\<close> using A "\<exists>E" by blast
          (* TODO: PLM: Proving O!x is silently skipped. *)
          AOT_hence \<open>E!x & \<not>\<^bold>\<A>E!x\<close>
            by (rule betaC_1_a)
          AOT_hence 1: \<open>\<diamond>E!x\<close> by (metis T_S5_fund_1 con_dis_i_e_2_a vdash_properties_10)
          AOT_have \<open>[\<lambda>x \<diamond>E!x]x\<close>
            by (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] 1)
          AOT_hence \<open>O!x\<close>
            by (rule AOT_ordinary[THEN "=\<^sub>d\<^sub>fI"(2), rotated]) cqt_2_lambda
          AOT_hence \<open>O!x & [\<guillemotleft>?P\<guillemotright>]x\<close> using Px "&I" by blast
          AOT_thus \<open>\<exists>u [\<guillemotleft>?P\<guillemotright>]u\<close> by (rule "\<exists>I")
        next
          AOT_show \<open>\<not>\<exists>u [L\<^sup>-]u\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>u [L\<^sup>-]u\<close>
            then AOT_obtain u where \<open>O!u & [L\<^sup>-]u\<close> using "\<exists>E"[rotated] by blast
            moreover AOT_have \<open>\<not>[L\<^sup>-]u\<close>
              using thm_noncont_e_e_2[THEN contingent_properties_2[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)]
              by (metis qml_2 rule_ui_3 vdash_properties_10 vdash_properties_1_b)
            ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis con_dis_taut_2 modus_tollens_1 raa_cor_3)
          qed
        qed
        AOT_show \<open>\<not>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
        proof (rule raa_cor_2)
          AOT_assume \<open>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
          AOT_hence \<open>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [L]\<^sup>-\<close>
            apply (rule eq_part_2[unvarify F G, THEN "\<rightarrow>E", rotated 2])
             apply cqt_2_lambda
            by (simp add: rel_neg_T_3)
          AOT_thus \<open>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [L]\<^sup>- & \<not>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [L]\<^sup>-\<close> using B "&I" by blast
        qed
      }
    next
      AOT_show \<open>\<diamond>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using \<theta> "&E" by blast
    qed
    AOT_thus \<open>\<diamond>([L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>] & \<diamond>\<not>[L]\<^sup>- \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>])\<close> using S5Basic_11 intro_elim_3_b by blast
  next
    AOT_show \<open>[\<lambda>x [E!]x & \<not>\<^bold>\<A>[E!]x]\<down>\<close> by cqt_2_lambda
  next
    AOT_show \<open>[L]\<^sup>-\<down>\<close>
      by (simp add: rel_neg_T_3)
  qed
qed


AOT_theorem approx_cont_2: \<open>\<exists>F\<exists>G \<diamond>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
proof -
  let ?P = \<open>\<guillemotleft>[\<lambda>x E!x & \<not>\<^bold>\<A>E!x]\<guillemotright>\<close>
  AOT_have \<open>\<diamond>q\<^sub>0 & \<diamond>\<not>q\<^sub>0\<close> by (metis q\<^sub>0_prop)
  AOT_hence 1: \<open>\<diamond>\<exists>x(E!x & \<not>\<^bold>\<A>E!x) & \<diamond>\<not>\<exists>x(E!x & \<not>\<^bold>\<A>E!x)\<close>
    by (rule q\<^sub>0_def[THEN "=\<^sub>d\<^sub>fE"(2), rotated])
       (simp add: log_prop_prop_2)
  AOT_have \<theta>: \<open>\<diamond>\<exists>x [\<guillemotleft>?P\<guillemotright>]x & \<diamond>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
    apply (AOT_subst \<open>\<lambda>\<kappa> . \<guillemotleft>[\<guillemotleft>?P\<guillemotright>]\<kappa>\<guillemotright>\<close> \<open>\<lambda>\<kappa> . \<guillemotleft>E!\<kappa> & \<not>\<^bold>\<A>E!\<kappa>\<guillemotright>\<close>)
     apply (rule beta_C_meta[THEN "\<rightarrow>E"]; cqt_2_lambda)
    by (fact 1)
  show ?thesis
  proof (rule_tac \<tau>=\<open>\<guillemotleft>[L]\<^sup>-\<guillemotright>\<close> in "\<exists>I"(1); (rule_tac \<tau>=\<open>?P\<close> in "\<exists>I"(1))?)
    AOT_have \<open>\<diamond>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>] & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
    proof (rule "&I"; rule "RM\<diamond>"[THEN "\<rightarrow>E"]; (rule "\<rightarrow>I")?)
      AOT_modally_strict {
        AOT_assume A: \<open>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
        AOT_show \<open>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
        proof (safe intro!: empty_approx_1[unvarify F H, THEN "\<rightarrow>E"] rel_neg_T_3 "&I")
          AOT_show \<open>[\<guillemotleft>?P\<guillemotright>]\<down>\<close> by cqt_2_lambda
        next
          AOT_show \<open>\<not>\<exists>u [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>u [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close>
            then AOT_obtain u where \<open>O!u & [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close> using "\<exists>E"[rotated] by blast
            AOT_hence \<open>\<^bold>\<A>[L\<^sup>-]u\<close>
              using betaC_1_a "&E" by blast
            moreover AOT_have \<open>\<box>\<not>[L\<^sup>-]u\<close>
              using thm_noncont_e_e_2[THEN contingent_properties_2[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)]
              by (metis RN qml_2 rule_ui_3 vdash_properties_10 vdash_properties_1_b)
            ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis Act_Sub_3 KBasic2_1 intro_elim_3_a raa_cor_3 vdash_properties_10)
          qed
        next
          AOT_show \<open>\<not>\<exists>v [\<guillemotleft>?P\<guillemotright>]v\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>v [\<guillemotleft>?P\<guillemotright>]v\<close>
            then AOT_obtain u where \<open>O!u & [\<guillemotleft>?P\<guillemotright>]u\<close> using "\<exists>E"[rotated] by blast
            AOT_hence \<open>[\<guillemotleft>?P\<guillemotright>]u\<close> using "&E" by blast
            AOT_hence \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> by (rule "\<exists>I")
            AOT_thus \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x & \<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using A "&I" by blast
          qed
        next
          AOT_show \<open>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z]\<down>\<close> by cqt_2_lambda
        qed
      }
    next
      AOT_show \<open>\<diamond>\<not>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using \<theta> "&E" by blast
    next
      AOT_modally_strict {
        AOT_assume A: \<open>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close>
        AOT_have B: \<open>\<not>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]\<close>
        proof (safe intro!: empty_approx_2[unvarify F H, THEN "\<rightarrow>E"] rel_neg_T_3 "&I")
          AOT_show \<open>[\<guillemotleft>?P\<guillemotright>]\<down>\<close> by cqt_2_lambda
        next
          AOT_obtain x where Px: \<open>[\<guillemotleft>?P\<guillemotright>]x\<close> using A "\<exists>E" by blast
          AOT_hence \<open>E!x & \<not>\<^bold>\<A>E!x\<close>
            by (rule betaC_1_a)
          AOT_hence 1: \<open>\<diamond>E!x\<close> by (metis T_S5_fund_1 con_dis_i_e_2_a vdash_properties_10)
          AOT_have \<open>[\<lambda>x \<diamond>E!x]x\<close>
            by (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] 1)
          AOT_hence \<open>O!x\<close>
            by (rule AOT_ordinary[THEN "=\<^sub>d\<^sub>fI"(2), rotated]) cqt_2_lambda
          AOT_hence \<open>O!x & [\<guillemotleft>?P\<guillemotright>]x\<close> using Px "&I" by blast
          AOT_thus \<open>\<exists>u [\<guillemotleft>?P\<guillemotright>]u\<close> by (rule "\<exists>I")
        next
          AOT_show \<open>\<not>\<exists>u [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close>
          proof (rule raa_cor_2)
            AOT_assume \<open>\<exists>u [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close>
            then AOT_obtain u where \<open>O!u & [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]u\<close> using "\<exists>E"[rotated] by blast
            AOT_hence \<open>\<^bold>\<A>[L\<^sup>-]u\<close>
              using betaC_1_a "&E" by blast
            moreover AOT_have \<open>\<box>\<not>[L\<^sup>-]u\<close>
              using thm_noncont_e_e_2[THEN contingent_properties_2[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)]
              by (metis RN qml_2 rule_ui_3 vdash_properties_10 vdash_properties_1_b)
            ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis Act_Sub_3 KBasic2_1 intro_elim_3_a raa_cor_3 vdash_properties_10)
          qed
        next
          AOT_show \<open>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z]\<down>\<close> by cqt_2_lambda
        qed
        AOT_show \<open>\<not>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
        proof (rule raa_cor_2)
          AOT_assume \<open>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>]\<close>
          AOT_hence \<open>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]\<close>
            by (rule eq_part_2[unvarify F G, THEN "\<rightarrow>E", rotated 2])
               cqt_2_lambda+
          AOT_thus \<open>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[L\<^sup>-]z] & \<not>[\<guillemotleft>?P\<guillemotright>] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[L\<^sup>-]z]\<close> using B "&I" by blast
        qed
      }
    next
      AOT_show \<open>\<diamond>\<exists>x [\<guillemotleft>?P\<guillemotright>]x\<close> using \<theta> "&E" by blast
    qed
    AOT_thus \<open>\<diamond>([\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>] & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[L\<^sup>-]z] \<approx>\<^sub>E [\<guillemotleft>?P\<guillemotright>])\<close> using S5Basic_11 intro_elim_3_b by blast
  next
    AOT_show \<open>[\<lambda>x [E!]x & \<not>\<^bold>\<A>[E!]x]\<down>\<close> by cqt_2_lambda
  next
    AOT_show \<open>[L]\<^sup>-\<down>\<close>
      by (simp add: rel_neg_T_3)
  qed
qed

(* TODO: PLM: proof in PLM takes weaker assumption, resulting in a more involved proof *)
AOT_theorem approx_nec_1: \<open>\<box>\<forall>x ([F]x \<rightarrow> \<box>[F]x) \<rightarrow> F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close>
proof(rule "\<rightarrow>I")
  AOT_assume A: \<open>\<box>\<forall>x ([F]x \<rightarrow> \<box>[F]x)\<close>
  AOT_hence 0: \<open>\<forall>x \<box>([F]x \<rightarrow> \<box>[F]x)\<close> using CBF[THEN "\<rightarrow>E"] by blast
  AOT_hence 1: \<open>\<forall>x ([F]x \<rightarrow> \<box>[F]x)\<close> using A qml_2[axiom_inst, THEN "\<rightarrow>E"] by blast
  AOT_have act_F_den: \<open>[\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> by cqt_2_lambda
  AOT_show \<open>F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close>
  proof (safe intro!: apE_eqE_1[unvarify G, THEN "\<rightarrow>E"] eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] act_F_den GEN "\<rightarrow>I" "\<equiv>I")
    fix u
    AOT_assume \<open>[F]u\<close>
    AOT_hence \<open>\<box>[F]u\<close> using 1[THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
    AOT_hence act_F_u: \<open>\<^bold>\<A>[F]u\<close> by (metis nec_imp_act vdash_properties_10)
    AOT_show \<open>[\<lambda>z \<^bold>\<A>[F]z]u\<close>
      by (rule betaC_2_a; cqt_2_lambda; safe intro!: act_F_u cqt_2_const_var[axiom_inst])
  next
    fix u
    AOT_assume \<open>[\<lambda>z \<^bold>\<A>[F]z]u\<close>
    AOT_hence \<open>\<^bold>\<A>[F]u\<close>
      by (rule betaC_1_a)
    AOT_thus \<open>[F]u\<close>
      using 0[THEN "\<forall>E"(2)[where \<beta>=u]]
      by (metis intro_elim_3_a sc_eq_fur_2 vdash_properties_10)
  qed
qed

(* TODO: not in PLM *)
AOT_theorem approx_nec_1': \<open>\<box>\<forall>u ([F]u \<rightarrow> \<box>[F]u) \<rightarrow> F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close>
proof(rule "\<rightarrow>I")
  AOT_assume A: \<open>\<box>\<forall>u ([F]u \<rightarrow> \<box>[F]u)\<close>
  AOT_hence 0: \<open>\<forall>u \<box>([F]u \<rightarrow> \<box>[F]u)\<close>
    by (metis Ordinary.res_var_bound_reas_3 vdash_properties_10)
  AOT_hence 1: \<open>\<forall>u ([F]u \<rightarrow> \<box>[F]u)\<close> using A qml_2[axiom_inst, THEN "\<rightarrow>E"] by blast
  AOT_have act_F_den: \<open>[\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> by cqt_2_lambda
  AOT_show \<open>F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close>
  proof (safe intro!: apE_eqE_1[unvarify G, THEN "\<rightarrow>E"] eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] act_F_den GEN "\<rightarrow>I" "\<equiv>I")
    fix u
    AOT_assume \<open>O!u\<close>
    moreover AOT_assume \<open>[F]u\<close>
    ultimately AOT_have \<open>\<box>[F]u\<close> using 1[THEN "\<forall>E"(2)] by (metis "\<rightarrow>E")
    AOT_hence act_F_u: \<open>\<^bold>\<A>[F]u\<close> by (metis nec_imp_act vdash_properties_10)
    AOT_show \<open>[\<lambda>z \<^bold>\<A>[F]z]u\<close>
      by (rule betaC_2_a; cqt_2_lambda; safe intro!: act_F_u cqt_2_const_var[axiom_inst])
  next
    fix u
    AOT_assume Ou: \<open>O!u\<close>
    AOT_assume \<open>[\<lambda>z \<^bold>\<A>[F]z]u\<close>
    AOT_hence \<open>\<^bold>\<A>[F]u\<close>
      by (rule betaC_1_a)
    AOT_thus \<open>[F]u\<close>
      using 0[THEN "\<forall>E"(2)[where \<beta>=u]]
      by (metis Ou intro_elim_3_a sc_eq_fur_2 vdash_properties_10)
  qed
qed

AOT_theorem approx_nec_2: \<open>(\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x) & \<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)) \<rightarrow> \<box>(F \<approx>\<^sub>E G \<rightarrow> \<box>F \<approx>\<^sub>E G)\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x) & \<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close>
  AOT_hence \<open>\<box>(\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x) & \<box>\<forall>x([G]x \<rightarrow> \<box>[G]x))\<close>
    using "&E"(1) "&E"(2) KBasic_3 S5Basic_5 con_dis_i_e_1 intro_elim_3_b vdash_properties_10 by meson
  moreover AOT_have \<open>\<box>(\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x) & \<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)) \<rightarrow> \<box>(F \<approx>\<^sub>E G \<rightarrow> \<box>F \<approx>\<^sub>E G)\<close>
  proof(rule RM; rule "\<rightarrow>I"; rule "\<rightarrow>I")
    AOT_modally_strict {
      AOT_assume \<open>\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x) & \<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close>
      AOT_hence \<open>\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x)\<close> and \<open>\<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close> using "&E" by blast+
      AOT_hence \<open>\<forall>x\<box>([F]x \<rightarrow> \<box>[F]x)\<close> and \<open>\<forall>x\<box>([G]x \<rightarrow> \<box>[G]x)\<close> using CBF[THEN "\<rightarrow>E"] by blast+
      AOT_hence F_nec: \<open>\<box>([F]x \<rightarrow> \<box>[F]x)\<close> and G_nec: \<open>\<box>([G]x \<rightarrow> \<box>[G]x)\<close> for x using "\<forall>E"(2) by blast+
      AOT_assume \<open>F \<approx>\<^sub>E G\<close>
      AOT_hence \<open>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
        by (metis "\<equiv>\<^sub>d\<^sub>fE" equi_3)
      then AOT_obtain R where \<open>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close> using "\<exists>E"[rotated] by blast
      AOT_hence C1: \<open>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R]uv))\<close> and C2: \<open>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R]uv))\<close>
        using equi_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
      AOT_obtain R' where \<open>Rigidifies(R', R)\<close>
        using rigid_der_3 "\<exists>E"[rotated] by blast
      AOT_hence 1: \<open>Rigid(R') & \<forall>x\<^sub>1...\<forall>x\<^sub>n ([R']x\<^sub>1...x\<^sub>n \<equiv> [R]x\<^sub>1...x\<^sub>n)\<close> using df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
      AOT_hence \<open>\<box>\<forall>x\<^sub>1...\<forall>x\<^sub>n ([R']x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[R']x\<^sub>1...x\<^sub>n)\<close> using df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
      AOT_hence \<open>\<forall>x\<^sub>1...\<forall>x\<^sub>n (\<diamond>[R']x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[R']x\<^sub>1...x\<^sub>n)\<close>
        using intro_elim_3_a rigid_rel_thms_1 by blast
      AOT_hence D: \<open>\<forall>x\<^sub>1\<forall>x\<^sub>2 (\<diamond>[R']x\<^sub>1x\<^sub>2 \<rightarrow> \<box>[R']x\<^sub>1x\<^sub>2)\<close>
        using tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
      AOT_have E: \<open>\<forall>x\<^sub>1\<forall>x\<^sub>2 ([R']x\<^sub>1x\<^sub>2 \<equiv> [R]x\<^sub>1x\<^sub>2)\<close> using tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fE", OF 1[THEN "&E"(2)]] by blast
      AOT_have \<open>\<forall>u \<box>([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<close> and \<open>\<forall>v \<box>([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<close>
      proof (safe intro!: GEN "\<rightarrow>I")
        fix u
        AOT_assume ou: \<open>O!u\<close>
        AOT_show \<open>\<box>([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<close>
        proof (rule raa_cor_1)
          AOT_assume \<open>\<not>\<box>([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<close>
          AOT_hence 1: \<open>\<diamond>\<not>([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<close> using KBasic_11 intro_elim_3_a by blast
          AOT_have \<open>\<diamond>([F]u & \<not>\<exists>!v ([G]v & [R']uv))\<close>
            apply (AOT_subst \<open>\<guillemotleft>[F]u & \<not>\<exists>!v ([G]v & [R']uv)\<guillemotright>\<close> \<open>\<guillemotleft>\<not>([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<guillemotright>\<close>)
             apply (meson intro_elim_3_f oth_class_taut_1_b oth_class_taut_3_a)
            by (fact 1)
          AOT_hence A: \<open>\<diamond>[F]u & \<diamond>\<not>\<exists>!v ([G]v & [R']uv)\<close>
            using KBasic2_3 vdash_properties_10 by blast
          AOT_hence \<open>\<box>[F]u\<close>
            using F_nec con_dis_i_e_2_a intro_elim_3_a sc_eq_box_box_1 vdash_properties_6 by blast
          AOT_hence \<open>[F]u\<close> by (metis qml_2 vdash_properties_10 vdash_properties_1_b)
          AOT_hence \<open>\<exists>!v ([G]v & [R]uv)\<close> using C1[THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou, THEN "\<rightarrow>E"] by blast
          AOT_hence \<open>\<exists>v ([G]v & [R]uv & \<forall>v' ([G]v' & [R]uv' \<rightarrow> v' =\<^sub>E v))\<close>
            using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by auto
          then AOT_obtain a where a_prop: \<open>O!a & ([G]a & [R]ua & \<forall>v' ([G]v' & [R]uv' \<rightarrow> v' =\<^sub>E a))\<close>
            using "\<exists>E"[rotated] by blast
          AOT_have \<open>\<exists>v \<box>([G]v & [R']uv & \<forall>v' ([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E v))\<close>
          proof(rule_tac \<beta>=a in "\<exists>I"(2); safe intro!: "&I" a_prop[THEN "&E"(1)] KBasic_3[THEN "\<equiv>E"(2)])
            AOT_show \<open>\<box>[G]a\<close>
              using a_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
              by (metis G_nec qml_2 vdash_properties_10 vdash_properties_1_b)
          next
            AOT_show \<open>\<box>[R']ua\<close>
              using D[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"]
                    E[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<equiv>E"(2),
                      OF a_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)]]
              by (metis T_S5_fund_1 vdash_properties_10)
          next
            AOT_have \<open>\<forall>v' \<box>([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E a)\<close>
            proof (rule GEN; rule "\<rightarrow>I"; rule raa_cor_1)
              fix v'
              AOT_assume ov': \<open>O!v'\<close>
              AOT_assume \<open>\<not>\<box>([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E a)\<close>
              AOT_hence 1: \<open>\<diamond>\<not>([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E a)\<close> by (metis KBasic_11 intro_elim_3_a)
              AOT_have \<open>\<diamond>([G]v' & [R']uv' & \<not>v' =\<^sub>E a)\<close>
                apply (AOT_subst \<open>\<guillemotleft>[G]v' & [R']uv' & \<not>v' =\<^sub>E a\<guillemotright>\<close> \<open>\<guillemotleft>\<not>([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E a)\<guillemotright>\<close>)
                 apply (meson intro_elim_3_f oth_class_taut_1_b oth_class_taut_3_a)
                by (fact 1)
              AOT_hence 1: \<open>\<diamond>[G]v'\<close> and 2: \<open>\<diamond>[R']uv'\<close> and 3: \<open>\<diamond>\<not>v' =\<^sub>E a\<close>
                using KBasic2_3[THEN "\<rightarrow>E", THEN "&E"(1)] KBasic2_3[THEN "\<rightarrow>E", THEN "&E"(2)] by blast+
              AOT_have Gv': \<open>[G]v'\<close> using G_nec 1
                by (meson "B\<diamond>" KBasic_13 vdash_properties_10)
              AOT_have \<open>\<box>[R']uv'\<close> using 2 D[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
              AOT_hence R'uv': \<open>[R']uv'\<close> by (metis "B\<diamond>" T_S5_fund_1 vdash_properties_10) 
              AOT_hence \<open>[R]uv'\<close> using E[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<equiv>E"(1)] by blast
              AOT_hence \<open>v' =\<^sub>E a\<close>
                using a_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ov',
                             THEN "\<rightarrow>E", OF "&I", OF Gv'] by blast
              AOT_hence \<open>\<box>(v' =\<^sub>E a)\<close> by (metis id_nec3_1 intro_elim_3_d raa_cor_3)
              moreover AOT_have \<open>\<not>\<box>(v' =\<^sub>E a)\<close>
                using 3 KBasic_11 intro_elim_3_b by blast
              ultimately AOT_show \<open>\<box>(v' =\<^sub>E a) & \<not>\<box>(v' =\<^sub>E a)\<close> using "&I" by blast
            qed
            AOT_thus \<open>\<box>\<forall>v'([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E a)\<close>
              using Ordinary.res_var_bound_reas_2 vdash_properties_10 by fast
          qed
          AOT_hence 1: \<open>\<box>\<exists>v ([G]v & [R']uv & \<forall>v' ([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E v))\<close>
            using Ordinary.res_var_bound_Buridan vdash_properties_10 by fast
          AOT_have \<open>\<box>\<exists>!v ([G]v & [R']uv)\<close>
            by (AOT_subst \<open>\<guillemotleft>\<exists>!v ([G]v & [R']uv)\<guillemotright>\<close> \<open>\<guillemotleft>\<exists>v ([G]v & [R']uv & \<forall>v' ([G]v' & [R']uv' \<rightarrow> v' =\<^sub>E v))\<guillemotright>\<close>)
               (auto simp: 1 equi_1[THEN "\<equiv>Df"])
          moreover AOT_have \<open>\<not>\<box>\<exists>!v ([G]v & [R']uv)\<close>
            using A[THEN "&E"(2)] KBasic_11[THEN "\<equiv>E"(2)] by blast
          ultimately AOT_show \<open>\<box>\<exists>!v ([G]v & [R']uv) & \<not>\<box>\<exists>!v ([G]v & [R']uv)\<close> by (rule "&I")
        qed
      next
        fix v
        AOT_assume ou: \<open>O!v\<close>
        AOT_show \<open>\<box>([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<close>
        proof (rule raa_cor_1)
          AOT_assume \<open>\<not>\<box>([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<close>
          AOT_hence 1: \<open>\<diamond>\<not>([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<close> using KBasic_11 intro_elim_3_a by blast
          AOT_have \<open>\<diamond>([G]v & \<not>\<exists>!u ([F]u & [R']uv))\<close>
            apply (AOT_subst \<open>\<guillemotleft>[G]v & \<not>\<exists>!u ([F]u & [R']uv)\<guillemotright>\<close> \<open>\<guillemotleft>\<not>([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<guillemotright>\<close>)
             apply (meson intro_elim_3_f oth_class_taut_1_b oth_class_taut_3_a)
            by (fact 1)
          AOT_hence A: \<open>\<diamond>[G]v & \<diamond>\<not>\<exists>!u ([F]u & [R']uv)\<close>
            using KBasic2_3 vdash_properties_10 by blast
          AOT_hence \<open>\<box>[G]v\<close>
            using G_nec con_dis_i_e_2_a intro_elim_3_a sc_eq_box_box_1 vdash_properties_6 by blast
          AOT_hence \<open>[G]v\<close> by (metis qml_2 vdash_properties_10 vdash_properties_1_b)
          AOT_hence \<open>\<exists>!u ([F]u & [R]uv)\<close> using C2[THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou, THEN "\<rightarrow>E"] by blast
          AOT_hence \<open>\<exists>u ([F]u & [R]uv & \<forall>u' ([F]u' & [R]u'v \<rightarrow> u' =\<^sub>E u))\<close>
            using equi_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by auto
          then AOT_obtain a where a_prop: \<open>O!a & ([F]a & [R]av & \<forall>u' ([F]u' & [R]u'v \<rightarrow> u' =\<^sub>E a))\<close>
            using "\<exists>E"[rotated] by blast
          AOT_have \<open>\<exists>u \<box>([F]u & [R']uv & \<forall>u' ([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E u))\<close>
          proof(rule_tac \<beta>=a in "\<exists>I"(2); safe intro!: "&I" a_prop[THEN "&E"(1)] KBasic_3[THEN "\<equiv>E"(2)])
            AOT_show \<open>\<box>[F]a\<close>
              using a_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
              by (metis F_nec qml_2 vdash_properties_10 vdash_properties_1_b)
          next
            AOT_show \<open>\<box>[R']av\<close>
              using D[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"]
                    E[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<equiv>E"(2),
                      OF a_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)]]
              by (metis T_S5_fund_1 vdash_properties_10)
          next
            AOT_have \<open>\<forall>u' \<box>([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E a)\<close>
            proof (rule GEN; rule "\<rightarrow>I"; rule raa_cor_1)
              fix u'
              AOT_assume ou': \<open>O!u'\<close>
              AOT_assume \<open>\<not>\<box>([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E a)\<close>
              AOT_hence 1: \<open>\<diamond>\<not>([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E a)\<close> by (metis KBasic_11 intro_elim_3_a)
              AOT_have \<open>\<diamond>([F]u' & [R']u'v & \<not>u' =\<^sub>E a)\<close>
                apply (AOT_subst \<open>\<guillemotleft>[F]u' & [R']u'v & \<not>u' =\<^sub>E a\<guillemotright>\<close> \<open>\<guillemotleft>\<not>([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E a)\<guillemotright>\<close>)
                 apply (meson intro_elim_3_f oth_class_taut_1_b oth_class_taut_3_a)
                by (fact 1)
              AOT_hence 1: \<open>\<diamond>[F]u'\<close> and 2: \<open>\<diamond>[R']u'v\<close> and 3: \<open>\<diamond>\<not>u' =\<^sub>E a\<close>
                using KBasic2_3[THEN "\<rightarrow>E", THEN "&E"(1)] KBasic2_3[THEN "\<rightarrow>E", THEN "&E"(2)] by blast+
              AOT_have Fu': \<open>[F]u'\<close> using F_nec 1
                by (meson "B\<diamond>" KBasic_13 vdash_properties_10)
              AOT_have \<open>\<box>[R']u'v\<close> using 2 D[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
              AOT_hence R'u'v: \<open>[R']u'v\<close> by (metis "B\<diamond>" T_S5_fund_1 vdash_properties_10) 
              AOT_hence \<open>[R]u'v\<close> using E[THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<equiv>E"(1)] by blast
              AOT_hence \<open>u' =\<^sub>E a\<close>
                using a_prop[THEN "&E"(2), THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF ou',
                             THEN "\<rightarrow>E", OF "&I", OF Fu'] by blast
              AOT_hence \<open>\<box>(u' =\<^sub>E a)\<close> by (metis id_nec3_1 intro_elim_3_d raa_cor_3)
              moreover AOT_have \<open>\<not>\<box>(u' =\<^sub>E a)\<close>
                using 3 KBasic_11 intro_elim_3_b by blast
              ultimately AOT_show \<open>\<box>(u' =\<^sub>E a) & \<not>\<box>(u' =\<^sub>E a)\<close> using "&I" by blast
            qed
            AOT_thus \<open>\<box>\<forall>u'([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E a)\<close>
              using Ordinary.res_var_bound_reas_2 vdash_properties_10 by fast
          qed
          AOT_hence 1: \<open>\<box>\<exists>u ([F]u & [R']uv & \<forall>u' ([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E u))\<close>
            using Ordinary.res_var_bound_Buridan vdash_properties_10 by fast
          AOT_have \<open>\<box>\<exists>!u ([F]u & [R']uv)\<close>
            by (AOT_subst \<open>\<guillemotleft>\<exists>!u ([F]u & [R']uv)\<guillemotright>\<close> \<open>\<guillemotleft>\<exists>u ([F]u & [R']uv & \<forall>u' ([F]u' & [R']u'v \<rightarrow> u' =\<^sub>E u))\<guillemotright>\<close>)
               (auto simp: 1 equi_1[THEN "\<equiv>Df"])
          moreover AOT_have \<open>\<not>\<box>\<exists>!u ([F]u & [R']uv)\<close>
            using A[THEN "&E"(2)] KBasic_11[THEN "\<equiv>E"(2)] by blast
          ultimately AOT_show \<open>\<box>\<exists>!u ([F]u & [R']uv) & \<not>\<box>\<exists>!u ([F]u & [R']uv)\<close> by (rule "&I")
        qed
      qed
      AOT_hence \<open>\<box>\<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv))\<close> and \<open>\<box>\<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv))\<close>
        using Ordinary.res_var_bound_reas_2[THEN "\<rightarrow>E"] by auto
      moreover AOT_have \<open>\<box>[R']\<down>\<close> and \<open>\<box>[F]\<down>\<close> and \<open>\<box>[G]\<down>\<close>
        by (simp_all add: ex_2_a)
      ultimately AOT_have 1: \<open>\<box>([R']\<down> & [F]\<down> & [G]\<down> & \<forall>u ([F]u \<rightarrow> \<exists>!v ([G]v & [R']uv)) & \<forall>v ([G]v \<rightarrow> \<exists>!u ([F]u & [R']uv)))\<close>
        using KBasic_3 con_dis_i_e_1 intro_elim_3_b by meson
      AOT_have \<open>\<box>R' |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
        by (AOT_subst_using subst: equi_2[THEN "\<equiv>Df"])
           (fact 1)
      AOT_hence \<open>\<exists>R \<box>R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
        by (rule "\<exists>I"(2))
      AOT_hence 1: \<open>\<box>\<exists>R R |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G\<close>
        by (metis sign_S5_thm_1 vdash_properties_10)
      AOT_show \<open>\<box>F \<approx>\<^sub>E G\<close>
        by (AOT_subst_using subst: equi_3[THEN "\<equiv>Df"])
           (fact 1)
    }
  qed
  ultimately AOT_show \<open>\<box>(F \<approx>\<^sub>E G \<rightarrow> \<box>F \<approx>\<^sub>E G)\<close> using "\<rightarrow>E" by blast
qed

AOT_theorem actuallyF_1: \<open>\<^bold>\<A>(F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z])\<close>
proof -
  AOT_have 1: \<open>\<^bold>\<A>([F]x \<equiv> \<^bold>\<A>[F]x)\<close> for x
    by (meson Act_Basic_5 act_conj_act_4 intro_elim_3_b oth_class_taut_2_e)
  AOT_have \<open>\<^bold>\<A>([F]x \<equiv> [\<lambda>z \<^bold>\<A>[F]z]x)\<close> for x
    apply (AOT_subst \<open>\<guillemotleft>[\<lambda>z \<^bold>\<A>[F]z]x\<guillemotright>\<close> \<open>\<guillemotleft>\<^bold>\<A>[F]x\<guillemotright>\<close>)
     apply (rule beta_C_meta[THEN "\<rightarrow>E"])
     apply cqt_2_lambda
    by (fact 1)
  AOT_hence \<open>O!x \<rightarrow> \<^bold>\<A>([F]x \<equiv> [\<lambda>z \<^bold>\<A>[F]z]x)\<close> for x by (metis deduction_theorem) 
  AOT_hence \<open>\<forall>u \<^bold>\<A>([F]u \<equiv> [\<lambda>z \<^bold>\<A>[F]z]u)\<close>
    using "\<forall>I" by fast
  AOT_hence 1: \<open>\<^bold>\<A>\<forall>u ([F]u \<equiv> [\<lambda>z \<^bold>\<A>[F]z]u)\<close>
    by (metis Ordinary.res_var_bound_reas_4 vdash_properties_10)
  AOT_modally_strict {
    AOT_have \<open>[\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> by cqt_2_lambda
  } note 2 = this
  AOT_have \<open>\<^bold>\<A>(F \<equiv>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z])\<close>
    apply (AOT_subst \<open>\<guillemotleft>F \<equiv>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<guillemotright>\<close> \<open>\<guillemotleft>\<forall>u ([F]u \<equiv> [\<lambda>z \<^bold>\<A>[F]z]u)\<guillemotright>\<close>)
    using eqE[THEN "\<equiv>Df", THEN "\<equiv>S"(1), OF "&I", OF cqt_2_const_var[axiom_inst], OF 2]
    by (auto simp: 1)
  (* TODO: PLM: refers to a rule of substitution, which is not applicable *)
  moreover AOT_have \<open>\<^bold>\<A>(F \<equiv>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z] \<rightarrow> F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z])\<close>
    using apE_eqE_1[unvarify G, THEN RA(2), OF 2] by metis
  ultimately AOT_show \<open>\<^bold>\<A>F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close>
    by (metis act_cond vdash_properties_10)
qed

(* TODO: PLM: important: Proof in PLM proves different theorem! I.e. it proves this, but states the one below. *)
AOT_theorem actuallyF_2: \<open>\<box>\<forall>x ([\<lambda>z \<^bold>\<A>[F]z]x \<rightarrow> [\<lambda>z \<box>\<^bold>\<A>[F]z]x)\<close>
proof(rule RN; safe intro!: GEN "\<rightarrow>I")
  AOT_modally_strict {
    fix x
    AOT_assume \<open>[\<lambda>z \<^bold>\<A>[F]z]x\<close>
    AOT_hence \<open>\<^bold>\<A>[F]x\<close>
      by (rule betaC_1_a) (* TODO: PLM needlessly refers to [\<lambda>z \<^bold>\<A>[F]z]\<down> *)
    AOT_hence 1: \<open>\<box>\<^bold>\<A>[F]x\<close> by (metis Act_Basic_6 intro_elim_3_a)
    AOT_show \<open>[\<lambda>z \<box>\<^bold>\<A>[F]z]x\<close>
      by (rule betaC_2_a; cqt_2_lambda; safe intro!: 1 cqt_2_const_var[axiom_inst])
  }
qed

(* TODO: PLM: important: this is used below, but only the above is proven in PLM *)
AOT_theorem actuallyF_2': \<open>\<box>\<forall>x ([\<lambda>z \<^bold>\<A>[F]z]x \<rightarrow> \<box>[\<lambda>z \<^bold>\<A>[F]z]x)\<close>
proof(rule RN; safe intro!: GEN "\<rightarrow>I")
  AOT_modally_strict {
    fix x
    AOT_assume \<open>[\<lambda>z \<^bold>\<A>[F]z]x\<close>
    AOT_hence \<open>\<^bold>\<A>[F]x\<close>
      by (rule betaC_1_a)
    AOT_hence 1: \<open>\<box>\<^bold>\<A>[F]x\<close> by (metis Act_Basic_6 intro_elim_3_a)
    AOT_show \<open>\<box>[\<lambda>z \<^bold>\<A>[F]z]x\<close>
      apply (AOT_subst \<open>\<guillemotleft>[\<lambda>z \<^bold>\<A>[F]z]x\<guillemotright>\<close> \<open>\<guillemotleft>\<^bold>\<A>[F]x\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E"])
       apply cqt_2_lambda
      by (fact 1)
  }
qed

AOT_define numbers :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>Numbers'(_,_')\<close>)
  \<open>Numbers(x,G) \<equiv>\<^sub>d\<^sub>f A!x & G\<down> & \<forall>F(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>

(* Not in PLM *)
AOT_theorem numbers_den:
  assumes \<open>\<Pi>\<down>\<close>
  shows \<open>Numbers(\<kappa>, \<Pi>) \<equiv> A!\<kappa> & \<forall>F(\<kappa>[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E \<Pi>)\<close>
  apply (safe intro!: assms numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" "\<equiv>I" "\<rightarrow>I" cqt_2_const_var[axiom_inst] dest!:  numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"])
  using "&E" by blast+
  

AOT_theorem num_tran_1: \<open>G \<approx>\<^sub>E H \<rightarrow> (Numbers(x, G) \<equiv> Numbers(x, H))\<close>
proof (safe intro!: "\<rightarrow>I" "\<equiv>I")
  AOT_assume 0: \<open>G \<approx>\<^sub>E H\<close>
  AOT_assume \<open>Numbers(x, G)\<close>
  AOT_hence Ax: \<open>A!x\<close> and \<theta>: \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
    using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_show \<open>Numbers(x, H)\<close>
  proof(safe intro!: numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" Ax cqt_2_const_var[axiom_inst] GEN)
    fix F
    AOT_have \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> using \<theta>[THEN "\<forall>E"(2)].
    also AOT_have \<open>\<dots> \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close> using 0 eq_part_5'[THEN "\<equiv>E"(1), THEN "\<forall>E"(2)] by metis
    finally AOT_show \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close>.
  qed
next
  AOT_assume \<open>G \<approx>\<^sub>E H\<close>
  AOT_hence 0: \<open>H \<approx>\<^sub>E G\<close> by (metis eq_part_2 vdash_properties_10)
  AOT_assume \<open>Numbers(x, H)\<close>
  AOT_hence Ax: \<open>A!x\<close> and \<theta>: \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H)\<close>
    using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_show \<open>Numbers(x, G)\<close>
  proof(safe intro!: numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" Ax cqt_2_const_var[axiom_inst] GEN)
    fix F
    AOT_have \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close> using \<theta>[THEN "\<forall>E"(2)].
    also AOT_have \<open>\<dots> \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> using 0 eq_part_5'[THEN "\<equiv>E"(1), THEN "\<forall>E"(2)] by metis
    finally AOT_show \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close>.
  qed
qed

AOT_theorem num_tran_2: \<open>(Numbers(x, G) & Numbers(x,H)) \<rightarrow> G \<approx>\<^sub>E H\<close>
proof (rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>Numbers(x,G)\<close>
  AOT_hence \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
  AOT_hence 1: \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> for F using "\<forall>E"(2) by blast
  AOT_assume \<open>Numbers(x,H)\<close>
  AOT_hence \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H)\<close> using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
  AOT_hence \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close> for F using "\<forall>E"(2) by blast
  AOT_hence \<open>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close> for F by (metis "1" intro_elim_3_f)
  AOT_thus \<open>G \<approx>\<^sub>E H\<close>
    using eq_part_5'[THEN "\<equiv>E"(2), OF GEN] by blast
qed

AOT_theorem num_tran_3: \<open>G \<equiv>\<^sub>E H \<rightarrow> (Numbers(x, G) \<equiv> Numbers(x, H))\<close>
  using apE_eqE_1 ded_thm_cor_1 num_tran_1 by blast

AOT_theorem pre_Hume: \<open>(Numbers(x,G) & Numbers(y,H)) \<rightarrow> (x = y \<equiv> G \<approx>\<^sub>E H)\<close>
proof(safe intro!: "\<rightarrow>I" "\<equiv>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>Numbers(x, G)\<close>
  moreover AOT_assume \<open>x = y\<close>
  ultimately AOT_have \<open>Numbers(y, G)\<close> by (rule "rule=E")
  moreover AOT_assume \<open>Numbers(y, H)\<close>
  ultimately AOT_show \<open>G \<approx>\<^sub>E H\<close> using num_tran_2 "\<rightarrow>E" "&I" by blast
next
  AOT_assume \<open>Numbers(x, G)\<close>
  AOT_hence Ax: \<open>A!x\<close> and xF: \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_assume \<open>Numbers(y, H)\<close>
  AOT_hence Ay: \<open>A!y\<close> and yF: \<open>\<forall>F (y[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H)\<close> using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_assume G_approx_H: \<open>G \<approx>\<^sub>E H\<close>
  AOT_show \<open>x = y\<close>
  proof(rule ab_obey_1[THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF "&I", OF Ax, OF Ay]; rule GEN)
    fix F
    AOT_have \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> using xF[THEN "\<forall>E"(2)].
    also AOT_have \<open>\<dots> \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E H\<close> using eq_part_5'[THEN "\<equiv>E"(1), OF G_approx_H, THEN "\<forall>E"(2)].
    also AOT_have \<open>\<dots> \<equiv> y[F]\<close> using yF[THEN "\<forall>E"(2), symmetric].
    finally AOT_show \<open>x[F] \<equiv> y[F]\<close>.
  qed
qed

AOT_theorem two_num_not: \<open>\<exists>u\<exists>v(u \<noteq> v) \<rightarrow> \<exists>x\<exists>G\<exists>H(Numbers(x,G) & Numbers(x, H) & \<not>G \<equiv>\<^sub>E H)\<close>
proof (rule "\<rightarrow>I")
  AOT_have eqE_den: \<open>[\<lambda>x x =\<^sub>E y]\<down>\<close> for y by cqt_2_lambda
  AOT_assume \<open>\<exists>u\<exists>v(u \<noteq> v)\<close>
  then AOT_obtain c where Oc: \<open>O!c\<close> and \<open>\<exists>v (c \<noteq> v)\<close> using "&E" "\<exists>E"[rotated] by blast
  then AOT_obtain d where Od: \<open>O!d\<close> and c_noteq_d: \<open>c \<noteq> d\<close> using "&E" "\<exists>E"[rotated] by blast
  AOT_hence c_noteqE_d: \<open>c \<noteq>\<^sub>E d\<close>
    using eq_E_simple_2[THEN "\<rightarrow>E"] eq_E_simple_2 intro_elim_3_b modus_tollens_1 noneq_infix rule_eq_df_2 thm_neg_eq_E by fast
  AOT_hence not_c_eqE_d: \<open>\<not>c =\<^sub>E d\<close>
    using intro_elim_3_a thm_neg_eq_E by blast
  AOT_have \<open>\<exists>x (A!x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>x x =\<^sub>E c]))\<close>
    by (simp add: a_objects vdash_properties_1_b)
  then AOT_obtain a where a_prop: \<open>A!a & \<forall>F (a[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>x x =\<^sub>E c])\<close> using "\<exists>E"[rotated] by blast
  AOT_have \<open>\<exists>x (A!x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>x x =\<^sub>E d]))\<close>
    by (simp add: a_objects vdash_properties_1_b)
  then AOT_obtain b where b_prop: \<open>A!b & \<forall>F (b[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>x x =\<^sub>E d])\<close> using "\<exists>E"[rotated] by blast
  AOT_have num_a_eq_c: \<open>Numbers(a, [\<lambda>x x =\<^sub>E c])\<close>
    by (safe intro!: numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" a_prop[THEN "&E"(1)] a_prop[THEN "&E"(2)]) cqt_2_lambda
  moreover AOT_have num_b_eq_d: \<open>Numbers(b, [\<lambda>x x =\<^sub>E d])\<close>
    by (safe intro!: numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" b_prop[THEN "&E"(1)] b_prop[THEN "&E"(2)]) cqt_2_lambda
  moreover AOT_have \<open>[\<lambda>x x =\<^sub>E c] \<approx>\<^sub>E [\<lambda>x x =\<^sub>E d]\<close>
  proof (rule equi_3[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    let ?R = \<open>\<guillemotleft>[\<lambda>xy (x =\<^sub>E c & y =\<^sub>E d)]\<guillemotright>\<close>
    AOT_have Rcd: \<open>[\<guillemotleft>?R\<guillemotright>]cd\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
         (auto simp: ord_eq_Eequiv_1[THEN "\<rightarrow>E"] Od Oc intro!: "&I")
    AOT_show \<open>\<exists>R R |: [\<lambda>x x =\<^sub>E c] \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E [\<lambda>x x =\<^sub>E d]\<close>
    proof (safe intro!: "\<exists>I"(1)[where \<tau>=\<open>?R\<close>] equi_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" eqE_den GEN "\<rightarrow>I")
      AOT_show \<open>\<guillemotleft>?R\<guillemotright>\<down>\<close> by cqt_2_lambda
    next
      fix u
      AOT_assume \<open>O!u\<close>
      AOT_assume \<open>[\<lambda>x x =\<^sub>E c]u\<close>
      AOT_hence \<open>u =\<^sub>E c\<close> by (metis betaC_1_a)
      AOT_hence u_is_c: \<open>u = c\<close>  by (metis eq_E_simple_2 vdash_properties_6)
      AOT_show \<open>\<exists>!v ([\<lambda>x x =\<^sub>E d]v & [\<guillemotleft>?R\<guillemotright>]uv)\<close>
      proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=d] "&I" Od GEN "\<rightarrow>I")
        AOT_show \<open>[\<lambda>x x =\<^sub>E d]d\<close>
          by (rule betaC_2_a; cqt_2_lambda; safe intro!: ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Od] cqt_2_const_var[axiom_inst])
      next
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]ud\<close> using u_is_c[symmetric] Rcd "rule=E" by fast
      next
        fix v
        AOT_assume \<open>O!v\<close>
        AOT_assume \<open>[\<lambda>x x =\<^sub>E d]v & [\<guillemotleft>?R\<guillemotright>]uv\<close>
        AOT_thus \<open>v =\<^sub>E d\<close> by (metis betaC_1_a con_dis_i_e_2_a)
      qed
    next
      fix v
      AOT_assume \<open>O!v\<close>
      AOT_assume \<open>[\<lambda>x x =\<^sub>E d]v\<close>
      AOT_hence \<open>v =\<^sub>E d\<close> by (metis betaC_1_a)
      AOT_hence v_is_d: \<open>v = d\<close>  by (metis eq_E_simple_2 vdash_properties_6)
      AOT_show \<open>\<exists>!u ([\<lambda>x x =\<^sub>E c]u & [\<guillemotleft>?R\<guillemotright>]uv)\<close>
      proof (safe intro!: equi_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "\<exists>I"(2)[where \<beta>=c] "&I" Oc GEN "\<rightarrow>I")
        AOT_show \<open>[\<lambda>x x =\<^sub>E c]c\<close>
          by (rule betaC_2_a; cqt_2_lambda; safe intro!: ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Oc] cqt_2_const_var[axiom_inst])
      next
        AOT_show \<open>[\<guillemotleft>?R\<guillemotright>]cv\<close> using v_is_d[symmetric] Rcd "rule=E" by fast
      next
        fix u
        AOT_assume \<open>O!u\<close>
        AOT_assume \<open>[\<lambda>x x =\<^sub>E c]u & [\<guillemotleft>?R\<guillemotright>]uv\<close>
        AOT_thus \<open>u =\<^sub>E c\<close> by (metis betaC_1_a con_dis_i_e_2_a)
      qed
    next
      AOT_show \<open>\<guillemotleft>?R\<guillemotright>\<down>\<close> by cqt_2_lambda
    qed
  qed
  ultimately AOT_have \<open>a = b\<close>
    using  pre_Hume[unvarify G H, OF eqE_den, OF eqE_den, THEN "\<rightarrow>E", OF "&I", THEN "\<equiv>E"(2)] by blast
  AOT_hence num_a_eq_d: \<open>Numbers(a, [\<lambda>x x =\<^sub>E d])\<close> using num_b_eq_d "rule=E" id_sym by fast
  AOT_have not_equiv: \<open>\<not>[\<lambda>x x =\<^sub>E c] \<equiv>\<^sub>E [\<lambda>x x =\<^sub>E d]\<close>
  proof (rule raa_cor_2)
    AOT_assume \<open>[\<lambda>x x =\<^sub>E c] \<equiv>\<^sub>E [\<lambda>x x =\<^sub>E d]\<close>
    AOT_hence \<open>[\<lambda>x x =\<^sub>E c]c \<equiv> [\<lambda>x x =\<^sub>E d]c\<close> using eqE[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"] Oc by blast
    moreover AOT_have \<open>[\<lambda>x x =\<^sub>E c]c\<close>
      by (rule betaC_2_a; cqt_2_lambda; safe intro!: ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Oc] cqt_2_const_var[axiom_inst])
    ultimately AOT_have \<open>[\<lambda>x x =\<^sub>E d]c\<close> using "\<equiv>E"(1) by blast
    AOT_hence \<open>c =\<^sub>E d\<close>
      by (rule betaC_1_a)
    AOT_thus \<open>c =\<^sub>E d & \<not>c =\<^sub>E d\<close> using not_c_eqE_d "&I" by blast
  qed
  AOT_show \<open>\<exists>x \<exists>G \<exists>H (Numbers(x,G) & Numbers(x,H) & \<not>G \<equiv>\<^sub>E H)\<close>
    apply (rule_tac \<beta>=a in "\<exists>I"(2))
    apply (rule_tac \<tau>=\<open>\<guillemotleft>[\<lambda>x x =\<^sub>E c]\<guillemotright>\<close> in "\<exists>I"(1))
     apply (rule_tac \<tau>=\<open>\<guillemotleft>[\<lambda>x x =\<^sub>E d]\<guillemotright>\<close> in "\<exists>I"(1))
    by (safe intro!: eqE_den "&I" num_a_eq_c num_a_eq_d not_equiv)
qed

AOT_theorem num_1: \<open>\<exists>x Numbers(x,G)\<close>
  by (AOT_subst \<open>\<lambda> \<kappa> . \<guillemotleft>Numbers(\<kappa>,G)\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>[A!]\<kappa> & \<forall>F (\<kappa>[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<guillemotright>\<close>)
     (auto simp: numbers_den[OF cqt_2_const_var[axiom_inst]] a_objects[axiom_inst])

AOT_theorem num_2: \<open>\<exists>!x Numbers(x,G)\<close>
  by (AOT_subst \<open>\<lambda> \<kappa> . \<guillemotleft>Numbers(\<kappa>,G)\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>[A!]\<kappa> & \<forall>F (\<kappa>[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<guillemotright>\<close>)
     (auto simp: A_objects_unique numbers_den[OF cqt_2_const_var[axiom_inst]])

AOT_theorem num_cont_1: \<open>\<exists>x\<exists>G(Numbers(x, G) & \<not>\<box>Numbers(x, G))\<close>
proof -
  AOT_have \<open>\<exists>F\<exists>G \<diamond>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
    using approx_cont_2.
  then AOT_obtain F where \<open>\<exists>G \<diamond>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using "\<exists>E"[rotated] by blast
  then AOT_obtain G where \<open>\<diamond>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G & \<diamond>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<theta>: \<open>\<diamond>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> and \<zeta>: \<open>\<diamond>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close>
    using KBasic2_3[THEN "\<rightarrow>E"] "&E" S5Basic_7[THEN "\<rightarrow>E"] by blast+
  AOT_obtain a where \<open>Numbers(a, G)\<close> using num_1 "\<exists>E"[rotated] by blast
  moreover AOT_have \<open>\<not>\<box>Numbers(a, G)\<close>
  proof (rule raa_cor_2)
    AOT_assume 1: \<open>\<box>Numbers(a, G)\<close>
    AOT_have \<open>\<box>([A!]a & G\<down> & \<forall>F (a[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close>
      by (AOT_subst_using_rev subst: numbers[THEN "\<equiv>Df"]) (fact 1)
    AOT_hence \<open>\<box>A!a\<close> and \<open>\<box>\<forall>F (a[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
      using KBasic_3[THEN "\<equiv>E"(1)] "&E" by blast+
    AOT_hence \<open>\<forall>F \<box>(a[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using CBF[THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>\<box>(a[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using "\<forall>E"(2) by blast
    AOT_hence A: \<open>\<box>(a[F] \<rightarrow> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> and B: \<open>\<box>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<rightarrow> a[F])\<close>
      using KBasic_4[THEN "\<equiv>E"(1)] "&E" by blast+
    AOT_have \<open>\<box>(\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<rightarrow> \<not>a[F])\<close>
      apply (AOT_subst \<open>\<guillemotleft>\<not>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<rightarrow> \<not>a[F]\<guillemotright>\<close> \<open>\<guillemotleft>a[F] \<rightarrow> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<guillemotright>\<close>)
       using intro_elim_2 useful_tautologies_4 useful_tautologies_5 apply presburger
       by (fact A)
    AOT_hence \<open>\<diamond>\<not>a[F]\<close> by (metis KBasic_13 \<zeta> vdash_properties_10)
    AOT_hence \<open>\<not>a[F]\<close> by (metis KBasic_11 en_eq_2_1 intro_elim_3_b intro_elim_3_d)
    AOT_hence \<open>\<not>\<diamond>a[F]\<close> by (metis en_eq_3_1 intro_elim_3_d)
    moreover AOT_have \<open>\<diamond>a[F]\<close> by (meson B \<theta> KBasic_13 vdash_properties_10)
    ultimately AOT_show \<open>\<diamond>a[F] & \<not>\<diamond>a[F]\<close> using "&I" by blast
  qed

  ultimately AOT_have \<open>Numbers(a, G) & \<not>\<box>Numbers(a, G)\<close> using "&I" by blast
  AOT_hence \<open>\<exists>G (Numbers(a, G) & \<not>\<box>Numbers(a, G))\<close> by (rule "\<exists>I")
  AOT_thus \<open>\<exists>x\<exists>G (Numbers(x, G) & \<not>\<box>Numbers(x, G))\<close> by (rule "\<exists>I")
qed

(* TODO: PLM: proof neglects to mention RM *)
AOT_theorem num_cont_2: \<open>\<box>\<forall>z([G]z \<rightarrow> \<box>[G]z) \<rightarrow> \<box>\<forall>x(Numbers(x,G) \<rightarrow> \<box>Numbers(x,G))\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>\<box>\<forall>z([G]z \<rightarrow> \<box>[G]z)\<close>
  AOT_hence \<open>\<box>\<box>\<forall>z([G]z \<rightarrow> \<box>[G]z)\<close> by (metis S5Basic_6 intro_elim_3_a)
  moreover AOT_have \<open>\<box>\<box>\<forall>z([G]z \<rightarrow> \<box>[G]z) \<rightarrow> \<box>\<forall>x(Numbers(x,G) \<rightarrow> \<box>Numbers(x,G))\<close>
  proof(rule RM; safe intro!: "\<rightarrow>I" GEN)
    AOT_modally_strict {
      AOT_have act_den: \<open>[\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
      fix x
      AOT_assume G_nec: \<open>\<box>\<forall>z([G]z \<rightarrow> \<box>[G]z)\<close>
      AOT_assume \<open>Numbers(x, G)\<close>
      AOT_hence \<open>[A!]x & G\<down> & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
      AOT_hence Ax: \<open>[A!]x\<close> and \<open>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using "&E" by blast+
      AOT_hence \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G\<close> for F using "\<forall>E"(2) by blast
      moreover AOT_have \<open>\<box>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<rightarrow> \<box>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> for F
        using approx_nec_2[unvarify F, OF act_den, THEN "\<rightarrow>E", OF "&I", OF actuallyF_2', OF G_nec].
      moreover AOT_have \<open>\<box>(x[F] \<rightarrow> \<box>x[F])\<close> for F by (simp add: RN pre_en_eq_1_1)
      ultimately AOT_have \<open>\<box>(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> for F
        using sc_eq_box_box_5[THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF "&I"] by blast
      AOT_hence \<open>\<forall>F \<box>(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> by (rule "\<forall>I")
      AOT_hence 1: \<open>\<box>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close> using BF[THEN "\<rightarrow>E"] by fast
      AOT_have \<open>\<box>G\<down>\<close> by (simp add: ex_2_a)
      moreover AOT_have \<open>\<box>[A!]x\<close> using Ax using oa_facts_2 vdash_properties_10 by blast
      ultimately AOT_have \<open>\<box>(A!x & G\<down>)\<close>
        by (metis KBasic_3 con_dis_i_e_1 intro_elim_3_b)
      AOT_hence 2: \<open>\<box>(A!x & G\<down> & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close> using 1
        using KBasic_3 con_dis_i_e_1 intro_elim_3_b by fast
      AOT_show \<open>\<box>Numbers(x, G)\<close>
        by (AOT_subst_using subst: numbers[THEN "\<equiv>Df"]) (fact 2)
    }
  qed
  ultimately AOT_show \<open>\<box>\<forall>x(Numbers(x,G) \<rightarrow> \<box>Numbers(x,G))\<close>
    using "\<rightarrow>E" by blast
qed

AOT_theorem num_cont_3: \<open>\<box>\<forall>x(Numbers(x, [\<lambda>z \<^bold>\<A>[G]z]) \<rightarrow> \<box>Numbers(x, [\<lambda>z \<^bold>\<A>[G]z]))\<close>
  by (rule num_cont_2[unvarify G, THEN "\<rightarrow>E"]; (cqt_2_lambda | rule actuallyF_2'))

AOT_theorem num_uniq: \<open>\<^bold>\<iota>x Numbers(x, G)\<down>\<close>
  using "\<equiv>E"(2) A_Exists_2 RA_2 num_2 by blast

AOT_define num :: \<open>\<tau> \<Rightarrow> \<kappa>\<^sub>s\<close> (\<open>#_\<close> [100] 100) (* TODO: figure out a suitable precedence *)
  \<open>#G =\<^sub>d\<^sub>f \<^bold>\<iota>x Numbers(x, G)\<close>

AOT_theorem num_can_1: \<open>#G = \<^bold>\<iota>x(A!x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close>
proof -
  AOT_have \<open>\<box>\<forall>x(Numbers(x,G) \<equiv> [A!]x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close>
    by (rule RN; rule GEN; rule numbers_den[OF cqt_2_const_var[axiom_inst]])
  AOT_hence \<open>\<^bold>\<iota>x Numbers(x, G) = \<^bold>\<iota>x([A!]x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close>
    using num_uniq equiv_desc_eq_3[THEN "\<rightarrow>E", OF "&I"] by auto
  thus ?thesis
    by (rule "=\<^sub>d\<^sub>fI"(1)[OF num, OF num_uniq])
qed

AOT_theorem num_can_2: \<open>#G = \<^bold>\<iota>x(A!x & \<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
proof (rule id_trans[OF num_can_1]; rule equiv_desc_eq_2[THEN "\<rightarrow>E"];
       safe intro!: "&I" A_descriptions logic_actual_nec_3[axiom_inst, THEN "\<equiv>E"(2)]
                    GEN Act_Basic_5[THEN "\<equiv>E"(2)])
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  AOT_have eq_part_3': \<open>\<^bold>\<turnstile>\<^sub>\<box> F \<approx>\<^sub>E G & F \<approx>\<^sub>E H \<rightarrow> G \<approx>\<^sub>E H\<close> for F G H
    by (metis con_dis_i_e_1 eq_part_2 eq_part_3 "\<rightarrow>I" "&E" vdash_properties_6)
  fix x
  {
    fix F
    AOT_have \<open>\<^bold>\<A>(F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z])\<close>
      by (simp add: actuallyF_1)
    moreover AOT_have \<open>\<^bold>\<A>((F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]) \<rightarrow> ([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<equiv> F \<approx>\<^sub>E G))\<close>
      by (auto intro!: RA "\<rightarrow>I" "\<equiv>I"
               simp: eq_part_3[unvarify G, OF act_den, THEN "\<rightarrow>E", OF "&I"]
                     eq_part_3'[unvarify G, OF act_den, THEN "\<rightarrow>E", OF "&I"])
    ultimately AOT_have \<open>\<^bold>\<A>([\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<equiv> F \<approx>\<^sub>E G)\<close>
      using logic_actual_nec_2[axiom_inst, THEN "\<equiv>E"(1), THEN "\<rightarrow>E"] by blast

    AOT_hence \<open>\<^bold>\<A>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G \<equiv> \<^bold>\<A>F \<approx>\<^sub>E G\<close> by (metis Act_Basic_5 intro_elim_3_a)
    (* TODO: PLM: Important: cites 727.4 instead of 727.5 ; also missing parentheses? wrong citation? Next formula after \<theta>. *)
    AOT_hence 0: \<open>(\<^bold>\<A>x[F] \<equiv> \<^bold>\<A>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G) \<equiv> (\<^bold>\<A>x[F] \<equiv> \<^bold>\<A>F \<approx>\<^sub>E G)\<close>
      by (auto intro!: "\<equiv>I" "\<rightarrow>I" elim: "\<equiv>E")
    AOT_have \<open>\<^bold>\<A>(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G) \<equiv> (\<^bold>\<A>x[F] \<equiv> \<^bold>\<A>[\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
      by (simp add: Act_Basic_5)
    also AOT_have \<open>\<dots> \<equiv> (\<^bold>\<A>x[F] \<equiv> \<^bold>\<A>F \<approx>\<^sub>E G)\<close> using 0.
    also AOT_have \<open>\<dots> \<equiv> \<^bold>\<A>((x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
      by (meson Act_Basic_5 intro_elim_3_f oth_class_taut_3_a)
    finally AOT_have 0: \<open>\<^bold>\<A>(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G) \<equiv> \<^bold>\<A>((x[F] \<equiv> F \<approx>\<^sub>E G))\<close>.
  } note 0 = this
  AOT_have \<open>\<^bold>\<A>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G) \<equiv> \<forall>F \<^bold>\<A>(x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)\<close>
    using logic_actual_nec_3 vdash_properties_1_b by blast
  also AOT_have \<open>\<dots> \<equiv>  \<forall>F \<^bold>\<A>((x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
    apply (safe intro!: "\<equiv>I" "\<rightarrow>I" GEN)
    using 0 intro_elim_3_a intro_elim_3_b rule_ui_3 by blast+
  also AOT_have \<open>\<dots> \<equiv> \<^bold>\<A>(\<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
    using intro_elim_3_f logic_actual_nec_3 oth_class_taut_3_a vdash_properties_1_b by blast
  finally AOT_have 0: \<open>\<^bold>\<A>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G) \<equiv> \<^bold>\<A>(\<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>.
  AOT_have \<open>\<^bold>\<A>([A!]x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)) \<equiv> (\<^bold>\<A>A!x & \<^bold>\<A>\<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G))\<close>
    by (simp add: Act_Basic_2)
  also AOT_have \<open>\<dots> \<equiv> \<^bold>\<A>[A!]x & \<^bold>\<A>(\<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
    using 0 oth_class_taut_4_f vdash_properties_6 by blast
  also AOT_have \<open>\<dots> \<equiv> \<^bold>\<A>(A!x & \<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>
    using Act_Basic_2 intro_elim_3_f oth_class_taut_3_a by blast
  finally AOT_show \<open>\<^bold>\<A>([A!]x & \<forall>F (x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E G)) \<equiv> \<^bold>\<A>([A!]x & \<forall>F (x[F] \<equiv> F \<approx>\<^sub>E G))\<close>.
qed

(* TODO: not in PLM *)
AOT_theorem num_den: \<open>#G\<down>\<close>
  using "t=t-proper_1" num_can_1 vdash_properties_10 by blast
AOT_theorem num_den': \<open>#\<Pi>\<down>\<close> if \<open>\<Pi>\<down>\<close>
  using num_den[unvarify G, OF that].
(* TODO: not in PLM *)
AOT_act_theorem numbers_num: \<open>Numbers(#G, G)\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF num])
  apply (simp add: num_uniq)
  using num_uniq vdash_properties_10 y_in_3 by blast

AOT_define card :: \<open>\<tau> \<Rightarrow> \<phi>\<close> (\<open>NaturalCardinal'(_')\<close>)
  \<open>NaturalCardinal(x) \<equiv>\<^sub>d\<^sub>f \<exists>G(x = #G)\<close>

AOT_theorem natcard_nec: \<open>NaturalCardinal(x) \<rightarrow> \<box>NaturalCardinal(x)\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>NaturalCardinal(x)\<close>
  AOT_hence \<open>\<exists>G(x = #G)\<close> using card[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain G where \<open>x = #G\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>\<box>x = #G\<close> by (metis id_nec_2 vdash_properties_10)
  AOT_hence \<open>\<exists>G \<box>x = #G\<close> by (rule "\<exists>I")
  AOT_hence 1: \<open>\<box>\<exists>G x = #G\<close> by (metis sign_S5_thm_1 vdash_properties_10)
  AOT_show \<open>\<box>NaturalCardinal(x)\<close>
    by (AOT_subst_using subst: card[THEN "\<equiv>Df"]) (fact 1)
qed

AOT_act_theorem hume_1: \<open>#F = #G \<equiv> F \<approx>\<^sub>E G\<close>
  by (safe intro!: pre_Hume[unvarify x y, OF num_den, OF num_den, THEN "\<rightarrow>E"] "&I" numbers_num)

AOT_act_theorem hume_2: \<open>#F = #G \<equiv> \<exists>R (R |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G)\<close>
  apply (AOT_subst_rev \<open>\<lambda> \<Pi> . \<guillemotleft> \<Pi> |: F \<^sub>1\<^sub>-\<^sub>1\<longleftrightarrow>\<^sub>E G \<guillemotright>\<close> \<open>\<lambda> \<Pi> . \<guillemotleft>\<Pi> |: F \<^sub>1\<^sub>-\<^sub>1\<longrightarrow>\<^sub>o\<^sub>n\<^sub>t\<^sub>oE G\<guillemotright>\<close>)
   apply (fact equi_rem_thm)
  using equi_3 hume_1 intro_elim_3_e rule_eq_df_1 by blast

AOT_act_theorem hume_3: \<open>F \<equiv>\<^sub>E G \<rightarrow> #F = #G\<close>
  by (metis apE_eqE_1 deduction_theorem hume_1 intro_elim_3_b vdash_properties_10)

AOT_theorem hume_strict: \<open>\<exists>!x (Numbers(x, F) & Numbers(x, G)) \<equiv> F \<approx>\<^sub>E G\<close>
proof(safe intro!: "\<equiv>I" "\<rightarrow>I")
  AOT_assume \<open>\<exists>!x (Numbers(x, F) & Numbers(x, G))\<close>
  AOT_hence \<open>\<exists>x (Numbers(x, F) & Numbers(x, G) & \<forall>z ((Numbers(z, F) & Numbers(z, G) \<rightarrow> z = x)))\<close>
    using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain a where a_prop: \<open>Numbers(a, F) & Numbers(a, G) & \<forall>z ((Numbers(z, F) & Numbers(z, G) \<rightarrow> z = a))\<close>
    using "\<exists>E"[rotated] by blast
  AOT_show \<open>F \<approx>\<^sub>E G\<close>
    by (auto intro!: id_eq_1 pre_Hume[THEN "\<rightarrow>E", OF a_prop[THEN "&E"(1)], THEN "\<equiv>E"(1)])
next
  AOT_assume 0: \<open>F \<approx>\<^sub>E G\<close>
  moreover AOT_obtain b where num_b_F: \<open>Numbers(b, F)\<close> by (metis "instantiation" num_1)
  ultimately AOT_have num_b_G: \<open>Numbers(b, G)\<close> using num_tran_1[THEN "\<rightarrow>E", THEN "\<equiv>E"(1)] by blast
  AOT_have \<open>\<forall>z (Numbers(z, F) & Numbers(z, G) \<rightarrow> z = b)\<close>
  proof(safe intro!: GEN "\<rightarrow>I"; drule "&E"(1))
    AOT_show \<open>z = b\<close> if \<open>Numbers(z, F)\<close> for z
      using pre_Hume[THEN "\<rightarrow>E", OF "&I", OF that, OF num_b_F, THEN "\<equiv>E"(2), rotated, OF eq_part_1].
  qed
  AOT_hence \<open>Numbers(b, F) & Numbers(b, G) & \<forall>z (Numbers(z, F) & Numbers(z, G) \<rightarrow> z = b)\<close>
    using num_b_F num_b_G "&I" by blast
  AOT_hence \<open>\<exists>x (Numbers(x, F) & Numbers(x, G) & \<forall>z (Numbers(z, F) & Numbers(z, G) \<rightarrow> z = x))\<close>
    by (rule "\<exists>I")
  AOT_thus \<open>\<exists>!x (Numbers(x, F) & Numbers(x, G))\<close>
    by (rule uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fI"])
qed

AOT_theorem unotEu: \<open>\<not>\<exists>y[\<lambda>x O!x & \<not>(x =\<^sub>E x)]y\<close>
proof(rule raa_cor_2)
  AOT_assume \<open>\<exists>y[\<lambda>x O!x & \<not>(x =\<^sub>E x)]y\<close>
  then AOT_obtain y where \<open>[\<lambda>x O!x & \<not>(x =\<^sub>E x)]y\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>O!y & \<not>(y =\<^sub>E y)\<close> by (rule betaC_1_a)
  moreover AOT_have \<open>y =\<^sub>E y\<close> by (metis calculation[THEN "&E"(1)] ord_eq_Eequiv_1 vdash_properties_10)
  ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis con_dis_i_e_2_b raa_cor_3)
qed
(* TODO: PLM: maybe this should actually be stated as 756 unotEu *)
AOT_theorem unotEu': \<open>\<not>\<exists>y[\<lambda>x O!x & x \<noteq>\<^sub>E x]y\<close>
proof(rule raa_cor_2)
  AOT_assume \<open>\<exists>y[\<lambda>x O!x & x \<noteq>\<^sub>E x]y\<close>
  then AOT_obtain y where \<open>[\<lambda>x O!x & x \<noteq>\<^sub>E x]y\<close> using "\<exists>E"[rotated] by blast
  AOT_hence 0: \<open>O!y & y \<noteq>\<^sub>E y\<close> by (rule betaC_1_a)
  AOT_hence \<open>\<not>(y =\<^sub>E y)\<close> using con_dis_i_e_2_b intro_elim_3_a thm_neg_eq_E by blast
  moreover AOT_have \<open>y =\<^sub>E y\<close> by (metis 0[THEN "&E"(1)] ord_eq_Eequiv_1 vdash_properties_10)
  ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis raa_cor_3)
qed
(* TODO: not in PLM, but used in proof 761 *)
AOT_theorem unotEu'': \<open>\<not>\<exists>v[\<lambda>x O!x & \<^bold>\<A>x \<noteq>\<^sub>E x]v\<close>
proof(rule raa_cor_2)
  AOT_assume \<open>\<exists>v[\<lambda>x O!x & \<^bold>\<A>x \<noteq>\<^sub>E x]v\<close>
  then AOT_obtain y where \<open>[\<lambda>x O!x & \<^bold>\<A>x \<noteq>\<^sub>E x]y\<close> using "\<exists>E"[rotated] "&E" by blast
  AOT_hence 0: \<open>O!y & \<^bold>\<A>y \<noteq>\<^sub>E y\<close> by (rule betaC_1_a)
  AOT_have \<open>\<^bold>\<A>\<not>(y =\<^sub>E y)\<close>
    apply (AOT_subst  \<open>\<guillemotleft>\<not>(y =\<^sub>E y)\<guillemotright>\<close> \<open>\<guillemotleft>y \<noteq>\<^sub>E y\<guillemotright>\<close>)
     apply (meson intro_elim_3_b oth_class_taut_2_e thm_neg_eq_E)
    by (fact 0[THEN "&E"(2)])
  AOT_hence \<open>\<not>(y =\<^sub>E y)\<close> by (metis "\<not>\<not>I" Act_Sub_1 id_act2_1 intro_elim_3_d)
  moreover AOT_have \<open>y =\<^sub>E y\<close> by (metis 0[THEN "&E"(1)] ord_eq_Eequiv_1 vdash_properties_10)
  ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis raa_cor_3)
qed

AOT_define zero :: \<open>\<kappa>\<^sub>s\<close> (\<open>0\<close>)
  \<open>0 =\<^sub>d\<^sub>f #[\<lambda>x O!x & x \<noteq>\<^sub>E x]\<close>

(* TODO: not part of PLM *)
AOT_theorem zero_den: \<open>0\<down>\<close>
  by (rule "=\<^sub>d\<^sub>fI"(2)[OF zero]; rule num_den'; cqt_2_lambda)

AOT_theorem zero_card: \<open>NaturalCardinal(0)\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(2)[OF zero])
   apply (rule num_den'; cqt_2_lambda)
  apply (rule card[THEN "\<equiv>\<^sub>d\<^sub>fI"])
  apply (rule_tac \<tau>=\<open>\<guillemotleft>[\<lambda>x [O!]x & x \<noteq>\<^sub>E x]\<guillemotright>\<close> in "\<exists>I"(1))
   apply (rule "rule=I_1"; rule num_den'; cqt_2_lambda)
  by cqt_2_lambda

AOT_theorem eq_num_1: \<open>\<^bold>\<A>Numbers(x, G) \<equiv> Numbers(x,[\<lambda>z \<^bold>\<A>[G]z])\<close>
proof -
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  AOT_have \<open>\<box>(\<exists>!x(Numbers(x, G) & Numbers(x,[\<lambda>z \<^bold>\<A>[G]z])) \<equiv> G \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z])\<close>
    using hume_strict[unvarify G, OF act_den, THEN RN].
  AOT_hence \<open>\<^bold>\<A>(\<exists>!x(Numbers(x, G) & Numbers(x,[\<lambda>z \<^bold>\<A>[G]z])) \<equiv> G \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z])\<close>
    using nec_imp_act[THEN "\<rightarrow>E"] by fast
  AOT_hence \<open>\<^bold>\<A>(\<exists>!x(Numbers(x, G) & Numbers(x,[\<lambda>z \<^bold>\<A>[G]z])))\<close>
    using actuallyF_1 Act_Basic_5 intro_elim_3_a intro_elim_3_b by fast
  AOT_hence \<open>\<exists>!x \<^bold>\<A>((Numbers(x, G) & Numbers(x,[\<lambda>z \<^bold>\<A>[G]z])))\<close>
    by (metis A_Exists_1 intro_elim_3_a)
  AOT_hence \<open>\<exists>x(\<^bold>\<A>((Numbers(x, G) & Numbers(x,[\<lambda>z \<^bold>\<A>[G]z]))) & \<forall>z(\<^bold>\<A>((Numbers(z, G) & Numbers(z,[\<lambda>z \<^bold>\<A>[G]z]))) \<rightarrow> z = x))\<close>
    using uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain a where \<open>\<^bold>\<A>((Numbers(a, G) & Numbers(a,[\<lambda>z \<^bold>\<A>[G]z])))\<close>
    using "\<exists>E"[rotated] "&E" by blast
  AOT_hence act_a_num_G: \<open>\<^bold>\<A>Numbers(a, G)\<close> and act_a_num_actG: \<open>\<^bold>\<A>Numbers(a,[\<lambda>z \<^bold>\<A>[G]z])\<close>
    using Act_Basic_2 "&E" intro_elim_3_a by blast+
  AOT_hence num_a_act_g: \<open>Numbers(a, [\<lambda>z \<^bold>\<A>[G]z])\<close>
    using num_cont_2[unvarify G, OF act_den, THEN "\<rightarrow>E", OF actuallyF_2',
                     THEN CBF[THEN "\<rightarrow>E"], THEN "\<forall>E"(2)]
    by (metis intro_elim_3_a sc_eq_fur_2 vdash_properties_6)
  AOT_have 0: \<open>\<^bold>\<turnstile>\<^sub>\<box> Numbers(x, G) & Numbers(y, G) \<rightarrow> x = y\<close> for y
    using pre_Hume[THEN "\<rightarrow>E", THEN "\<equiv>E"(2), rotated, OF eq_part_1] "\<rightarrow>I" by blast
  show ?thesis
  proof(safe intro!: "\<equiv>I" "\<rightarrow>I")
    AOT_assume \<open>\<^bold>\<A>Numbers(x, G)\<close>
    AOT_hence \<open>\<^bold>\<A>x = a\<close>
      using 0[THEN RA(2), THEN act_cond[THEN "\<rightarrow>E"], THEN "\<rightarrow>E", OF Act_Basic_2[THEN "\<equiv>E"(2)], OF "&I"]
            act_a_num_G by blast
    AOT_hence \<open>x = a\<close> by (metis id_act_1 intro_elim_3_b)
    AOT_hence \<open>a = x\<close> using id_sym by auto
    AOT_thus \<open>Numbers(x, [\<lambda>z \<^bold>\<A>[G]z])\<close>
      using "rule=E" num_a_act_g by fast
  next
    AOT_assume \<open>Numbers(x, [\<lambda>z \<^bold>\<A>[G]z])\<close>
    AOT_hence \<open>a = x\<close>
      using pre_Hume[unvarify G H, THEN "\<rightarrow>E", OF act_den, OF act_den, OF "&I", OF num_a_act_g, THEN "\<equiv>E"(2)]
            eq_part_1[unvarify F, OF act_den] by blast
    AOT_thus \<open>\<^bold>\<A>Numbers(x, G)\<close>
      using act_a_num_G "rule=E" by fast
  qed
qed

AOT_theorem eq_num_2: \<open>Numbers(x,[\<lambda>z \<^bold>\<A>[G]z]) \<equiv> x = #G\<close>
proof -
  AOT_have 0: \<open>\<^bold>\<turnstile>\<^sub>\<box> x = \<^bold>\<iota>x Numbers(x, G) \<equiv> \<forall>y (Numbers(y, [\<lambda>z \<^bold>\<A>[G]z]) \<equiv> y = x)\<close> for x
    by (AOT_subst_rev \<open>\<lambda> \<kappa> . \<guillemotleft>\<^bold>\<A>Numbers(\<kappa>, G)\<guillemotright>\<close> \<open>\<lambda> \<kappa> . \<guillemotleft>Numbers(\<kappa>, [\<lambda>z \<^bold>\<A>[G]z])\<guillemotright>\<close>)
       (auto simp: eq_num_1 descriptions[axiom_inst])
  AOT_have \<open>#G = \<^bold>\<iota>x Numbers(x, G) \<equiv> \<forall>y (Numbers(y, [\<lambda>z \<^bold>\<A>[G]z]) \<equiv> y = #G)\<close>
    using 0[unvarify x, OF num_den].
  moreover AOT_have \<open>#G = \<^bold>\<iota>x Numbers(x, G)\<close>
    using num num_uniq rule_id_def_1 by blast
  ultimately AOT_have \<open>\<forall>y (Numbers(y, [\<lambda>z \<^bold>\<A>[G]z]) \<equiv> y = #G)\<close> using "\<equiv>E" by blast
  thus ?thesis using "\<forall>E"(2) by blast
qed

AOT_theorem eq_num_3: \<open>Numbers(#G, [\<lambda>y \<^bold>\<A>[G]y])\<close>
proof -
  AOT_have \<open>#G = #G\<close>
    by (simp add: "rule=I_1" num_den)
  thus ?thesis using eq_num_2[unvarify x, OF num_den, THEN "\<equiv>E"(2)] by blast
qed

AOT_theorem eq_num_4: \<open>A!#G & \<forall>F (#G[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z])\<close>
  by (auto intro!: "&I" eq_num_3[THEN numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(1), THEN "&E"(1)]
                   eq_num_3[THEN numbers[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)])

AOT_theorem eq_num_5: \<open>#G[\<lambda>z \<^bold>\<A>[G]z]\<close>
proof -
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  show ?thesis
    apply (rule eq_num_4[THEN "&E"(2), THEN "\<forall>E"(1), THEN "\<equiv>E"(2)])
     apply cqt_2_lambda
    apply (rule approx_nec_1[unvarify F, THEN "\<rightarrow>E", symmetric])
     apply cqt_2_lambda
    using actuallyF_2' by auto
qed

AOT_theorem eq_num_6: \<open>Numbers(x, G) \<rightarrow> NaturalCardinal(x)\<close>
proof(rule "\<rightarrow>I")
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  AOT_obtain F where \<open>Rigidifies(F, G)\<close>
    by (metis "instantiation" rigid_der_3)
  AOT_hence \<theta>: \<open>\<box>\<forall>x([F]x \<rightarrow> \<box>[F]x)\<close> and \<open>\<forall>x([F]x \<equiv> [G]x)\<close>
    using df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(2)]
          df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(1), THEN df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2)]
    by blast+
  AOT_hence \<open>F \<equiv>\<^sub>E G\<close>
    by (auto intro!: eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I" elim: "\<forall>E"(2))
  moreover AOT_assume \<open>Numbers(x, G)\<close>
  ultimately AOT_have \<open>Numbers(x, F)\<close>
    using num_tran_3[THEN "\<rightarrow>E", THEN "\<equiv>E"(2)] by blast
  moreover AOT_have \<open>F \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[F]z]\<close> using \<theta> approx_nec_1 vdash_properties_10 by blast
  ultimately AOT_have \<open>Numbers(x, [\<lambda>z \<^bold>\<A>[F]z])\<close>
    using num_tran_1[unvarify H, OF act_den, THEN "\<rightarrow>E", THEN "\<equiv>E"(1)] by blast
  AOT_hence \<open>x = #F\<close> using eq_num_2[THEN "\<equiv>E"(1)] by blast
  AOT_hence \<open>\<exists>F x = #F\<close> by (rule "\<exists>I")
  AOT_thus \<open>NaturalCardinal(x)\<close>
    using card[THEN "\<equiv>\<^sub>d\<^sub>fI"] by blast
qed

AOT_theorem card_en: \<open>NaturalCardinal(x) \<rightarrow> \<forall>F(x[F] \<equiv> x = #F)\<close>
proof(rule "\<rightarrow>I"; rule GEN)
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  fix F
  AOT_assume \<open>NaturalCardinal(x)\<close>
  AOT_hence \<open>\<exists>F x = #F\<close> using card[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  then AOT_obtain P where x_def: \<open>x = #P\<close> using "\<exists>E"[rotated] by blast
  AOT_hence num_x_act_P: \<open>Numbers(x,[\<lambda>z \<^bold>\<A>[P]z])\<close> using eq_num_2[THEN "\<equiv>E"(2)] by blast
  AOT_have \<open>#P[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[P]z]\<close>
    using eq_num_4[THEN "&E"(2), THEN "\<forall>E"(2)] by blast
  AOT_hence \<open>x[F] \<equiv> [\<lambda>z \<^bold>\<A>[F]z] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[P]z]\<close> using x_def[symmetric] "rule=E" by fast
  also AOT_have \<open>\<dots> \<equiv> Numbers(x, [\<lambda>z \<^bold>\<A>[F]z])\<close>
    using num_tran_1[unvarify G H, OF act_den, OF act_den]
    using num_tran_2[unvarify G H, OF act_den, OF act_den]
    by (metis con_dis_i_e_1 deduction_theorem intro_elim_2 intro_elim_3_b num_x_act_P)
  also AOT_have \<open>\<dots> \<equiv> x = #F\<close>
    using eq_num_2 by blast
  finally AOT_show \<open>x[F] \<equiv> x = #F\<close>.
qed

AOT_theorem zeroF: \<open>\<not>\<exists>u [F]u \<equiv> Numbers(0, F)\<close>
proof -
  AOT_have \<open>Numbers(0, [\<lambda>y \<^bold>\<A>[\<lambda>x O!x & x \<noteq>\<^sub>E x]y])\<close>
    apply (rule "=\<^sub>d\<^sub>fI"(2)[OF zero])
     apply (rule num_den'; cqt_2_lambda)
    apply (rule eq_num_3[unvarify G])
    by cqt_2_lambda
  AOT_hence numbers0: \<open>Numbers(0, [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x])\<close>
  proof (rule num_tran_3[unvarify x G H, THEN "\<rightarrow>E", THEN "\<equiv>E"(1), rotated 4])
    AOT_show \<open>[\<lambda>y \<^bold>\<A>[\<lambda>x O!x & x \<noteq>\<^sub>E x]y] \<equiv>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]\<close>
    proof (safe intro!: eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" GEN "\<rightarrow>I")
      fix u
      AOT_assume Ou: \<open>O!u\<close>
      AOT_have \<open>[\<lambda>y \<^bold>\<A>[\<lambda>x O!x & x \<noteq>\<^sub>E x]y]u \<equiv> \<^bold>\<A>[\<lambda>x O!x & x \<noteq>\<^sub>E x]u\<close>
        by (rule beta_C_meta[THEN "\<rightarrow>E"]; cqt_2_lambda)
      also AOT_have \<open>\<dots> \<equiv> \<^bold>\<A>(O!u & u \<noteq>\<^sub>E u)\<close>
        apply (AOT_subst \<open>\<guillemotleft>[\<lambda>x O!x & x \<noteq>\<^sub>E x]u\<guillemotright>\<close> \<open>\<guillemotleft>O!u & u \<noteq>\<^sub>E u\<guillemotright>\<close>)
         apply (rule beta_C_meta[THEN "\<rightarrow>E"]; cqt_2_lambda)
        by (simp add: oth_class_taut_3_a)
      also AOT_have \<open>\<dots> \<equiv> (\<^bold>\<A>O!u & \<^bold>\<A>u \<noteq>\<^sub>E u)\<close>
        by (simp add: Act_Basic_2)
      also AOT_have \<open>\<dots> \<equiv> (O!u & \<^bold>\<A>u \<noteq>\<^sub>E u)\<close>
        by (metis Ou con_dis_i_e_1 con_dis_i_e_2_b deduction_theorem intro_elim_2 intro_elim_3_a oa_facts_7)
      also AOT_have \<open>\<dots> \<equiv> [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]u\<close>
        by (rule beta_C_meta[THEN "\<rightarrow>E", symmetric]; cqt_2_lambda)
      finally AOT_show \<open>[\<lambda>y \<^bold>\<A>[\<lambda>x O!x & x \<noteq>\<^sub>E x]y]u \<equiv> [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]u\<close>.
    qed(cqt_2_lambda)+
  qed(fact zero_den | cqt_2_lambda)+
  show ?thesis
  proof(safe intro!: "\<equiv>I" "\<rightarrow>I")
    AOT_assume \<open>\<not>\<exists>u [F]u\<close>
    moreover AOT_have \<open>\<not>\<exists>v [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]v\<close> using unotEu''.
    ultimately AOT_have 0: \<open>F \<approx>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]\<close>
      by (rule empty_approx_1[unvarify H, THEN "\<rightarrow>E", rotated, OF "&I"]) cqt_2_lambda
    AOT_thus \<open>Numbers(0, F)\<close>
      by (rule num_tran_1[unvarify x H, THEN "\<rightarrow>E", THEN "\<equiv>E"(2), rotated, rotated])
         (fact zero_den numbers0 | cqt_2_lambda)+
  next
    AOT_assume \<open>Numbers(0, F)\<close>
    AOT_hence 1: \<open>F \<approx>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]\<close>
      by (rule num_tran_2[unvarify x H, THEN "\<rightarrow>E", rotated 2, OF "&I"])
         (fact numbers0 zero_den | cqt_2_lambda)+
    AOT_show \<open>\<not>\<exists>u [F]u\<close>
    proof(rule raa_cor_2)
      AOT_have 0: \<open>[\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x]\<down>\<close> by cqt_2_lambda
      AOT_assume \<open>\<exists>u [F]u\<close>
      AOT_hence \<open>\<not>(F \<approx>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x])\<close>
        by (rule empty_approx_2[unvarify H, OF 0, THEN "\<rightarrow>E", OF "&I"])
           (rule unotEu'')
      AOT_thus \<open>F \<approx>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x] & \<not>(F \<approx>\<^sub>E [\<lambda>x [O!]x & \<^bold>\<A>x \<noteq>\<^sub>E x])\<close> 
        using 1 "&I" by blast
    qed
  qed
qed
lemmas "0F" = zeroF

AOT_act_theorem zero_eq_1: \<open>NaturalCardinal(x) \<rightarrow> \<forall>F (x[F] \<equiv> Numbers(x, F))\<close>
proof(safe intro!: "\<rightarrow>I" GEN)
  fix F
  AOT_assume \<open>NaturalCardinal(x)\<close>
  AOT_hence \<open>\<forall>F (x[F] \<equiv> x = #F)\<close> by (metis card_en vdash_properties_10)
  AOT_hence 1: \<open>x[F] \<equiv> x = #F\<close> using "\<forall>E"(2) by blast
  AOT_have 2: \<open>x[F] \<equiv> x = \<^bold>\<iota>y(Numbers(y, F))\<close>
    by (rule num[THEN "=\<^sub>d\<^sub>fE"(1)])
       (auto simp: 1 num_uniq)
  AOT_have \<open>x = \<^bold>\<iota>y(Numbers(y, F)) \<rightarrow> Numbers(x, F)\<close> (* TODO: PLM: missing closing parenthesis *)
    using y_in_1 by blast
  moreover AOT_have \<open>Numbers(x, F) \<rightarrow> x = \<^bold>\<iota>y(Numbers(y, F))\<close>
  proof(rule "\<rightarrow>I")
    AOT_assume 1: \<open>Numbers(x, F)\<close>
    moreover AOT_obtain z where z_prop: \<open>\<forall>y (Numbers(y, F) \<rightarrow> y = z)\<close>
      using num_2[THEN uniqueness_1[THEN "\<equiv>\<^sub>d\<^sub>fE"]] "\<exists>E"[rotated] "&E" by blast
    ultimately AOT_have \<open>x = z\<close> using "\<forall>E"(2) "\<rightarrow>E" by blast
    AOT_hence \<open>\<forall>y (Numbers(y, F) \<rightarrow> y = x)\<close> using z_prop "rule=E" id_sym by fast
    AOT_thus \<open>x = \<^bold>\<iota>y(Numbers(y,F))\<close>
      by (rule hintikka[THEN "\<equiv>E"(2), OF "&I", rotated])
         (fact 1)
  qed
  ultimately AOT_have \<open>x = \<^bold>\<iota>y(Numbers(y, F)) \<equiv> Numbers(x, F)\<close>
    by (metis intro_elim_2)
  AOT_thus \<open>x[F] \<equiv> Numbers(x, F)\<close> using 2 by (metis intro_elim_3_e)
qed

AOT_act_theorem zero_eq_2: \<open>0[F] \<equiv> \<not>\<exists>u[F]u\<close>
proof -
  AOT_have \<open>0[F] \<equiv> Numbers(0, F)\<close>
    using zero_eq_1[unvarify x, OF zero_den, THEN "\<rightarrow>E", OF zero_card, THEN "\<forall>E"(2)].
  also AOT_have \<open>\<dots> \<equiv> \<not>\<exists>u[F]u\<close> using "0F"[symmetric].
  finally show ?thesis.
qed

AOT_act_theorem zero_eq_3: \<open>\<not>\<exists>u[F]u \<equiv> #F = 0\<close>
proof -
  AOT_have \<open>\<not>\<exists>u[F]u \<equiv> 0[F]\<close> using zero_eq_2[symmetric].
  also AOT_have \<open>\<dots> \<equiv> 0 = #F\<close>
    using card_en[unvarify x, OF zero_den, THEN "\<rightarrow>E", OF zero_card, THEN "\<forall>E"(2)].
  also AOT_have \<open>\<dots> \<equiv> #F = 0\<close>
    by (simp add: deduction_theorem id_sym intro_elim_2)
  finally show ?thesis.
qed

AOT_define Hereditary :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>Hereditary'(_,_')\<close>)
  hered_1: \<open>Hereditary(F, R) \<equiv>\<^sub>d\<^sub>f R\<down> & F\<down> & \<forall>x\<forall>y([R]xy \<rightarrow> ([F]x \<rightarrow> [F]y))\<close>

AOT_theorem hered_2: \<open>[\<lambda>xy \<forall>F((\<forall>z([R]xz \<rightarrow> [F]z) & Hereditary(F,R)) \<rightarrow> [F]y)]\<down>\<close>
  by cqt_2_lambda

AOT_define StrongAncestral :: \<open>\<tau> \<Rightarrow> \<Pi>\<close> (\<open>_\<^sup>*\<close>)
  ances_df: \<open>R\<^sup>* =\<^sub>d\<^sub>f [\<lambda>xy \<forall>F((\<forall>z([R]xz \<rightarrow> [F]z) & Hereditary(F,R)) \<rightarrow> [F]y)]\<close>

AOT_theorem ances: \<open>[R\<^sup>*]xy \<equiv> \<forall>F((\<forall>z([R]xz \<rightarrow> [F]z) & Hereditary(F,R)) \<rightarrow> [F]y)\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF ances_df])
   apply cqt_2_lambda
  apply (rule beta_C_meta[THEN "\<rightarrow>E", OF hered_2, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified])
  by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)

AOT_theorem anc_her_1: \<open>[R]xy \<rightarrow> [R\<^sup>*]xy\<close>
proof (safe intro!: "\<rightarrow>I" ances[THEN "\<equiv>E"(2)] GEN)
  fix F
  AOT_assume \<open>\<forall>z ([R]xz \<rightarrow> [F]z) & Hereditary(F, R)\<close>
  AOT_hence \<open>[R]xy \<rightarrow> [F]y\<close> using "\<forall>E"(2) "&E" by blast
  moreover AOT_assume \<open>[R]xy\<close>
  ultimately AOT_show \<open>[F]y\<close> using "\<rightarrow>E" by blast
qed

AOT_theorem anc_her_2: \<open>([R\<^sup>*]xy & \<forall>z([R]xz \<rightarrow> [F]z) & Hereditary(F,R)) \<rightarrow> [F]y\<close>
proof(rule "\<rightarrow>I"; (frule "&E"(1); drule "&E"(2))+)
  AOT_assume \<open>[R\<^sup>*]xy\<close>
  AOT_hence \<open>(\<forall>z([R]xz \<rightarrow> [F]z) & Hereditary(F,R)) \<rightarrow> [F]y\<close>
    using ances[THEN "\<equiv>E"(1)] "\<forall>E"(2) by blast
  moreover AOT_assume \<open>\<forall>z([R]xz \<rightarrow> [F]z)\<close>
  moreover AOT_assume \<open>Hereditary(F,R)\<close>
  ultimately AOT_show \<open>[F]y\<close> using "\<rightarrow>E" "&I" by blast
qed

AOT_theorem anc_her_3: \<open>([F]x & [R\<^sup>*]xy & Hereditary(F, R)) \<rightarrow> [F]y\<close>
proof(rule "\<rightarrow>I"; (frule "&E"(1); drule "&E"(2))+)
  AOT_assume 1: \<open>[F]x\<close>
  AOT_assume 2: \<open>Hereditary(F, R)\<close>
  AOT_hence 3: \<open>\<forall>x \<forall>y ([R]xy \<rightarrow> ([F]x \<rightarrow> [F]y))\<close> using hered_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
  AOT_have \<open>\<forall>z ([R]xz \<rightarrow> [F]z)\<close>
  proof (rule GEN; rule "\<rightarrow>I")
    fix z
    AOT_assume \<open>[R]xz\<close>
    moreover AOT_have \<open>[R]xz \<rightarrow> ([F]x \<rightarrow> [F]z)\<close> using 3 "\<forall>E"(2) by blast
    ultimately AOT_show \<open>[F]z\<close> using 1 "\<rightarrow>E" by blast
  qed
  moreover AOT_assume \<open>[R\<^sup>*]xy\<close>
  ultimately AOT_show \<open>[F]y\<close>
    by (auto intro!: 2 anc_her_2[THEN "\<rightarrow>E"] "&I")
qed

AOT_theorem anc_her_4: \<open>([R]xy & [R\<^sup>*]yz) \<rightarrow> [R\<^sup>*]xz\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume 0: \<open>[R\<^sup>*]yz\<close> and 1: \<open>[R]xy\<close>
  AOT_show \<open>[R\<^sup>*]xz\<close>
  proof(safe intro!: ances[THEN "\<equiv>E"(2)] GEN "&I" "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
    fix F
    AOT_assume \<open>\<forall>z ([R]xz \<rightarrow> [F]z)\<close>
    AOT_hence 1: \<open>[F]y\<close> using 1 "\<forall>E"(2) "\<rightarrow>E" by blast
    AOT_assume 2: \<open>Hereditary(F,R)\<close>
    AOT_show \<open>[F]z\<close>
      by (rule anc_her_3[THEN "\<rightarrow>E"]; auto intro!: "&I" 1 2 0)
  qed
qed

AOT_theorem anc_her_5: \<open>[R\<^sup>*]xy \<rightarrow> \<exists>z [R]zy\<close>
proof (rule "\<rightarrow>I")
  AOT_have 0: \<open>[\<lambda>y \<exists>x [R]xy]\<down>\<close> by cqt_2_lambda
  AOT_assume 1: \<open>[R\<^sup>*]xy\<close>
  AOT_have \<open>[\<lambda>y\<exists>x [R]xy]y\<close>
  proof(rule anc_her_2[unvarify F, OF 0, THEN "\<rightarrow>E"];
        safe intro!: "&I" GEN "\<rightarrow>I" hered_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] cqt_2_const_var[axiom_inst] 0)
    AOT_show \<open>[R\<^sup>*]xy\<close> using 1.
  next
    fix z
    AOT_assume \<open>[R]xz\<close>
    AOT_hence 1: \<open>\<exists>x [R]xz\<close> by (rule "\<exists>I")
    AOT_show \<open>[\<lambda>y\<exists>x [R]xy]z\<close>
      by (rule betaC_2_a; cqt_2_lambda; auto simp: cqt_2_const_var[axiom_inst] 1)
  next
    fix x y
    AOT_assume \<open>[R]xy\<close>
    AOT_hence 1: \<open>\<exists>x [R]xy\<close> by (rule "\<exists>I")
    AOT_show \<open>[\<lambda>y \<exists>x [R]xy]y\<close>
      by (rule betaC_2_a; auto simp: 0 1 cqt_2_const_var[axiom_inst])
  qed
  AOT_thus \<open>\<exists>z [R]zy\<close>
    by (rule betaC_1_a)
qed

AOT_theorem anc_her_6: \<open>([R\<^sup>*]xy & [R\<^sup>*]yz) \<rightarrow> [R\<^sup>*]xz\<close>
proof (rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>[R\<^sup>*]xy\<close>
  AOT_hence \<theta>: \<open>\<forall>z ([R]xz \<rightarrow> [F]z) & Hereditary(F,R) \<rightarrow> [F]y\<close> for F
    using "\<forall>E"(2)  ances[THEN "\<equiv>E"(1)] by blast
  AOT_assume \<open>[R\<^sup>*]yz\<close>
  AOT_hence \<xi>: \<open>\<forall>z ([R]yz \<rightarrow> [F]z) & Hereditary(F,R) \<rightarrow> [F]z\<close> for F
    using "\<forall>E"(2) ances[THEN "\<equiv>E"(1)] by blast
  AOT_show \<open>[R\<^sup>*]xz\<close>
  proof (rule ances[THEN "\<equiv>E"(2)]; safe intro!: GEN "\<rightarrow>I")
    fix F
    AOT_assume \<zeta>: \<open>\<forall>z ([R]xz \<rightarrow> [F]z) & Hereditary(F,R)\<close>
    AOT_show \<open>[F]z\<close>
    proof (rule \<xi>[THEN "\<rightarrow>E", OF "&I"])
      AOT_show \<open>Hereditary(F,R)\<close> using \<zeta>[THEN "&E"(2)].
    next
      AOT_show \<open>\<forall>z ([R]yz \<rightarrow> [F]z)\<close>
      proof(rule GEN; rule "\<rightarrow>I")
        fix z
        AOT_assume \<open>[R]yz\<close>
        moreover AOT_have \<open>[F]y\<close> using \<theta>[THEN "\<rightarrow>E", OF \<zeta>].
        ultimately AOT_show \<open>[F]z\<close>
          using \<zeta>[THEN "&E"(2), THEN hered_1[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2), THEN "\<forall>E"(2),
                  THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E"]
          by blast
      qed
    qed
  qed
qed

AOT_define df_1_1_1 :: \<open>\<tau> \<Rightarrow> \<phi>\<close> (\<open>1-1'(_')\<close>)
  \<open>1-1(R) \<equiv>\<^sub>d\<^sub>f R\<down> & \<forall>x\<forall>y\<forall>z([R]xz & [R]yz \<rightarrow> x = y)\<close>

AOT_define df_1_1_2 :: \<open>\<tau> \<Rightarrow> \<phi>\<close> (\<open>Rigid\<^sub>1\<^sub>-\<^sub>1'(_')\<close>)
  \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(R) \<equiv>\<^sub>d\<^sub>f 1-1(R) & Rigid(R)\<close>

AOT_theorem df_1_1_3: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(R) \<rightarrow> \<box>\<forall>x\<forall>y\<forall>z([R]xz & [R]yz \<rightarrow> x = y)\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(R)\<close>
  AOT_hence \<open>1-1(R)\<close> and RigidR: \<open>Rigid(R)\<close> using df_1_1_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast+
  AOT_hence 1: \<open>[R]xz & [R]yz \<rightarrow> x = y\<close> for x y z using df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E"(2) "\<forall>E"(2) by blast
  AOT_have 1: \<open>[R]xz & [R]yz \<rightarrow> \<box>x = y\<close> for x y z
    by (AOT_subst_rev \<open>\<guillemotleft>x = y\<guillemotright>\<close> \<open>\<guillemotleft>\<box>x = y\<guillemotright>\<close>)
       (auto simp: 1 id_nec_2 intro_elim_2 qml_2 vdash_properties_1_b)
  AOT_have \<open>\<box>\<forall>x\<^sub>1...\<forall>x\<^sub>n ([R]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[R]x\<^sub>1...x\<^sub>n)\<close> using df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fE", OF RigidR] "&E" by blast
  AOT_hence \<open>\<forall>x\<^sub>1...\<forall>x\<^sub>n \<box>([R]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[R]x\<^sub>1...x\<^sub>n)\<close> using BFs_2[THEN "\<rightarrow>E"] by fast
  AOT_hence \<open>\<forall>x\<^sub>1\<forall>x\<^sub>2 \<box>([R]x\<^sub>1x\<^sub>2 \<rightarrow> \<box>[R]x\<^sub>1x\<^sub>2)\<close> using tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fE"] by blast
  AOT_hence \<open>\<box>([R]xy \<rightarrow> \<box>[R]xy)\<close> for x y using "\<forall>E"(2) by blast
  AOT_hence \<open>\<box>(([R]xz \<rightarrow> \<box>[R]xz) & ([R]yz \<rightarrow> \<box>[R]yz))\<close> for x y z by (metis KBasic_3 con_dis_i_e_1 intro_elim_3_c raa_cor_3)
  moreover AOT_have \<open>\<box>(([R]xz \<rightarrow> \<box>[R]xz) & ([R]yz \<rightarrow> \<box>[R]yz)) \<rightarrow> \<box>(([R]xz & [R]yz) \<rightarrow> \<box>([R]xz & [R]yz))\<close> for x y z
    by (rule RM) (metis "\<rightarrow>I" KBasic_3 con_dis_i_e_1 con_dis_i_e_2_a con_dis_i_e_2_b intro_elim_3_b vdash_properties_10)
  ultimately AOT_have 2: \<open>\<box>(([R]xz & [R]yz) \<rightarrow> \<box>([R]xz & [R]yz))\<close> for x y z using "\<rightarrow>E" by blast
  AOT_hence 3: \<open>\<box>([R]xz & [R]yz \<rightarrow> x = y)\<close> for x y z using kir_ext_2[THEN "\<rightarrow>E", THEN "\<rightarrow>E", OF 2, OF 1] by blast
  AOT_show \<open>\<box>\<forall>x\<forall>y\<forall>z([R]xz & [R]yz \<rightarrow> x = y)\<close>
    by (safe intro!: GEN BF[THEN "\<rightarrow>E"] 3)
qed

AOT_register_restricted_type
  RigidOneToOneRelation: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>)\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<exists>\<alpha> Rigid\<^sub>1\<^sub>-\<^sub>1(\<alpha>)\<close>
    proof (rule_tac \<tau>=\<open>\<guillemotleft>(=\<^sub>E)\<guillemotright>\<close> in "\<exists>I"(1))
      AOT_show \<open>Rigid\<^sub>1\<^sub>-\<^sub>1((=\<^sub>E))\<close>
      proof (safe intro!: df_1_1_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] GEN "\<rightarrow>I" df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] eq_E_denotes)
        fix x y z
        AOT_assume \<open>x =\<^sub>E z & y =\<^sub>E z\<close>
        AOT_thus \<open>x = y\<close>
          by (metis "rule=E" con_dis_i_e_2_a con_dis_taut_2 eq_E_simple_2 id_sym vdash_properties_10)
      next
        AOT_have \<open>\<forall>x\<forall>y \<box>(x =\<^sub>E y \<rightarrow> \<box>x =\<^sub>E y)\<close>
        proof(rule GEN; rule GEN)
          AOT_show \<open>\<box>(x =\<^sub>E y \<rightarrow> \<box>x =\<^sub>E y)\<close> for x y
            by (meson RN deduction_theorem id_nec3_1 intro_elim_3_a)
        qed
        AOT_hence \<open>\<forall>x\<^sub>1...\<forall>x\<^sub>n \<box>([(=\<^sub>E)]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[(=\<^sub>E)]x\<^sub>1...x\<^sub>n)\<close>
          by (rule tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fI"])
        AOT_thus \<open>\<box>\<forall>x\<^sub>1...\<forall>x\<^sub>n ([(=\<^sub>E)]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[(=\<^sub>E)]x\<^sub>1...x\<^sub>n)\<close>
          using BF[THEN "\<rightarrow>E"] by fast
      qed
    qed(fact eq_E_denotes)
  }
next
  AOT_modally_strict {
    AOT_show \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>) \<rightarrow> \<Pi>\<down>\<close> for \<Pi>
    proof(rule "\<rightarrow>I")
      AOT_assume \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>)\<close>
      AOT_hence \<open>1-1(\<Pi>)\<close> using df_1_1_2[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
      AOT_thus \<open>\<Pi>\<down>\<close> using df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
    qed
  }
qed
AOT_register_variable_names
  RigidOneToOneRelation: \<R> \<S>

interpretation RigidOneToOne: AOT_rigid_restriction_condition \<open>\<lambda> \<Pi>. \<guillemotleft>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>)\<guillemotright>\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<box>(Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>) \<rightarrow> \<box>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>))\<close> for \<Pi>
    proof(rule RN; rule "\<rightarrow>I")
      AOT_modally_strict {
        AOT_assume 0: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>)\<close>
        AOT_hence 1: \<open>\<Pi>\<down>\<close> by (metis RigidOneToOneRelation.strict_existential_import[THEN "\<rightarrow>E"])
        AOT_hence 2: \<open>\<box>\<Pi>\<down>\<close> using exist_nec vdash_properties_10 by blast
        AOT_have 3: \<open>\<box>\<forall>x\<forall>y\<forall>z([\<Pi>]xz & [\<Pi>]yz \<rightarrow> x = y)\<close> using df_1_1_3[unvarify R, OF 1, THEN "\<rightarrow>E", OF 0].
        AOT_have 4: \<open>\<box>1-1(\<Pi>)\<close>
          apply (AOT_subst_using subst: df_1_1_1[THEN "\<equiv>Df"])
          using "2" "3" KBasic_3 df_simplify_2 intro_elim_3_b by blast
        AOT_have \<open>Rigid(\<Pi>)\<close> using 0 "\<equiv>\<^sub>d\<^sub>fE"[OF df_1_1_2] "&E" by blast
        AOT_hence \<open>\<box>\<forall>x\<^sub>1...\<forall>x\<^sub>n ([\<Pi>]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[\<Pi>]x\<^sub>1...x\<^sub>n)\<close> using  df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fE"] "&E" by blast
        AOT_hence 5: \<open>\<box>\<box>\<forall>x\<^sub>1...\<forall>x\<^sub>n ([\<Pi>]x\<^sub>1...x\<^sub>n \<rightarrow> \<box>[\<Pi>]x\<^sub>1...x\<^sub>n)\<close> by (metis S5Basic_6 intro_elim_3_a)
        AOT_have 6: \<open>\<box>Rigid(\<Pi>)\<close>
          apply (AOT_subst_using subst: df_rigid_rel_1[THEN "\<equiv>Df"])
          using 2 5 KBasic_3 df_simplify_2 intro_elim_3_b by blast
        AOT_show \<open>\<box>Rigid\<^sub>1\<^sub>-\<^sub>1(\<Pi>)\<close>
          apply (AOT_subst_using subst: df_1_1_2[THEN "\<equiv>Df"])
          using 4 6 KBasic_3 df_simplify_2 intro_elim_3_b by blast
      }
    qed
  }
qed

AOT_define df_1_1_4 :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> (\<open>InDomainOf'(_,_')\<close>)
  \<open>InDomainOf(x, R) \<equiv>\<^sub>d\<^sub>f \<exists>y [R]xy\<close>

AOT_define id_d_R :: \<open>\<tau> \<Rightarrow> \<Pi>\<close> (\<open>'(=\<^sub>_')\<close>)
  \<open>(=\<^sub>\<R>) =\<^sub>d\<^sub>f [\<lambda>xy \<exists>z ([\<R>]xz & [\<R>]yz)]\<close>

syntax "_AOT_id_d_R_infix" :: \<open>\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau> \<Rightarrow> \<phi>\<close> ("(_ =\<^sub>_/ _)" [50, 51, 51] 50)
translations
  "_AOT_id_d_R_infix \<kappa> \<Pi> \<kappa>'" == "CONST AOT_exe (CONST id_d_R \<Pi>) (\<kappa>,\<kappa>')"

AOT_theorem id_R_thm_1: \<open>x =\<^sub>\<R> y \<equiv> \<exists>z ([\<R>]xz & [\<R>]yz)\<close>
proof -
  AOT_have 0: \<open>[\<lambda>xy \<exists>z ([\<R>]xz & [\<R>]yz)]\<down>\<close> by cqt_2_lambda
  show ?thesis
    apply (rule "=\<^sub>d\<^sub>fI"(1)[OF id_d_R])
    apply (fact 0)
    apply (rule beta_C_meta[THEN "\<rightarrow>E", OF 0, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified])
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)

qed

AOT_theorem id_R_thm_2: \<open>x =\<^sub>\<R> y \<rightarrow> (InDomainOf(x, \<R>) & InDomainOf(y, \<R>))\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>x =\<^sub>\<R> y\<close>
  AOT_hence \<open>\<exists>z ([\<R>]xz & [\<R>]yz)\<close> using id_R_thm_1[THEN "\<equiv>E"(1)] by simp
  then AOT_obtain z where z_prop: \<open>[\<R>]xz & [\<R>]yz\<close> using "\<exists>E"[rotated] by blast
  AOT_show \<open>InDomainOf(x, \<R>) & InDomainOf(y, \<R>)\<close>
  proof (safe intro!: "&I" df_1_1_4[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    AOT_show \<open>\<exists>y [\<R>]xy\<close> using z_prop[THEN "&E"(1)] "\<exists>I" by fast
  next
    AOT_show \<open>\<exists>z [\<R>]yz\<close> using z_prop[THEN "&E"(2)] "\<exists>I" by fast
  qed
qed

AOT_theorem id_R_thm_3:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>x =\<^sub>\<R> y \<rightarrow> x = y\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>x =\<^sub>\<R> y\<close>
  AOT_hence \<open>\<exists>z ([\<R>]xz & [\<R>]yz)\<close> using id_R_thm_1[THEN "\<equiv>E"(1)] by simp
  then AOT_obtain z where z_prop: \<open>[\<R>]xz & [\<R>]yz\<close> using "\<exists>E"[rotated] by blast
  AOT_thus \<open>x = y\<close>
    using df_1_1_3[THEN "\<rightarrow>E", OF assms, THEN qml_2[axiom_inst, THEN "\<rightarrow>E"],
                   THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
qed

AOT_theorem id_R_thm_4:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>(InDomainOf(x, \<R>) \<or> InDomainOf(y, \<R>)) \<rightarrow> (x =\<^sub>\<R> y \<equiv> x = y)\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>InDomainOf(x, \<R>) \<or> InDomainOf(y, \<R>)\<close>
  moreover {
    AOT_assume \<open>InDomainOf(x, \<R>)\<close>
    AOT_hence \<open>\<exists>z [\<R>]xz\<close> by (metis "\<equiv>\<^sub>d\<^sub>fE" df_1_1_4)
    then AOT_obtain z where z_prop: \<open>[\<R>]xz\<close> using "\<exists>E"[rotated] by blast
    AOT_have \<open>x =\<^sub>\<R> y \<equiv> x = y\<close>
    proof(safe intro!: "\<equiv>I" "\<rightarrow>I" id_R_thm_3[OF assms, THEN "\<rightarrow>E"])
      AOT_assume \<open>x = y\<close>
      AOT_hence \<open>[\<R>]yz\<close> using z_prop "=E" by fast
      AOT_hence \<open>[\<R>]xz & [\<R>]yz\<close> using z_prop "&I" by blast
      AOT_hence \<open>\<exists>z ([\<R>]xz & [\<R>]yz)\<close> by (rule "\<exists>I")
      AOT_thus \<open>x =\<^sub>\<R> y\<close>
        using id_R_thm_1 intro_elim_3_b by blast
    qed
  }
  moreover {
    AOT_assume \<open>InDomainOf(y, \<R>)\<close>
    AOT_hence \<open>\<exists>z [\<R>]yz\<close> by (metis "\<equiv>\<^sub>d\<^sub>fE" df_1_1_4)
    then AOT_obtain z where z_prop: \<open>[\<R>]yz\<close> using "\<exists>E"[rotated] by blast
    AOT_have \<open>x =\<^sub>\<R> y \<equiv> x = y\<close>
    proof(safe intro!: "\<equiv>I" "\<rightarrow>I" id_R_thm_3[OF assms, THEN "\<rightarrow>E"])
      AOT_assume \<open>x = y\<close>
      AOT_hence \<open>[\<R>]xz\<close> using z_prop "=E" id_sym by fast
      AOT_hence \<open>[\<R>]xz & [\<R>]yz\<close> using z_prop "&I" by blast
      AOT_hence \<open>\<exists>z ([\<R>]xz & [\<R>]yz)\<close> by (rule "\<exists>I")
      AOT_thus \<open>x =\<^sub>\<R> y\<close>
        using id_R_thm_1 intro_elim_3_b by blast
    qed
  }
  ultimately AOT_show \<open>x =\<^sub>\<R> y \<equiv> x = y\<close>
    by (metis con_dis_i_e_4_b raa_cor_1)
qed

AOT_theorem id_R_thm_5: \<open>InDomainOf(x, \<R>) \<rightarrow> x =\<^sub>\<R> x\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>InDomainOf(x, \<R>)\<close>
  AOT_hence \<open>\<exists>z [\<R>]xz\<close> by (metis "\<equiv>\<^sub>d\<^sub>fE" df_1_1_4)
  then AOT_obtain z where z_prop: \<open>[\<R>]xz\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>[\<R>]xz & [\<R>]xz\<close> using "&I" by blast
  AOT_hence \<open>\<exists>z ([\<R>]xz & [\<R>]xz)\<close> using "\<exists>I" by fast
  AOT_thus \<open>x =\<^sub>\<R> x\<close>
    using id_R_thm_1 intro_elim_3_b by blast
qed

AOT_theorem id_R_thm_6:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>x =\<^sub>\<R> y \<rightarrow> y =\<^sub>\<R> x\<close>
proof(rule "\<rightarrow>I")
  AOT_assume 0: \<open>x =\<^sub>\<R> y\<close>
  AOT_hence 1: \<open>InDomainOf(x,\<R>) & InDomainOf(y,\<R>)\<close> using id_R_thm_2[THEN "\<rightarrow>E"] by blast
  AOT_hence \<open>x =\<^sub>\<R> y \<equiv> x = y\<close>
    using id_R_thm_4[THEN "\<rightarrow>E", OF assms, OF "\<or>I"(1)] "&E" by blast
  AOT_hence \<open>x = y\<close> using 0 by (metis intro_elim_3_a)
  AOT_hence \<open>y = x\<close> using id_sym by blast
  moreover AOT_have \<open>y =\<^sub>\<R> x \<equiv> y = x\<close>
    using id_R_thm_4[THEN "\<rightarrow>E", OF assms, OF "\<or>I"(2)] 1 "&E" by blast
  ultimately AOT_show \<open>y =\<^sub>\<R> x\<close>
    by (metis intro_elim_3_b)
qed

AOT_theorem id_R_thm_7:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>x =\<^sub>\<R> y & y =\<^sub>\<R> z \<rightarrow> x =\<^sub>\<R> z\<close>
proof (rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume 0: \<open>x =\<^sub>\<R> y\<close>
  AOT_hence 1: \<open>InDomainOf(x,\<R>) & InDomainOf(y,\<R>)\<close> using id_R_thm_2[THEN "\<rightarrow>E"] by blast
  AOT_hence \<open>x =\<^sub>\<R> y \<equiv> x = y\<close>
    using id_R_thm_4[THEN "\<rightarrow>E", OF assms, OF "\<or>I"(1)] "&E" by blast
  AOT_hence x_eq_y: \<open>x = y\<close> using 0 by (metis intro_elim_3_a)
  AOT_assume 2: \<open>y =\<^sub>\<R> z\<close>
  AOT_hence 3: \<open>InDomainOf(y,\<R>) & InDomainOf(z,\<R>)\<close> using id_R_thm_2[THEN "\<rightarrow>E"] by blast
  AOT_hence \<open>y =\<^sub>\<R> z \<equiv> y = z\<close>
    using id_R_thm_4[THEN "\<rightarrow>E", OF assms, OF "\<or>I"(1)] "&E" by blast
  AOT_hence \<open>y = z\<close> using 2 by (metis intro_elim_3_a)
  AOT_hence x_eq_z: \<open>x = z\<close> using x_eq_y id_trans by blast
  AOT_have \<open>InDomainOf(x,\<R>) & InDomainOf(z,\<R>)\<close> using 1 3 "&I" "&E" by meson
  AOT_hence \<open>x =\<^sub>\<R> z \<equiv> x = z\<close>
    using id_R_thm_4[THEN "\<rightarrow>E", OF assms, OF "\<or>I"(1)] "&E" by blast
  AOT_thus \<open>x =\<^sub>\<R> z\<close> using x_eq_z "\<equiv>E"(2) by blast
qed

AOT_define w_ances_df :: \<open>\<Pi> \<Rightarrow> \<Pi>\<close> (\<open>_\<^sup>+\<close>)
  \<open>[\<R>]\<^sup>+ =\<^sub>d\<^sub>f [\<lambda>xy [\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y]\<close>

AOT_theorem w_ances_df_den_1: \<open>[\<lambda>xy [\<Pi>]\<^sup>*xy \<or> x =\<^sub>\<Pi> y]\<down>\<close> by cqt_2_lambda
AOT_theorem w_ances_df_den_2: \<open>[\<Pi>]\<^sup>+\<down>\<close> using w_ances_df_den_1 "=\<^sub>d\<^sub>fI"(1)[OF w_ances_df] by blast

AOT_theorem w_ances: \<open>[\<R>]\<^sup>+xy \<equiv> ([\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y)\<close>
proof -
  AOT_have 0: \<open>[\<lambda>xy [\<R>\<^sup>*]xy \<or> x =\<^sub>\<R> y]\<down>\<close> by cqt_2_lambda
  (* TODO: try to prevent 1 and 2 from being needed *)
  AOT_have 1: \<open>\<guillemotleft>(AOT_term_of_var x,AOT_term_of_var y)\<guillemotright>\<down>\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  have 2: \<open>\<guillemotleft>[\<lambda>\<mu>\<^sub>1...\<mu>\<^sub>n [\<R>\<^sup>*]\<mu>\<^sub>1...\<mu>\<^sub>n \<or> [(=\<^sub>\<R>)]\<mu>\<^sub>1...\<mu>\<^sub>n]xy\<guillemotright> = \<guillemotleft>[\<lambda>xy [\<R>\<^sup>*]xy \<or> [(=\<^sub>\<R>)]xy]xy\<guillemotright>\<close>
    by (simp add: cond_case_prod_eta)
  show ?thesis
    apply (rule "=\<^sub>d\<^sub>fI"(1)[OF w_ances_df])
     apply (fact w_ances_df_den_1)
    using beta_C_meta[THEN "\<rightarrow>E", OF 0, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified, OF 1] 2 by simp
qed

AOT_theorem wances_her_1: \<open>[\<R>]xy \<rightarrow> [\<R>]\<^sup>+xy\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>[\<R>]xy\<close>
  AOT_hence \<open>[\<R>]\<^sup>*xy\<close>
    using anc_her_1[THEN "\<rightarrow>E"] by blast
  AOT_thus \<open>[\<R>]\<^sup>+xy\<close> using w_ances[THEN "\<equiv>E"(2)] "\<or>I" by blast
qed

AOT_theorem wances_her_2:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([F]x & [\<R>]\<^sup>+xy & Hereditary(F, \<R>)) \<rightarrow> [F]y\<close>
proof(rule "\<rightarrow>I"; (frule "&E"(1); drule "&E"(2))+)
  AOT_assume 0: \<open>[F]x\<close>
  AOT_assume 1: \<open>Hereditary(F, \<R>)\<close>
  AOT_assume \<open>[\<R>]\<^sup>+xy\<close>
  AOT_hence \<open>[\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y\<close> using w_ances[THEN "\<equiv>E"(1)] by simp
  moreover {
    AOT_assume \<open>[\<R>]\<^sup>*xy\<close>
    AOT_hence \<open>[F]y\<close>  using anc_her_3[THEN "\<rightarrow>E", OF "&I", OF "&I"] 0 1 by blast
  }
  moreover {
    AOT_assume \<open>x =\<^sub>\<R> y\<close>
    AOT_hence \<open>x = y\<close> using id_R_thm_3[OF assms, THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>[F]y\<close> using 0 "=E" by blast
  }
  ultimately AOT_show \<open>[F]y\<close>
    by (metis con_dis_i_e_4_c raa_cor_1)
qed

AOT_theorem wances_her_3:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([\<R>]\<^sup>+xy & [\<R>]yz) \<rightarrow> [\<R>]\<^sup>*xz\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>[\<R>]\<^sup>+xy\<close>
  moreover AOT_assume Ryz: \<open>[\<R>]yz\<close>
  ultimately AOT_have \<open>[\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y\<close> using w_ances[THEN "\<equiv>E"(1)] by metis
  moreover {
    AOT_assume R_star_xy: \<open>[\<R>]\<^sup>*xy\<close>
    AOT_have \<open>[\<R>]\<^sup>*xz\<close>
    proof (safe intro!: ances[THEN "\<equiv>E"(2)] "\<rightarrow>I" GEN)
      fix F
      AOT_assume 0: \<open>\<forall>z ([\<R>]xz \<rightarrow> [F]z) & Hereditary(F,\<R>)\<close>
      AOT_hence \<open>[F]y\<close>
        using R_star_xy ances[THEN "\<equiv>E"(1), OF R_star_xy, THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
      AOT_thus \<open>[F]z\<close>
        using hered_1[THEN "\<equiv>\<^sub>d\<^sub>fE", OF 0[THEN "&E"(2)], THEN "&E"(2)]
              "\<forall>E"(2) "\<rightarrow>E" Ryz by blast
    qed
  }
  moreover {
    AOT_assume \<open>x =\<^sub>\<R> y\<close>
    AOT_hence \<open>x = y\<close> using id_R_thm_3[OF assms, THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>[\<R>]xz\<close> using Ryz "=E" id_sym by fast
    AOT_hence \<open>[\<R>]\<^sup>*xz\<close> by (metis anc_her_1[THEN "\<rightarrow>E"])
  }
  ultimately AOT_show \<open>[\<R>]\<^sup>*xz\<close>
    by (metis con_dis_i_e_4_c raa_cor_1)
qed

AOT_theorem wances_her_4:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([\<R>]\<^sup>*xy & [\<R>]yz) \<rightarrow> [\<R>]\<^sup>+xz\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>[\<R>]\<^sup>*xy\<close>
  AOT_hence \<open>[\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y\<close> using "\<or>I" by blast
  AOT_hence \<open>[\<R>]\<^sup>+xy\<close> using w_ances[THEN "\<equiv>E"(2)] by blast
  moreover AOT_assume \<open>[\<R>]yz\<close>
  ultimately AOT_have \<open>[\<R>]\<^sup>*xz\<close> using wances_her_3[OF assms, THEN "\<rightarrow>E", OF "&I"] by simp
  AOT_hence \<open>[\<R>]\<^sup>*xz \<or> x =\<^sub>\<R> z\<close> using "\<or>I" by blast
  AOT_thus \<open>[\<R>]\<^sup>+xz\<close> using w_ances[THEN "\<equiv>E"(2)] by blast
qed

AOT_theorem wances_her_5:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([\<R>]xy & [\<R>]\<^sup>+yz) \<rightarrow> [\<R>]\<^sup>*xz\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume 0: \<open>[\<R>]xy\<close>
  AOT_assume \<open>[\<R>]\<^sup>+yz\<close>
  AOT_hence \<open>[\<R>]\<^sup>*yz \<or> y =\<^sub>\<R> z\<close> by (metis intro_elim_3_a w_ances)
  moreover {
    AOT_assume \<open>[\<R>]\<^sup>*yz\<close>
    AOT_hence \<open>[\<R>]\<^sup>*xz\<close> using 0 by (metis anc_her_4 con_dis_taut_5 vdash_properties_10)
  }
  moreover {
    AOT_assume \<open>y =\<^sub>\<R> z\<close>
    AOT_hence \<open>y = z\<close> by (metis assms id_R_thm_3 vdash_properties_10)
    AOT_hence \<open>[\<R>]xz\<close> using 0 "=E" by fast
    AOT_hence \<open>[\<R>]\<^sup>*xz\<close> by (metis anc_her_1 vdash_properties_10)
  }
  ultimately AOT_show \<open>[\<R>]\<^sup>*xz\<close> by (metis con_dis_i_e_4_b reductio_aa_1)
qed

AOT_theorem wances_her_6:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([\<R>]\<^sup>+xy & [\<R>]\<^sup>+yz) \<rightarrow> [\<R>]\<^sup>+xz\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume 0: \<open>[\<R>]\<^sup>+xy\<close>
  AOT_hence 1: \<open>[\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y\<close> by (metis intro_elim_3_a w_ances)
  AOT_assume 2: \<open>[\<R>]\<^sup>+yz\<close>
  {
    AOT_assume \<open>x =\<^sub>\<R> y\<close>
    AOT_hence \<open>x = y\<close> by (metis assms id_R_thm_3 vdash_properties_10)
    AOT_hence \<open>[\<R>]\<^sup>+xz\<close> using 2 "=E" id_sym by fast
  }
  moreover {
    AOT_assume \<open>\<not>(x =\<^sub>\<R> y)\<close>
    AOT_hence 3: \<open>[\<R>]\<^sup>*xy\<close> using 1 by (metis con_dis_i_e_4_c) 
    AOT_have \<open>[\<R>]\<^sup>*yz \<or> y =\<^sub>\<R> z\<close> using 2 by (metis intro_elim_3_a w_ances)
    moreover {
      AOT_assume \<open>[\<R>]\<^sup>*yz\<close>
      AOT_hence \<open>[\<R>]\<^sup>*xz\<close> using 3 by (metis anc_her_6 con_dis_taut_5 vdash_properties_10)
      AOT_hence \<open>[\<R>]\<^sup>+xz\<close> by (metis con_dis_i_e_3_a intro_elim_3_b w_ances)
    }
    moreover {
      AOT_assume \<open>y =\<^sub>\<R> z\<close>
      AOT_hence \<open>y = z\<close> by (metis assms id_R_thm_3 vdash_properties_10)
      AOT_hence \<open>[\<R>]\<^sup>+xz\<close> using 0 "=E" id_sym by fast
    }
    ultimately AOT_have \<open>[\<R>]\<^sup>+xz\<close> by (metis con_dis_i_e_4_c reductio_aa_1)
  }
  ultimately AOT_show \<open>[\<R>]\<^sup>+xz\<close> by (metis reductio_aa_1)
qed

AOT_theorem wances_her_7:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>[\<R>]\<^sup>*xy \<rightarrow> \<exists>z([\<R>]\<^sup>+xz & [\<R>]zy)\<close>
proof(rule "\<rightarrow>I")
  AOT_assume 0: \<open>[\<R>]\<^sup>*xy\<close>
  AOT_have 1: \<open>\<forall>z ([\<R>]xz \<rightarrow> [\<Pi>]z) & Hereditary(\<Pi>,\<R>) \<rightarrow> [\<Pi>]y\<close> if \<open>\<Pi>\<down>\<close> for \<Pi>
    using ances[THEN "\<equiv>E"(1), THEN "\<forall>E"(1), OF 0] that by blast
  AOT_have \<open>[\<lambda>y \<exists>z([\<R>]\<^sup>+xz & [\<R>]zy)]y\<close>
  proof (rule 1[THEN "\<rightarrow>E"]; cqt_2_lambda?; safe intro!: "&I" GEN "\<rightarrow>I" hered_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] cqt_2_const_var[axiom_inst])
    fix z
    AOT_assume 0: \<open>[\<R>]xz\<close>
    AOT_hence \<open>\<exists>z [\<R>]xz\<close> by (rule "\<exists>I")
    AOT_hence \<open>InDomainOf(x, \<R>)\<close> by (metis "\<equiv>\<^sub>d\<^sub>fI" df_1_1_4)
    AOT_hence \<open>x =\<^sub>\<R> x\<close> by (metis id_R_thm_5 "\<rightarrow>E")
    AOT_hence \<open>[\<R>]\<^sup>+xx\<close> by (metis con_dis_i_e_3_b intro_elim_3_b w_ances)
    AOT_hence \<open>[\<R>]\<^sup>+xx & [\<R>]xz\<close> using 0 "&I" by blast
    AOT_hence 1: \<open>\<exists>y ([\<R>]\<^sup>+xy & [\<R>]yz)\<close> by (rule "\<exists>I")
    AOT_show \<open>[\<lambda>y \<exists>z ([\<R>]\<^sup>+xz & [\<R>]zy)]z\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 1)
  next
    fix x' y
    AOT_assume Rx'y: \<open>[\<R>]x'y\<close>
    AOT_assume \<open>[\<lambda>y \<exists>z ([\<R>]\<^sup>+xz & [\<R>]zy)]x'\<close>
    AOT_hence \<open>\<exists>z ([\<R>]\<^sup>+xz & [\<R>]zx')\<close>
      using betaC_1_a by blast
    then AOT_obtain c where c_prop: \<open>[\<R>]\<^sup>+xc & [\<R>]cx'\<close> using "\<exists>E"[rotated] by blast
    AOT_hence \<open>[\<R>]\<^sup>*xx'\<close>
      by (meson Rx'y anc_her_1 anc_her_6 assms con_dis_taut_5 vdash_properties_10 wances_her_3)
    AOT_hence \<open>[\<R>]\<^sup>*xx' \<or> x =\<^sub>\<R> x'\<close> by (rule "\<or>I")
    AOT_hence \<open>[\<R>]\<^sup>+xx'\<close> by (metis intro_elim_3_b w_ances)
    AOT_hence \<open>[\<R>]\<^sup>+xx' & [\<R>]x'y\<close> using Rx'y by (metis con_dis_i_e_1)
    AOT_hence 1: \<open>\<exists>z ([\<R>]\<^sup>+xz & [\<R>]zy)\<close> by (rule "\<exists>I")
    AOT_show \<open>[\<lambda>y \<exists>z ([\<R>]\<^sup>+xz & [\<R>]zy)]y\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 1)
  qed(cqt_2_lambda)
  AOT_thus \<open>\<exists>z([\<R>]\<^sup>+xz & [\<R>]zy)\<close>
    using betaC_1_a by fast
qed

AOT_theorem one_to_one_R_1:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([\<R>]xy & [\<R>]\<^sup>*zy) \<rightarrow> [\<R>]\<^sup>+zx\<close>
proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>[\<R>]\<^sup>*zy\<close>
  AOT_hence \<open>\<exists>x ([\<R>]\<^sup>+zx & [\<R>]xy)\<close> using wances_her_7[OF assms, THEN "\<rightarrow>E"] by simp
  then AOT_obtain a where a_prop: \<open>[\<R>]\<^sup>+za & [\<R>]ay\<close> using "\<exists>E"[rotated] by blast
  moreover AOT_assume \<open>[\<R>]xy\<close>
  ultimately AOT_have \<open>x = a\<close>
    using df_1_1_2[THEN "\<equiv>\<^sub>d\<^sub>fE", OF assms, THEN "&E"(1), THEN "\<equiv>\<^sub>d\<^sub>fE"[OF df_1_1_1],
                   THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF "&I"]
    "&E" by blast
  AOT_thus \<open>[\<R>]\<^sup>+zx\<close> using a_prop[THEN "&E"(1)] "=E" id_sym by fast
qed

AOT_theorem one_to_one_R_2:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>[\<R>]xy \<rightarrow> (\<not>[\<R>]\<^sup>*xx \<rightarrow> \<not>[\<R>]\<^sup>*yy)\<close>
proof(rule "\<rightarrow>I"; rule useful_tautologies_5[THEN "\<rightarrow>E"]; rule "\<rightarrow>I")
  AOT_assume 0: \<open>[\<R>]xy\<close>
  moreover AOT_assume \<open>[\<R>]\<^sup>*yy\<close>
  ultimately AOT_have \<open>[\<R>]\<^sup>+yx\<close> using one_to_one_R_1[OF assms, THEN "\<rightarrow>E", OF "&I"] by blast
  AOT_thus \<open>[\<R>]\<^sup>*xx\<close> using 0 by (metis assms con_dis_i_e_1 vdash_properties_10 wances_her_5)
qed

AOT_theorem one_to_one_R_3:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>\<not>[\<R>]\<^sup>*xx \<rightarrow> ([\<R>]\<^sup>+xy \<rightarrow> \<not>[\<R>]\<^sup>*yy)\<close>
proof(safe intro!: "\<rightarrow>I")
  AOT_have 0: \<open>[\<lambda>z \<not>[\<R>]\<^sup>*zz]\<down>\<close> by cqt_2_lambda
  AOT_assume 1: \<open>\<not>[\<R>]\<^sup>*xx\<close>
  AOT_assume 2: \<open>[\<R>]\<^sup>+xy\<close>
  AOT_have \<open>[\<lambda>z \<not>[\<R>]\<^sup>*zz]y\<close>
  proof(rule wances_her_2[OF assms, unvarify F, OF 0, THEN "\<rightarrow>E"];
        safe intro!: "&I" hered_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
    AOT_show  \<open>[\<lambda>z \<not>[\<R>]\<^sup>*zz]x\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: 1 cqt_2_const_var[axiom_inst])
  next
    AOT_show \<open>[\<R>]\<^sup>+xy\<close> by (fact 2)
  next
    fix x y
    AOT_assume \<open>[\<lambda>z \<not>[\<R>\<^sup>*]zz]x\<close>
    AOT_hence \<open>\<not>[\<R>]\<^sup>*xx\<close> by (rule betaC_1_a)
    moreover AOT_assume \<open>[\<R>]xy\<close>
    ultimately AOT_have 1: \<open>\<not>[\<R>]\<^sup>*yy\<close> using one_to_one_R_2[OF assms, THEN "\<rightarrow>E", THEN "\<rightarrow>E"] by blast
    AOT_show \<open>[\<lambda>z \<not>[\<R>\<^sup>*]zz]y\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 1)
  qed(cqt_2_lambda)
  AOT_thus \<open>\<not>[\<R>]\<^sup>*yy\<close> using betaC_1_a by blast
qed

AOT_theorem one_to_one_R_4:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>[\<R>]\<^sup>*xy \<rightarrow> InDomainOf(x,\<R>)\<close>
proof(rule "\<rightarrow>I"; rule df_1_1_4[THEN "\<equiv>\<^sub>d\<^sub>fI"])
  AOT_have 0: \<open>[\<lambda>z [\<R>]\<^sup>*xz \<rightarrow> \<exists>y [\<R>]xy]\<down>\<close> by cqt_2_lambda
  AOT_assume 1: \<open>[\<R>]\<^sup>*xy\<close>
  AOT_have \<open>[\<lambda>z [\<R>\<^sup>*]xz \<rightarrow> \<exists>y [\<R>]xy]y\<close>
  proof (rule anc_her_2[unvarify F, OF 0, THEN "\<rightarrow>E"];
         safe intro!: "&I" hered_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
    AOT_show \<open>[\<R>]\<^sup>*xy\<close> by (fact 1)
  next
    fix z
    AOT_assume 0: \<open>[\<R>]xz\<close>
    AOT_show \<open>[\<lambda>z [\<R>\<^sup>*]xz \<rightarrow> \<exists>y [\<R>]xy]z\<close>
      apply (rule betaC_2_a; cqt_2_lambda)
       apply (simp add: cqt_2_const_var[axiom_inst])
      by (meson "0" deduction_theorem existential_2_a)
  next
    fix x' y
    AOT_assume Rx'y: \<open>[\<R>]x'y\<close>
    AOT_assume \<open>[\<lambda>z [\<R>\<^sup>*]xz \<rightarrow> \<exists>y [\<R>]xy]x'\<close>
    AOT_hence 0: \<open>[\<R>\<^sup>*]xx' \<rightarrow> \<exists>y [\<R>]xy\<close> by (rule betaC_1_a)
    AOT_have 1: \<open>[\<R>\<^sup>*]xy \<rightarrow> \<exists>y [\<R>]xy\<close>
    proof(rule "\<rightarrow>I")
      AOT_assume \<open>[\<R>]\<^sup>*xy\<close>
      AOT_hence \<open>[\<R>]\<^sup>+xx'\<close> by (metis Rx'y assms con_dis_i_e_1 one_to_one_R_1 vdash_properties_6)
      AOT_hence \<open>[\<R>]\<^sup>*xx' \<or> x =\<^sub>\<R> x'\<close> by (metis intro_elim_3_a w_ances)
      moreover {
        AOT_assume \<open>[\<R>]\<^sup>*xx'\<close>
        AOT_hence \<open>\<exists>y [\<R>]xy\<close> using 0 by (metis "\<rightarrow>E")
      }
      moreover {
        AOT_assume \<open>x =\<^sub>\<R> x'\<close>
        AOT_hence \<open>x = x'\<close> by (metis assms id_R_thm_3 "\<rightarrow>E")
        AOT_hence \<open>[\<R>]xy\<close> using Rx'y "=E" id_sym by fast
        AOT_hence \<open>\<exists>y [\<R>]xy\<close> by (rule "\<exists>I")
      }
      ultimately AOT_show \<open>\<exists>y [\<R>]xy\<close> by (metis con_dis_i_e_4_c reductio_aa_1)
    qed
    AOT_show \<open>[\<lambda>z [\<R>\<^sup>*]xz \<rightarrow> \<exists>y [\<R>]xy]y\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 1)
  qed(cqt_2_lambda)
  AOT_hence \<open>[\<R>\<^sup>*]xy \<rightarrow> \<exists>y [\<R>]xy\<close> by (rule betaC_1_a)
  AOT_thus \<open>\<exists>y [\<R>]xy\<close> using 1 "\<rightarrow>E" by blast
qed

AOT_theorem one_to_one_R_5:
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>[\<R>]\<^sup>+xy \<rightarrow> InDomainOf(x,\<R>)\<close>
proof (rule "\<rightarrow>I")
  AOT_assume \<open>[\<R>]\<^sup>+xy\<close>
  AOT_hence \<open>[\<R>]\<^sup>*xy \<or> x =\<^sub>\<R> y\<close> by (metis intro_elim_3_a w_ances)
  moreover {
    AOT_assume \<open>[\<R>]\<^sup>*xy\<close>
    AOT_hence \<open>InDomainOf(x,\<R>)\<close> using one_to_one_R_4[OF assms] "\<rightarrow>E" by blast
  }
  moreover {
    AOT_assume \<open>x =\<^sub>\<R> y\<close>
    AOT_hence \<open>InDomainOf(x,\<R>)\<close> by (metis con_dis_taut_1 id_R_thm_2 vdash_properties_6)
  }
  ultimately AOT_show \<open>InDomainOf(x,\<R>)\<close> by (metis con_dis_i_e_4_c reductio_aa_1)
qed

AOT_theorem pre_ind: 
  assumes \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>)\<close>
  shows \<open>([F]z & \<forall>x\<forall>y(([\<R>]\<^sup>+zx & [\<R>]\<^sup>+zy) \<rightarrow> ([\<R>]xy \<rightarrow> ([F]x \<rightarrow> [F]y)))) \<rightarrow> \<forall>x ([\<R>]\<^sup>+zx \<rightarrow> [F]x)\<close>
proof(safe intro!: "\<rightarrow>I" GEN)
  AOT_have den: \<open>[\<lambda>y [F]y & [\<R>]\<^sup>+zy]\<down>\<close> by cqt_2_lambda
  fix x
  AOT_assume \<theta>: \<open>[F]z & \<forall>x\<forall>y(([\<R>]\<^sup>+zx & [\<R>]\<^sup>+zy) \<rightarrow> ([\<R>]xy \<rightarrow> ([F]x \<rightarrow> [F]y)))\<close>
  AOT_assume 0: \<open>[\<R>]\<^sup>+zx\<close>

  AOT_have \<open>[\<lambda>y [F]y & [\<R>]\<^sup>+zy]x\<close>
  proof (rule wances_her_2[OF assms, unvarify F, OF den, THEN "\<rightarrow>E"]; safe intro!: "&I")
    AOT_show \<open>[\<lambda>y [F]y & [\<R>]\<^sup>+zy]z\<close>
    proof (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] "&I")
      AOT_show \<open>[F]z\<close> using \<theta> "&E" by blast
    next
      AOT_show \<open>[\<R>]\<^sup>+zz\<close>
        by (rule w_ances[THEN "\<equiv>E"(2), OF "\<or>I"(2)])
           (meson "0" assms id_R_thm_5 one_to_one_R_5 "\<rightarrow>E")
    qed
  next
    AOT_show \<open>[\<R>]\<^sup>+zx\<close> by (fact 0)
  next
    AOT_show \<open>Hereditary([\<lambda>y [F]y & [\<R>]\<^sup>+zy],\<R>)\<close>
    proof (safe intro!: hered_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
      fix x' y
      AOT_assume 1: \<open>[\<R>]x'y\<close>
      AOT_assume \<open>[\<lambda>y [F]y & [\<R>]\<^sup>+zy]x'\<close>
      AOT_hence 2: \<open>[F]x' & [\<R>]\<^sup>+zx'\<close> by (rule betaC_1_a)
      AOT_have \<open>[\<R>]\<^sup>*zy\<close> using 1 2[THEN "&E"(2)]
        by (metis assms con_dis_taut_5 modus_tollens_1 reductio_aa_1 wances_her_3)
      AOT_hence 3: \<open>[\<R>]\<^sup>+zy\<close> by (metis con_dis_i_e_3_a intro_elim_3_b w_ances)
      AOT_show \<open>[\<lambda>y [F]y & [\<R>]\<^sup>+zy]y\<close>
      proof (rule betaC_2_a; cqt_2_lambda; safe intro!: cqt_2_const_var[axiom_inst] "&I" 3)
        AOT_show \<open>[F]y\<close>
        proof (rule \<theta>[THEN "&E"(2), THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", THEN "\<rightarrow>E", THEN "\<rightarrow>E"])
          AOT_show \<open>[\<R>]\<^sup>+zx' & [\<R>]\<^sup>+zy\<close>
            using 2 3 "&E" "&I" by blast
        next
          AOT_show \<open>[\<R>]x'y\<close> by (fact 1)
        next
          AOT_show \<open>[F]x'\<close> using 2 "&E" by blast
        qed
      qed
    qed(cqt_2_lambda)
  qed
  AOT_thus \<open>[F]x\<close> using betaC_1_a con_dis_i_e_2_a by fast
qed

AOT_theorem denotes_all: \<open>[\<lambda>x \<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> x[G])]\<down>\<close>
proof -
  AOT_modally_strict {
    fix x y
    AOT_assume indist: \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    AOT_hence nec_indist: \<open>\<box>\<forall>F ([F]x \<equiv> [F]y)\<close> 
      using ind_nec vdash_properties_10 by blast
    AOT_hence indist_nec: \<open>\<forall>F \<box>([F]x \<equiv> [F]y)\<close>
      using BFs_2 vdash_properties_10 by blast
    AOT_assume 0: \<open>\<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> x[G])\<close>
    AOT_have \<open>x[F]\<close>
      by (safe intro!: 0[THEN "\<forall>E"(2), THEN "\<rightarrow>E"] GEN "\<rightarrow>I" RN "\<equiv>I")
    AOT_hence Ax: \<open>A!x\<close> by (metis encoders_are_abstract existential_2_a "\<rightarrow>E")
    AOT_hence Ay: \<open>A!y\<close> using indist "\<forall>E"(1) intro_elim_3_a oa_exist_2 by blast
    AOT_have \<open>\<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> y[G])\<close>
        using indistinguishable_ord_enc_all[axiom_inst, THEN "\<rightarrow>E", OF "&I", OF "&I", OF "&I",
            OF cqt_2_const_var[axiom_inst], OF Ax, OF Ay, OF indist_nec, THEN "\<equiv>E"(1), OF 0].
  } note 0 = this
  AOT_modally_strict {
    fix x y
    AOT_assume \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    moreover AOT_have \<open>\<forall>F ([F]y \<equiv> [F]x)\<close>
      by (metis calculation cqt_basic_11 intro_elim_3_b)
    ultimately AOT_have \<open>\<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> x[G]) \<equiv> \<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> y[G])\<close>
      using 0 "\<equiv>I" "\<rightarrow>I" by auto
  } note 1 = this
  AOT_show \<open>[\<lambda>x \<forall>G (\<forall>u \<box>([G]u \<equiv> [F]u) \<rightarrow> x[G])]\<down>\<close>
    by (safe intro!: RN GEN "\<rightarrow>I" 1 kirchner_thm_2[THEN "\<equiv>E"(2)])
qed

AOT_theorem denotes_ex: \<open>[\<lambda>x \<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & x[G])]\<down>\<close>
proof -
  AOT_modally_strict {
    fix x y
    AOT_assume indist: \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    AOT_hence nec_indist: \<open>\<box>\<forall>F ([F]x \<equiv> [F]y)\<close> 
      using ind_nec vdash_properties_10 by blast
    AOT_hence indist_nec: \<open>\<forall>F \<box>([F]x \<equiv> [F]y)\<close>
      using BFs_2 vdash_properties_10 by blast
    AOT_assume 0: \<open>\<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & x[G])\<close>
    then AOT_obtain G where \<open>\<forall>u \<box>([G]u \<equiv> [F]u) & x[G]\<close> using "\<exists>E"[rotated] by blast
    AOT_hence \<open>x[G]\<close> using "&E" by blast
    AOT_hence Ax: \<open>A!x\<close> by (metis encoders_are_abstract existential_2_a "\<rightarrow>E")
    AOT_hence Ay: \<open>A!y\<close> using indist "\<forall>E"(1) intro_elim_3_a oa_exist_2 by blast
    AOT_have \<open>\<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & y[G])\<close>
      using indistinguishable_ord_enc_ex[axiom_inst, THEN "\<rightarrow>E", OF "&I", OF "&I", OF "&I", OF cqt_2_const_var[axiom_inst], OF Ax,
          OF Ay, OF indist_nec, THEN "\<equiv>E"(1), OF 0].
  } note 0 = this
  AOT_modally_strict {
    fix x y
    AOT_assume \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    moreover AOT_have \<open>\<forall>F ([F]y \<equiv> [F]x)\<close>
      by (metis calculation cqt_basic_11 intro_elim_3_b)
    ultimately AOT_have \<open>\<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & x[G]) \<equiv> \<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & y[G])\<close>
      using 0 "\<equiv>I" "\<rightarrow>I" by auto
  } note 1 = this
  AOT_show \<open>[\<lambda>x \<exists>G (\<forall>u \<box>([G]u \<equiv> [F]u) & x[G])]\<down>\<close>
    by (safe intro!: RN GEN "\<rightarrow>I" 1 kirchner_thm_2[THEN "\<equiv>E"(2)])
qed

AOT_theorem numbers_prop_den: \<open>[\<lambda>x Numbers(x, F)]\<down>\<close>
proof - 
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  AOT_have act_beta: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]u \<equiv> \<^bold>\<A>[F]u\<close> for F u
    by (rule beta_C_meta[THEN "\<rightarrow>E"]) cqt_2_lambda
  AOT_modally_strict {
    fix v and x y
    AOT_assume indist: \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    AOT_hence \<open>\<box>\<forall>F([F]x \<equiv> [F]y)\<close> using ind_nec vdash_properties_10 by blast
    AOT_have \<open>Numbers(x, F) \<rightarrow> Numbers(y, F)\<close>
    proof(safe intro!: "\<rightarrow>I")
      AOT_assume \<open>Numbers(x, F)\<close>

      AOT_hence x_prop: \<open>[A!]x & \<forall>G (x[G] \<equiv> [\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F)\<close>
        using numbers_den[OF cqt_2_const_var[axiom_inst], THEN "\<equiv>E"(1)] by blast
      AOT_hence Ax: \<open>A!x\<close> and x_enc_cond: \<open>x[G] \<equiv> [\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F\<close> for G
        using "&E" "\<forall>E" by blast+
      AOT_have Ay: \<open>A!y\<close>
        using indist Ax intro_elim_3_a oa_exist_2 rule_ui_1 by blast

      {
        fix G
        AOT_assume G_act_equinum_F: \<open>[\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F\<close>
        AOT_hence \<open>x[G]\<close> by (metis intro_elim_3_b x_enc_cond)
        {
          fix H
          AOT_assume \<open>\<forall>u \<box>([H]u \<equiv> [G]u)\<close>
          AOT_hence \<open>\<box>\<forall>u ([H]u \<equiv> [G]u)\<close>
            by (metis Ordinary.res_var_bound_reas_2 "\<rightarrow>E")
          AOT_hence \<open>\<^bold>\<A>\<forall>u ([H]u \<equiv> [G]u)\<close> by (metis nec_imp_act vdash_properties_6)
          AOT_hence 0: \<open>\<forall>u \<^bold>\<A>([H]u \<equiv> [G]u)\<close>  by (metis Ordinary.res_var_bound_reas_5 vdash_properties_10)
          {
            fix u
            AOT_assume \<open>O!u\<close>
            AOT_hence \<open>\<^bold>\<A>([H]u \<equiv> [G]u)\<close> using 0 "\<forall>E"(2) "\<rightarrow>E" by blast
            AOT_hence \<open>\<^bold>\<A>[H]u \<equiv> \<^bold>\<A>[G]u\<close> by (metis Act_Basic_5 intro_elim_3_a)
            AOT_hence \<open>[\<lambda>z \<^bold>\<A>[H]z]u \<equiv> [\<lambda>z \<^bold>\<A>[G]z]u\<close>
              using act_beta by (metis deduction_theorem intro_elim_2 intro_elim_3_a intro_elim_3_b)
          } note 1 = this
          AOT_have \<open>[\<lambda>z \<^bold>\<A>[H]z] \<equiv>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z]\<close>
            by (rule eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"])
               (auto intro!: "&I" act_den GEN "\<rightarrow>I" 1)
          AOT_hence \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z]\<close>
            using apE_eqE_1[unvarify F G, OF act_den, OF act_den, THEN "\<rightarrow>E"] by blast
          AOT_hence \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F\<close>
            by (metis G_act_equinum_F eq_part_3')
          AOT_hence \<open>x[H]\<close> by (metis intro_elim_3_b x_enc_cond)
        }
        AOT_hence \<open>(\<forall>u \<box>([H]u \<equiv> [G]u) \<rightarrow> x[H])\<close> for H by (rule "\<rightarrow>I")
        AOT_hence 0: \<open>\<forall>H(\<forall>u \<box>([H]u \<equiv> [G]u) \<rightarrow> x[H])\<close> by (rule GEN)
        AOT_have \<open>[\<lambda>x \<forall>H(\<forall>u \<box>([H]u \<equiv> [G]u) \<rightarrow> x[H])]x\<close>
          by (rule betaC_2_a; simp add: denotes_all; simp add: cqt_2_const_var[axiom_inst] 0)
        AOT_hence \<open>[\<lambda>x \<forall>H(\<forall>u \<box>([H]u \<equiv> [G]u) \<rightarrow> x[H])]y\<close>
          using indist[THEN "\<forall>E"(1), OF denotes_all, THEN "\<equiv>E"(1)] by blast
        AOT_hence \<open>\<forall>H(\<forall>u \<box>([H]u \<equiv> [G]u) \<rightarrow> y[H])\<close>
          by (rule betaC_1_a)
        moreover AOT_have \<open>\<forall>u \<box>([G]u \<equiv> [G]u)\<close>
          by (safe intro!: GEN "\<rightarrow>I" RN "\<equiv>I")
        ultimately AOT_have \<open>y[G]\<close> using "\<forall>E"(2) "\<rightarrow>E" by blast
      }
      moreover {
        fix G
        AOT_assume yG: \<open>y[G]\<close>
        AOT_hence 0: \<open>\<exists>H (\<forall>u \<box>([H]u \<equiv> [G]u) & y[H])\<close>
          by (rule_tac \<beta>=\<open>G\<close> in "\<exists>I"(2))
             (safe intro!: yG "&I" "\<rightarrow>I" GEN RN "\<equiv>I")
        AOT_have \<open>[\<lambda>y \<exists>H (\<forall>u \<box>([H]u \<equiv> [G]u) & y[H])]y\<close>
          by (rule betaC_2_a; simp add: denotes_ex; simp add: cqt_2_const_var[axiom_inst] 0)
        AOT_hence \<open>[\<lambda>y \<exists>H (\<forall>u \<box>([H]u \<equiv> [G]u) & y[H])]x\<close>
          using indist[THEN "\<forall>E"(1), OF denotes_ex, THEN "\<equiv>E"(2)] by blast
        AOT_hence \<open>\<exists>H (\<forall>u \<box>([H]u \<equiv> [G]u) & x[H])\<close>
          by (rule betaC_1_a)
        then AOT_obtain H where H_eq_G: \<open>\<forall>u \<box>([H]u \<equiv> [G]u)\<close> and x_enc_H: \<open>x[H]\<close> using "&E" "\<exists>E"[rotated] by blast
        AOT_have actH_equinum_F: \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E F\<close>
          using intro_elim_3_a x_enc_H x_enc_cond by blast
        AOT_have \<open>\<box>\<forall>u ([H]u \<equiv> [G]u)\<close>
          by (metis H_eq_G Ordinary.res_var_bound_reas_2 vdash_properties_10)
        AOT_hence \<open>\<^bold>\<A>\<forall>u ([H]u \<equiv> [G]u)\<close>
          by (metis nec_imp_act vdash_properties_6)
        AOT_hence \<open>\<forall>u \<^bold>\<A>([H]u \<equiv> [G]u)\<close>
          by (metis Ordinary.res_var_bound_reas_5 vdash_properties_10)
        AOT_hence \<open>\<^bold>\<A>([H]u \<equiv> [G]u)\<close> if \<open>O!u\<close> for u using that "\<forall>E"(2) "\<rightarrow>E" by fast
        AOT_hence \<open>\<^bold>\<A>[H]u \<equiv> \<^bold>\<A>[G]u\<close> if \<open>O!u\<close> for u
          by (metis Act_Basic_5 intro_elim_3_a that)
        AOT_hence 0: \<open>[\<lambda>x \<^bold>\<A>[H]x]u \<equiv> [\<lambda>x \<^bold>\<A>[G]x]u\<close> if \<open>O!u\<close> for u
          by (metis act_beta deduction_theorem intro_elim_2 intro_elim_3_a intro_elim_3_b that)
        AOT_have \<open>[\<lambda>z \<^bold>\<A>[H]z] \<approx>\<^sub>E [\<lambda>z \<^bold>\<A>[G]z]\<close>
          apply (rule apE_eqE_1[unvarify F G, OF act_den, OF act_den, THEN "\<rightarrow>E"])
          apply (rule eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"])
          by (safe intro!: "&I" act_den GEN "\<rightarrow>I" 0)
        AOT_hence \<open>[\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F\<close>
          using actH_equinum_F by (metis eq_part_2' eq_part_3' vdash_properties_10)
      }
      ultimately AOT_have \<open>y[G] \<equiv> [\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F\<close> for G
        by (metis deduction_theorem intro_elim_2)
      AOT_hence 0: \<open>\<forall>G (y[G] \<equiv> [\<lambda>z \<^bold>\<A>[G]z] \<approx>\<^sub>E F)\<close>
        by (rule GEN)
      AOT_show \<open>Numbers(y, F)\<close>
        by (safe intro!: numbers[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" Ay cqt_2_const_var[axiom_inst] 0)
    qed
  } note 0 = this
  AOT_modally_strict {
    fix v and x y
    AOT_assume \<open>\<forall>F ([F]x \<equiv> [F]y)\<close>
    moreover AOT_have \<open>\<forall>F ([F]y \<equiv> [F]x)\<close>
      by (metis calculation cqt_basic_11 intro_elim_3_a)
    ultimately AOT_have \<open>Numbers(x, F) \<equiv> Numbers(y, F)\<close>
      using 0 intro_elim_2 by simp
  } note 0 = this
  AOT_show \<open>[\<lambda>x Numbers(x,F)]\<down>\<close>
    apply (rule kirchner_thm_2[THEN "\<equiv>E"(2)]; rule RN)
    apply (rule GEN)
    apply (rule GEN)
    using 0 "\<rightarrow>I" by simp
qed

AOT_theorem pred: \<open>[\<lambda>xy \<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))]\<down>\<close>
proof -
  AOT_have prod_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> \<guillemotleft>(AOT_term_of_var x\<^sub>1,AOT_term_of_var x\<^sub>2)\<guillemotright>\<down>\<close> for x\<^sub>1 x\<^sub>2 :: \<open>\<kappa> AOT_var\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  AOT_have proj1_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>xy [F]x]\<down>\<close> for F by cqt_2_lambda
  AOT_have proj2_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>xy [F]y]\<down>\<close> for F by cqt_2_lambda
  AOT_have act_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]\<down>\<close> for F by cqt_2_lambda
  AOT_have act_beta: \<open>\<^bold>\<turnstile>\<^sub>\<box> [\<lambda>z \<^bold>\<A>[F]z]u \<equiv> \<^bold>\<A>[F]u\<close> for F u
    by (rule beta_C_meta[THEN "\<rightarrow>E"]) cqt_2_lambda
  AOT_modally_strict {
    fix x\<^sub>1 x\<^sub>2 y\<^sub>1 y\<^sub>2
    AOT_assume 0: \<open>\<forall>F ([F]x\<^sub>1x\<^sub>2 \<equiv> [F]y\<^sub>1y\<^sub>2)\<close>
    AOT_have \<open>[\<lambda>xy [F]x]x\<^sub>1x\<^sub>2 \<equiv> [\<lambda>xy [F]x]y\<^sub>1y\<^sub>2\<close> for F
      by (rule 0[THEN "\<forall>E"(1)]) cqt_2_lambda
    AOT_have \<open> \<^bold>\<turnstile>\<^sub>\<box> \<psi>{[\<lambda>\<mu>\<^sub>1...\<mu>\<^sub>n \<phi>{\<mu>\<^sub>1...\<mu>\<^sub>n}]} \<equiv> \<psi>{[\<lambda>xy \<phi>{\<guillemotleft>(x,y)\<guillemotright>}]}\<close> for \<phi> \<psi>
      by (simp add: oth_class_taut_3_a)
    AOT_have xy1_eq: \<open>([F]x\<^sub>1 \<equiv> [F]y\<^sub>1)\<close> for F
      apply (AOT_subst_rev \<open>\<guillemotleft>[\<lambda>xy [F]x]x\<^sub>1x\<^sub>2\<guillemotright>\<close> \<open>\<guillemotleft>[F]x\<^sub>1\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E", OF proj1_den, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified, OF prod_den])
      apply (AOT_subst_rev \<open>\<guillemotleft>[\<lambda>xy [F]x]y\<^sub>1y\<^sub>2\<guillemotright>\<close> \<open>\<guillemotleft>[F]y\<^sub>1\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E", OF proj1_den, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified, OF prod_den])
      using "0" proj1_den rule_ui_1 by blast
    AOT_hence \<open>\<forall>F([F]x\<^sub>1 \<equiv> [F]y\<^sub>1)\<close> by (rule GEN)
    AOT_have xy2_eq: \<open>([F]x\<^sub>2 \<equiv> [F]y\<^sub>2)\<close> for F
      apply (AOT_subst_rev \<open>\<guillemotleft>[\<lambda>xy [F]y]x\<^sub>1x\<^sub>2\<guillemotright>\<close> \<open>\<guillemotleft>[F]x\<^sub>2\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E", OF proj2_den, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified, OF prod_den])
      apply (AOT_subst_rev \<open>\<guillemotleft>[\<lambda>xy [F]y]y\<^sub>1y\<^sub>2\<guillemotright>\<close> \<open>\<guillemotleft>[F]y\<^sub>2\<guillemotright>\<close>)
       apply (rule beta_C_meta[THEN "\<rightarrow>E", OF proj2_den, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, where \<tau>=\<open>(_,_)\<close>, simplified, OF prod_den])
      using "0" proj2_den rule_ui_1 by blast
    AOT_hence \<open>\<forall>F([F]x\<^sub>2 \<equiv> [F]y\<^sub>2)\<close> by (rule GEN)

    AOT_have \<open>(\<exists>F \<exists>u ([F]u & Numbers(x\<^sub>2,F) & Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u))) \<rightarrow>
              (\<exists>F \<exists>u ([F]u & Numbers(y\<^sub>2,F) & Numbers(y\<^sub>1,[F]\<^sup>-\<^sup>u)))\<close>
    proof (rule "\<rightarrow>I")
      AOT_assume \<open>\<exists>F \<exists>u ([F]u & Numbers(x\<^sub>2,F) & Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u))\<close>
      then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(x\<^sub>2,F) & Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
      then AOT_obtain u where \<open>O!u & ([F]u & Numbers(x\<^sub>2,F) & Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
      AOT_hence Ou: \<open>O!u\<close>
            and Fu: \<open>[F]u\<close>
            and numbers_x2_F: \<open>Numbers(x\<^sub>2,F)\<close>
            and numbers_x1_F_minus_u: \<open>Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u)\<close>
        using "&E" by blast+

      AOT_have \<open>[\<lambda>x Numbers(x,F)]x\<^sub>2\<close>
        by (rule betaC_2_a; simp add: numbers_prop_den; simp add: cqt_2_const_var[axiom_inst] numbers_x2_F)
      AOT_hence \<open>[\<lambda>x Numbers(x,F)]y\<^sub>2\<close>
        using xy2_eq[unvarify F, OF numbers_prop_den, THEN "\<equiv>E"(1)] by blast
      AOT_hence numbers_y2_F: \<open>Numbers(y\<^sub>2,F)\<close>
        by (rule betaC_1_a)
      AOT_have F_minus_u_den: \<open>[F]\<^sup>-\<^sup>u\<down>\<close>
        using "\<equiv>\<^sub>d\<^sub>fE" con_dis_i_e_2_a con_dis_i_e_2_b numbers numbers_x1_F_minus_u by blast
      AOT_have \<open>[\<lambda>x Numbers(x,[F]\<^sup>-\<^sup>u)]x\<^sub>1\<close>
        by (rule betaC_2_a; simp add: numbers_prop_den[unvarify F, OF F_minus_u_den]; simp add: cqt_2_const_var[axiom_inst] numbers_x1_F_minus_u)
      AOT_hence \<open>[\<lambda>x Numbers(x,[F]\<^sup>-\<^sup>u)]y\<^sub>1\<close>
        using xy1_eq[unvarify F, OF numbers_prop_den[unvarify F, OF F_minus_u_den], THEN "\<equiv>E"(1)] by blast
      AOT_hence numbers_y_1_F_minus_u: \<open>Numbers(y\<^sub>1,[F]\<^sup>-\<^sup>u)\<close>
        by (rule betaC_1_a)

      AOT_show \<open>\<exists>F \<exists>u ([F]u & Numbers(y\<^sub>2,F) & Numbers(y\<^sub>1,[F]\<^sup>-\<^sup>u))\<close>
        apply (rule_tac \<beta>=F in "\<exists>I"(2))
        apply (rule_tac \<beta>=u in "\<exists>I"(2))
        by (safe intro!: "&I" Ou Fu numbers_y2_F numbers_y_1_F_minus_u)
    qed
  } note 0 = this
  AOT_modally_strict {
    fix x\<^sub>1 x\<^sub>2 y\<^sub>1 y\<^sub>2
    AOT_assume \<open>\<forall>F ([F]x\<^sub>1x\<^sub>2 \<equiv> [F]y\<^sub>1y\<^sub>2)\<close>
    moreover AOT_have \<open>\<forall>F ([F]y\<^sub>1y\<^sub>2 \<equiv> [F]x\<^sub>1x\<^sub>2)\<close>
      using calculation cqt_basic_11 intro_elim_3_a by fastforce
    ultimately AOT_have \<open>\<exists>F \<exists>u ([F]u & Numbers(x\<^sub>2,F) & Numbers(x\<^sub>1,[F]\<^sup>-\<^sup>u)) \<equiv>
                         \<exists>F \<exists>u ([F]u & Numbers(y\<^sub>2,F) & Numbers(y\<^sub>1,[F]\<^sup>-\<^sup>u))\<close>
      using 0 "\<equiv>I" "\<rightarrow>E" by auto
  } note 0 = this
  AOT_show \<open>[\<lambda>xy \<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))]\<down>\<close>
    apply (rule kirchner_thm_2[THEN "\<equiv>E"(2)]; rule RN)
    apply (rule tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    apply (rule GEN)
    apply (rule GEN)
    apply (rule tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fI"])
    apply (rule GEN)
    apply (rule GEN)
    using 0 "\<rightarrow>I" by simp
qed

AOT_define pred_thm_1 :: \<open>\<tau>\<close> (\<open>\<P>\<close>)
  \<open>\<P> =\<^sub>d\<^sub>f [\<lambda>xy \<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))]\<close>

AOT_theorem pred_denotes: \<open>\<P>\<down>\<close>
  using pred pred_thm_1 rule_id_def_2_b' by blast

AOT_theorem pred_thm_2: \<open>[\<P>]xy \<equiv> \<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
proof -
  AOT_have prod_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> \<guillemotleft>(AOT_term_of_var x\<^sub>1,AOT_term_of_var x\<^sub>2)\<guillemotright>\<down>\<close> for x\<^sub>1 x\<^sub>2 :: \<open>\<kappa> AOT_var\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  show ?thesis
    apply (rule "=\<^sub>d\<^sub>fI"(2)[OF pred_thm_1])
    apply (metis pred)
    by (rule beta_C_meta[unvarify \<nu>\<^sub>1\<nu>\<^sub>n, OF prod_den, THEN "\<rightarrow>E", OF pred, simplified])
qed


(* TODO: PLM important: states =\<^sub>d\<^sub>f instead of = with expanded "Hereditary" *)
AOT_theorem assume_anc_1:
  \<open>[\<P>]\<^sup>* = [\<lambda>xy \<forall>F((\<forall>z([\<P>]xz \<rightarrow> [F]z) & Hereditary(F,\<P>)) \<rightarrow> [F]y)]\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF ances_df])
   apply cqt_2_lambda
  apply (rule "=I"(1))
  by cqt_2_lambda

AOT_theorem assume_anc_den: \<open>\<P>\<^sup>*\<down>\<close>
  using "t=t-proper_1" assume_anc_1 vdash_properties_10 by blast

AOT_theorem assume_anc_2:
  \<open>[\<P>\<^sup>*]xy \<equiv> \<forall>F((\<forall>z([\<P>]xz \<rightarrow> [F]z) & \<forall>x'\<forall>y'([\<P>]x'y' \<rightarrow> ([F]x' \<rightarrow> [F]y'))) \<rightarrow> [F]y)\<close>
proof -
  AOT_have prod_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> \<guillemotleft>(AOT_term_of_var x\<^sub>1,AOT_term_of_var x\<^sub>2)\<guillemotright>\<down>\<close> for x\<^sub>1 x\<^sub>2 :: \<open>\<kappa> AOT_var\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  AOT_have den: \<open>[\<lambda>xy \<forall>F((\<forall>z([\<P>]xz \<rightarrow> [F]z) & Hereditary(F,\<P>)) \<rightarrow> [F]y)]\<down>\<close>
    by cqt_2_lambda
  AOT_have 1: \<open>[\<P>\<^sup>*]xy \<equiv> \<forall>F((\<forall>z([\<P>]xz \<rightarrow> [F]z) & Hereditary(F,\<P>)) \<rightarrow> [F]y)\<close>
    apply (rule "rule=E"[rotated, OF assume_anc_1[symmetric]])
    by (rule beta_C_meta[unvarify \<nu>\<^sub>1\<nu>\<^sub>n, OF prod_den, THEN "\<rightarrow>E", simplified, OF den, simplified])
  show ?thesis
    apply (AOT_subst_rev \<open>\<lambda> \<Pi> . \<guillemotleft>Hereditary(\<Pi>,\<P>)\<guillemotright>\<close> \<open>\<lambda> \<Pi>. \<guillemotleft>\<forall>x'\<forall>y' ([\<P>]x'y' \<rightarrow> ([\<Pi>]x' \<rightarrow> [\<Pi>]y'))\<guillemotright>\<close>)
    using hered_1[THEN "\<equiv>Df", THEN "\<equiv>S"(1), OF "&I", OF pred_denotes, OF cqt_2_const_var[axiom_inst]] apply blast
    by (fact 1)
qed

AOT_theorem no_pred_0_1: \<open>\<not>\<exists>x [\<P>]x 0\<close> (* TODO: unfortunate syntactically required space *)
proof(rule raa_cor_2)
  AOT_assume \<open>\<exists>x [\<P>]x 0\<close>
  then AOT_obtain a where \<open>[\<P>]a 0\<close>
    using "\<exists>E"[rotated] by blast
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(0, F) & Numbers(a, [F]\<^sup>-\<^sup>u))\<close>
    using pred_thm_2[unvarify y, OF zero_den, THEN "\<equiv>E"(1)] by blast
  then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(0, F) & Numbers(a, [F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
  then AOT_obtain u where \<open>O!u & ([F]u & Numbers(0, F) & Numbers(a, [F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>O!u & [F]u\<close> and num0_F: \<open>Numbers(0, F)\<close> using "&E" "&I" by blast+
  AOT_hence \<open>\<exists>u [F]u\<close> using "\<exists>I" by fast
  moreover AOT_have \<open>\<not>\<exists>u [F]u\<close> using num0_F
    using intro_elim_3_b zeroF by blast
  ultimately AOT_show \<open>p & \<not>p\<close> for p by (metis raa_cor_3)
qed

AOT_theorem no_pred_0_2: \<open>\<not>\<exists>x [\<P>\<^sup>*]x 0\<close>
proof(rule raa_cor_2)
  AOT_assume \<open>\<exists>x [\<P>\<^sup>*]x 0\<close>
  then AOT_obtain a where \<open>[\<P>\<^sup>*]a 0\<close>
    using "\<exists>E"[rotated] by blast
  AOT_hence \<open>\<exists>z [\<P>]z 0\<close>
    using anc_her_5[unvarify R y, OF zero_den, OF pred_denotes, THEN "\<rightarrow>E"] by auto
  AOT_thus \<open>\<exists>z [\<P>]z 0 & \<not>\<exists>z [\<P>]z 0\<close>
    by (metis no_pred_0_1 raa_cor_3)
qed

AOT_theorem no_pred_0_3: \<open>\<not>[\<P>\<^sup>*]0 0\<close>
  by (metis existential_1 no_pred_0_2 reductio_aa_1 zero_den)

AOT_theorem pred_1_1_1: \<open>[\<P>]xy \<rightarrow> \<box>[\<P>]xy\<close>
proof(rule "\<rightarrow>I")
  AOT_assume \<open>[\<P>]xy\<close>
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using intro_elim_3_a pred_thm_2 by fast
  then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using "\<exists>E"[rotated] by blast
  then AOT_obtain u where props: \<open>O!u & ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using "\<exists>E"[rotated] by blast
  AOT_obtain G where Ridigifies_G_F: \<open>Rigidifies(G, F)\<close>
    by (metis "instantiation" rigid_der_3)
  AOT_hence \<xi>: \<open>\<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close> and \<zeta>: \<open>\<forall>x([G]x \<equiv> [F]x)\<close>
    using df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(1), THEN "\<equiv>\<^sub>d\<^sub>fE"[OF df_rigid_rel_1], THEN "&E"(2)]
          df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(2)] by blast+

  AOT_have rigid_num_nec: \<open>Numbers(x,F) & Rigidifies(G,F) \<rightarrow> \<box>Numbers(x,G)\<close> for x G F
  proof(rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
    fix G F x
    AOT_assume Numbers_xF: \<open>Numbers(x,F)\<close>
    AOT_assume \<open>Rigidifies(G,F)\<close>
    AOT_hence \<xi>: \<open>\<box>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close> and \<zeta>: \<open>\<forall>x([G]x \<equiv> [F]x)\<close>
      using df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(1), THEN "\<equiv>\<^sub>d\<^sub>fE"[OF df_rigid_rel_1], THEN "&E"(2)]
            df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fE", THEN "&E"(2)] by blast+
    AOT_thus \<open>\<box>Numbers(x,G)\<close>
    proof (safe intro!:
          num_cont_2[THEN "\<rightarrow>E", OF \<xi>, THEN qml_2[axiom_inst, THEN "\<rightarrow>E"], THEN "\<forall>E"(2), THEN "\<rightarrow>E"]
          num_tran_3[THEN "\<rightarrow>E", THEN "\<equiv>E"(1), rotated, OF Numbers_xF]
          eqE[THEN "\<equiv>\<^sub>d\<^sub>fI"]
            "&I" cqt_2_const_var[axiom_inst] GEN "\<rightarrow>I")
      AOT_show \<open>[F]u \<equiv> [G]u\<close> for u
        using \<zeta>[THEN "\<forall>E"(2)] by (metis intro_elim_3_f oth_class_taut_3_a) 
    qed
  qed
  AOT_have \<open>\<box>Numbers(y,G)\<close>
    using rigid_num_nec[THEN "\<rightarrow>E", OF "&I", OF props[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)], OF Ridigifies_G_F].
  moreover {
    AOT_have \<open>Rigidifies([G]\<^sup>-\<^sup>u, [F]\<^sup>-\<^sup>u)\<close>
    proof (safe intro!: df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] df_rigid_rel_2[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" F_minus_u_den GEN "\<equiv>I" "\<rightarrow>I")
      AOT_have \<open>\<box>\<forall>x([G]x \<rightarrow> \<box>[G]x) \<rightarrow> \<box>\<forall>x([[G]\<^sup>-\<^sup>u]x \<rightarrow> \<box>[[G]\<^sup>-\<^sup>u]x)\<close>
      proof (rule RM; safe intro!: "\<rightarrow>I" GEN)
        AOT_modally_strict {
          fix x
          AOT_assume 0: \<open>\<forall>x([G]x \<rightarrow> \<box>[G]x)\<close>
          AOT_assume 1: \<open>[[G]\<^sup>-\<^sup>u]x\<close>
          AOT_have \<open>[\<lambda>x [G]x & x \<noteq>\<^sub>E u]x\<close>
            apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fE"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
             apply cqt_2_lambda
            by (fact 1)
          AOT_hence \<open>[G]x & x \<noteq>\<^sub>E u\<close>
            by (rule betaC_1_a)
          AOT_hence 2: \<open>\<box>[G]x\<close> and 3: \<open>\<box>x \<noteq>\<^sub>E u\<close>
            using "&E" 0[THEN "\<forall>E"(2), THEN "\<rightarrow>E"] id_nec_4_1 intro_elim_3_a by blast+
          AOT_show \<open>\<box>[[G]\<^sup>-\<^sup>u]x\<close>
            apply (AOT_subst \<open>\<guillemotleft>[[G]\<^sup>-\<^sup>u]x\<guillemotright>\<close> \<open>\<guillemotleft>[G]x & x \<noteq>\<^sub>E u\<guillemotright>\<close>)
             apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fI"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
              apply cqt_2_lambda
             apply (rule beta_C_meta[THEN "\<rightarrow>E"])
            apply cqt_2_lambda
            using 2 3 KBasic_3 df_simplify_2 intro_elim_3_b by blast
        }
      qed
      AOT_thus \<open>\<box>\<forall>x([[G]\<^sup>-\<^sup>u]x \<rightarrow> \<box>[[G]\<^sup>-\<^sup>u]x)\<close> using \<xi> "\<rightarrow>E" by blast
    next
      fix x
      AOT_assume 1: \<open>[[G]\<^sup>-\<^sup>u]x\<close>
      AOT_have \<open>[\<lambda>x [G]x & x \<noteq>\<^sub>E u]x\<close>
        apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fE"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
         apply cqt_2_lambda
        by (fact 1)
      AOT_hence \<open>[G]x & x \<noteq>\<^sub>E u\<close>
        by (rule betaC_1_a)
      AOT_hence 2: \<open>[F]x & x \<noteq>\<^sub>E u\<close>
        using \<zeta> con_dis_i_e_1 con_dis_i_e_2_a con_dis_i_e_2_b intro_elim_3_a rule_ui_3 by blast
      AOT_have 3: \<open>[\<lambda>x [F]x & x \<noteq>\<^sub>E u]x\<close>
        by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 2)
      AOT_show \<open>[[F]\<^sup>-\<^sup>u]x\<close>
        apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fI"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
         apply cqt_2_lambda
        by (simp add: 3)
    next
      fix x
      AOT_assume 1: \<open>[[F]\<^sup>-\<^sup>u]x\<close>
      AOT_have \<open>[\<lambda>x [F]x & x \<noteq>\<^sub>E u]x\<close>
        apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fE"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
         apply cqt_2_lambda
        by (fact 1)
      AOT_hence \<open>[F]x & x \<noteq>\<^sub>E u\<close>
        by (rule betaC_1_a)
      AOT_hence 2: \<open>[G]x & x \<noteq>\<^sub>E u\<close>
        using \<zeta> con_dis_i_e_1 con_dis_i_e_2_a con_dis_i_e_2_b intro_elim_3_b rule_ui_3 by blast
      AOT_have 3: \<open>[\<lambda>x [G]x & x \<noteq>\<^sub>E u]x\<close>
        by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 2)
      AOT_show \<open>[[G]\<^sup>-\<^sup>u]x\<close>
        apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fI"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified])
         apply cqt_2_lambda
        by (simp add: 3)
    qed
    AOT_hence \<open>\<box>Numbers(x,[G]\<^sup>-\<^sup>u)\<close>
      using rigid_num_nec[unvarify F G, OF F_minus_u_den, OF F_minus_u_den, THEN "\<rightarrow>E", OF "&I",
              OF props[THEN "&E"(2), THEN "&E"(2)]] by blast
  }
  moreover AOT_have \<open>\<box>[G]u\<close>
    using props[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1), THEN \<zeta>[THEN "\<forall>E"(2), THEN "\<equiv>E"(2)]]
          \<xi>[THEN qml_2[axiom_inst, THEN "\<rightarrow>E"], THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
  ultimately AOT_have \<open>\<box>([G]u & Numbers(y,G) & Numbers(x,[G]\<^sup>-\<^sup>u))\<close>
    by (metis KBasic_3 con_dis_i_e_1 intro_elim_3_b)
  AOT_hence \<open>O!u & \<box>([G]u & Numbers(y,G) & Numbers(x,[G]\<^sup>-\<^sup>u))\<close>
    using props[THEN "&E"(1)] "&I" by blast
  AOT_hence \<open>\<exists>u (\<box>([G]u & Numbers(y,G) & Numbers(x,[G]\<^sup>-\<^sup>u)))\<close>
    by (rule "\<exists>I")
  AOT_hence \<open>\<box>\<exists>u ([G]u & Numbers(y,G) & Numbers(x,[G]\<^sup>-\<^sup>u))\<close>
    using Ordinary.res_var_bound_Buridan vdash_properties_10 by fast
  AOT_hence \<open>\<exists>F \<box>\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    by (rule "\<exists>I")
  AOT_hence 0: \<open>\<box>\<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using sign_S5_thm_1 vdash_properties_10 by fast
  AOT_show \<open>\<box>[\<P>]xy\<close>
    by (AOT_subst \<open>\<guillemotleft>[\<P>]xy\<guillemotright>\<close> \<open>\<guillemotleft>\<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<guillemotright>\<close>; simp add: pred_thm_2 0)
qed

AOT_theorem pred_1_1_2: \<open>Rigid(\<P>)\<close>
  by (safe intro!: df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] pred_denotes "&I" RN tuple_forall[THEN "\<equiv>\<^sub>d\<^sub>fI"];
      safe intro!: GEN pred_1_1_1)

AOT_theorem pred_1_1_3: \<open>1-1(\<P>)\<close>
proof (safe intro!: df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] pred_denotes "&I" GEN "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  fix x y z
  AOT_assume \<open>[\<P>]xz\<close>
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(z,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close> using pred_thm_2[THEN "\<equiv>E"(1)] by blast
  then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(z,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
  then AOT_obtain u where u_prop: \<open>O!u & ([F]u & Numbers(z,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
  AOT_assume \<open>[\<P>]yz\<close>
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(z,F) & Numbers(y,[F]\<^sup>-\<^sup>u))\<close> using pred_thm_2[THEN "\<equiv>E"(1)] by blast
  then AOT_obtain G where \<open>\<exists>u ([G]u & Numbers(z,G) & Numbers(y,[G]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
  then AOT_obtain v where v_prop: \<open>O!v & ([G]v & Numbers(z,G) & Numbers(y,[G]\<^sup>-\<^sup>v))\<close> using "\<exists>E"[rotated] by blast
  AOT_show \<open>x = y\<close>
  proof (rule pre_Hume[unvarify G H, OF F_minus_u_den, OF F_minus_u_den, THEN "\<rightarrow>E", OF "&I", THEN "\<equiv>E"(2)])
    AOT_show \<open>Numbers(x, [F]\<^sup>-\<^sup>u)\<close> using u_prop "&E" by blast
  next
    AOT_show \<open>Numbers(y, [G]\<^sup>-\<^sup>v)\<close> using v_prop "&E" by blast
  next
    AOT_have \<open>F \<approx>\<^sub>E G\<close>
      using u_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)]
      using v_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(2)]
      using num_tran_2[THEN "\<rightarrow>E", OF "&I"] by blast
    AOT_thus \<open>[F]\<^sup>-\<^sup>u \<approx>\<^sub>E [G]\<^sup>-\<^sup>v\<close>
      using u_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
      using v_prop[THEN "&E"(2), THEN "&E"(1), THEN "&E"(1)]
      using eqP'[OF u_prop[THEN "&E"(1)], OF v_prop[THEN "&E"(1)], THEN "\<rightarrow>E", OF "&I", OF "&I"]
      by blast
  qed
qed

AOT_theorem pred_1_1_4: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<P>)\<close>
  by (meson "\<equiv>\<^sub>d\<^sub>fI" con_dis_i_e_1 df_1_1_2 pred_1_1_2 pred_1_1_3)

(* TODO: PLM uses =\<^sub>d\<^sub>f instead *)
AOT_theorem assume1_1: \<open>(=\<^sub>\<P>) = [\<lambda>xy \<exists>z ([\<P>]xz & [\<P>]yz)]\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF id_d_R])
   apply cqt_2_lambda
  apply (rule "=I"(1))
  by cqt_2_lambda

AOT_theorem assume1_2: \<open>x =\<^sub>\<P> y \<equiv> \<exists>z ([\<P>]xz & [\<P>]yz)\<close>
proof (rule "rule=E"[rotated, OF assume1_1[symmetric]])
  AOT_have prod_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> \<guillemotleft>(AOT_term_of_var x\<^sub>1,AOT_term_of_var x\<^sub>2)\<guillemotright>\<down>\<close> for x\<^sub>1 x\<^sub>2 :: \<open>\<kappa> AOT_var\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  AOT_have 1: \<open>[\<lambda>xy \<exists>z ([\<P>]xz & [\<P>]yz)]\<down>\<close> by cqt_2_lambda
  AOT_show \<open>[\<lambda>xy \<exists>z ([\<P>]xz & [\<P>]yz)]xy \<equiv> \<exists>z ([\<P>]xz & [\<P>]yz)\<close>
    using beta_C_meta[THEN "\<rightarrow>E", OF 1, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, OF prod_den, simplified] by blast
qed

(* TODO: PLM: states =\<^sub>d\<^sub>f instead of = *)
AOT_theorem assume1_3: \<open>[\<P>]\<^sup>+ = [\<lambda>xy [\<P>]\<^sup>*xy \<or> x =\<^sub>\<P> y]\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF w_ances_df])
   apply (simp add: w_ances_df_den_1)
  apply (rule "rule=E"[rotated, OF assume1_1[symmetric]])
  apply (rule "=\<^sub>d\<^sub>fI"(1)[OF id_d_R])
   apply cqt_2_lambda
  apply (rule "=I"(1))
  by cqt_2_lambda

AOT_theorem assume1_4: \<open>[\<P>]\<^sup>+xy \<equiv> [\<P>]\<^sup>*xy \<or> x =\<^sub>\<P> y\<close>
proof -
  AOT_have 0: \<open>[\<lambda>xy [\<P>]\<^sup>*xy \<or> x =\<^sub>\<P> y]\<down>\<close> by cqt_2_lambda
  AOT_have prod_den: \<open>\<^bold>\<turnstile>\<^sub>\<box> \<guillemotleft>(AOT_term_of_var x\<^sub>1,AOT_term_of_var x\<^sub>2)\<guillemotright>\<down>\<close> for x\<^sub>1 x\<^sub>2 :: \<open>\<kappa> AOT_var\<close>
    by (simp add: con_dis_i_e_1 ex_1_a prod_denotesI rule_ui_3)
  show ?thesis
    apply (rule "rule=E"[rotated, OF assume1_3[symmetric]])
    using beta_C_meta[THEN "\<rightarrow>E", OF 0, unvarify \<nu>\<^sub>1\<nu>\<^sub>n, OF prod_den, simplified, of x y]
    by (simp add: cond_case_prod_eta) (* TODO: try to avoid this *)
qed

AOT_define nnumber_1 :: \<open>\<tau>\<close> (\<open>\<nat>\<close>)
  \<open>\<nat> =\<^sub>d\<^sub>f [\<lambda>x [\<P>]\<^sup>+0x]\<close>

AOT_theorem nnumber_den: \<open>\<nat>\<down>\<close>
  by (rule "=\<^sub>d\<^sub>fI"(2)[OF nnumber_1]; cqt_2_lambda)

AOT_theorem nnumber_2: \<open>[\<nat>]x \<equiv> [\<P>]\<^sup>+0x\<close>
  apply (rule "=\<^sub>d\<^sub>fI"(2)[OF nnumber_1])
   apply cqt_2_lambda
  apply (rule beta_C_meta[THEN "\<rightarrow>E"])
  by cqt_2_lambda

(* TODO: PLM: this proof is an exercise? Is that intentional? *)
AOT_theorem zero_n: \<open>[\<nat>]0\<close>
proof (safe intro!: nnumber_2[unvarify x, OF zero_den, THEN "\<equiv>E"(2)]
    assume1_4[unvarify x y, OF zero_den, OF zero_den, THEN "\<equiv>E"(2)]
    "\<or>I"(2) assume1_2[unvarify x y, OF zero_den, OF zero_den, THEN "\<equiv>E"(2)])
  AOT_obtain u where Ou: \<open>O!u\<close>
    by (metis "B\<diamond>" "instantiation" T_S5_fund_1 o_objects_exist_1 vdash_properties_10)
  AOT_have den: \<open>[\<lambda>x O!x & x =\<^sub>E u]\<down>\<close> by cqt_2_lambda
  AOT_obtain a where a_prop: \<open>Numbers(a, [\<lambda>x O!x & x =\<^sub>E u])\<close>
    using num_1[unvarify G, OF den] "\<exists>E"[rotated] by blast
  AOT_have \<open>[\<P>]0a\<close>
  proof (safe intro!: pred_thm_2[unvarify x, OF zero_den, THEN "\<equiv>E"(2)]
                      "\<exists>I"(1)[where \<tau>=\<open>\<guillemotleft>[\<lambda>x O!x & x =\<^sub>E u]\<guillemotright>\<close>] "\<exists>I"(2)[where \<beta>=u] "&I" Ou den
                      "0F"[unvarify F, OF F_minus_u_den, unvarify F, OF den, THEN "\<equiv>E"(1)])
    AOT_show \<open>[\<lambda>x [O!]x & x =\<^sub>E u]u\<close>
      by (rule betaC_2_a; cqt_2_lambda;
          safe intro!: "&I" cqt_2_const_var[axiom_inst] Ou ord_eq_Eequiv_1[THEN "\<rightarrow>E", OF Ou])
  next
    AOT_show \<open>Numbers(a,[\<lambda>x [O!]x & x =\<^sub>E u])\<close> using a_prop.
  next
    AOT_show \<open>\<not>\<exists>v [[\<lambda>x [O!]x & x =\<^sub>E u]\<^sup>-\<^sup>u]v\<close>
    proof(rule raa_cor_2)
      AOT_assume \<open>\<exists>v [[\<lambda>x [O!]x & x =\<^sub>E u]\<^sup>-\<^sup>u]v\<close>
      then AOT_obtain v where \<open>[[\<lambda>x [O!]x & x =\<^sub>E u]\<^sup>-\<^sup>u]v\<close> using "\<exists>E"[rotated] "&E" by blast
      AOT_hence \<open>[\<lambda>z [\<lambda>x [O!]x & x =\<^sub>E u]z & z \<noteq>\<^sub>E u]v\<close>
        apply (rule F_minus_u[THEN "=\<^sub>d\<^sub>fE"(1), where \<tau>\<^sub>1\<tau>\<^sub>n="(_,_)", simplified, rotated])
        by cqt_2_lambda
      AOT_hence \<open>[\<lambda>x [O!]x & x =\<^sub>E u]v & v \<noteq>\<^sub>E u\<close>
        by (rule betaC_1_a)
      AOT_hence \<open>v =\<^sub>E u\<close> and \<open>v \<noteq>\<^sub>E u\<close> using betaC_1_a "&E" by blast+
      AOT_hence \<open>v =\<^sub>E u & \<not>(v =\<^sub>E u)\<close> by (metis intro_elim_3_d reductio_aa_1 thm_neg_eq_E)
      AOT_thus \<open>p & \<not>p\<close> for p  by (metis raa_cor_1)
    qed
  qed
  AOT_thus \<open>\<exists>z ([\<P>]0z & [\<P>]0z)\<close>
    by (safe intro!: "&I" "\<exists>I"(2)[where \<beta>=a])
qed

AOT_theorem mod_col_num_1: \<open>[\<nat>]x \<rightarrow> \<box>[\<nat>]x\<close>
proof(rule "\<rightarrow>I")
  AOT_have pre_ind: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> (([F]z & \<forall>x\<forall>y(([\<R>]\<^sup>+zx & [\<R>]\<^sup>+zy) \<rightarrow> ([\<R>]xy \<rightarrow> ([F]x \<rightarrow> [F]y)))) \<rightarrow> \<forall>x ([\<R>]\<^sup>+zx \<rightarrow> [F]x))\<close>
    for \<R> F z using pre_ind "\<rightarrow>I" by presburger
  AOT_have wances_her_3: \<open>\<^bold>\<turnstile>\<^sub>\<box> Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> ([[\<R>]\<^sup>+]xy & [\<R>]yz \<rightarrow> [\<R>\<^sup>*]xz)\<close> for \<R> x y z
    using wances_her_3 "\<rightarrow>I" by blast
  AOT_have nec0N: \<open>[\<lambda>x \<box>[\<nat>]x]0\<close>
    by (rule betaC_2_a; cqt_2_lambda; simp add: zero_den RN zero_n)
  AOT_have 1: \<open>[\<lambda>x \<box>[\<nat>]x]0 & \<forall>x\<forall>y ([[\<P>]\<^sup>+]0x & [[\<P>]\<^sup>+]0y \<rightarrow> ([\<P>]xy \<rightarrow> ([\<lambda>x \<box>[\<nat>]x]x \<rightarrow> [\<lambda>x \<box>[\<nat>]x]y))) \<rightarrow> \<forall>x ([[\<P>]\<^sup>+]0x \<rightarrow> [\<lambda>x \<box>[\<nat>]x]x)\<close>
    apply (rule pre_ind[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4, unvarify z, OF zero_den, unvarify F])
    by cqt_2_lambda
  AOT_have \<open>\<forall>x ([[\<P>]\<^sup>+]0x \<rightarrow> [\<lambda>x \<box>[\<nat>]x]x)\<close>
  proof (rule 1[THEN "\<rightarrow>E"]; safe intro!: "&I" GEN "\<rightarrow>I" nec0N; frule "&E"(1); drule "&E"(2))
    fix x y
    AOT_assume \<open>[\<P>]xy\<close>
    AOT_hence 0: \<open>\<box>[\<P>]xy\<close> by (metis pred_1_1_1 vdash_properties_10)
    AOT_assume \<open>[\<lambda>x \<box>[\<nat>]x]x\<close>
    AOT_hence \<open>\<box>[\<nat>]x\<close>
      by (rule betaC_1_a)
    AOT_hence \<open>\<box>([\<P>]xy & [\<nat>]x)\<close>
      by (metis "0" KBasic_3 con_dis_taut_5 intro_elim_3_b vdash_properties_10)
    moreover AOT_have \<open>\<box>([\<P>]xy & [\<nat>]x) \<rightarrow> \<box>[\<nat>]y\<close>
    proof (rule RM; rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
      AOT_modally_strict {
        AOT_assume 0: \<open>[\<P>]xy\<close>
        AOT_assume \<open>[\<nat>]x\<close>
        AOT_hence 1: \<open>[[\<P>]\<^sup>+]0x\<close> by (metis intro_elim_3_a nnumber_2)
        AOT_show \<open>[\<nat>]y\<close>
          apply (rule nnumber_2[THEN "\<equiv>E"(2)])
          apply (rule assume1_4[unvarify x, OF zero_den, THEN "\<equiv>E"(2)])
          apply (rule "\<or>I"(1))
          apply (rule wances_her_3[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4, unvarify x, OF zero_den, THEN "\<rightarrow>E"])
          apply (rule "&I")
           apply (fact 1)
          by (fact 0)
      }
    qed
    ultimately AOT_have 0: \<open>\<box>[\<nat>]y\<close> by (metis vdash_properties_10) 
    AOT_show \<open>[\<lambda>x \<box>[\<nat>]x]y\<close>
      by (rule betaC_2_a; cqt_2_lambda; simp add: cqt_2_const_var[axiom_inst] 0)
  qed
  AOT_hence 0: \<open>[[\<P>]\<^sup>+]0x \<rightarrow> [\<lambda>x \<box>[\<nat>]x]x\<close>
    using "\<forall>E"(2) by blast
  AOT_assume \<open>[\<nat>]x\<close>
  AOT_hence \<open>[[\<P>]\<^sup>+]0x\<close> by (metis intro_elim_3_a nnumber_2)
  AOT_hence \<open>[\<lambda>x \<box>[\<nat>]x]x\<close> using 0[THEN "\<rightarrow>E"] by blast
  AOT_thus \<open>\<box>[\<nat>]x\<close>
    by (rule betaC_1_a)
qed

AOT_theorem mod_col_num_2: \<open>Rigid(\<nat>)\<close>
  by (safe intro!: df_rigid_rel_1[THEN "\<equiv>\<^sub>d\<^sub>fI"] "&I" RN GEN mod_col_num_1 nnumber_den)

AOT_register_restricted_type
  Number: \<open>[\<nat>]\<kappa>\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<exists>x [\<nat>]x\<close>
      by (rule_tac \<tau>=\<open>\<guillemotleft>0\<guillemotright>\<close> in "\<exists>I"(1); simp add: zero_n zero_den)
  }
next
  AOT_modally_strict {
    AOT_show \<open>[\<nat>]\<kappa> \<rightarrow> \<kappa>\<down>\<close> for \<kappa>
      by (simp add: deduction_theorem russell_axiom_exe_1.\<psi>_denotes_asm)
  }
qed
AOT_register_variable_names
  Number: m n k i j
interpretation Number: AOT_rigid_restriction_condition \<open>\<lambda>\<kappa>. \<guillemotleft>[\<nat>]\<kappa>\<guillemotright>\<close>
proof
  AOT_modally_strict {
    AOT_show \<open>\<box>([\<nat>]x \<rightarrow> \<box>[\<nat>]x)\<close> for x
      by (simp add: RN mod_col_num_1)
  }
qed

AOT_theorem zero_pred: \<open>\<not>\<exists>n [\<P>]n 0\<close>
proof (rule raa_cor_2)
  AOT_assume \<open>\<exists>n [\<P>]n 0\<close>
  then AOT_obtain n where \<open>[\<nat>]n & [\<P>]n 0\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>\<exists>x [\<P>]x 0\<close> using "&E" "\<exists>I" by fast
  AOT_thus \<open>\<exists>x [\<P>]x 0 & \<not>\<exists>x [\<P>]x 0\<close>
    using no_pred_0_1 "&I" by auto
qed

AOT_theorem no_same_succ: \<open>\<forall>n\<forall>m\<forall>k([\<P>]nk & [\<P>]mk \<rightarrow> n = m)\<close>
proof(safe intro!: GEN "\<rightarrow>I")
  fix n m k
  AOT_assume \<open>[\<P>]nk & [\<P>]mk\<close>
  AOT_thus \<open>n = m\<close>
    by (rule df_1_1_3[unvarify R, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4,
        THEN qml_2[axiom_inst, THEN "\<rightarrow>E"], THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"])
qed

AOT_theorem suc_num_1:
  assumes \<open>[\<nat>]n\<close>
  shows \<open>[\<P>]nx \<rightarrow> [\<nat>]x\<close>
proof(rule "\<rightarrow>I")
  AOT_have wances_her_3: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> ([[\<R>]\<^sup>+]xy & [\<R>]yz \<rightarrow> [\<R>\<^sup>*]xz)\<close> for \<R> x y z
    using wances_her_3 "\<rightarrow>I" by blast
  AOT_have \<open>[[\<P>]\<^sup>+]0 n\<close>
    by (meson assms intro_elim_3_a nnumber_2)
  moreover AOT_assume \<open>[\<P>]nx\<close>
  ultimately AOT_have \<open>[[\<P>]\<^sup>*]0 x\<close>
    using wances_her_3[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4, unvarify x, OF zero_den, THEN "\<rightarrow>E", OF "&I"]
    by blast
  AOT_hence \<open>[[\<P>]\<^sup>+]0 x\<close> 
    using assume1_4[unvarify x, OF zero_den, THEN "\<equiv>E"(2), OF "\<or>I"(1)] by blast
  AOT_thus \<open>[\<nat>]x\<close>
    by (metis intro_elim_3_b nnumber_2)
qed

AOT_theorem suc_num_2:
  assumes \<open>[\<nat>]n\<close>
  shows \<open>[[\<P>]\<^sup>*]nx \<rightarrow> [\<nat>]x\<close>
proof(rule "\<rightarrow>I")
  AOT_have \<open>[[\<P>]\<^sup>+]0 n\<close>
    using assms intro_elim_3_a nnumber_2 by blast
  AOT_assume \<open>[[\<P>]\<^sup>*]n x\<close>
  AOT_hence \<open>\<forall>F (\<forall>z ([\<P>]nz \<rightarrow> [F]z) & \<forall>x'\<forall>y' ([\<P>]x'y' \<rightarrow> ([F]x' \<rightarrow> [F]y')) \<rightarrow> [F]x)\<close>
    using assume_anc_2[THEN "\<equiv>E"(1)] by blast
  AOT_hence \<theta>: \<open>\<forall>z ([\<P>]nz \<rightarrow> [\<nat>]z) & \<forall>x'\<forall>y' ([\<P>]x'y' \<rightarrow> ([\<nat>]x' \<rightarrow> [\<nat>]y')) \<rightarrow> [\<nat>]x\<close>
    using "\<forall>E"(1) nnumber_den by blast
  AOT_show \<open>[\<nat>]x\<close>
  proof (safe intro!: \<theta>[THEN "\<rightarrow>E"] GEN "\<rightarrow>I" "&I")
    AOT_show \<open>[\<nat>]z\<close> if \<open>[\<P>]nz\<close> for z
      using assms suc_num_1 that vdash_properties_10 by blast
  next
    AOT_show \<open>[\<nat>]y\<close> if \<open>[\<P>]xy\<close> and \<open>[\<nat>]x\<close> for x y
      using suc_num_1 that(1) that(2) vdash_properties_10 by blast
  qed
qed

AOT_theorem suc_num_3:
  assumes \<open>[\<nat>]n\<close>
  shows \<open>[\<P>]\<^sup>+nx \<rightarrow> [\<nat>]x\<close>
proof (rule "\<rightarrow>I")
  AOT_have id_R_thm_3: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> (x =\<^sub>\<R> y \<rightarrow> x = y)\<close> for x y \<R>
    using id_R_thm_3 "\<rightarrow>I" by blast
  AOT_assume \<open>[\<P>]\<^sup>+nx\<close>
  AOT_hence \<open>[\<P>]\<^sup>*nx \<or> n =\<^sub>\<P> x\<close>
    by (metis assume1_4 intro_elim_3_a)
  moreover {
    AOT_assume \<open>[\<P>]\<^sup>*nx\<close>
    AOT_hence \<open>[\<nat>]x\<close> by (metis assms suc_num_2 vdash_properties_10)
  }
  moreover {
    AOT_assume \<open>n =\<^sub>\<P> x\<close>
    AOT_hence \<open>n = x\<close>
      using id_R_thm_3[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4, THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>[\<nat>]x\<close> by (metis "rule=E" assms)
  }
  ultimately AOT_show \<open>[\<nat>]x\<close>
    by (metis con_dis_i_e_4_c reductio_aa_1)
qed

AOT_theorem pred_num:
  assumes \<open>[\<nat>]n\<close>
  shows \<open>[\<P>]xn \<rightarrow> [\<nat>]x\<close>
proof (rule "\<rightarrow>I")
  AOT_have wances_her_7: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> ([\<R>\<^sup>*]xy \<rightarrow> \<exists>z ([[\<R>]\<^sup>+]xz & [\<R>]zy))\<close> for \<R> x y
    using wances_her_7 "\<rightarrow>I" by blast
  AOT_assume 0: \<open>[\<P>]xn\<close>
  AOT_have \<open>[[\<P>]\<^sup>+]0 n\<close>
    using assms intro_elim_3_a nnumber_2 by blast
  AOT_hence \<open>[[\<P>]\<^sup>*]0 n \<or> 0 =\<^sub>\<P> n\<close>
    using assume1_4[unvarify x, OF zero_den] by (metis intro_elim_3_a)
  moreover {
    AOT_assume \<open>0 =\<^sub>\<P> n\<close>
    AOT_hence \<open>\<exists>z ([\<P>]0z & [\<P>]nz)\<close>
      using assume1_2[unvarify x, OF zero_den, THEN "\<equiv>E"(1)] by blast
    then AOT_obtain a where \<open>[\<P>]0a & [\<P>]na\<close> using "\<exists>E"[rotated] by blast
    AOT_hence \<open>0 = n\<close>
      using pred_1_1_3[THEN df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2), THEN "\<forall>E"(1), OF zero_den,
                       THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>[\<P>]x 0\<close> using 0 "rule=E" id_sym by fast
    AOT_hence \<open>\<exists>x [\<P>]x 0\<close> by (rule "\<exists>I")
    AOT_hence \<open>\<exists>x [\<P>]x 0 & \<not>\<exists>x [\<P>]x 0\<close>
      by (metis no_pred_0_1 raa_cor_3)
  }
  ultimately AOT_have \<open>[[\<P>]\<^sup>*]0n\<close> by (metis con_dis_i_e_4_c raa_cor_1)
  AOT_hence \<open>\<exists>z ([[\<P>]\<^sup>+]0z & [\<P>]zn)\<close>
    using wances_her_7[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4,
                       unvarify x, OF zero_den, THEN "\<rightarrow>E"] by blast
  then AOT_obtain b where b_prop: \<open>[[\<P>]\<^sup>+]0b & [\<P>]bn\<close> using "\<exists>E"[rotated] by blast
  AOT_hence \<open>[\<nat>]b\<close> by (metis con_dis_i_e_2_a intro_elim_3_b nnumber_2)
  moreover AOT_have \<open>x = b\<close>
      using pred_1_1_3[THEN df_1_1_1[THEN "\<equiv>\<^sub>d\<^sub>fE"], THEN "&E"(2), THEN "\<forall>E"(2),
                       THEN "\<forall>E"(2), THEN "\<forall>E"(2), THEN "\<rightarrow>E", OF "&I", OF 0, OF b_prop[THEN "&E"(2)]].
  ultimately AOT_show \<open>[\<nat>]x\<close>
    using "rule=E" id_sym by fast
qed

AOT_theorem nat_card: \<open>[\<nat>]x \<rightarrow> NaturalCardinal(x)\<close>
proof(rule "\<rightarrow>I")
  AOT_have id_R_thm_3: \<open>Rigid\<^sub>1\<^sub>-\<^sub>1(\<R>) \<rightarrow> (x =\<^sub>\<R> y \<rightarrow> x = y)\<close> for x y \<R>
    using id_R_thm_3 "\<rightarrow>I" by blast
  AOT_assume \<open>[\<nat>]x\<close>
  AOT_hence \<open>[[\<P>]\<^sup>+]0x\<close>
    by (metis intro_elim_3_a nnumber_2)
  AOT_hence \<open>[[\<P>]\<^sup>*]0x \<or> 0 =\<^sub>\<P> x\<close>
    using assume1_4[unvarify x, OF zero_den, THEN "\<equiv>E"(1)] by blast
  moreover {
    AOT_assume \<open>[[\<P>]\<^sup>*]0x\<close>
    then AOT_obtain a where \<open>[\<P>]ax\<close>
      using anc_her_5[unvarify R x, OF zero_den, OF pred_denotes, THEN "\<rightarrow>E"] "\<exists>E"[rotated] by blast
    AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(x,F) & Numbers(a,[F]\<^sup>-\<^sup>u))\<close>
      using pred_thm_2[THEN "\<equiv>E"(1)] by blast
    then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(x,F) & Numbers(a,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
    then AOT_obtain u where \<open>O!u & ([F]u & Numbers(x,F) & Numbers(a,[F]\<^sup>-\<^sup>u))\<close> using "\<exists>E"[rotated] by blast
    AOT_hence \<open>NaturalCardinal(x)\<close>
      using eq_num_6[THEN "\<rightarrow>E"] "&E" by blast
  }
  moreover {
    AOT_assume \<open>0 =\<^sub>\<P> x\<close>
    AOT_hence \<open>0 = x\<close>
      using id_R_thm_3[unvarify \<R>, OF pred_denotes, THEN "\<rightarrow>E", OF pred_1_1_4,
                       unvarify x, OF zero_den, THEN "\<rightarrow>E"] by blast
    AOT_hence \<open>NaturalCardinal(x)\<close>
      by (metis "rule=E" zero_card)
  }
  ultimately AOT_show \<open>NaturalCardinal(x)\<close>
    by (metis con_dis_i_e_4_b raa_cor_1)
qed

AOT_theorem pred_func_1: \<open>[\<P>]xy & [\<P>]xz \<rightarrow> y = z\<close>
proof (rule "\<rightarrow>I"; frule "&E"(1); drule "&E"(2))
  AOT_assume \<open>[\<P>]xy\<close>
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using pred_thm_2[THEN "\<equiv>E"(1)] by blast
  then AOT_obtain F where \<open>\<exists>u ([F]u & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using "\<exists>E"[rotated] by blast
  then AOT_obtain a where Oa: \<open>O!a\<close> and a_prop: \<open>[F]a & Numbers(y,F) & Numbers(x,[F]\<^sup>-\<^sup>a)\<close>
    using "\<exists>E"[rotated] "&E" by blast
  AOT_assume \<open>[\<P>]xz\<close>
  AOT_hence \<open>\<exists>F\<exists>u ([F]u & Numbers(z,F) & Numbers(x,[F]\<^sup>-\<^sup>u))\<close>
    using pred_thm_2[THEN "\<equiv>E"(1)] by blast
  then AOT_obtain G where \<open>\<exists>u ([G]u & Numbers(z,G) & Numbers(x,[G]\<^sup>-\<^sup>u))\<close>
    using "\<exists>E"[rotated] by blast
  then AOT_obtain b where Ob: \<open>O!b\<close> and b_prop: \<open>[G]b & Numbers(z,G) & Numbers(x,[G]\<^sup>-\<^sup>b)\<close>
    using "\<exists>E"[rotated] "&E" by blast
  AOT_have \<open>[F]\<^sup>-\<^sup>a \<approx>\<^sub>E  [G]\<^sup>-\<^sup>b\<close>
    using num_tran_2[unvarify G H, OF F_minus_u_den, OF F_minus_u_den, THEN "\<rightarrow>E", OF "&I", OF
          a_prop[THEN "&E"(2)], OF b_prop[THEN "&E"(2)]].
  AOT_hence \<open>F \<approx>\<^sub>E G\<close>
    using P'_eq[OF Oa, OF Ob, THEN "\<rightarrow>E", OF "&I", OF "&I"]
          a_prop[THEN "&E"(1), THEN "&E"(1)] b_prop[THEN "&E"(1), THEN "&E"(1)] by blast
  AOT_thus \<open>y = z\<close>
    using pre_Hume[THEN "\<rightarrow>E", THEN "\<equiv>E"(2), OF "&I", OF a_prop[THEN "&E"(1), THEN "&E"(2)], OF b_prop[THEN "&E"(1), THEN "&E"(2)]]
    by blast
qed

AOT_theorem pred_func_2:
  assumes \<open>[\<nat>]n\<close> and \<open>[\<nat>]m\<close> and \<open>[\<nat>]k\<close>
  shows \<open>[\<P>]nm & [\<P>]nk \<rightarrow> m = k\<close>
  using pred_func_1.

AOT_axiom modal_axiom: \<open>\<exists>x([\<nat>]x & x = #G) \<rightarrow> \<diamond>\<exists>y([E!]y & \<forall>u (\<^bold>\<A>[G]u \<rightarrow> u \<noteq>\<^sub>E y))\<close>
  oops

end
