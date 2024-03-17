#### Preamble ####
# Purpose: Generates graphs and tables showing the causes of death
# Author: Maria Mangru, Rayan Awad Alim, MD Mubtasim-Faud
# Date: 15th March, 2024
# License: MIT



# libraries
library(dplyr)
library(knitr)
library(ggplot2)
library(forcats)
library(testthat)

# read in the dataset

file_path <- "./data/analysis_data/clean_nyc_data.csv"
nyc_data <- read.csv(file_path)


# create table showing count of deaths by cause (overall)
death_count_by_cause <- nyc_data %>%
  group_by(Leading.Cause) %>%
  summarise(Total_Deaths = sum(as.numeric(Deaths), na.rm = TRUE)) %>%
  arrange(desc(Total_Deaths))
knitr::kable(death_count_by_cause, caption = "Count of Deaths by Leading Cause")


# create table showing age-adjusted death rate by cause (average)
age_adj_death_rate_by_cause <- nyc_data %>%
  group_by(Leading.Cause) %>%
  summarise(Average_Age_Adjusted_Death_Rate = mean(as.numeric(Age_Adjusted_Death_Rate), na.rm = TRUE)) %>%
  arrange(desc(Average_Age_Adjusted_Death_Rate))
knitr::kable(age_adj_death_rate_by_cause, caption = "Average Age-Adjusted Death Rates by Leading Cause")


# create table showing top 5 leading causes of death by race
top_causes_by_race <- nyc_data %>%
  group_by(Race.Ethnicity, Leading.Cause) %>%
  summarise(Total_Deaths = sum(as.numeric(Deaths), na.rm = TRUE)) %>%
  arrange(Race.Ethnicity, desc(Total_Deaths)) %>%
  mutate(rank = row_number()) %>%
  filter(rank <= 5) %>%
  ungroup()

table_top_causes_by_race <- top_causes_by_race %>%
  select(-rank) %>%
  arrange(Race.Ethnicity, desc(Total_Deaths))

knitr::kable(table_top_causes_by_race, caption = "Top 5 Leading Causes of Death by Race")

# create table showing average age-adjusted death rates by top 5 leading causes of death by race
avg_rate_top_causes_by_race <- nyc_data %>%
  group_by(Race.Ethnicity, Leading.Cause) %>%
  summarise(Average_Age_Adjusted_Death_Rate = mean(as.numeric(Age_Adjusted_Death_Rate), na.rm = TRUE)) %>%
  arrange(Race.Ethnicity, desc(Average_Age_Adjusted_Death_Rate)) %>%
  mutate(rank = row_number()) %>%
  filter(rank <= 5) %>%
  ungroup()

table_avg_rate_top_causes_by_race <- avg_rate_top_causes_by_race %>%
  select(-rank) %>%
  arrange(Race.Ethnicity, desc(Average_Age_Adjusted_Death_Rate))

knitr::kable(table_avg_rate_top_causes_by_race, caption = "Average Age-Adjusted Death Rates by Top 5 Leading Cause of Death by Race")

# create bar graph to display leading causes of death by race
gg <- ggplot(top_causes_by_race, aes(x = Leading.Cause, y = Total_Deaths)) +
  geom_col(aes(fill = Leading.Cause)) + 
  facet_wrap(~Race.Ethnicity, scales = "free_y") + 
  scale_fill_brewer(palette = "Paired") + 
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 40, hjust = 1), 
        strip.text.x = element_text(size = 6), 
        legend.position = "none") + 
  labs(x = "Top 5 Causes of Death", y = "Total Deaths") 

print(gg)
ggsave("top_causes_by_race.png", plot = gg, width = 12, height = 8)

# create bar graph to display average age-adjusted death rates by top 5 leading causes of death by race
gg <- ggplot(avg_rate_top_causes_by_race, aes(x = Leading.Cause, y = Average_Age_Adjusted_Death_Rate)) +
  geom_col(aes(fill = Leading.Cause)) + 
  facet_wrap(~Race.Ethnicity, scales = "free_y") + 
  scale_fill_brewer(palette = "Paired") + 
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 40, hjust = 1), 
        strip.text.x = element_text(size = 6), 
        legend.position = "none") + 
  labs(x = "Top 5 Causes of Death", y = "Average Age-Adjusted Death Rate") 

print(gg)
ggsave("avg_rate_top_causes_by_race.png", plot = gg, width = 12, height = 8)



# Save datatsets for use in models 
write.csv(death_count_by_cause, "data/analysis_data/death_count_by_cause.csv", row.names = FALSE)
write.csv(table_top_causes_by_race, "data/analysis_data/top_causes_by_race.csv", row.names = FALSE)


















