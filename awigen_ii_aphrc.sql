--=================================
-- Credential
--=================================
-- Created By:	Daniel Maina Nderitu
-- Project	:	MADIVA
-- Year		:	2023
-- Status	:	Data Assessment and Validation - AWIGEN II (Not yet - 5-6-2023)
-- Location	:	D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases\tables\MADIVA
--=================================
--=================================
USE [madiva]
GO

 -- ALTER TABLE awigen_ii add [PK] nvarchar(50) not null default newid()
 -- alter table [NCDIndicatorsData] alter column ind_id nvarchar(50) not null
-- delete from [dbo].[NCDIndicatorsData] where source='AWIGEN_II'
-- select * from [dbo].[NCDIndicatorsData] where source='AWIGEN_II'
-- ALTER TABLE [dbo].[madiva_nairobi] add [PK] nvarchar(50) not null default newid()
-- select * from [dbo].[madiva_nairobi]

/* Important codes
-111	biomarker - below level of accurate quantitation
-222	biomarker - above level of maximal quantitation
-555	missing values as a result of branchng logic
-999	true missing values

*/

BEGIN TRAN
DELETE madiva..NCDIndicatorsData
WHERE source='103'
COMMIT TRAN
GO

INSERT INTO [dbo].[NCDIndicatorsData]
           (record_id
,individual_id
,obs_date
,[source]
,hdss_name
,health_rating
,contracep
,trad_rx_12m
,trad_rx_ever
,stroke_fhx
,stroke_parents
,stroke_mom
,stroke_dad
,stroke_sibling
,stroke_children
,stroke_other
,epi_hx
,sex_ever
,sex_age_first
,visceral_fat
,sex_never_reason
,sex_partners_24m
,sex_4_money_ever
,sex_4_money_condom
,sex_violence
,sex_violence_nocondom
,sex_important_choose_partner
,sex_partners_no_ever
,sex_choose_start
,sex_no_condom_hiv_person
,adv_stp_alcohol
,adv_stp_smk
,asthma_ever
,asthma_mom
,asthma_dad
,tobac_ever
,tobac_cur
,tobac_daily
,tobac_freq
,tobac_freq_30d
,tobac_smkls_ever
,tobac_smkls_cur
,tobac_smkls_daily
,tobac_smkls_freq_cat
,adv_ex
,tobac_start_age_cat
,tobac_start_yr
,tobac_c_cig
,tobac_c_snf
,tobac_c_pi
,tobac_age_stp
,tobac_p_daily
,tobac_p_cig
,tobac_p_snf
,tobac_p_pi
,smk_start_yrs
,adv_wt_loss
,smk_stop
,smk_stop_days
,smk_stop_year
,angina_diag_year
,angina_ever
,angina_rx_ever
,angina_rx_current
,angina_rx_2w
,angina_rx_12m
,angina_rx_trad
,angina_walk_uphill
,angina_walk_ordinarily
,adv_change_diet
,angina_do_when_pain
,angina_stand
,angina_xp_leftarm
,angina_xp_lowerchest
,angina_xp_upperchest
,angina_symptoms_2w
,chest_pain
,angina_fhx
,angina_parents
,angina_mom
,subcutaneous_fat
,angina_dad
,angina_sibling
,angina_children
,angina_other
,hrt_fail
,hrt_fail_rx_ever
,hrt_fail_rx_current
,hrt_fail_rx_trad
,hrt_atck_year_diagnosed
,hrt_atck_ever
,hrt_atck_rx_ever
,num_child
,hrt_atck_rx_current
,hrt_atck_rx_trad
,hrt_other
,hrt_other_diag_year
,hrt_fhx
,hrt_parents
,hrt_mom
,hrt_dad
,hrt_sibling
,hrt_children
,hrt_fam_other
,preg
,alco_ever
,alco_12m
,alco_30d
,alco_cur
,alco_type

,alco_beer
,alco_wine
,alco_homebrew
,alco_spirit
,alco_other

,alco_freq
,alco_freq_12m
,alco_freq_30d
,alco_num_7d
,alco_num_drnk
,urine_preg_tst
,alco_bing_y
,alco_with_meals_30d
,alco_hangov
,alco_last_take
,alco_cutdwon
,drug_ever
,drugs_Injected
,alcohol_drugs_fam
,drnk_suc
,drnk_juice
,water_freq
,soft_drink_12m
,soft_drink_12m_freq
,sugar_add
,sugar_per_day
,sugar_tea_spoon
,preg_num_cat
,chol_measured
,chol_t_mmol
,chol_ever
,chol_dur
,chol_rx_ever
,chol_rx_cur
,chol_rx_2w
,chol_rx_trad
,chol_rx_wt_loss
,chol_rx_diet
,births
,chol_rx_phy_act
,chol_rx_other
,chol_fam
,chol_parents
,chol_mom
,chol_dad
,chol_sibling
,chol_children
,chol_fam_other
,ldl_mmol
,bg_mmol_fst
,hdl_mmol
,trigs_mmol
,actv_vpa
,actv_vpa_days
,actv_vpa_hrs
,actv_vpa_minutes
,actv_mpa
,actv_mpa_days
,actv_mpa_hrs
,actv_mpa_minutes
,insulin_fasting
,actv_mvpa
,actv_sitting_or_standing
,actv_walk_bicycle
,actv_walk_bicycle_days
,actv_walk_bicycle_hrs
,actv_walk_bicycle_min
,actv_vigorous_sports
,actv_vigorous_sports_days
,actv_vigorous_sports_hrs
,actv_vigorous_sports_min
,bg_mmol_random
,actv_moderate_sports
,actv_moderate_sports_days
,actv_moderate_sports_hrs
,actv_moderate_sports_min
,actv_sitting_hrs
,actv_sitting_min
,actv_sleeping_hrs
,mens_age_start
,mens_age_stop
,mens_today
,mens_stop_days
,mens_last_period_month
,mens_last_period_year
,pulse
,att_clinic_pub_ever
,att_clinic_priv_3m
,att_clinic_public_3m
,kidney_fail_hrd
,kidney_low_func
,kidney_fail_diag_year
,kidney_disease_ever
,kidney_rx
,kidney_test_ever
,kidney_fail_dur
,kidney_fail_fh
,bp_measured_ever
,kidney_fail_parents
,kidney_fail_mom
,kidney_fail_dad
,kidney_fail_sibling
,kidney_fail_children
,kidney_fail_other
,kidney_bladder_inf_ever
,kidney_bladder_inf_age
,kidney_bladder_inf_freq
,kidney_stones_ever
,bp_sys
,kidney_stones_age_cal
,kidney_stones_freq_cal
,kidney_stones_fh
,kidney_stones_parents
,kidney_stones_mom
,kidney_stones_dad
,kidney_stones_sibling
,kidney_stones_children
,kidney_problems
,kidney_stones_other
,hiv_counselled
,bp_dia
,hiv_tested
,hiv_tested_when_d
,hiv_tested_when_c
,hiv_tested_month
,hiv_tested_yr
,hiv_status_slf_rpt
,hiv_test_result
,hiv_care
,hiv_rx_ever
,hiv_rx_cur
,hpt_duration
,hpt_ever
,hiv_rx_trad_cur
,hiv_rx_trad_ever
,tb_year
,tb_ever
,tb_12m
,tb_dia_yr
,tb_rx_ever
,tb_rx_cur
,tb_rx_trad_cur
,tb_rx_trad_ever
,tb_counsel
,height_cm
,hpt_preg
,canc_brst_ever
,canc_any_ever
,canc_any_diag_year
,canc_cerv_ever
,canc_prost_ever
,canc_other_ever
,canc_other_cur
,canc_other_rx_ever
,canc_cerv_mother
,canc_prost_father
,canc_breast_mother
,std_trichomonas_ever
,hpt_12m
,std_genital_herpes
,std_syphilis
,std_chancroid
,std_pid
,bil_swim_river
,bil_bld_uri_ever
,bil_bld_uri_12m
,bil_test_ever
,bil_ever
,bil_rx_cur
,hpt_rx_current
,bil_rx_freq
,bil_urine_test_results
,fd_fruit_days
,fd_fruitservings
,fd_veg_days
,fd_veg_salt_cooking
,fd_veg_salt_eating
,fd_veg_servings
,fd_red_meat_freq
,fd_samosa
,fd_mandazi
,fd_chips_freq
,fd_fried_chicken
,fd_fried_fish
,fd_eat_drink_12h
,fd_oil_type
,fd_meals_outhome_ave
,hpt_rx_ever
,circumcised
,circumcised_age
,circumcised_when
,circumcised_where
,work_difficulty
,urine_sg
,urine_ph
,hpt_rx_2w
,urine_leuk
,urine_nit
,urine_pro
,urine_ket
,urine_ubg
,urine_ery
,egfr_epi
,egfr_epi_aa
,egfr_mdrd1
,egfr_cg1
,hpt_rx_12m
,egfr_cgbsa
,pi_acr
,schistosom
,avg_sleep
,obes_mom
,obes_dad
,malaria_ever
,malaria_ever_12m
,pesticide_xp
,pesticide_xp_region
,hpt_trad_ever
,thyroid_ever
,liver_dis_ever
,liver_dis_diag_year
,pp_neur
,poor_vision
,amputation
,body_swelling
,oedema
,other_comp
,diff_brthng_cur
,diff_brthng_ever
,hpt_rx_trad
,fever_cur
,anaemia
,dehydrated
,oedema_lvl
,convulsion
,injury
,any_rx_12h
,specimen_taken_h
,specimen_taken_m
,fd_diet_change
,hpt_rx_other
,chron_rx_ever
,chron_other_name
,chron_rx_cur
,hpt_adv_rd_Salt
,weight_kg
,hpt_adv_wt_loss
,hpt_adv_wt_loss_30d
,hpt_adv_stp_smk
,hpt_adv_stp_smk_30d
,hpt_adv_ex
,hpt_adv_ex_30d
,hpt_fhx
,hpt_other
,hpt_parents
,hpt_mom
,waist_cm
,hpt_dad
,hpt_sibling
,hpt_children
,diab_hx
,diab_12m
,diab_duration
,diab_rx_ever
,diab_rx_current
,diab_pills
,diab_insu
,bmi
,diab_insu_today
,diab_insu_2w
,diab_insu_12m
,diab_rx_wt_loss
,diab_rx_diet
,diab_rx_phy_act
,diab_rx_other
,diab_rx_2w
,diab_rx_12m
,diab_adv_wt_loss
,hip_cm
,diab_adv_stp_smk
,diab_adv_ex
,diab_rx_trad_ever
,diab_rx_trad_curr
,diab_measured
,diab_fhx
,diab_parents
,diab_mom
,diab_dad
,diab_sibling
,poc_hb
,diab_children
,diab_other_fam
,diab_rx_other_2w
,stroke_ever
,stroke_trans_isc_ever
,stroke_wkness
,stroke_numb
,stroke_paralysis_ever
,vision_problem
,stroke_blind
,stroke_hl_vis
,stroke_undstn
,stroke_verbal
,stroke_rx_ever
,stroke_rx_2w
,stroke_rx_12m
,stroke_rx_current
,stroke_rx_trad
,stroke_year_first
,stroke_interfere_daily_activity
,seizure

)
--select * from dbo.awigen_ii
select PK AS record_id
,study_id AS individual_id
,enrolment_date as obs_date   -- TODO: Will consult with the project team for this data (the person who extracted the data should resolve this - )
,'103' AS source
,'2' as hdss_name
,NULL AS health_rating
,NULL AS contracep
,NULL AS trad_rx_12m
,NULL AS trad_rx_ever
,NULL AS stroke_fhx
,NULL AS stroke_parents
,NULL AS stroke_mom
,NULL AS stroke_dad
,NULL AS stroke_sibling
,NULL AS stroke_children
,NULL AS stroke_other
,NULL AS epi_hx
,NULL AS sex_ever
,NULL AS sex_age_first

,CASE WHEN visceral_fat=-999 THEN -999  WHEN visceral_fat is not null THEN ROUND(visceral_fat, 2) WHEN visceral_fat is null THEN -999  END AS visceral_fat

,NULL AS sex_never_reason
,NULL AS sex_partners_24m
,NULL AS sex_4_money_ever
,NULL AS sex_4_money_condom
,NULL AS sex_violence
,NULL AS sex_violence_nocondom
,NULL AS sex_important_choose_partner
,NULL AS sex_partners_no_ever
,NULL AS sex_choose_start
,NULL AS sex_no_condom_hiv_person
,NULL AS adv_stp_alcohol
,NULL AS adv_stp_smk

,CASE WHEN asthma_diagnosed=0 THEN 0 WHEN asthma_diagnosed=1 THEN 1 WHEN asthma_diagnosed=2 THEN 333 WHEN asthma_diagnosed=3 THEN 444  WHEN asthma_diagnosed=-999 THEN 999  WHEN asthma_diagnosed=-555 THEN 888  WHEN asthma_diagnosed is null THEN 999 END AS asthma_ever -- TODO 9

,CASE WHEN asthma_mom=0 THEN 0 WHEN asthma_mom=1 THEN 1 WHEN asthma_mom=2 THEN 333 WHEN asthma_mom=3 THEN 444  WHEN asthma_mom=-999 THEN 999  WHEN asthma_mom=-555 THEN 888  WHEN asthma_mom is null THEN 999 END AS asthma_mom

,CASE WHEN asthma_dad=0 THEN 0 WHEN asthma_dad=1 THEN 1 WHEN asthma_dad=2 THEN 333 WHEN asthma_dad=3 THEN 444  WHEN asthma_dad=-999 THEN 999  WHEN asthma_dad=-555 THEN 888  WHEN asthma_dad is null THEN 999 END AS asthma_dad

,CASE WHEN tobacco_use=0 THEN 0 WHEN tobacco_use=1 THEN 1 WHEN tobacco_use=2 THEN 333 WHEN tobacco_use=3 THEN 444  WHEN tobacco_use=-999 THEN 999  WHEN tobacco_use=-555 THEN 888  WHEN tobacco_use is null THEN 999 END AS tobac_ever

,CASE WHEN tobacco_use!=1 THEN 888 WHEN current_smoker=0 THEN 0 WHEN current_smoker=1 THEN 1 WHEN current_smoker=2 THEN 333 WHEN current_smoker=3 THEN 444  WHEN current_smoker=-999 THEN 999  WHEN current_smoker=-555 THEN 888  WHEN current_smoker is null THEN 999 END AS tobac_cur

,NULL AS tobac_daily
,NULL AS tobac_freq
,NULL AS tobac_freq_30d

,CASE WHEN smokeless_tobacco_use=0 THEN 0 WHEN smokeless_tobacco_use=1 THEN 1 WHEN smokeless_tobacco_use=2 THEN 333 WHEN smokeless_tobacco_use=3 THEN 444  WHEN smokeless_tobacco_use=-999 THEN 999  WHEN smokeless_tobacco_use=-555 THEN 888  WHEN smokeless_tobacco_use is null THEN 999 END AS tobac_smkls_ever

,NULL AS tobac_smkls_cur
,NULL AS tobac_smkls_daily
,NULL AS tobac_smkls_freq_cat
,NULL AS adv_ex
,NULL AS tobac_start_age_cat
,NULL AS tobac_start_yr
,NULL AS tobac_c_cig
,NULL AS tobac_c_snf
,NULL AS tobac_c_pi
,NULL AS tobac_age_stp
,NULL AS tobac_p_daily
,NULL AS tobac_p_cig
,NULL AS tobac_p_snf
,NULL AS tobac_p_pi
,NULL AS smk_start_yrs
,NULL AS adv_wt_loss
,NULL AS smk_stop
,NULL AS smk_stop_days
,NULL AS smk_stop_year
,NULL AS angina_diag_year

,CASE WHEN angina=0 THEN 0 WHEN angina=1 THEN 1 WHEN angina=2 THEN 333 WHEN angina=3 THEN 444  WHEN angina=-999 THEN 999  WHEN angina=-555 THEN 888  WHEN angina is null THEN 999 END AS angina_ever

,NULL AS angina_rx_ever
,NULL AS angina_rx_current
,NULL AS angina_rx_2w
,NULL AS angina_rx_12m
,NULL AS angina_rx_trad
,NULL AS angina_walk_uphill
,NULL AS angina_walk_ordinarily
,NULL AS adv_change_diet
,NULL AS angina_do_when_pain
,NULL AS angina_stand
,NULL AS angina_xp_leftarm
,NULL AS angina_xp_lowerchest
,NULL AS angina_xp_upperchest
,NULL AS angina_symptoms_2w
,NULL AS chest_pain
,NULL AS angina_fhx
,NULL AS angina_parents
,NULL AS angina_mom

,CASE WHEN subcutaneous_fat is not null THEN  ROUND(subcutaneous_fat, 2) WHEN subcutaneous_fat=-999 THEN -999  WHEN subcutaneous_fat is null THEN -999 END AS subcutaneous_fat

,NULL AS angina_dad
,NULL AS angina_sibling
,NULL AS angina_children
,NULL AS angina_other

,CASE WHEN congestive_heart_failure=0 THEN 0 WHEN congestive_heart_failure=1 THEN 1 WHEN congestive_heart_failure=2 THEN 333 WHEN congestive_heart_failure=3 THEN 444  WHEN congestive_heart_failure=-999 THEN 999  WHEN congestive_heart_failure=-555 THEN 888  WHEN congestive_heart_failure is null THEN 999 END AS hrt_fail

,NULL AS hrt_fail_rx_ever
,NULL AS hrt_fail_rx_current
,NULL AS hrt_fail_rx_trad
,NULL AS hrt_atck_year_diagnosed

,CASE WHEN heartattack=0 THEN 0 WHEN heartattack=1 THEN 1 WHEN heartattack=2 THEN 333 WHEN heartattack=3 THEN 444  WHEN heartattack=-999 THEN 999  WHEN heartattack=-555 THEN 888  WHEN heartattack is null THEN 999 END AS hrt_atck_ever

,CASE WHEN heartattack_treat_ever=0 THEN 0 WHEN heartattack_treat_ever=1 THEN 1 WHEN heartattack_treat_ever=2 THEN 333 WHEN heartattack_treat_ever=3 THEN 444  WHEN heartattack_treat_ever=-999 THEN 999  WHEN heartattack_treat_ever=-555 THEN 888  WHEN heartattack_treat_ever is null THEN 999 END AS hrt_atck_rx_ever

,CASE WHEN number_of_children_c is not null THEN round(number_of_children_c,2) WHEN number_of_children_c=-999 THEN -999  WHEN number_of_children_c is null THEN -999 END AS num_child   -- TODO (what skip?)

,NULL AS hrt_atck_rx_current
,NULL AS hrt_atck_rx_trad
,NULL AS hrt_other
,NULL AS hrt_other_diag_year
,NULL AS hrt_fhx
,NULL AS hrt_parents
,NULL AS hrt_mom
,NULL AS hrt_dad
,NULL AS hrt_sibling
,NULL AS hrt_children
,NULL AS hrt_fam_other
,NULL AS preg

,CASE WHEN consume_alcohol=0 THEN 0 WHEN consume_alcohol=1 THEN 1 WHEN consume_alcohol=2 THEN 333 WHEN consume_alcohol=3 THEN 444  WHEN consume_alcohol=-999 THEN 999  WHEN consume_alcohol=-555 THEN 888  WHEN consume_alcohol is null THEN 999 END AS alco_ever

,NULL AS alco_12m
,NULL AS alco_30d

,CASE WHEN current_alcohol_consumer=0 THEN 0 WHEN current_alcohol_consumer=1 THEN 1 WHEN current_alcohol_consumer=2 THEN 333 WHEN current_alcohol_consumer=3 THEN 444  WHEN current_alcohol_consumer=-999 THEN 999  WHEN current_alcohol_consumer=-555 THEN 888  WHEN current_alcohol_consumer is null THEN 999 END AS alco_cur

,NULL AS alco_type

,NULL AS alco_beer
,NULL AS alco_wine
,NULL AS alco_homebrew
,NULL AS alco_spirit
,NULL AS alco_other

,NULL AS alco_freq
 ,NULL AS alco_freq_12m
,NULL AS alco_freq_30d
,NULL AS alco_num_7d
--1-Less than 1; 2-1-2; 3-3-4; 4-5 or more
,NULL AS  alco_num_drnk
,NULL AS urine_preg_tst

,CASE WHEN drinking_past_year=0 THEN 0 WHEN drinking_past_year=1 THEN 1 WHEN drinking_past_year=2 THEN 333 WHEN drinking_past_year=3 THEN 444  WHEN drinking_past_year=-999 THEN 999  WHEN drinking_past_year=-555 THEN 888  WHEN drinking_past_year is null THEN 999 END AS alco_bing_y

,NULL AS alco_with_meals_30d

,CASE WHEN had_hangover=0 THEN 0 WHEN had_hangover=1 THEN 1 WHEN had_hangover=2 THEN 333 WHEN had_hangover=3 THEN 444  WHEN had_hangover=-999 THEN 999  WHEN had_hangover=-555 THEN 888  WHEN had_hangover is null THEN 999 END AS alco_hangov

,NULL AS alco_last_take

,CASE WHEN consider_alcohol_cutdown=0 THEN 0 WHEN consider_alcohol_cutdown=1 THEN 1 WHEN consider_alcohol_cutdown=2 THEN 333 WHEN consider_alcohol_cutdown=3 THEN 444  WHEN consider_alcohol_cutdown=-999 THEN 999  WHEN consider_alcohol_cutdown=-555 THEN 888  WHEN consider_alcohol_cutdown is null THEN 999 END AS alco_cutdwon

,CASE WHEN drugs_use=0 THEN 0 WHEN drugs_use=1 THEN 1 WHEN drugs_use=2 THEN 333 WHEN drugs_use=3 THEN 444  WHEN drugs_use=-999 THEN 999  WHEN drugs_use=-555 THEN 888  WHEN drugs_use is null THEN 999 END AS drug_ever

,NULL AS drugs_Injected
,NULL AS alcohol_drugs_fam

,CASE WHEN sugar_drinks is not null THEN sugar_drinks WHEN sugar_drinks=-999 THEN -999  WHEN sugar_drinks is null THEN -999 END AS drnk_suc

,CASE WHEN juice is not null THEN juice WHEN juice=-999 THEN -999  WHEN juice is null THEN -999 END AS drnk_juice

,NULL AS water_freq
,NULL AS soft_drink_12m
,NULL AS soft_drink_12m_freq
,NULL AS sugar_add
,NULL AS sugar_per_day
,NULL AS sugar_tea_spoon
--1-one; 2-two; 3-three; 4-more than three
,
CASE 
WHEN number_of_pregnancies=1 THEN 1 
WHEN number_of_pregnancies=2 THEN 2 
WHEN number_of_pregnancies=3 THEN 3 
WHEN number_of_pregnancies>3 THEN 4 
WHEN number_of_pregnancies=-555 THEN 888 
WHEN number_of_pregnancies=-999 or number_of_pregnancies is null THEN 999  
END AS preg_num_cat

,NULL AS chol_measured
,NULL AS chol_t_mmol
,NULL AS chol_ever
,NULL AS chol_dur
,
CASE 
WHEN h_cholesterol=-999 THEN 888 
WHEN h_cholesterol=1 AND chol_treatment_ever=1 THEN 1 
WHEN h_cholesterol=1 AND chol_treatment_ever=0 THEN 0 
WHEN h_cholesterol=1 AND chol_treatment_ever IS NULL THEN NULL 
WHEN h_cholesterol IS NULL THEN NULL 
WHEN chol_treatment_ever=-555 THEN 888 
END AS chol_rx_ever

,NULL AS chol_rx_cur
,NULL AS chol_rx_2w
,NULL AS chol_rx_trad
,NULL AS chol_rx_wt_loss
,NULL AS chol_rx_diet

,CASE WHEN number_of_live_births is not null THEN round(number_of_live_births,2) WHEN number_of_live_births=-999 THEN -999  WHEN number_of_live_births is null THEN -999 END AS births

,NULL AS chol_rx_phy_act
,NULL AS chol_rx_other
,NULL AS chol_fam
,NULL AS chol_parents

,CASE WHEN h_cholesterol_mom=-555 THEN 888 
		      WHEN h_cholesterol_mom=2 THEN 333 
			  WHEN h_cholesterol_mom=3 THEN 444 
			  WHEN h_cholesterol_mom=-999 THEN 999
			  WHEN h_cholesterol_mom IS NULL THEN 999
			  ELSE h_cholesterol_mom END AS chol_mom

,CASE WHEN h_cholesterol_dad=-555 THEN 888
		      WHEN h_cholesterol_dad=2 THEN 333 
			  WHEN h_cholesterol_dad=3 THEN 444 
			  WHEN h_cholesterol_dad=-999 THEN 999
			  WHEN h_cholesterol_dad IS NULL THEN 999
			  ELSE h_cholesterol_dad END AS chol_dad

,NULL AS chol_sibling
,NULL AS chol_children
,NULL AS chol_fam_other

,CASE WHEN friedewald_ldl_c is not null THEN round(friedewald_ldl_c,2) WHEN friedewald_ldl_c=-999 THEN -999  WHEN friedewald_ldl_c is null THEN -999 END AS ldl_mmol -- not sure (ldl to )
,CASE WHEN glucose_result is not null THEN round(glucose_result,2) WHEN glucose_result=-999 THEN -999  WHEN glucose_result is null THEN -999 END AS bg_mmol_fst 
,CASE WHEN hdl is not null THEN round(hdl,2) WHEN hdl=-999 THEN -999  WHEN hdl is null THEN -999 END AS hdl_mmol
,CASE WHEN triglycerides is not null THEN round(triglycerides,2) WHEN triglycerides=-999 THEN -999  WHEN triglycerides is null THEN -999 END AS trigs_mmol

,NULL AS actv_vpa
,NULL AS actv_vpa_days
,NULL AS actv_vpa_hrs
,NULL AS actv_vpa_minutes
,NULL AS actv_mpa
,NULL AS actv_mpa_days
,NULL AS actv_mpa_hrs
,NULL AS actv_mpa_minutes

,CASE WHEN insulin_result is not null THEN round(insulin_result,2) WHEN insulin_result=-999 THEN -999  WHEN insulin_result is null THEN -999 END AS insulin_fasting
,CASE WHEN mvpa_c is not null THEN round(mvpa_c,2) WHEN mvpa_c=-999 THEN 999  WHEN mvpa_c is null THEN 999 END AS actv_mvpa 

,NULL AS actv_sitting_or_standing
,NULL AS actv_walk_bicycle
,NULL AS actv_walk_bicycle_days
,NULL AS actv_walk_bicycle_hrs
,NULL AS actv_walk_bicycle_min
,NULL AS actv_vigorous_sports
,NULL AS actv_vigorous_sports_days
,NULL AS actv_vigorous_sports_hrs
,NULL AS actv_vigorous_sports_min
,NULL AS bg_mmol_random
,NULL AS actv_moderate_sports
,NULL AS actv_moderate_sports_days
,NULL AS actv_moderate_sports_hrs
,NULL AS actv_moderate_sports_min
,NULL AS actv_sitting_hrs
,NULL AS actv_sitting_min
,NULL AS actv_sleeping_hrs
,NULL AS mens_age_start
,NULL AS mens_age_stop
,NULL AS mens_today
,NULL as mens_stop_days
---555 Not Applicable ---999 Missing
, CASE
        WHEN LEN(last_period_c) = 7
            AND SUBSTRING(last_period_c, 3, 1) = '-'
            AND ISNUMERIC(LEFT(last_period_c, 2)) = 1
            AND ISNUMERIC(RIGHT(last_period_c, 4)) = 1
            AND CAST(LEFT(last_period_c, 2) AS INT) BETWEEN 1 AND 12
        THEN LEFT(last_period_c, 2)    WHEN last_period_c='-555' THEN '888' WHEN last_period_c='-999' THEN '999'
		END AS mens_last_period_month
	,CASE
        WHEN LEN(last_period_c) = 7
            AND SUBSTRING(last_period_c, 3, 1) = '-'
            AND ISNUMERIC(LEFT(last_period_c, 2)) = 1
            AND ISNUMERIC(RIGHT(last_period_c, 4)) = 1
            AND CAST(LEFT(last_period_c, 2) AS INT) BETWEEN 1 AND 12
        THEN RIGHT(last_period_c, 4) WHEN last_period_c='-555' THEN '888' WHEN last_period_c='-999' THEN '999'
		END AS   mens_last_period_year

--select last_period_c from madiva..awigen_ii

,CASE WHEN pulse_average is not null THEN round(pulse_average,2) WHEN pulse_average=-999 THEN -999  WHEN pulse_average is null THEN -999 END AS pulse

,NULL AS att_clinic_pub_ever
,NULL AS att_clinic_priv_3m
,NULL AS att_clinic_public_3m
,NULL AS kidney_fail_hrd
,NULL AS kidney_low_func
,NULL AS kidney_fail_diag_year

,CASE WHEN kidney_disease=0 THEN 0 WHEN kidney_disease=1 THEN 1 WHEN kidney_disease=2 THEN 333 WHEN kidney_disease=3 THEN 444  WHEN kidney_disease=-999 THEN 999  WHEN kidney_disease=-555 THEN 888  WHEN kidney_disease is null THEN 999 END AS kidney_disease_ever

,NULL AS kidney_rx
,NULL AS kidney_test_ever
,NULL AS kidney_fail_dur
,NULL AS kidney_fail_fh
,NULL AS bp_measured_ever
,NULL AS kidney_fail_parents
,NULL AS kidney_fail_mom
,NULL AS kidney_fail_dad
,NULL AS kidney_fail_sibling
,NULL AS kidney_fail_children
,NULL AS kidney_fail_other
,NULL AS kidney_bladder_inf_ever
,NULL AS kidney_bladder_inf_age
,NULL AS kidney_bladder_inf_freq
,NULL AS kidney_stones_ever

,CASE WHEN bp_sys_average is not null THEN round(bp_sys_average, 2) WHEN bp_sys_average=-999 THEN -999  WHEN bp_sys_average is null THEN -999  END AS bp_sys

,NULL AS kidney_stones_age_cal
,NULL AS kidney_stones_freq_cal
,NULL AS kidney_stones_fh
,NULL AS kidney_stones_parents
,NULL AS kidney_stones_mom
,NULL AS kidney_stones_dad
,NULL AS kidney_stones_sibling
,NULL AS kidney_stones_children
,NULL AS kidney_problems
,NULL AS kidney_stones_other
,NULL AS hiv_counselled

,CASE WHEN bp_dia_average is not null THEN round(bp_dia_average,2) WHEN bp_dia_average=-999 THEN -999  WHEN bp_dia_average is null THEN -999  END AS bp_dia

,NULL AS hiv_tested
,NULL AS hiv_tested_when_d
,NULL AS hiv_tested_when_c
,NULL AS hiv_tested_month
,NULL AS hiv_tested_yr

,CASE WHEN hiv_positive=0 THEN 0 WHEN hiv_positive=1 THEN 1 WHEN hiv_positive=2 THEN 333 WHEN hiv_positive=3 THEN 444  WHEN hiv_positive=-999 THEN 999  WHEN hiv_positive=-555 THEN 888  WHEN hiv_positive is null THEN 999 END AS hiv_status_slf_rpt
,NULL AS hiv_test_result  --CASE WHEN hiv_final_status_c=0 THEN 0 WHEN hiv_final_status_c=1 THEN 1 WHEN hiv_final_status_c=2 THEN 333 WHEN hiv_final_status_c=3 THEN 444  WHEN hiv_final_status_c=-999 THEN 999  WHEN hiv_final_status_c=-555 THEN 888  WHEN hiv_final_status_c is null THEN 999 END

,NULL AS hiv_care
,NULL AS hiv_rx_ever
,CASE WHEN hiv_arv_meds_now=0 THEN 0 WHEN hiv_arv_meds_now=1 THEN 1 WHEN hiv_arv_meds_now=2 THEN 333 WHEN hiv_arv_meds_now=3 THEN 444  WHEN hiv_arv_meds_now=-999 THEN 999  WHEN hiv_arv_meds_now=-555 THEN 888  WHEN hiv_arv_meds_now is null THEN 999 END AS hiv_rx_cur
,NULL AS hpt_duration

,CASE WHEN hypertension=0 THEN 0 WHEN hypertension=1 THEN 1 WHEN hypertension=2 THEN 333 WHEN hypertension=-999 THEN 999 WHEN hypertension is NULL THEN 999 END AS hpt_ever

,NULL AS hiv_rx_trad_cur
,NULL AS hiv_rx_trad_ever
,NULL AS tb_year
,CASE WHEN tb=0 THEN 0 WHEN tb=1 THEN 1 WHEN tb=2 THEN 333 WHEN tb=3 THEN 444  WHEN tb=-999 THEN 999  WHEN tb=-555 THEN 888  WHEN tb is null THEN 999 END AS tb_ever 
,CASE WHEN tb_12months=0 THEN 0 WHEN tb_12months=1 THEN 1 WHEN tb_12months=2 THEN 333 WHEN tb_12months=3 THEN 444  WHEN tb_12months=-999 THEN 999  WHEN tb_12months=-555 THEN 888  WHEN tb_12months is null THEN 999 END AS tb_12m
,NULL AS tb_dia_yr
,CASE WHEN tb_treatment=0 THEN 0 WHEN tb_treatment=1 THEN 1 WHEN tb_treatment=2 THEN 333 WHEN tb_treatment=3 THEN 444  WHEN tb_treatment=-999 THEN 999  WHEN tb_treatment=-555 THEN 888  WHEN tb_treatment is null THEN 999 END AS tb_rx_ever 
,CASE WHEN tb_meds=0 THEN 0 WHEN tb_meds=1 THEN 1 WHEN tb_meds=2 THEN 333 WHEN tb_meds=3 THEN 444  WHEN tb_meds=-999 THEN 999  WHEN tb_meds=-555 THEN 888  WHEN tb_meds is null THEN 999 END AS tb_rx_cur
,NULL AS tb_rx_trad_cur
,NULL AS tb_rx_trad_ever
,NULL AS tb_counsel
,CASE WHEN standing_height=-999 THEN -999  WHEN standing_height is null THEN -999 WHEN standing_height is not null THEN round(standing_height, 2)/10  END AS height_cm
,NULL AS hpt_preg
,CASE WHEN breast_cancer=0 THEN 0 WHEN breast_cancer=1 THEN 1 WHEN breast_cancer=2 THEN 333 WHEN breast_cancer=3 THEN 444  WHEN breast_cancer=-999 THEN 999  WHEN breast_cancer=-555 THEN 888  WHEN breast_cancer is null THEN 999 END AS canc_brst_ever


,NULL AS canc_any_ever
,NULL AS canc_any_diag_year

,CASE WHEN cervical_cancer=0 THEN 0 WHEN cervical_cancer=1 THEN 1 WHEN cervical_cancer=2 THEN 333 WHEN cervical_cancer=3 THEN 444  WHEN cervical_cancer=-999 THEN 999  WHEN cervical_cancer=-555 THEN 888  WHEN cervical_cancer is null THEN 999 END AS canc_cerv_ever
,CASE WHEN prostate_cancer=0 THEN 0 WHEN prostate_cancer=1 THEN 1 WHEN prostate_cancer=2 THEN 333 WHEN prostate_cancer=3 THEN 444  WHEN prostate_cancer=-999 THEN 999  WHEN prostate_cancer=-555 THEN 888  WHEN prostate_cancer is null THEN 999 END AS canc_prost_ever
,CASE WHEN other_cancers=0 THEN 0 WHEN other_cancers=1 THEN 1 WHEN other_cancers=2 THEN 333 WHEN other_cancers=3 THEN 444  WHEN other_cancers=-999 THEN 999  WHEN other_cancers=-555 THEN 888  WHEN other_cancers is null THEN 999 END AS canc_other_ever
,NULL AS canc_other_cur
,NULL AS canc_other_rx_ever
,CASE WHEN cervical_cancer_mom=0 THEN 0 WHEN cervical_cancer_mom=1 THEN 1 WHEN cervical_cancer_mom=2 THEN 333 WHEN cervical_cancer_mom=3 THEN 444  WHEN cervical_cancer_mom=-999 THEN 999  WHEN cervical_cancer_mom=-555 THEN 888  WHEN cervical_cancer_mom is null THEN 999 END AS canc_cerv_mother
,CASE WHEN prostate_cancer_dad=0 THEN 0 WHEN prostate_cancer_dad=1 THEN 1 WHEN prostate_cancer_dad=2 THEN 333 WHEN prostate_cancer_dad=3 THEN 444  WHEN prostate_cancer_dad=-999 THEN 999  WHEN prostate_cancer_dad=-555 THEN 888  WHEN prostate_cancer_dad is null THEN 999 END AS canc_prost_father
,CASE WHEN breast_cancer_mom=0 THEN 0 WHEN breast_cancer_mom=1 THEN 1 WHEN breast_cancer_mom=2 THEN 333 WHEN breast_cancer_mom=3 THEN 444  WHEN breast_cancer_mom=-999 THEN 999  WHEN breast_cancer_mom=-555 THEN 888  WHEN breast_cancer_mom is null THEN 999 END AS canc_breast_mother
,NULL AS std_trichomonas_ever
,CASE WHEN hypertension!=1 THEN 888   WHEN hypertension_12months_yn=-999 THEN 999  WHEN hypertension_12months_yn is null THEN 999 WHEN hypertension_12months_yn=0 THEN 0 WHEN hypertension_12months_yn=1 THEN 1 WHEN hypertension_12months_yn=2 THEN 333 END AS hpt_12m

,NULL AS std_genital_herpes
,NULL AS std_syphilis
,NULL AS std_chancroid
,NULL AS std_pid
,NULL AS bil_swim_river
,NULL AS bil_bld_uri_ever
,NULL AS bil_bld_uri_12m
,NULL AS bil_test_ever
,NULL AS bil_ever
,NULL AS bil_rx_cur

,CASE WHEN hypertension_meds_current=0 THEN 0 WHEN hypertension_meds_current=1 THEN 1 WHEN hypertension_meds_current=2 THEN 333 WHEN hypertension_meds_current=3 THEN 444  WHEN hypertension_meds_current=-999 THEN 999  WHEN hypertension_meds_current=-555 THEN 888  WHEN hypertension_meds_current is null THEN 999 END AS hpt_rx_current
,NULL AS bil_rx_freq
,NULL AS bil_urine_test_results
,CASE WHEN days_fruit=0 THEN 0 WHEN days_fruit=1 THEN 1 WHEN days_fruit=2 THEN 333 WHEN days_fruit=3 THEN 444  WHEN days_fruit=-999 THEN 999  WHEN days_fruit=-555 THEN 888  WHEN days_fruit is null THEN -999 END AS fd_fruit_days
,CASE WHEN fruit_servings is not null THEN fruit_servings WHEN fruit_servings=-999 THEN -999  WHEN fruit_servings is null THEN -999 END AS fd_fruitservings 
,CASE WHEN days_veg is not null THEN days_veg WHEN days_veg=-999 THEN -999  WHEN days_veg is null THEN -999 END AS fd_veg_days 
,NULL AS fd_veg_salt_cooking
,NULL AS fd_veg_salt_eating

 ,CASE WHEN  veg_servings is not null THEN veg_servings WHEN veg_servings=-999 THEN -999 WHEN veg_servings=9999 THEN -999  WHEN veg_servings is null THEN -999 WHEN veg_servings=9997 THEN -444 END AS  fd_veg_servings

,NULL AS fd_red_meat_freq
,NULL AS fd_samosa
,NULL AS fd_mandazi
,NULL AS fd_chips_freq
,NULL AS fd_fried_chicken
,NULL AS fd_fried_fish
,NULL AS fd_eat_drink_12h
,NULL AS fd_oil_type
,NULL AS fd_meals_outhome_ave

,CASE WHEN hypertension_treat_ever=0 THEN 0 WHEN hypertension_treat_ever=1 THEN 1 WHEN hypertension_treat_ever=2 THEN 333 WHEN hypertension_treat_ever=-999 THEN 999  WHEN hypertension_treat_ever=-555 THEN 888  WHEN hypertension_treat_ever is null THEN 999 END AS hpt_rx_ever

,NULL AS circumcised
,NULL AS circumcised_age
,NULL AS circumcised_when
,NULL AS circumcised_where
,NULL AS work_difficulty
,NULL AS urine_sg
,NULL AS urine_ph
,NULL AS hpt_rx_2w
,NULL AS urine_leuk
,NULL AS urine_nit
,NULL AS urine_pro
,NULL AS urine_ket
,NULL AS urine_ubg
,NULL AS urine_ery
,NULL AS egfr_epi
,NULL AS egfr_epi_aa
,NULL AS egfr_mdrd1
,NULL AS egfr_cg1
,NULL AS hpt_rx_12m
,NULL AS egfr_cgbsa
,NULL AS pi_acr
,NULL AS schistosom

,NULL AS avg_sleep  -- Awigen 1 (CASE WHEN avg_sleep_per_night_c is not null THEN round(avg_sleep_per_night_c,2) WHEN avg_sleep_per_night_c=-999 THEN -999  WHEN avg_sleep_per_night_c is null THEN -999 END AS avg_sleep)
,CASE WHEN obesity_mom=0 THEN 0 WHEN obesity_mom=1 THEN 1 WHEN obesity_mom=2 THEN 333 WHEN obesity_mom=3 THEN 444  WHEN obesity_mom=-999 THEN 999  WHEN obesity_mom=-555 THEN 888  WHEN obesity_mom is null THEN 999 END AS obes_mom
,CASE WHEN obesity_dad=0 THEN 0 WHEN obesity_dad=1 THEN 1 WHEN obesity_dad=2 THEN 333 WHEN obesity_dad=3 THEN 444  WHEN obesity_dad=-999 THEN 999  WHEN obesity_dad=-555 THEN 888  WHEN obesity_dad is null THEN 999 END AS obes_dad
,CASE WHEN malaria=0 THEN 0 WHEN malaria=1 THEN 1 WHEN malaria=2 THEN 333 WHEN malaria=3 THEN 444  WHEN malaria=-999 THEN 999  WHEN malaria=-555 THEN 888  WHEN malaria is null THEN 999 END AS malaria_ever
,CASE WHEN malaria_month=0 THEN 0 WHEN malaria_month=1 THEN 1 WHEN malaria_month=2 THEN 333 WHEN malaria_month=3 THEN 444  WHEN malaria_month=-999 THEN 999  WHEN malaria_month=-555 THEN 888  WHEN malaria_month is null THEN 999 END AS malaria_ever_12m 
,CASE WHEN pesticide=0 THEN 0 WHEN pesticide=1 THEN 1 WHEN pesticide=2 THEN 333 WHEN pesticide=3 THEN 444  WHEN pesticide=-999 THEN 999  WHEN pesticide=-555 THEN 888  WHEN pesticide is null THEN 999 END AS pesticide_xp
,CASE WHEN region_pesticide=0 THEN 0 WHEN region_pesticide=1 THEN 1 WHEN region_pesticide=2 THEN 333 WHEN region_pesticide=3 THEN 444  WHEN region_pesticide=-999 THEN 999  WHEN region_pesticide=-555 THEN 888  WHEN region_pesticide is null THEN 999 END AS pesticide_xp_region
,NULL AS hpt_trad_ever
,CASE WHEN thyroid=0 THEN 0 WHEN thyroid=1 THEN 1 WHEN thyroid=2 THEN 333 WHEN thyroid=3 THEN 444  WHEN thyroid=-999 THEN 999  WHEN thyroid=-555 THEN 888  WHEN thyroid is null THEN 999 END AS thyroid_ever

,NULL AS liver_dis_ever
,NULL AS liver_dis_diag_year
,NULL AS pp_neur
,NULL AS poor_vision
,NULL AS amputation
,NULL AS body_swelling
,NULL AS oedema
,NULL AS other_comp
,NULL AS diff_brthng_cur
,NULL AS diff_brthng_ever

,CASE WHEN hypertension!=1 THEN 888 WHEN hypertension_trad_meds=1 THEN 1 WHEN hypertension_trad_meds=0 THEN 0 WHEN hypertension_trad_meds=2 THEN 333 WHEN hypertension_trad_meds=-999 THEN 999 END AS hpt_rx_trad

,NULL AS fever_cur
,NULL AS anaemia
,NULL AS dehydrated
,NULL AS oedema_lvl
,NULL AS convulsion
,NULL AS injury
,NULL AS any_rx_12h
,NULL AS specimen_taken_h
,NULL AS specimen_taken_m
,NULL AS fd_diet_change
,NULL AS hpt_rx_other
,NULL AS chron_rx_ever
,NULL AS chron_other_name
,NULL AS chron_rx_cur
,NULL AS hpt_adv_rd_Salt

,CASE WHEN weight is not null THEN round(weight, 2) WHEN weight=-999 THEN -999  WHEN weight is null THEN -999 END AS weight_kg

,NULL AS hpt_adv_wt_loss
,NULL AS hpt_adv_wt_loss_30d
,NULL AS hpt_adv_stp_smk
,NULL AS hpt_adv_stp_smk_30d
,NULL AS hpt_adv_ex
,NULL AS hpt_adv_ex_30d
,NULL AS hpt_fhx
,NULL AS hpt_other
,NULL AS hpt_parents

,CASE WHEN h_blood_pressure_mom=0 THEN 0 WHEN h_blood_pressure_mom=1 THEN 1 WHEN h_blood_pressure_mom=2 THEN 333 WHEN h_blood_pressure_mom=-999 THEN 999  WHEN h_blood_pressure_mom=-555 THEN 888  WHEN h_blood_pressure_mom is null THEN 999 END AS hpt_mom

--waist was measured in mm (AWIGEN)
,CASE WHEN waist_circumference is not null THEN round(waist_circumference,2)/10.0 WHEN waist_circumference=-999 THEN -999  WHEN waist_circumference is null THEN -999 END AS waist_cm

,CASE WHEN h_blood_pressure_dad=0 THEN 0 WHEN h_blood_pressure_dad=1 THEN 1 WHEN h_blood_pressure_dad=2 THEN 333 WHEN h_blood_pressure_dad=3 THEN 444  WHEN h_blood_pressure_dad=-999 THEN 999  WHEN h_blood_pressure_dad=-555 THEN 888  WHEN h_blood_pressure_dad is null THEN 999 END AS hpt_dad
,NULL AS hpt_sibling
,NULL AS hpt_children

,CASE WHEN diabetes='0' THEN 0 WHEN diabetes='1' THEN 1 WHEN diabetes='2' THEN 333 WHEN diabetes=3 THEN 444  WHEN diabetes=-999 THEN 999  WHEN diabetes=-555 THEN 888  WHEN diabetes is null THEN 999 END AS diab_hx

,CASE WHEN diabetes is null THEN 999 WHEN diabetes!=1 THEN 888 WHEN diabetes_12months=0 THEN 0 WHEN diabetes_12months=1 THEN 1 WHEN diabetes_12months=2 THEN 333 WHEN diabetes_12months=3 THEN 444  WHEN diabetes_12months=-999 THEN 999  WHEN diabetes_12months=-555 THEN 888  WHEN diabetes_12months is null THEN 999 END AS diab_12m

,NULL AS diab_duration
,CASE WHEN diabetes_treatment=0 THEN 0 WHEN diabetes_treatment=1 THEN 1 WHEN diabetes_treatment=2 THEN 333 WHEN diabetes_treatment=3 THEN 444  WHEN diabetes_treatment=-999 THEN 999  WHEN diabetes_treatment=-555 THEN 888  WHEN diabetes_treatment is null THEN 999 END AS diab_rx_ever
,NULL AS diab_rx_current

,CASE WHEN diabetes is null THEN 999 WHEN diabetes_treat_pills=0 THEN 0 WHEN diabetes_treat_pills=1 THEN 1 WHEN diabetes_treat_pills=-999 THEN 999  WHEN diabetes_treat_pills=-555 THEN 888  WHEN diabetes_treat_pills is null THEN 999 END AS diab_pills

,CASE WHEN diabetes is null THEN 999  WHEN diabetes_treat_insulin=0 THEN 0 WHEN diabetes_treat_insulin=1 THEN 1 WHEN diabetes_treat_insulin=2 THEN 333 WHEN diabetes_treat_insulin=3 THEN 444  WHEN diabetes_treat_insulin=-999 THEN 999  WHEN diabetes_treat_insulin=-555 THEN 888  WHEN diabetes_treat_insulin is null THEN 999 END AS diab_insu

,CASE WHEN bmi_c is not null THEN round(bmi_c, 2) WHEN bmi_c=-999 THEN -999 WHEN bmi_c is null THEN -999   END AS bmi
,NULL AS diab_insu_today
,NULL AS diab_insu_2w
,NULL AS diab_insu_12m

,CASE WHEN diabetes is null THEN 999 WHEN diabetes_treat_weight_loss=0 THEN 0 WHEN diabetes_treat_weight_loss=1 THEN 1 WHEN diabetes_treat_weight_loss=2 THEN 333 WHEN diabetes_treat_weight_loss=3 THEN 444  WHEN diabetes_treat_weight_loss=-999 THEN 999  WHEN diabetes_treat_weight_loss=-555 THEN 888  WHEN diabetes_treat_weight_loss is null THEN 999 END AS diab_rx_wt_loss

,CASE WHEN diabetes_treat_diet=0 THEN 0 WHEN diabetes_treat_diet=1 THEN 1 WHEN diabetes_treat_diet=2 THEN 333 WHEN diabetes_treat_diet=3 THEN 444  WHEN diabetes_treat_diet=-999 THEN 999  WHEN diabetes_treat_diet=-555 THEN 888  WHEN diabetes_treat_diet is null THEN 999 END AS diab_rx_diet
,NULL AS diab_rx_phy_act
,NULL AS diab_rx_other
,NULL AS diab_rx_2w
,NULL AS diab_rx_12m
,NULL AS diab_adv_wt_loss
,CASE WHEN hip_circumference=-999 THEN -999  WHEN hip_circumference is null THEN -999 WHEN hip_circumference is not null THEN hip_circumference/10  END AS hip_cm
,NULL AS diab_adv_stp_smk
,NULL AS diab_adv_ex
,NULL AS diab_rx_trad_ever
,NULL AS diab_rx_trad_curr
,NULL AS diab_measured
,CASE WHEN diabetes_history=0 THEN 0 WHEN diabetes_history=1 THEN 1 WHEN diabetes_history=2 THEN 333 WHEN diabetes_history=3 THEN 444  WHEN diabetes_history=-999 THEN 999  WHEN diabetes_history=-555 THEN 888  WHEN diabetes_history is null THEN 999 END AS diab_fhx 
,NULL AS diab_parents
,CASE WHEN diabetes_mother=0 THEN 0 WHEN diabetes_mother=1 THEN 1 WHEN diabetes_mother=2 THEN 333 WHEN diabetes_mother=3 THEN 444  WHEN diabetes_mother=-999 THEN 999  WHEN diabetes_mother=-555 THEN 888  WHEN diabetes_mother is null THEN 999 END AS diab_mom
,CASE WHEN diabetes_father=0 THEN 0 WHEN diabetes_father=1 THEN 1 WHEN diabetes_father=2 THEN 333 WHEN diabetes_father=3 THEN 444  WHEN diabetes_father=-999 THEN 999  WHEN diabetes_father=-555 THEN 888  WHEN diabetes_father is null THEN 999 END AS diab_dad
,NULL AS diab_sibling
,NULL AS poc_hb
,NULL AS diab_children
,NULL AS diab_other_fam
,NULL AS diab_rx_other_2w
,CASE WHEN stroke=0 THEN 0 WHEN stroke=1 THEN 1 WHEN stroke=2 THEN 333 WHEN stroke=3 THEN 444  WHEN stroke=-999 THEN 999  WHEN stroke=-555 THEN 888  WHEN stroke is null THEN 999 END AS stroke_ever
,CASE WHEN transient_ischemic_attack=0 THEN 0 WHEN transient_ischemic_attack=1 THEN 1 WHEN transient_ischemic_attack=2 THEN 333 WHEN transient_ischemic_attack=3 THEN 444  WHEN transient_ischemic_attack=-999 THEN 999  WHEN transient_ischemic_attack=-555 THEN 888  WHEN transient_ischemic_attack is null THEN 999 END AS stroke_trans_isc_ever
,CASE WHEN weakness=0 THEN 0 WHEN weakness=1 THEN 1 WHEN weakness=2 THEN 333 WHEN weakness=3 THEN 444  WHEN weakness=-999 THEN 999  WHEN weakness=-555 THEN 888  WHEN weakness is null THEN 999 END AS stroke_wkness
,CASE WHEN numbness=0 THEN 0 WHEN numbness=1 THEN 1 WHEN numbness=2 THEN 333 WHEN numbness=3 THEN 444  WHEN numbness=-999 THEN 999  WHEN numbness=-555 THEN 888  WHEN numbness is null THEN 999 END AS stroke_numb
,NULL AS stroke_paralysis_ever
,NULL AS vision_problem
,CASE WHEN blindness=0 THEN 0 WHEN blindness=1 THEN 1 WHEN blindness=2 THEN 333 WHEN blindness=3 THEN 444  WHEN blindness=-999 THEN 999  WHEN blindness=-555 THEN 888  WHEN blindness is null THEN 999 END AS stroke_blind
,CASE WHEN half_vision_loss=0 THEN 0 WHEN half_vision_loss=1 THEN 1 WHEN half_vision_loss=2 THEN 333 WHEN half_vision_loss=3 THEN 444  WHEN half_vision_loss=-999 THEN 999  WHEN half_vision_loss=-555 THEN 888  WHEN half_vision_loss is null THEN 999 END AS stroke_hl_vis
,CASE WHEN understanding_loss=0 THEN 0 WHEN understanding_loss=1 THEN 1 WHEN understanding_loss=2 THEN 333 WHEN understanding_loss=3 THEN 444  WHEN understanding_loss=-999 THEN 999  WHEN understanding_loss=-555 THEN 888  WHEN understanding_loss is null THEN 999 END AS stroke_undstn
,CASE WHEN expression_loss=0 THEN 0 WHEN expression_loss=1 THEN 1 WHEN expression_loss=2 THEN 333 WHEN expression_loss=3 THEN 444  WHEN expression_loss=-999 THEN 999  WHEN expression_loss=-555 THEN 888  WHEN expression_loss is null THEN 999 END AS stroke_verbal
,NULL AS stroke_rx_ever
,NULL AS stroke_rx_2w
,NULL AS stroke_rx_12m
,NULL AS stroke_rx_current
,NULL AS stroke_rx_trad
,NULL AS stroke_year_first
,NULL AS stroke_interfere_daily_activity
,NULL as seizure

from madiva..awigen_ii


--select * from madiva..NCDIndicatorsData

