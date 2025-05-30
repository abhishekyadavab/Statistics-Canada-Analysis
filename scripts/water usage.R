library(ggplot2)

# Load the dataset
file_path <- "/mnt/data/3810025001_databaseLoadingData.csv"
df <- read.csv("3810025001_databaseLoadingData.csv")

setwd("C:/Users/pankaj/OneDrive/Documents/big data 2 project")

# Filter data for total water use across all sectors
total_water_use <- subset(df, Sector == "Total, industries and households")

# Plot the data
ggplot(total_water_use, aes(x = REF_DATE, y = VALUE)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  geom_text(aes(label = VALUE), vjust = -0.5, color = "black", size = 3.5) +
  labs(title = "Trend of Total Water Use in Canada",
       x = "Year",
       y = "Water Use (thousands of cubic metres)") +
  theme_minimal()
