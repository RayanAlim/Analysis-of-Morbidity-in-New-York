
# load libraries
library(tidyverse)
library(here)


#Reading the raw data

file_path <-
  here("data",
       "raw_data",
       "New_York_City_Leading_Causes_of_Death_20240306.csv")
raw_data <- read_csv(file_path)


# Replacing periods with NA for missing values
clean_data <- raw_data %>%
  mutate(across(
    c(Deaths, `Death Rate`, `Age Adjusted Death Rate`),
    ~ na_if(.x, ".")
  ))

# Adjusting data types
clean_data <- clean_data %>%
  mutate(
    Year = as.integer(Year),
    Deaths = as.numeric(Deaths),
    Death_Rate = as.numeric(`Death Rate`),
    Age_Adjusted_Death_Rate = as.numeric(`Age Adjusted Death Rate`)
  )


write_path <- here("data", "analysis_data", "clean_nyc_data.csv")

write_csv(clean_data, write_path)


