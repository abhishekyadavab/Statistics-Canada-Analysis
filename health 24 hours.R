# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load dataset & set working directory 
setwd("C:/Users/pankaj/OneDrive/Documents/big data 2 project")
df <- read.csv("1310082101_databaseLoadingData.csv", stringsAsFactors = FALSE)

# Filter relevant data: Focus on 'Meeting guidelines' category and 'Estimate' characteristic
df_filtered <- df %>%
  filter(Categories == "Meeting guidelines", Characteristics == "Estimate") %>%
  group_by(REF_DATE) %>%
  summarise(Average_Value = mean(VALUE, na.rm = TRUE))  # Calculate average per year

# Create a simple bar chart
ggplot(df_filtered, aes(x = factor(REF_DATE), y = Average_Value, fill = REF_DATE)) +
  geom_bar(stat = "identity", width = 0.6, color = "black") +  # Simple bars with borders
  labs(
    title = "Average Percentage of Canadians Meeting 24-Hour Guidelines",
    subtitle = "Simplified View (2016-2021)",
    x = "Year",
    y = "Average % of Population"
  ) +
  theme_minimal() +
  theme(legend.position = "none")  # Remove legend since color isn't necessary

