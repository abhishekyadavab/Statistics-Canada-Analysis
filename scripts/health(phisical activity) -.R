
# STEP 1: Load Required Libraries
library(tidyverse)
library(ggplot2)
library(patchwork)
# STEP 2: Load and Clean Data
# Life Expectancy Data
life_expectancy_clean <- read_csv("1310037001_databaseLoadingData (1).csv") %>%
  separate(REF_DATE, into = c("Year_Start", "Year_End"), sep = "/") %>%
  filter(Sex %in% c("Males", "Females"), 
         `Age group` == "At birth",
         GEO != "Canada") %>%
  pivot_longer(cols = c(Year_Start, Year_End), 
               names_to = "Year_Type", 
               values_to = "Year") %>%
  mutate(Year = as.numeric(Year)) %>%
  group_by(GEO) %>%
  summarise(avg_life_expectancy = mean(VALUE, na.rm = TRUE)) %>%
  mutate(GEO = str_replace(GEO, "Newfoundland and Labrador", "Newfoundland"))
# Mental Health Data
mental_health_clean <- tibble(
  Category = rep(c("Total", "15-24", "25-54", "55-64", "65+", "Immigrants"), each = 3),
  Mental_Health = rep(c("Excellent", "Fair", "Poor"), times = 6),
  Percent = c(47.3,32,20.7,39,35,26,42.8,33.2,24,52.3,30.1,17.6,58.8,28.4,12.8,47.3,34.5,18.2)
)
# ---------------------------------------------
# STEP 3: Prepare Combined Dataset
# ---------------------------------------------
# Define color schemes
province_colors <- c(
  "Newfoundland" = "#1f77b4", "Prince Edward Island" = "#ff7f0e",
  "Nova Scotia" = "#2ca02c", "New Brunswick" = "#d62728",
  "Quebec" = "#9467bd", "Ontario" = "#8c564b",
  "Manitoba" = "#e377c2", "Saskatchewan" = "#7f7f7f",
  "Alberta" = "#bcbd22", "British Columbia" = "#17becf",
  "Canada" = "#2F4F4F"  # National benchmark color
)
mental_health_colors <- c("Excellent" = "#2ca02c", "Fair" = "#ff7f0e", "Poor" = "#d62728")

# Create combined data structure
combined_data <- bind_rows(
  life_expectancy_clean %>% 
    mutate(metric = "Life Expectancy", value = avg_life_expectancy),
  mental_health_clean %>%
    filter(Category == "Total") %>%
    mutate(GEO = "Canada", metric = "Mental Health", value = Percent)
)
# STEP 4: Create Unified Visualization
health_plot <- ggplot() +
  # Provincial life expectancy bars
  geom_col(
    data = filter(combined_data, metric == "Life Expectancy"),
    aes(x = reorder(GEO, value), y = value, fill = GEO),
    width = 0.7,
    alpha = 0.8
  ) +
  # National mental health points
  geom_point(
    data = filter(combined_data, metric == "Mental Health"),
    aes(x = GEO, y = value, color = Mental_Health),
    size = 6,
    position = position_jitter(width = 0.2)
  ) +
  # Value labels
  geom_text(
    data = filter(combined_data, metric == "Life Expectancy"),
    aes(x = GEO, y = value, label = round(value, 1)),
    vjust = -0.5, 
    size = 3.5,
    fontface = "bold"
  ) +
  geom_text(
    data = filter(combined_data, metric == "Mental Health"),
    aes(x = GEO, y = value, label = paste0(value, "%"), color = Mental_Health),
    vjust = -1,
    size = 3.5,
    fontface = "bold"
  ) +
  # Scales and colors
  scale_fill_manual(values = province_colors) +
  scale_color_manual(values = mental_health_colors) +
  # Labels and theme
  labs(
    title = "Canadian Health Metrics: Provincial vs National",
    subtitle = "Life Expectancy at Birth (2015-2017) vs National Mental Health Status (2023)",
    x = "Province / National Benchmark",
    y = "Years (Life Expectancy) / Percentage (Mental Health)",
    caption = "Data Sources: Statistics Canada, Canadian Community Health Survey"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
    legend.position = "bottom",
    panel.grid.major.x = element_blank(),
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, margin = margin(b = 15))
  )

# ---------------------------------------------
# STEP 5: Save and Display
# ---------------------------------------------
ggsave("unified_health_analysis.png", health_plot, 
       width = 16, height = 10, dpi = 300, bg = "white")

print(health_plot)