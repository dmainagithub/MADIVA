# Author:   Daniel Maina Nderitu
# Purpose:  Generate statistics and visualizations to make sense of data

# Load necessary libraries
library(dplyr)
library(ggplot2)
library(dslabs)
library(haven)
library(VennDiagram)
library(UpSetR)
library(lubridate)
library(ComplexUpset)
library(tidyverse)


set.seed(123)  # For reproducibility
# Define the output filenames
pdf_file <- "multimorbidity_analysis.pdf"
# Reading my stata file
ncd_indicators <- read_dta("D:/APHRC/GoogleDrive_ii/data_science/madiva/DMAC/databases/ncd_indicators/NCDs_and_individuals_no_nulls.dta")

ncd_indicators$year <- year(ncd_indicators$obs_date)

# Summarize the number of records per year
yearly_counts <- ncd_indicators %>%
  group_by(year) %>%
  summarise(record_count = n())

# Display the summarized table
print(yearly_counts)

# Create a bar plot for records per year
yearly_plot <- ggplot(yearly_counts, aes(x = factor(year), y = record_count, fill = factor(year))) +
  geom_bar(stat = "identity") +
  scale_fill_viridis_d() +  # Automatically assigns distinct colors
  labs(title = "Number of Records Per Year",
       x = "Year",
       y = "Count of Records") +
  theme_minimal() +
  geom_text(aes(label = record_count), vjust = -0.5, size = 4)  # Add labels on bars

# # **Display the plot in RStudio**
print(yearly_plot)

ggsave("visualization/general_record_count_plot.png", plot = yearly_plot, width = 7, height = 5, dpi = 300)


# =============================================================================
# =============================================================================
# Data Points
# Count unique years per individual
timepoints_count <- ncd_indicators %>%
  select(individual_id, year) %>%  # Select relevant columns
  distinct() %>%  # Remove duplicate records within the same year
  group_by(individual_id) %>%
  summarise(num_timepoints = n(), .groups = "drop")  # Count unique years

# Compute the count of individuals per number of unique years
timepoints_count <- timepoints_count %>%
  count(num_timepoints) %>%
  mutate(percentage = (n / sum(n)) * 100)  # Calculate percentage

# Display a summary table
print(n=20, timepoints_count)

# Create a bar plot for visualization
timepoint_plot <- ggplot(timepoints_count, aes(x = factor(num_timepoints), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = paste0(n, " (", round(percentage, 1), "%)")), 
            vjust = -0.5, size = 3.5) +  # Show both count and percentage
  scale_x_discrete(expand = expansion(mult = 0.1)) +  # Ensure all x labels appear
  labs(title = "Number of Unique Time Points (Years) Per Individual",
       x = "Number of Years with Records",
       y = "Count of Individuals") +
  theme_minimal()

print(timepoint_plot)
ggsave("visualization/timepoint_plot.png", plot = timepoint_plot, width = 7, height = 5, dpi = 300)


# =============================================================================
# =============================================================================

# 
# df_wide <- ncd_indicators %>%
#   mutate(value = 1) %>%
#   pivot_wider(names_from = year, values_from = value, values_fill = list(value = 0)) 
# 
# # UpSet plot
# upset(
#   df_wide, 
#   names(df_wide)[-1],  # Select year columns
#   width_ratio = 0.2
# ) + labs(title = "UpSet Plot of Records by Year")
# 
# 
# # Summarize the number of records per year
# yearly_counts <- multi_conditions %>%
#   group_by(year) %>%
#   summarise(record_count = n())
# 
# # Display the summarized table
# print(yearly_counts)
# 
# # Create a bar plot for records per year
# yearly_plot <- ggplot(yearly_counts, aes(x = factor(year), y = record_count, fill = factor(year))) +
#   geom_bar(stat = "identity") +
#   scale_fill_viridis_d() +  # Automatically assigns distinct colors
#   labs(title = "Number of Records Per Year",
#        x = "Year",
#        y = "Count of Records") +
#   theme_minimal() +
#   geom_text(aes(label = record_count), vjust = -0.5, size = 4)  # Add labels on bars
# 
# # **Display the plot in RStudio**
# print(yearly_plot)

ncd_indicators %>%
  select(individual_id, year)

