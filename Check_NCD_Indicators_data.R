# Author:   Daniel Maina Nderitu
# Purpose:  Generate statistics and visualizations to make sense of data

# Load necessary libraries
library(dplyr)
library(ggplot2)
library(dslabs)
library(haven)
library(VennDiagram)
library(lubridate)
library(ComplexUpset)
library(tidyverse)
# library(UpSetR)

# analysis_script.R
load("madiva_processed_datasets.RData")  # Loads all saved datasets

set.seed(123)  # For reproducibility
# Define the output filenames
pdf_file <- "visualization/EDA_analysis.pdf"

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
ggsave("visualization/combined_mm_plot.png", plot = multi_plot, width = 7, height = 5, dpi = 300)
# Close the PDF device
while (dev.cur() > 1) dev.off()

# =============================================================================
# =============================================================================
# Venn Diagram to show overlap
venn_diag <- venn.diagram(
  x = list(
    Hypertension = which(multi_conditions$hypertension == 1),
    Diabetes = which(multi_conditions$diabetes == 1),
    CKD = which(multi_conditions$ckd == 1),
    cvd = which(multi_conditions$cvd == 1)
  ),
  category.names = c("Hypertension", "Diabetes", "CKD", "CVD"), #, "heart_disease"
  filename = "visualization/venn_diagram.png",
  output = TRUE,
  fill = c("red", "blue", "green", "yellow")
)

# Display the plot
print(venn_diag)

# =============================================================================
# Save as PDF
# =============================================================================
# Step 3: **Save Multiple Plots in a PDF**
# pdf(pdf_file, width = 8, height = 6)
# Define PNG output file
png_file_iii <- "visualization/upset_plot_iii.png"

# Save the plot as a PNG
png(png_file_iii, width = 2000, height = 1500, res = 300)  # Adjust dimensions for clarity
# Define custom colors
custom_colors <- c("red", "blue", "yellowgreen", "purple", "yellow", "brown", "maroon2") # 

# Create the UpSet plot
upset_plot_iii <- upset(
  upset_data_long, 
  intersect = c("hypertension", "diabetes", "cvd"),  # Use "intersect" instead of "sets" # , "ckd"
  base_annotations = list(
    'Intersection size' = intersection_size(
      mapping = aes(fill = as.factor(intersection))  # Color bars
    ) + 
      scale_fill_manual(values = custom_colors)  # Apply custom colors
  ),
  width_ratio = 0.3
) + theme_minimal()

# Close the PDF device
while (dev.cur() > 1) dev.off()





print(plot_2)
# # Plot 3: Boxplot - Blood Glucose by Multimorbidity
# ggplot(ncd_indicators, aes(x = factor(multimorbidity), y = bg_mmol_fst, fill = factor(multimorbidity))) +
#   geom_boxplot() +
#   scale_fill_manual(values = c("red", "blue", "green", "purple", "orange")) +  # Custom colors
#   labs(title = "Blood Glucose Levels by Multimorbidity Count",
#        x = "Multimorbidity Count",
#        y = "Blood Glucose Level") +
#   theme_minimal()



# Confirm saved files
# print(paste("UpSet plot saved as:", png_file))
# print(paste("All plots saved in PDF:", pdf_file))

# =============================================================================
# =============================================================================
# Conditions count

# Define colors for each bar
color_palette <- c("gray", "blue", "green", "purple", "orange")  #, "red"

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
ggsave("visualization/multimorbidity_plot.png", multimorbidity_plot, width = 8, height = 6, dpi = 300)

# **Save the plot in a PDF**
pdf("multimorbidity_plot.pdf", width = 8, height = 6)
print(multimorbidity_plot)
dev.off()

# Confirmation message
print("Plot saved as multimorbidity_plot.png and multimorbidity_plot.pdf")
 
# =============================================================================

# UpSet plot
upset(
  df_wide, 
  names(df_wide)[-1],  # Select year columns
  width_ratio = 0.2
) + labs(title = "UpSet Plot of Records by Year")

# 
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================



