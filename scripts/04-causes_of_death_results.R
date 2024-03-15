
# libraries
library(dplyr)
library(knitr)
library(ggplot2)
library(forcats)
library(testthat)

# read in the dataset

file_path <- "../data/analysis_data/clean_nyc_data.csv"
nyc_data <- read.csv(file_path)


# create table showing count of deaths by cause (overall)
death_count_by_cause <- nyc_data %>%
  group_by(Leading.Cause) %>%
  summarise(Total_Deaths = sum(as.numeric(Deaths), na.rm = TRUE)) %>%
  arrange(desc(Total_Deaths))
knitr::kable(death_count_by_cause, caption = "Count of Deaths by Leading Cause")


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


















