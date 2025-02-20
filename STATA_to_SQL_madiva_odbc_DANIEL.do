// Author:		Daniel Maina Nderitu
// Project:		MADIVA
//Open Database Connectivity (ODBC) 
clear all
set more off
set maxvar 15000
//load the data
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
cd "D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases"
use "D:\Daniels\1_Data_Madiva\Improving the lives of diabetics\wdfbaseline_cleaned.dta", clear
compress
odbc list
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//
// Improving the lives of diabetics (DIABETES)
odbc insert, table("wdfbaseline_cleaned") dsn("madiva_system") create
use "D:\Daniels\1_Data_Madiva\Improving the lives of diabetics\wdffollowup_cleaned.dta"
odbc insert, table("wdffollowup_cleaned") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//AWIGEN I
// odbc insert, table("wdfbaseline_cleaned") dsn("MadivaDB") create
// import excel "D:\Daniels\1_Data_Madiva\AWI-Gen\EGA_Nairobi_dataset_v0_1.xlsx", sheet("EGA_Nairobi_dataset_v0_1") firstrow clear
use "D:\Daniels\1_Data_Madiva\AWI-Gen\2023\madiva_nairobi.dta", clear
odbc insert, table("awigen_i") dsn("madiva_system") create

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//AWIGEN II
// odbc insert, table("wdfbaseline_cleaned") dsn("MadivaDB") create
// import excel "D:\Daniels\1_Data_Madiva\AWI-Gen\EGA_Nairobi_dataset_v0_1.xlsx", sheet("EGA_Nairobi_dataset_v0_1") firstrow clear
use "D:\Daniels\1_Data_Madiva\AWI-Gen\data_2025\awigen_ii.dta", clear
odbc insert, table("awigen_ii") dsn("madiva_system") create

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Context of HIV infection
use "D:\Daniels\1_Data_Madiva\context_of_hiv_infection\HIV_data_final.dta", clear
odbc insert, table("context_of_hiv_infection") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Assessing linkages
use "D:\Daniels\1_Data_Madiva\cvds_ncds_assessing_linkages\CVD Main_data.dta", clear
odbc insert, table("assess_link_main") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\cvds_ncds_assessing_linkages\Alcohol Validation.dta", clear
odbc insert, table("assess_link_alcohol") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Epina (Todo OR to-do)
use "D:\Daniels\1_Data_Madiva\epina\epina.dta", clear
odbc insert, table("epina") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Scaleup
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\Clinic_baseline.dta", clear
odbc insert, table("SU_Clinic_baseline") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\Clinic_endline.dta"
odbc insert, table("SU_Clinic_endline") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\First_clinic.dta", clear
odbc insert, table("SU_First_clinic") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\Followup_clinic.dta", clear
odbc insert, table("SU_Followup_clinic") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\Population_baseline.dta", clear
odbc insert, table("SU_Population_baseline") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\Population_endline.dta", clear
odbc insert, table("SU_Population_endline") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Vaccination Registration
use "D:\Daniels\1_Data_Madiva\vaccinationregistration_anon.dta", clear
odbc insert, table("vaccinationregistration_anon") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\vaccinationregistrations_anon_2018.dta", clear
odbc insert, table("vaccinationregistrations_anon_2018") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Household ammenities (STATA to SQL) - HH SES
//Household possession and food security
//------------------------------------------------------------------------------
//deanonymization (social group id)
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\hhamenities_hhpossessions_allhhds_wealth_foodsec_povline_anon_2018.dta", clear

// Anonimizing Household ID
ren hha_hhid_anon socialgroupid_anon
merge m:1 socialgroupid_anon using "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta"
// use "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta", clear

ren socialgroupid_anon socialgroupid_guid
ren socialgroupid_anonUPTOr37 socialgroupid_intid
drop if _merge==2
drop _merge

label variable socialgroupid_guid "Socialgroup GUID"
label variable socialgroupid "Socialgroup ID - Site specific"
label variable socialgroupid_intid "Socialgroup Integer ID"

format hha_intvwdate %td
gen hha_intvwdate2 = string(hha_intvwdate,"%tdCCYY-NN-DD")
drop hha_intvwdate
ren hha_intvwdate2 hha_intvwdate

//Insert in SQL Server
odbc insert, table("hh_possession_foodsec") dsn("madiva_system") create

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

// Only household possession
use "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\hhamenities_hhpossessions_anon_2015_2018.dta", clear

// Anonimizing Household ID
ren hha_hhid_anon socialgroupid_anon
merge m:1 socialgroupid_anon using "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta"
// use "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta", clear

ren socialgroupid_anon socialgroupid_guid
ren socialgroupid_anonUPTOr37 socialgroupid_intid
drop if _merge==2
drop _merge

label variable socialgroupid_guid "Socialgroup GUID"
label variable socialgroupid "Socialgroup ID - Site specific"


// Format date variables
local date_var hha_intvwdate hha_hhh_datebirth 
foreach m of local date_var {
    local mcode = `mcode' + 1
    display "`mcode': `m'"
	
	format `m' %td
	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
	drop `m'
	rename `m'2 `m'
}

odbc insert, table("hh_possession_only") dsn("madiva_system") create

//------------------------------------------------------------------------------
//DE-ANONYMIZATION WORK (TO-DO)
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//Individuals
use "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\individual_characteristics_anon_2018.dta", clear
local date_var ind_datebirth ind_datedeath ind_dateintodsa ind_dateoutofdsa
foreach m of local date_var {
    local mcode = `mcode' + 1
    display "`mcode': `m'"
	
	format `m' %td
	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
	drop `m'
	rename `m'2 `m'
}
//De-anonymize individual's IDs [Individual Mother and Father]
//******************************************************************************
//deanonymization (mother id)
ren ind_momindividualid_anon individualid_anon
merge m:1 individualid_anon using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID.dta"

ren individualid_anon mother_guid
ren individualid ind_motherid
ren individualid_anonUPTOr37 ind_mother_intid
drop if _merge==2
drop _merge

label variable mother_guid "Mother GUID"
label variable ind_motherid "Mother ID - Site specific"
label variable ind_mother_intid "Mother Integer ID"
//------------------------------------------------------------------------------
//deanonymization (father id)
//------------------------------------------------------------------------------
ren ind_popindividualid_anon individualid_anon
merge m:1 individualid_anon using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID.dta"

ren individualid_anon father_guid
ren individualid ind_fatherid
ren individualid_anonUPTOr37 ind_father_intid
drop if _merge==2
drop _merge

label variable father_guid "Father GUID"
label variable ind_fatherid "Father ID - Site specific"
label variable ind_father_intid "Father Integer ID"

//------------------------------------------------------------------------------
//deanonymization (Individual id)
//------------------------------------------------------------------------------
ren ind_individualid_anon individualid_anon
merge m:1 individualid_anon using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID.dta"

ren individualid_anon individual_guid
ren individualid indid
ren individualid_anonUPTOr37 individual_intid
drop if _merge==2
drop _merge

label variable individual_guid "Individual GUID"
label variable indid "Individual ID - Site specific"
label variable individual_intid "Individual Integer ID"

//******************************************************************************
//Insert in SQL Server
odbc insert, table("individual_characteristics_anon_X_2018") dsn("madiva_system") create

//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************
//------------------------------------------------------------------------------
//MEMBERSHIP DATA
//------------------------------------------------------------------------------
import delimited "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\server_data\Membership.csv", delimiter(comma) bindquote(strict) varnames(1) clear

// Format date variables (long string to a shorter string)
gen short_mem_startdate = substr(mem_startdate, 1, 10)
drop mem_startdate
ren short_mem_startdate mem_startdate
// list mem_startdate short_mem_startdate
gen short_mem_enddate = substr(mem_enddate, 1, 10)
drop mem_enddate
ren short_mem_enddate mem_enddate
// list mem_enddate short_mem_enddate
gen short_mem_entrydate = substr(mem_entrydate, 1, 10)
drop mem_entrydate
ren short_mem_entrydate mem_entrydate
// list mem_entrydate short_mem_entrydate
gen short_mem_dateupdated = substr(mem_dateupdated, 1, 10)
drop mem_dateupdated
ren short_mem_dateupdated mem_dateupdated
// list mem_dateupdated short_mem_dateupdated
//------------------------------------------------------------------------------
//deanonymization (Individual id)
//------------------------------------------------------------------------------
ren mem_individualid individualid_anonUPTOr37
merge m:1 individualid_anonUPTOr37 using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID_refined.dta"

ren ïmem_id mem_id

ren proxy_individualid_anon individual_guid
ren proxy_individualid indid
ren individualid_anonUPTOr37 individual_intid
drop if _merge==2
drop _merge

label variable individual_guid "Individual GUID"
label variable indid "Individual ID - Site specific"
label variable individual_intid "Individual Integer ID"

//------------------------------------------------------------------------------
//deanonymization (social group id)
//------------------------------------------------------------------------------
ren mem_socialgroupid socialgroupid_anonUPTOr37
merge m:1 socialgroupid_anonUPTOr37 using "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta"

ren socialgroupid_anon socialgroupid_guid
ren socialgroupid_anonUPTOr37 socialgroupid_intid
drop if _merge==2
drop _merge

label variable socialgroupid_guid "Socialgroup GUID"
label variable socialgroupid "Socialgroup ID - Site specific"
label variable socialgroupid_intid "Socialgroup Integer ID"

//******************************************************************************
//Insert in SQL Server
odbc insert, table("membership") dsn("madiva_system") create
//------------------------------------------------------------------------------
//*******************************************************************************
//**************************Household********************************************
//*******************************************************************************
//Household
import delimited "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\server_data\social_group.csv", delimiter(comma) bindquote(strict) varnames(1) clear
//------------------------------------------------------------------------------
// ren res_individualid individ
// Format date variables (long string to a shorter string)
gen short_sgp_supervisordate = substr(sgp_supervisordate, 1, 10)
drop sgp_supervisordate
ren short_sgp_supervisordate sgp_supervisordate
// Format date variables (long string to a shorter string)
gen short_sgp_officecheckerdate = substr(sgp_officecheckerdate, 1, 10)
drop sgp_officecheckerdate
ren short_sgp_officecheckerdate sgp_officecheckerdate
// Format date variables (long string to a shorter string)
gen short_sgp_entrydate = substr(sgp_entrydate, 1, 10)
drop sgp_entrydate
ren short_sgp_entrydate sgp_entrydate
// Format date variables (long string to a shorter string)
gen short_sgp_dateupdated = substr(sgp_dateupdated, 1, 10)
drop sgp_dateupdated
ren short_sgp_dateupdated sgp_dateupdated
//------------------------------------------------------------------------------
ren sgp_headid individualid_anonUPTOr37
merge m:1 individualid_anonUPTOr37 using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID_refined.dta"

ren proxy_individualid_anon hhhid_guid
ren proxy_individualid hhhid
drop if _merge==2
drop _merge

label variable hhhid_guid "Socialgroup GUID"
label variable hhhid "Socialgroup ID - Site specific"
label variable sgp_socialgroupid "Socialgroup Integer ID"

ren individualid_anonUPTOr37 sgp_headid
label variable sgp_socialgroupid "Socialgroup householdhead ID"

save "dss_households.dta", replace
//******************************************************************************
//Insert in SQL Server
odbc insert, table("households") dsn("madiva_system") create
// save "social_group.dta", replace
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Verbal Autopsy
//------------------------------------------------------------------------------
// Harmonised VA (Insert)
use "D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases\VA\Harmonised_VA_data.dta", clear
odbc insert, table("VA_harmonised") dsn("madiva_system") create

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

// Only household possession
use "D:\Daniels\1_Data_Madiva\VA\Verbalautopsy_2002-2015.dta", clear

// Format date variables
// local date_var hha_intvwdate hha_hhh_datebirth 
// foreach m of local date_var {
//     local mcode = `mcode' + 1
//     display "`mcode': `m'"
//	
// 	format `m' %td
// 	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
// 	drop `m'
// 	rename `m'2 `m'
// }

odbc insert, table("VA_2002_2015") dsn("madiva_system") create

//VA Two
use "D:\Daniels\1_Data_Madiva\VA\verbalautopsy_symptoms_anon.dta", clear

// Format date variables
// local date_var hha_intvwdate hha_hhh_datebirth 
// foreach m of local date_var {
//     local mcode = `mcode' + 1
//     display "`mcode': `m'"
//	
// 	format `m' %td
// 	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
// 	drop `m'
// 	rename `m'2 `m'
// }

odbc insert, table("VA_ii") dsn("madiva_system") create


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Residency - the smaller file
use "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\server_data\deanonymized_residency.dta", clear 
odbc insert, table("deanonymized_residency") dsn("madiva_system") create


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Residency DATA - 4.5 GBs
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\residency_cov_anon_portal_2018.dta", clear

// Format date variables
local date_var res_eventdate res_datebeg res_hhh_datebirth res_datebirth
foreach m of local date_var {
    local mcode = `mcode' + 1
    display "`mcode': `m'"
	
	format `m' %td
	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
	drop `m'
	rename `m'2 `m'
}


//******************************************************************************
//Insert in SQL Server
odbc insert, table("residency_raw") dsn("madiva_system") create
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Verbal Autopsy (VA)
use "D:\Daniels\1_Data_Madiva\VA\verbalautopsy_symptoms_anon.dta", clear
// Work on dates
local date_var vau_intvwdate vau_datebirth vau_datedeath
foreach m of local date_var {
    local mcode = `mcode' + 1
    display "`mcode': `m'"
	
	format `m' %td
	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
	drop `m'
	rename `m'2 `m'
}

odbc insert, table("verbalautopsy_symptoms_anon") dsn("madiva_system") create
//------------------------------------------------------------------------------
use "D:\Daniels\1_Data_Madiva\VA\Verbalautopsy_2002-2015.dta", clear

// Work on dates
local date_var vau_datebirth vau_datedeath vau_intvwdate
foreach m of local date_var {
    local mcode = `mcode' + 1
    display "`mcode': `m'"
	
	format `m' %td
	gen `m'2 = string(`m',"%tdCCYY-NN-DD")
	drop `m'
	rename `m'2 `m'
}

odbc insert, table("Verbalautopsy_2002_2015") dsn("madiva_system") create




// // Format date variables (long string to a shorter string)
// gen short_mem_startdate = substr(mem_startdate, 1, 10)
// drop mem_startdate
// ren short_mem_startdate mem_startdate
// // list mem_startdate short_mem_startdate
// gen short_mem_enddate = substr(mem_enddate, 1, 10)
// drop mem_enddate
// ren short_mem_enddate mem_enddate
// // list mem_enddate short_mem_enddate
// gen short_mem_entrydate = substr(mem_entrydate, 1, 10)
// drop mem_entrydate
// ren short_mem_entrydate mem_entrydate
// // list mem_entrydate short_mem_entrydate
// gen short_mem_dateupdated = substr(mem_dateupdated, 1, 10)
// drop mem_dateupdated
// ren short_mem_dateupdated mem_dateupdated
// // list mem_dateupdated short_mem_dateupdated
// //------------------------------------------------------------------------------
// //deanonymization (Individual id)
// //------------------------------------------------------------------------------
// ren mem_individualid individualid_anonUPTOr37
// merge m:1 individualid_anonUPTOr37 using "D:\Daniels\1_Data_Madiva\SCALE_UP_cvds_sustainable_model_for_cv_health\anonymizers\ANONYMIZER_INDIVIDUALID_refined.dta"
//
// ren ïmem_id mem_id
//
// ren proxy_individualid_anon individual_guid
// ren proxy_individualid indid
// ren individualid_anonUPTOr37 individual_intid
// drop if _merge==2
// drop _merge
//
// label variable individual_guid "Individual GUID"
// label variable indid "Individual ID - Site specific"
// label variable individual_intid "Individual Integer ID"
//
// //------------------------------------------------------------------------------
// //deanonymization (social group id)
// //------------------------------------------------------------------------------
// ren mem_socialgroupid socialgroupid_anonUPTOr37
// merge m:1 socialgroupid_anonUPTOr37 using "D:\Daniels\1_Data_Madiva\anonymizers\ANONYMIZER_SOCIALGROUPID_cleaned.dta"
//
// ren socialgroupid_anon socialgroupid_guid
// ren socialgroupid_anonUPTOr37 socialgroupid_intid
// drop if _merge==2
// drop _merge
//
// label variable socialgroupid_guid "Socialgroup GUID"
// label variable socialgroupid "Socialgroup ID - Site specific"
// label variable socialgroupid_intid "Socialgroup Integer ID"



// Event Confirmation
. import delimited "D:\Daniels\1_Data_Madiva\NUHDSS_work\dss data\server_data\Eventconfirmation.csv", delimiter(comma) bindquote(strict) varnames(1) clear 



odbc insert, table("Eventconfirmation") dsn("madiva_system") create











