#### Preamble ####
# Purpose: Tests for simulated dataset and causes of death files 
# Author: Maria Mangru, Rayan Awad Alim, MD Mubtasim-Faud
# Date: 15th March, 2024
# License: MIT


# Load libraries 
library(testthat)
library(dplyr)
library(tidyr)
suppressPackageStartupMessages(library(stringr))


# Script #1 to be tested - simulated data
source("00-simulated_dataset.r", local = TRUE)

# Ensure the simulated dataset has properties similar to the original dataset
test_that("Data has correct types", {
  expect_is(simulated_data$Year, "integer")
  expect_is(simulated_data$Leading_Cause, "character")
  expect_is(simulated_data$Sex, "character")
  expect_is(simulated_data$Race_Ethnicity, "character")
  expect_is(simulated_data$Deaths, "integer")
  expect_is(simulated_data$Death_Rate, "numeric")
  expect_is(simulated_data$Age_Adjusted_Death_Rate, "numeric")
})

# Ensure 'Year' column contains only the years in the specified range
test_that("Year column contains appropriate years", {
  expect_true(all(simulated_data$Year >= 2007 & simulated_data$Year <= 2014))
})

# Ensure no duplicated rows exists
test_that("There are no duplicate rows", {
  expect_equal(nrow(simulated_data), nrow(distinct(simulated_data)))
})


# Script #2 to be tested - causes of death
source("04-causes_of_death_results.R", local = TRUE)

# Data set has been loaded correctly
test_that("Dataset has been loaded", {
  expect_true(exists("nyc_data"))
  expect_is(nyc_data, "data.frame")
})

# 'death_count_by_cause' has the correct columns
test_that("'death_count_by_cause' has correct columns", {
  expected_cols <- c("Leading.Cause", "Total_Deaths")
  expect_equal(colnames(death_count_by_cause), expected_cols)
})

# 'death_count_by_cause' table has correct number of rows
test_that("'death_count_by_cause' has correct number of rows", {
  expect_true(nrow(death_count_by_cause) > 0)
})

