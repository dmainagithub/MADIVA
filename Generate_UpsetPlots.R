# install.packages(c("ComplexUpset","ggplot2","dplyr"))

library(ComplexUpset)
library(ggplot2)
library(dplyr)

# Define function to compute percentages
compute_percentage <- function(data) {
  data$Percentage <- (data$Freq / sum(data$Freq)) * 100
  return(data)
}

# Data
load("madiva_processed_datasets.RData")  # Loads all saved datasets

# Define condition names
condition_names <- c("hypertension", "diabetes", "ckd", "cvd") # , "asthma"

# Define custom colors
set_colors <- c("hypertension" = "red",
                "diabetes" = "blue",
                "ckd" = "green",
                "cvd" = "purple"
                ) # "asthma" = "orange"

# Define custom colors for present and missing intersections
color_present <- "black"  # Color for actual intersections
color_missing <- "gray80"  # Gray out missing intersections

# Remove the individual_id column before plotting
ploting_data <- select(multi_conditions, -individual_id, -multimorbidity)

# Define condition names
condition_names <- c("hypertension", "diabetes", "ckd", "cvd")

# Define custom colors for sets
set_colors <- c("red", "blue", "green", "purple") #, "orange"

# Ensure the dataset is binary (0/1) for plotting
conditions_data_binary <- ploting_data%>%
  mutate(across(hypertension:cvd, ~ ifelse(is.na(.), 0, .)))  # Replace  # Convert to binary (1 if present)
conditions_data_binary[conditions_data_binary > 1] <- 1 

# Define PNG output file
png_file <- "visualization/upset_plot.png"
# Save as PNG
png(png_file, width = 2000, height = 1500, res = 300)

# Define the UpSet plot
upset_plot <- upset(
  conditions_data_binary,  # Ensure data is correctly formatted
  colnames(conditions_data_binary),  # Use only relevant columns
  base_annotations = list(
    'Intersection Size' = intersection_size(
      counts = TRUE,
      text = list(size = 4)  # Adjust text size for clarity
    )
  ),
  width_ratio = 0.2,  # Adjust layout
  matrix = intersection_matrix(
    geom = geom_point(
      aes(),  # Ensure correct fill mapping  # fill = as.factor(intersect)
      size = 3,
      shape = 21  # Use shape 21 for custom fill color
    )
  ),
  themes = upset_modify_themes(
    list(
      "intersections_matrix" = theme(text = element_text(size = 10))
    )
  )
) +
  scale_fill_manual(values = c("1" = color_present, "0" = color_missing))  # Apply colors

# Display the plot
# print(upset_plot)

dev.off()  # Close the PNG device

# Save as PDF
pdf("visualization/upset_plot.pdf", width = 8, height = 6)

# Close the PDF device
while (dev.cur() > 1) dev.off()

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# =============================================================================
# =============================================================================
# Upset plot (colored upset plot)
# =============================================================================
# =============================================================================

# Ensure the directory exists
if (!dir.exists("visualization")) {
  dir.create("visualization")
}

# Define PNG output file
png_file_ii <- "visualization/upset_plot_ii.png"

# Save the plot as a PNG
png(png_file_ii, width = 2000, height = 1500, res = 300)  # Adjust dimensions for clarity

# =============================================================================
# Define custom colors for conditions
custom_colors <- c(
  "hypertension" = "red", 
  "diabetes" = "blue", 
  # "ckd" = "green", 
  "cvd" = "purple"
)
# Generate ComplexUpset Plot with Colors
upset(
  upset_data_long, 
  intersect = c("hypertension", "diabetes", "cvd"), # , "ckd"
  base_annotations = list(
    'Intersection size' = intersection_size(
      mapping = aes(fill = as.factor(intersection)),
      counts = TRUE,  # Ensure labels are added
      text = list(size = 3)  # Reduce label size
    ) 
    # + geom_bar(width = 0.6)  # Increase spacing between bars
  ),
  width_ratio = 0.3
) + theme_minimal()

# Close the PDF device
while (dev.cur() > 1) dev.off()

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# head(conditions_data)
# summary(conditions_data)
# str(conditions_data)

