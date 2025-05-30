# ---------------------------------------------
# STEP 1: Load Required Libraries
# ---------------------------------------------
library(tidyverse)
library(ggplot2)
library(patchwork)
library(ggthemes)

# ---------------------------------------------
# STEP 2: Set Working Directory & Load Data
# ---------------------------------------------
setwd("C:/Users/pankaj/OneDrive/Documents/big data 2 project")

life_expectancy_data <- read_csv("1310037001_databaseLoadingData (1).csv")
mental_health_data <- read_csv("4510008001_databaseLoadingData.csv")

# ---------------------------------------------
# STEP 3: Data Cleaning
# ---------------------------------------------

## Life Expectancy Data Cleaning
life_expectancy_clean_provinces <- life_expectancy_data %>%
  separate(REF_DATE, into = c("Year_Start", "Year_End"), sep = "/", convert = TRUE) %>%
  pivot_longer(cols = c("Year_Start", "Year_End"), names_to = "Year_Column", values_to = "Year") %>%
  filter(Sex %in% c("Males", "Females"), `Age group` == "At birth", GEO != "Canada") %>%
  select(Year, GEO, Sex, VALUE) %>%
  rename(Life_Expectancy = VALUE) %>%
  drop_na(Year) %>%
  mutate(Year = as.numeric(Year))

# Calculate Average Life Expectancy by Province
average_life_expectancy <- life_expectancy_clean_provinces %>%
  group_by(GEO) %>%
  summarise(avg_life_expectancy = mean(Life_Expectancy, na.rm = TRUE))

# Adjust province names for better display
average_life_expectancy$GEO <- gsub("Newfoundland", "Newfound\nland", average_life_expectancy$GEO)

## Mental Health Data Cleaning
mental_health_clean <- tibble::tribble(
  ~Category, ~Mental_Health, ~Percent,
  "Total, 15 years and over", "Excellent", 47.3,
  "Total, 15 years and over", "Fair", 32.0,
  "Total, 15 years and over", "Poor", 20.7,
  "15 to 24 years", "Excellent", 39,
  "15 to 24 years", "Fair", 35,
  "15 to 24 years", "Poor", 26,
  "25 to 54 years", "Excellent", 42.8,
  "25 to 54 years", "Fair", 33.2,
  "25 to 54 years", "Poor", 24,
  "55 to 64 years", "Excellent", 52.3,
  "55 to 64 years", "Fair", 30.1,
  "55 to 64 years", "Poor", 17.6,
  "65 years and over", "Excellent", 58.8,
  "65 years and over", "Fair", 28.4,
  "65 years and over", "Poor", 12.8,
  "Total, by immigrant status", "Excellent", 47.3,
  "Total, by immigrant status", "Fair", 34.5,
  "Total, by immigrant status", "Poor", 18.2
)

# ---------------------------------------------
# STEP 4: Data Visualization
# ---------------------------------------------

## Life Expectancy Bar Chart
color_palette <- c("darkred", "darkorange", "darkgreen", "darkblue", "purple", "darkcyan", 
                   "gold", "darkviolet", "slateblue", "indianred", "seagreen", "crimson")

hale_plot <- ggplot(average_life_expectancy, aes(x = GEO, y = avg_life_expectancy, fill = GEO)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = round(avg_life_expectancy, 1)), 
            vjust = ifelse(average_life_expectancy$avg_life_expectancy > 80, -0.5, 1.5),  
            color = "black", size = 5, fontface = "bold") +  
  theme_minimal(base_size = 14) +
  labs(title = "Average Life Expectancy by Province (2015/2017)", 
       x = "Province", y = "Average Life Expectancy") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 16, face = "bold"),
        plot.margin = margin(20, 20, 20, 20)) +
  scale_fill_manual(values = color_palette)

## Mental Health Stacked Bar Chart
mental_health_colors <- c("Excellent" = "#2ca02c", "Fair" = "#ff7f0e", "Poor" = "#d62728")

mental_health_plot <- ggplot(mental_health_clean, aes(x = reorder(Category, -Percent), y = Percent, fill = Mental_Health)) +
  geom_col(width = 0.7, position = "stack") +  
  coord_flip() +
  labs(title = "Perceived Mental Health in Canada (2023)",
       subtitle = "Breakdown by Sociodemographic Characteristics",
       x = "", 
       y = "Percentage (%)",
       fill = "Mental Health Status",
       caption = "Source: Statistics Canada") +
  scale_fill_manual(values = mental_health_colors) +  
  geom_text(aes(label = paste0(Percent, "%")), position = position_stack(vjust = 0.5), size = 4, color = "white") +  
  theme_light() +
  theme(plot.title = element_text(face = "bold", size = 14, margin = margin(b = 10)),
        axis.text.y = element_text(size = 10),
        panel.grid.major.y = element_blank())

# ---------------------------------------------
# STEP 5: Combine Plots & Save Output
# ---------------------------------------------

final_plot <- hale_plot / mental_health_plot +
  plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(face = "bold", size = 12))

# Ensure directory exists before saving
dir.create("C:/Users/pankaj/OneDrive/Documents/big data 2 project", recursive = TRUE, showWarnings = FALSE)

# Save as an image
ggsave("health_domain_infographic_fixed.png", plot = final_plot, width = 14, height = 12, dpi = 300, bg = "white")

# Display final visualization
print(final_plot)



