library(tidyverse)
setwd("C:/Users/pankaj/OneDrive/Documents/big data 2 project")

# Load and preprocess data
processed_data <- read_csv("4510007701_databaseLoadingData.csv") %>%
  filter(
    Indicators == "Very strong or somewhat strong sense of belonging to Canada",
    Gender %in% c("Men", "Women")  # Focus only on gender-specific data
  ) %>%
  mutate(
    Year = substr(REF_DATE, 1, 4),
    VALUE = as.numeric(VALUE)
  ) %>%
  group_by(Year, Gender) %>%  # Group by both Year and Gender
  summarise(Average_Percentage = mean(VALUE, na.rm = TRUE))

# Create bar plot
ggplot(processed_data, aes(x = Year, y = Average_Percentage, fill = Gender)) +
  geom_bar(
    stat = "identity", 
    position = position_dodge(width = 0.7),  # Control spacing between bars
    width = 0.5  # Narrower bars
  ) +
  labs(
    title = "Strong Sense of Belonging to Canada by Year and Gender",
    x = "Year",
    y = "Average Percentage (%)",
    fill = "Gender"
  ) +
  theme_minimal(base_size = 12) +  # Adjust base font size
  scale_fill_brewer(palette = "Set2") +
  geom_text(
    aes(label = round(Average_Percentage, 1)),
    position = position_dodge(width = 0.7),  # Align labels with bars
    vjust = -0.5, 
    size = 3.5  # Smaller label text
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),  # Center title
    legend.position = "top"
  )
