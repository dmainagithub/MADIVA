# Blood Pressure Measurements

library(ggplot2)


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Data
load("madiva_processed_datasets.RData")  # Loads all saved datasets

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
my_plot <- ggplot(bp_data, aes(x = visitdate, y = bp_sys, group = patientid, color = as.factor(patientid))) +
  geom_line() +
  geom_point() +
  labs(title = "Systolic Blood Pressure Over Time",
       x = "Date",
       y = "Systolic BP (mmHg)") +
  theme_minimal()

ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/bp_plot.png", plot = my_plot, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/bp_plot.pdf", plot = my_plot, width = 8, height = 6)

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Scatter plot
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cl_plot_ii <- ggplot(bp_data, aes(x = bp_dia, y = bp_sys, color = adssid)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatter Plot of Systolic vs. Diastolic BP",
       x = "Diastolic BP (mmHg)",
       y = "Systolic BP (mmHg)") +
  theme_minimal()

ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_ii.png", plot = cl_plot_ii, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_ii.pdf", plot = cl_plot_ii, width = 8, height = 6)

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Plot_iii
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cl_plot_iii <- ggplot(bp_data, aes(x = visitdate, y = bp_sys, group = adssid, color = adssid)) +
  geom_line(alpha = 0.6) +
  labs(title = "Blood Pressure Trajectories per Individual",
       x = "Date",
       y = "Systolic BP (mmHg)") +
  theme_minimal()
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_iii.png", plot = cl_plot_iii, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_iii.pdf", plot = cl_plot_iii, width = 8, height = 6)

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Heatmap
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cl_plot_iv <- ggplot(bp_data, aes(x = visitdate, y = adssid, fill = bp_sys)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Heatmap of Systolic BP Over Time",
       x = "Date",
       y = "Individual ID") +
  theme_minimal()
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_iv.png", plot = cl_plot_iv, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_plot_iv.pdf", plot = cl_plot_iv, width = 8, height = 6)

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Overall BP Distribution
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cl_bp_distribution_overall <- ggplot(bp_data, aes(x = bp_sys)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Systolic BP by Year",
       x = "Systolic BP (mmHg)",
       y = "Count") +
  theme_minimal() +
  facet_wrap(~year)  # Facet by year

ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_bp_dis.png", plot = cl_bp_distribution_overall, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/cl_bp_dis.pdf", plot = cl_bp_distribution_overall, width = 8, height = 6)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# For NCD Indicators
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Overall Systolic Distribution
# Remove unwanted values
bp_data_filtered <- bp_data_ncds %>%
  filter(!bp_sys %in% c(-444, -888, -999))  # Exclude invalid values

# Define custom x-axis breaks
breaks_seq <- seq(min(bp_data_filtered$bp_sys, na.rm = TRUE),
                  max(bp_data_filtered$bp_sys, na.rm = TRUE), 
                  by = 30)  # Adjust step size as needed

ncd_bp_sys_overall <- ggplot(bp_data_filtered, aes(x = bp_sys)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Systolic BP by Year",
       x = "Systolic BP (mmHg)",
       y = "Count") +
  theme_minimal() +
  scale_x_continuous(breaks = breaks_seq) +  # More x-axis labels
  facet_wrap(~year)  # Facet by year

ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/ncd_bp_sys.png", plot = ncd_bp_sys_overall, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/ncd_bp_sys.pdf", plot = ncd_bp_sys_overall, width = 8, height = 6)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  
# 
# Overall Diastolic Distribution
# Remove unwanted values
bp_data_filtered <- bp_data_ncds %>%
  filter(!bp_dia %in% c(-444, -888, -999, 20, 764, 8656))  # Exclude invalid values

# Define custom x-axis breaks
breaks_seq <- seq(min(bp_data_filtered$bp_dia, na.rm = TRUE),
                  max(bp_data_filtered$bp_dia, na.rm = TRUE), 
                  by = 30)  # Adjust step size as needed

ncd_bp_dia_overall <- ggplot(bp_data_filtered, aes(x = bp_dia)) +
  geom_histogram(binwidth = 20, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Systolic BP by Year",
       x = "Diastolic BP (mmHg)",
       y = "Count") +
  theme_minimal() +
  scale_x_continuous(breaks = breaks_seq) +  # More x-axis labels
  facet_wrap(~year)  # Facet by year

ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/ncd_bp_dias.png", plot = ncd_bp_dia_overall, width = 8, height = 6, dpi = 300)
ggsave("D:/Daniels/1_Data_Madiva/madiva_merged_data/clinic_data/ncd_bp_dias.pdf", plot = ncd_bp_dia_overall, width = 8, height = 6)



