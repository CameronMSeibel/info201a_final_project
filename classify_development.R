# Cameron Seibel
#
# This script classifies a country's development status as either "developed" or "underdeveloped"

library(dplyr)
library(nnet)

# Be sure working directory is set to source file location.
source("common.R")

gdp <- read.csv("data/input/gdp_per_capita.csv")
le <- read.csv("data/input/total_life_expectancy.csv")

gdp_estimate <- read.csv("../data/output/gdp_estimates.csv", stringsAsFactors = F)
le_estimate <- read.csv("../data/output/life_expectancy_estimates.csv", stringsAsFactors = F)

# Could try with other values, but small values consistently only classified "underdeveloped"
hidden_layer_size = 100

gdp <- gdp %>%
  select(Country.Name, X2016) %>% 
  filter(!is.na(X2016))
colnames(gdp) <- c("country_name", "gdp")

le <- le %>% 
  select(Country.Name, X2016) %>% 
  filter(!is.na(X2016))
colnames(le) <- c("country_name", "le")

training_set <- merge(gdp, le, by = "country_name")
training_set$developed <- sapply(training_set$country_name, initial_classification)
training_set <- training_set[, -1]

# nnet takes issue with character input; requires factors
training_set[[3]] <- as.factor(training_set[[3]])

country_classifier <- nnet.formula(developed ~ ., data = training_set, size = hidden_layer_size)

countries <- gsub("_GDP", "",colnames(gdp_estimate))
remove <- c("X", "year")
countries <- countries[! countries %in% remove]

output <- data.frame("year" = estimate_range)

for(country in countries){
  country_data <- data.frame(
    "gdp" = gdp_estimate[, paste0(country, "_GDP")],
    "le" = le_estimate[, paste0(country, "_LE")]
  )
  country_classification <- data.frame(
    estimate_range,
    predict(country_classifier, country_data, type = "class")
  )
  colnames(country_classification) <- c("year", paste0(country, "_Classification"))
  output <- merge(output, country_classification, by = "year")
}

write.csv(output, "../data/output/development_classifications.csv")


