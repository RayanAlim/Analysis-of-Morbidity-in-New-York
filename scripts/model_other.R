# load libraries
library(dplyr)
library(readr)
library(ggplot2)
library(forcats)
#### Preamble ####
# Purpose: Regression model for causes of death for other 
# Author: Maria Mangru, Rayan Awad Alim, MD Mubtasim-Faud
# Date: 15th March, 2024
# License: MIT

library(rstanarm)
library(knitr)
library(kableExtra)

# load the dataset 
file_path <- "../data/analysis_data/clean_nyc_data.csv"
nyc_data <- read.csv(file_path)

# Convert Deaths to numeric if it's not already
nyc_data$Deaths <- as.numeric(as.character(nyc_data$Deaths))

# Filter for the year 2014 and the specific race
race_name <- "Other Race/Ethnicity" 

nyc_data_2014_race <- nyc_data %>%
  filter(Year == 2014, Race.Ethnicity == race_name)

# Identify the top 5 causes of death for the selected race
top_causes_by_race <- nyc_data_2014_race %>%
  group_by(Leading.Cause) %>%
  summarise(Total_Deaths = sum(as.numeric(Deaths), na.rm = TRUE), .groups = 'drop') %>%
  arrange(desc(Total_Deaths)) %>%
  slice_max(Total_Deaths, n = 5)

# Ensure data for regression includes only the top causes
nyc_data_for_regression <- nyc_data_2014_race %>%
  inner_join(top_causes_by_race, by = "Leading.Cause")


# negative binomial regression
neg_binom_model <- stan_glm(
  Total_Deaths ~ Leading.Cause,
  data = nyc_data_for_regression,
  family = neg_binomial_2(link = "log"),
  seed = 853
)

# Output the model summary
model_summary <- summary(neg_binom_model)

# Display the model summary table
kable(model_summary, caption = paste("Negative Binomial Regression Summary for", race_name)) %>%
  kable_styling(bootstrap_options = c("striped", "hover"))