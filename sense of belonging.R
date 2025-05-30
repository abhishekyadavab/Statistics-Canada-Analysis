# ---------------------------------------------
# STEP 1: Load Required Libraries
# ---------------------------------------------
library(ggplot2)       # For plotting
library(dplyr)         # For data manipulation
library(readr)         # For reading CSV files
library(tidyr)         # For data reshaping
# STEP 2: Load and Clean Both Datasets
data_belonging <- read_csv("4510005201_databaseLoadingData.csv")
data_count_on <- read_csv("4510005001_databaseLoadingData.csv")
# Clean data and average values by year
clean_and_average <- function(df, indicator_name) {
  df %>%
    mutate(
      VALUE = as.numeric(VALUE),
      Year = substr(REF_DATE, 1, 4)  # Extract year (e.g., "2022" from "2022-04")
    ) %>%
    filter(!is.na(VALUE)) %>%
    group_by(Year, GEO, Gender) %>%
    summarise(Avg_Value = mean(VALUE, na.rm = TRUE)) %>%
    ungroup() %>%
    mutate(
      GEO = factor(GEO, levels = unique(GEO)),  # Preserve province order
      Gender = factor(Gender, levels = c("Men", "Women", "Total, all persons")),
      Indicator = indicator_name  # Add indicator label
    )
}
# Process both datasets
data_belonging_avg <- clean_and_average(
  data_belonging %>% filter(Indicators == "Very strong or somewhat strong sense of belonging to local community"),
  "Sense of Belonging"
)
data_count_on_avg <- clean_and_average(
  data_count_on %>% filter(Indicators == "Always or often has people to depend on when needed"),
  "People to Count On"
)

# Combine datasets
combined_data <- bind_rows(data_belonging_avg, data_count_on_avg) %>%
  mutate(Indicator = factor(Indicator, levels = c("Sense of Belonging", "People to Count On")))

# ---------------------------------------------
# STEP 3: Define Custom Theme
# ---------------------------------------------
custom_theme <- theme_minimal() +
  theme(
    axis.text.x = element_text(size = 10, angle = 0),
    axis.text.y = element_text(size = 10),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    strip.text = element_text(size = 11, face = "bold"),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, margin = margin(b = 15)),
    panel.grid.major.y = element_line(color = "grey90"),
    panel.spacing = unit(0.4, "cm")
  )
# STEP 4: Create Dot Plot with Yearly Averages
dot_plot <- ggplot(
  combined_data,
  aes(x = Avg_Value, y = GEO, color = Gender, shape = Year)  # Shape = Year, Color = Gender
) +
  geom_point(
    size = 2, 
    position = position_dodge(width = 0.2),  # Dodge points by Year
    stroke = 1.5
  ) +
  facet_grid(
    Indicator ~ .,  # Facet by Indicator (rows)
    scales = "free_y",
    space = "free_y"
  ) +
  labs(
    title = "Social Connectedness in Canada (2022 vs. 2024)",
    subtitle = "Data Source: Statistics Canada | Timeframe: Q2 2022 to Q4 2024 | Values are yearly averages",
    x = "Average Percentage of Population",
    y = "Province/Territory",
    color = "Gender",
    shape = "Year"
  ) +
  scale_color_manual(
    values = c("#E41A1C", "#377EB8", "#4DAF4A")  # Men (red), Women (blue), Total (green)
  ) +
  scale_shape_manual(values = c(16, 17)) +  # 2022 = circle, 2024 = triangle
  scale_x_continuous(
    limits = c(0, 100),  # Fix x-axis range
    breaks = seq(0, 100, by = 10)  # Add gridlines every 10%
  ) +
  custom_theme

# ---------------------------------------------
# STEP 5: Save and Display
# ---------------------------------------------
print(dot_plot)
ggsave("Social_Connectedness_Dot_Plot.png", plot = dot_plot, 
       width = 14, height = 10, dpi = 300, bg = "white")