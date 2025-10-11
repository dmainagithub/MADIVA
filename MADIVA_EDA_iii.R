# Load necessary libraries
library(dplyr)
library(ggplot2)
library(dslabs)
library(haven)

set.seed(123)  # For reproducibility
# Reading my stata file
ncd_indicators <- read_dta("D:/APHRC/GoogleDrive_ii/data_science/madiva/DMAC/databases/ncd_indicators/NCDs_and_individuals_no_nulls.dta")

# Summarize to get the number of records per individual
record_counts <- ncd_indicators %>%
  group_by(individual_id) %>%  # Group by individual
  summarise(count = n()) %>%   # Count number of records per individual
  ungroup()

# Step 2: Create categories
record_counts <- record_counts %>%
  mutate(category = case_when(
    count == 1 ~ "1 Record",
    count == 2 ~ "2 Records",
    count == 3 ~ "3 Records",
    count >= 4 ~ "4+ Records"
  ))

# Step 3: Count how many individuals fall into each category
category_summary <- record_counts %>%
  group_by(category) %>%
  summarise(count = n()) %>%
  ungroup()

# Step 4: Calculate percentage
total_people <- sum(category_summary$count)
category_summary <- category_summary %>%
  mutate(percentage = (count / total_people) * 100)

# Step 5: Create three bar plots
count_plot <- ggplot(category_summary, aes(x = category, y = count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = count), vjust = -0.5, size = 2) +
  labs(title = "Number of Individuals Per Category",
       x = "Number of Records",
       y = "Count") +
  theme_minimal()

percentage_plot <- ggplot(category_summary, aes(x = category, y = percentage)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  geom_text(aes(label = sprintf("%.1f%%", percentage)), vjust = -0.5, size = 2) +
  labs(title = "Percentage of Individuals Per Category",
       x = "Number of Records",
       y = "Percentage (%)") +
  theme_minimal()

combined_plot <- ggplot(category_summary, aes(x = category, y = count)) +
  geom_bar(stat = "identity", fill = "purple") +
  
  # Count labels (placed inside bars for better visibility)
  geom_text(aes(label = count), vjust = 1.5, color = "white", size = 4) +
  
  # Percentage labels (placed above the bars to avoid overlap)
  geom_text(aes(y = count + max(count) * 0.05, label = sprintf("%.1f%%", percentage)), 
            vjust = -0.5, size = 3, color = "red") +
  
  labs(title = "Individuals Per Category (Count & Percentage)",
       x = "Number of Records",
       y = "Count") +
  theme_minimal()


# Step 6: Save the plots as images
ggsave("count_plot.png", plot = count_plot, width = 6, height = 4)
ggsave("percentage_plot.png", plot = percentage_plot, width = 6, height = 4)
ggsave("combined_plot.png", plot = combined_plot, width = 6, height = 4)

# Step 7: Save all plots in a PDF with a summary
pdf("Summary_Plots.pdf", width = 8, height = 6)

# Title Page
plot.new()
title("Summary of Individual Record Counts")
text(0.5, 0.8, paste("Total Individuals:", total_people), cex = 1.5)
text(0.5, 0.7, "This report summarizes the distribution of records per individual.", cex = 1.2)

# Print the plots
print(count_plot)
print(percentage_plot)
print(combined_plot)

dev.off()  # Close the PDF
