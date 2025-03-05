# Author:   Daniel Maina Nderitu
# Purpose:  Data Processing R-Script

library(dplyr)
library(ggplot2)
library(haven)
library(dslabs)
library(VennDiagram)
library(lubridate)
library(ComplexUpset)
library(tidyverse)

# Reading my stata file (Load raw data)
ncd_indicators <- read_dta("D:/APHRC/GoogleDrive_ii/data_science/madiva/DMAC/databases/ncd_indicators/NCDs_and_individuals_no_nulls.dta")
# Add a column (year)
ncd_indicators$year <- year(ncd_indicators$obs_date)
bp_data_ncds <- ncd_indicators %>% drop_na(bp_sys, bp_dia, obs_date)
# Ensure year column exists
bp_data_ncds <- bp_data_ncds %>%
  mutate(year = year(obs_date))  # Extract year from date column

vital_stats <- read_dta("D:/APHRC/GoogleDrive_ii/data_science/madiva/Project_1/Clinic_link/data/merged_data/vital_signs_cleaned_hdss_participants.dta")
bp_data <- vital_stats %>% drop_na(bp_sys, bp_dia, visitdate)
# Ensure year column exists
bp_data <- bp_data %>%
  mutate(year = year(visitdate))  # Extract year from date column


# Remove place holder values (9997, 9999) and replace with NA
ncd_indicators <- ncd_indicators %>%
  mutate(
    bg_mmol_fst = ifelse(bg_mmol_fst %in% c(9997, 9999), NA, bg_mmol_fst),
    bg_mmol_random = ifelse(bg_mmol_random %in% c(9997, 9999), NA, bg_mmol_random)
  )

# Processing conditions of interest
ncd_indicators <- ncd_indicators %>%
  mutate(
    hypertension = ifelse(hpt_ever == 1 | hpt_rx_ever == 1 | hpt_12m == 1 | bp_sys >= 140 | bp_dia >= 90, 1, 0),
    diabetes = ifelse(diab_hx == 1 | diab_12m == 1 | diab_rx_ever == 1 | diab_rx_current == 1 | diab_rx_other == 1 | diab_rx_2w == 1 | diab_rx_12m == 1 | diab_rx_trad_curr == 1 | diab_rx_other_2w == 1 | bg_mmol_fst >= 7.0 | bg_mmol_random >= 6.9, 1, 0),
    ckd = ifelse(kidney_rx == 1 | pi_acr >= 1.5, 1, 0),
    cvd = ifelse(hrt_fail_rx_current == 1 | hrt_fail_rx_trad == 1 | hrt_atck_ever == 1 | hrt_fail == 1 | hrt_fail_rx_ever == 1 | angina_rx_2w == 1 | angina_rx_12m == 1 | angina_rx_trad == 1 | angina_rx_current == 1 | angina_rx_ever == 1 | angina_ever == 1 | stroke_ever == 1 | stroke_numb == 1  | stroke_wkness == 1 |  stroke_paralysis_ever == 1 | stroke_blind == 1 | stroke_trans_isc_ever == 1 | hrt_other == 1 | hrt_atck_rx_trad == 1 | hrt_atck_rx_current == 1 | hrt_atck_rx_ever == 1 | hrt_atck_ever == 1 | hrt_fail_rx_trad == 1 | hrt_fail_rx_ever == 1 | hrt_fail_rx_current == 1, 1, 0), # 
    
  ) # | eGFR <= 45 


# Check missingness and case counts
missing_summary <- ncd_indicators %>%
  summarise(
    Hypertension_Missing = sum(is.na(hypertension)),
    Diabetes_Missing = sum(is.na(diabetes)),
    CKD_Missing = sum(is.na(ckd)),
    cvd_Missing = sum(is.na(cvd)),
  )

print(missing_summary)

condition_counts <- ncd_indicators %>%
  summarise(
    Hypertension_Present = sum(hypertension == 1, na.rm = TRUE),
    Diabetes_Present = sum(diabetes == 1, na.rm = TRUE),
    CKD_Present = sum(ckd == 1, na.rm = TRUE),
    cvd_Present = sum(cvd == 1, na.rm = TRUE),
  )

print(condition_counts)

# Count multimorbidity cases
multi_conditions <- ncd_indicators %>%
  group_by(individual_id) %>%
  summarise(
    hypertension = ifelse(all(is.na(hypertension)), NA, max(hypertension, na.rm = TRUE)),
    diabetes = ifelse(all(is.na(diabetes)), NA, max(diabetes, na.rm = TRUE)),
    ckd = ifelse(all(is.na(ckd)), NA, max(ckd, na.rm = TRUE)),
    cvd = ifelse(all(is.na(cvd)), NA, max(cvd, na.rm = TRUE)),
  ) %>%
  mutate(multimorbidity = rowSums(across(hypertension:cvd), na.rm = TRUE))

multimorbidity_count <- table(multi_conditions$multimorbidity)

print(multimorbidity_count)

# Count individuals per multimorbidity level
multi_summary <- multi_conditions %>%
  count(multimorbidity) %>%
  mutate(percentage = n / sum(n) * 100)

# Select only the condition columns
conditions_data <- ncd_indicators %>%
  select(individual_id, hypertension, diabetes, ckd, cvd, year) %>%
  mutate(across(hypertension:cvd, ~ ifelse(is.na(.), 0, .)))  # Replace NAs with 0 OR "# Convert condition variables to binary (0 or 1) and replace NA with 0"

# Remove the individual_id column before plotting
# conditions_data <- select(conditions_data, -individual_id)


# select(-individual_id)  # Remove ID column if present

# Ensure the dataset is numeric
conditions_data <- as.data.frame(conditions_data)

# Convert data to long format (needed for ComplexUpset)
upset_data_long <- multi_conditions %>%
  select(individual_id, hypertension, diabetes, ckd, cvd) %>%
  pivot_longer(-individual_id, names_to = "Condition", values_to = "Presence") %>%
  filter(Presence == 1) %>%  # Only keep cases where the condition is present
  pivot_wider(names_from = "Condition", values_from = "Presence", values_fill = 0)

# Count number of people with each multimorbidity level
multimorbidity_counts <- multi_conditions %>%
  count(multimorbidity) %>%
  mutate(percentage = (n / sum(n)) * 100)  # Calculate percentage

# Original data plus year columns
df_wide <- ncd_indicators %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = year, values_from = value, values_fill = list(value = 0))

# Number of unique persons in NCD Indicators dataset
print("Unique individuals :"  ) 
length(unique(ncd_indicators$individual_id)) 

# Save each dataset separately as .RData
save(missing_summary, condition_counts, multi_conditions, multi_summary, conditions_data, upset_data_long, multimorbidity_counts, df_wide, vital_stats, bp_data, bp_data_ncds, file = "madiva_processed_datasets.RData")
