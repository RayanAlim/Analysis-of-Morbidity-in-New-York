# load libraries
library(dplyr)
library(readr)
library(ggplot2)
library(forcats)
library(rstanarm)
library(knitr)
library(kableExtra)

# load the dataset 
file_path <- "../data/analysis_data/clean_nyc_data.csv"
nyc_data <- read.csv(file_path)


# Filter for the year 2014
nyc_data$Deaths <- as.numeric(as.character(nyc_data$Deaths))
nyc_data_2014 <- nyc_data %>%
  filter(Year == 2014)

# Identify top 5 causes of death overall
top_causes_overall <- nyc_data_2014 %>%
  group_by(Leading.Cause) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(Total_Deaths)) %>%
  slice_max(order_by = Total_Deaths, n = 5)

# Filter data for top 5 causes
nyc_data_2014_top_causes_with_totals <- nyc_data_2014 %>%
  inner_join(top_causes_overall, by = "Leading.Cause")

# Negative binomial regression for overall top 5 causes
neg_binom_model_overall <- stan_glm(
  Total_Deaths ~ Leading.Cause,
  data = nyc_data_2014_top_causes_with_totals,
  family = neg_binomial_2(link = "log"),
  seed = 853
)

# Summary model
summary(neg_binom_model_overall) 