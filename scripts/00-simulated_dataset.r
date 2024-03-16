#### Preamble ####
# Purpose: Simulates dataset
# Author: Maria Mangru, Rayan Awad Alim, MD Mubtasim-Faud
# Date: 15th March, 2024
# License: MIT

# Load libraries
library(dplyr)
library(tidyr)
library(stringr)
library(testthat)

set.seed(853) # Set a seed for reproducibility


# Number of rows to simulate
n <- 500

# Leading causes of death and their ICD-10 codes
leading_causes <- c(
  "Human immunodeficiency virus (HIV) disease B20-B24",
  "Malignant neoplasms C00-C97",
  "Diabetes mellitus E10-E14",
  "Alzheimer’s disease G30",
  "Diseases of heart I00-I09,I11,I13,I20-I51",
  "Essential hypertension and hypertensive renal disease I10, I12",
  "Cerebrovascular diseases I60-I69",
  "Atherosclerosis I70",
  "Other diseases of circulatory system I71-I78",
  "Influenza and pneumonia J10-J18",
  "Chronic lower respiratory diseases J40-J47",
  "Chronic liver disease and cirrhosis K70,K73-K74",
  "Nephritis, nephrotic syndrome and nephrosis N00-N07,N17-N19,N25-N27",
  "Certain conditions originating in the perinatal period P00-P96",
  "Congenital malformations, deformations & chromosomal abnormalities Q00-Q99",
  "Sudden infant death syndrome R95",
  "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified R00-R94,R96-R99",
  "All other diseases (Residual)",
  "Motor vehicle accidents V02-V04,V09.0,V09.2,V12-V14,V19.0-V19.2,V19.4-V19.6,V20-V79,V80.3-V80.5,V81.0-V81.1,V82.0-V82.1,V83-V86,V87.0-V87.8,V88.0-V88.8,V89.0,V89.2",
  "All other and unspecified accidents and adverse effects V01,V05-V06,V09.1,V09.3-V09.9,V10-V11,V15-V18,V19.3,V19.8-V19.9,V80.0-V80.2,V80.6-V80.9,V81.2-V81.9,V82.2-V82.9,V87.9,V88.9,V89.1,V89.3,V89.9,V90-X59,Y40-Y86,Y88",
  "Intentional self-harm (suicide) X60-X84,Y87.0",
  "Assault (homicide) X85-Y09,Y87.1",
  "All other external causes Y10-Y36,Y87.2,Y89"
)


# Generate the data
simulated_data <- tibble(
  Year = sample(2007:2014, n, replace = TRUE),
  Leading_Cause = sample(leading_causes, n, replace = TRUE),
  Sex = sample(c("M", "F"), n, replace = TRUE),
  Race_Ethnicity = sample(c("White Non-Hispanic", "Hispanic", "Black Non-Hispanic", 
                             "Asian and Pacific Islander", "Not Stated/Unknown", "Other Race/Ethnicity"), n, replace = TRUE),
  Deaths = sample(1:1500, n, replace = TRUE),
  Death_Rate = runif(n, 5, 30),
  Age_Adjusted_Death_Rate = runif(n, 5, 30)
)

