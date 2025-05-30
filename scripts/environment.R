# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load datasets
air_quality <- read.csv("percentage-canadians-below-at-caaqs-2021.csv", skip = 2, stringsAsFactors = FALSE)
ghg_emissions <- read.csv("ghg-emissions-national-en.csv", skip = 2, stringsAsFactors = FALSE)

# Rename columns for clarity
colnames(air_quality) <- c("Period", "Proportion")
colnames(ghg_emissions) <- c("Year", "GHG_Emissions")

# Convert columns to appropriate types
air_quality$Proportion <- as.numeric(air_quality$Proportion)
ghg_emissions$Year <- as.numeric(ghg_emissions$Year)
ghg_emissions$GHG_Emissions <- as.numeric(ghg_emissions$GHG_Emissions)
# Extract the year from the "Period" column in air_quality dataset
air_quality$Year <- as.numeric(sub(" .*", "", air_quality$Period))

# Merge both datasets by Year (Ensure no duplicate column names)
combined_data <- merge(air_quality, ghg_emissions, by = "Year", all = TRUE)
# Identify GHG emissions data timeframe
ghg_start_year <- min(ghg_emissions$Year, na.rm = TRUE)
ghg_end_year <- max(ghg_emissions$Year, na.rm = TRUE)

# Scale GHG Emissions to match Air Quality range
max_proportion <- max(combined_data$Proportion, na.rm = TRUE)
max_ghg <- max(combined_data$GHG_Emissions, na.rm = TRUE)
scaling_factor <- max_proportion / max_ghg

# Create a dual-axis plot
ggplot(combined_data, aes(x = Year)) +
  
  # First Line: Air Quality (Left Axis)
  geom_line(aes(y = Proportion, color = "Air Quality (CAAQS)"), size = 1) +
  geom_point(aes(y = Proportion, color = "Air Quality (CAAQS)"), size = 2) +
  geom_text(aes(y = Proportion, label = round(Proportion, 1)), vjust = -0.5, size = 3) +
  # Second Line: GHG Emissions (Scaled for Right Axis)
  geom_line(aes(y = GHG_Emissions * scaling_factor, color = "GHG Emissions"), size = 1) +
  geom_point(aes(y = GHG_Emissions * scaling_factor, color = "GHG Emissions"), size = 2) +
  geom_text(aes(y = GHG_Emissions * scaling_factor, label = round(GHG_Emissions, 1)), vjust = -0.5, size = 3) +
  # Labels and Titles
  labs(title = "Air Quality(2005 - 2020) CAAQS and GHG Emissions in Canada",
       subtitle = paste("GHG Emissions data available from", ghg_start_year, "to", ghg_end_year),
       x = "Year",
       y = "Proportion of Canadians Below CAAQS (%)",
       color = "Legend") +
  # Secondary Axis for GHG Emissions
  scale_y_continuous(sec.axis = sec_axis(~ . / scaling_factor, name = "GHG Emissions (Mt CO2 eq)")) +
  # Custom Theme
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1))
