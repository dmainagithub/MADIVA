# Load necessary libraries
library(dplyr)
library(ggplot2)
library(dslabs)
library(haven)
library(VennDiagram)
library(UpSetR)

set.seed(123)  # For reproducibility
# Define the output filenames
pdf_file <- "multimorbidity_analysis.pdf"
# Reading my stata file
ncd_indicators <- read_dta("D:/APHRC/GoogleDrive_ii/data_science/madiva/DMAC/databases/ncd_indicators/NCDs_and_individuals_no_nulls.dta")

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
    diabetes = ifelse(diab_hx == 1 | diab_12m == 1 | diab_rx_ever == 1 | diab_rx_current == 1 | diab_rx_other == 1 | diab_rx_2w == 1 | diab_rx_12m == 1 | diab_rx_trad_curr == 1 | diab_rx_other_2w == 1 | bg_mmol_fst >= 126 | bg_mmol_random >= 200, 1, 0),
    ckd = ifelse(kidney_rx == 1 | pi_acr >= 1.5, 1, 0),
    stroke = ifelse(stroke_ever == 1 | stroke_numb == 1 | stroke_wkness == 1 | stroke_paralysis_ever == 1 | stroke_blind == 1 | stroke_trans_isc_ever == 1, 1, 0), 
    heart_disease = ifelse(hrt_other == 1 | hrt_atck_rx_trad == 1 | hrt_atck_rx_current == 1 | hrt_atck_rx_ever == 1 | hrt_atck_ever == 1 | hrt_fail_rx_trad == 1 | hrt_fail_rx_ever == 1 | hrt_fail_rx_current == 1, 1, 0),
  ) # | eGFR <= 45 

# Check missingness and case counts
missing_summary <- ncd_indicators %>%
  summarise(
    Hypertension_Missing = sum(is.na(hypertension)),
    Diabetes_Missing = sum(is.na(diabetes)),
    CKD_Missing = sum(is.na(ckd)),
    stroke_Missing = sum(is.na(stroke)),
    heart_disease_Missing = sum(is.na(heart_disease)),
  )

print(missing_summary)

condition_counts <- ncd_indicators %>%
  summarise(
    Hypertension_Present = sum(hypertension == 1, na.rm = TRUE),
    Diabetes_Present = sum(diabetes == 1, na.rm = TRUE),
    CKD_Present = sum(ckd == 1, na.rm = TRUE),
    stroke_Present = sum(stroke == 1, na.rm = TRUE),
    heart_disease_Present = sum(heart_disease == 1, na.rm = TRUE)
  )

print(condition_counts)

# Count multimorbidity cases
multi_conditions <- ncd_indicators %>%
  group_by(individual_id) %>%
  summarise(
    hypertension = ifelse(all(is.na(hypertension)), NA, max(hypertension, na.rm = TRUE)),
    diabetes = ifelse(all(is.na(diabetes)), NA, max(diabetes, na.rm = TRUE)),
    ckd = ifelse(all(is.na(ckd)), NA, max(ckd, na.rm = TRUE)),
    stroke = ifelse(all(is.na(stroke)), NA, max(stroke, na.rm = TRUE)),
    heart_disease  = ifelse(all(is.na(heart_disease)), NA, max(heart_disease, na.rm = TRUE))
  ) %>%
  mutate(multimorbidity = rowSums(across(hypertension:heart_disease), na.rm = TRUE))

multimorbidity_count <- table(multi_conditions$multimorbidity)

print(multimorbidity_count)

# Count individuals per multimorbidity level
multi_summary <- multi_conditions %>%
  count(multimorbidity) %>%
  mutate(percentage = n / sum(n) * 100)
# =============================================================================
# =============================================================================
# Plot with both Count and Percentage
multi_plot <- ggplot(multi_summary, aes(x = factor(multimorbidity), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +  # Count Labels
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = 1.5, size = 3, color = "white") +  # Percentage Labels
  labs(title = "Distribution of Multimorbidity",
       x = "Number of Chronic Conditions",
       y = "Count of Individuals") +
  theme_minimal()

# Display the plot
print(multi_plot)

ggsave("combined_mm_plot.png", plot = multi_plot, width = 7, height = 5, dpi = 300)
# =============================================================================
# =============================================================================
# Venn Diagram to show overlap
venn.diagram(
  x = list(
    Hypertension = which(multi_conditions$hypertension == 1),
    Diabetes = which(multi_conditions$diabetes == 1),
    CKD = which(multi_conditions$ckd == 1),
    stroke = which(multi_conditions$stroke == 1),
    heart_disease = which(multi_conditions$heart_disease == 1)
  ),
  category.names = c("Hypertension", "Diabetes", "CKD", "Stroke", "heart_disease"),
  filename = "venn_diagram.png",
  output = TRUE,
  fill = c("red", "blue", "green", "yellow", "brown")
)

# =============================================================================
# =============================================================================
# Upset plot
# Select only the condition columns
conditions_data <- multi_conditions %>%
  select(hypertension, diabetes, ckd, stroke, heart_disease) # , asthma

# Convert condition variables to binary (0 or 1) and replace NA with 0
conditions_data <- conditions_data %>%
  mutate(across(hypertension:heart_disease, ~ ifelse(is.na(.), 0, .)))
  # select(-individual_id)  # Remove ID column if present

# Ensure the dataset is numeric
conditions_data <- as.data.frame(conditions_data)
# =============================================================================
# =============================================================================
# Define PNG output file
png_file <- "upset_plot.png"

# Step 2: **Save the plot as a PNG**
png(png_file, width = 8, height = 6, units = "in", res = 300)  # Open PNG device
upset(conditions_data, sets = colnames(conditions_data), 
      order.by = "freq", 
      mainbar.y.label = "Number of Individuals", 
      sets.x.label = "Number of People with Condition",
      sets.bar.color = c("red", "blue", "green", "purple", "orange"),  # Custom colors for sets
      text.scale = 1.2)
dev.off()  # Close the PNG device
# =============================================================================
# =============================================================================
# =============================================================================
# Save as PDF
# =============================================================================
# Step 3: **Save Multiple Plots in a PDF**
pdf(pdf_file, width = 8, height = 6)

# Plot 1: UpSet Plot
upset(conditions_data, sets = colnames(conditions_data), 
      order.by = "freq", 
      mainbar.y.label = "Number of Individuals", 
      sets.x.label = "Number of People with Condition",
      sets.bar.color = c("red", "blue", "green", "purple", "orange"),  # Custom colors for sets
      text.scale = 1.2)

# Plot 2: Bar Plot - Customized Colors
ggplot(multi_conditions, aes(x = multimorbidity, fill = factor(multimorbidity))) +
  geom_bar() +
  scale_fill_manual(values = c("red", "blue", "green", "purple", "orange")) +  # Custom colors
  labs(title = "Multimorbidity Distribution",
       x = "Number of Chronic Conditions",
       y = "Count") +
  theme_minimal()

# # Plot 3: Boxplot - Blood Glucose by Multimorbidity
# ggplot(ncd_indicators, aes(x = factor(multimorbidity), y = bg_mmol_fst, fill = factor(multimorbidity))) +
#   geom_boxplot() +
#   scale_fill_manual(values = c("red", "blue", "green", "purple", "orange")) +  # Custom colors
#   labs(title = "Blood Glucose Levels by Multimorbidity Count",
#        x = "Multimorbidity Count",
#        y = "Blood Glucose Level") +
#   theme_minimal()

# Close the PDF device
dev.off()

# Confirm saved files
print(paste("UpSet plot saved as:", png_file))
print(paste("All plots saved in PDF:", pdf_file))

# =============================================================================
# =============================================================================
# Conditions count
# Count number of people with each multimorbidity level
multimorbidity_counts <- multi_conditions %>%
  count(multimorbidity) %>%
  mutate(percentage = (n / sum(n)) * 100)  # Calculate percentage
  
# Define colors for each bar
color_palette <- c("gray", "blue", "green", "purple", "orange", "red")  

# Create the bar plot
multimorbidity_plot <- ggplot(multimorbidity_counts, aes(x = factor(multimorbidity), y = n, fill = factor(multimorbidity))) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = color_palette) +  
  labs(title = "Number of People with 0-5 Chronic Conditions",
       x = "Number of Chronic Conditions",
       y = "Count of Individuals") +
  theme_minimal() +
  geom_text(aes(label = paste0(n, " (", round(percentage, 1), "%)")), 
            vjust = -0.5, size = 4)  # Labels with count and percentage

# **Display the plot in RStudio**
print(multimorbidity_plot)

# **Save the plot as PNG**
ggsave("multimorbidity_plot.png", multimorbidity_plot, width = 8, height = 6, dpi = 300)

# **Save the plot in a PDF**
pdf("multimorbidity_plot.pdf", width = 8, height = 6)
print(multimorbidity_plot)
dev.off()

# Confirmation message
print("Plot saved as multimorbidity_plot.png and multimorbidity_plot.pdf")
 
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================



