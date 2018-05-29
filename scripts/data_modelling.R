# Cameron Seibel, INFO 201
# Data Modelling
#
# This script will analyze the data from the World Bank and make estimates for future values
# using naive methods of modelling data.

# Ensure that the working directory is properly set!
source("common.R")

gdp <- read.csv("../data/input/gdp_per_capita.csv", stringsAsFactors = F)
le <- read.csv("../data/input/total_life_expectancy.csv", stringsAsFactors = F)

countries <- gdp$Country.Name
gdp_output <- data.frame("year" = estimate_range)
le_output <- data.frame("year" = estimate_range)

# Keep track of countries that have no data such that we do not do any computation for them later
black_list <- c()

# For each country, model their GDP and estimate values for some time into the future.
for(country in countries){
  # Select only the columns of information, not meta-information
  gdp_vector <- as.numeric(as.vector(gdp[gdp$Country.Name == country, -4:-1]))
  gdp_data <- data.frame("gdp" = gdp_vector, "year" = year_range)
  gdp_data <- gdp_data[!is.na(gdp_data$gdp), ]
  
  le_vector <- as.numeric(as.vector(le[le$Country.Name == country, -4:-1]))
  le_data <- data.frame("le" = le_vector, "year" = year_range)
  le_data <- le_data[!is.na(le_data$le), ]
  # Can't model any countries whose data doesn't exist
  if(count(gdp_data) > 0 && count(le_data) > 0){
    clean_country <- clean_string(country)
    gdp_model <- lm(gdp ~ year, gdp_data)
    gdp_predictions <- data.frame(
      predict.lm(gdp_model, newdata = data.frame(year = estimate_range)), 
      estimate_range
    )
    colnames(gdp_predictions) <- c(paste0(clean_country, "_GDP"), "year")
    gdp_output <- merge(gdp_output, gdp_predictions, by = "year")
    
    le_model <- lm(le ~ year, le_data)
    le_predictions <- data.frame(
      predict.lm(le_model, newdata = data.frame(year = estimate_range)),
      estimate_range
    )
    colnames(le_predictions) <- c(paste0(clean_country, "_LE"), "year")
    le_output <- merge(le_output, le_predictions, by = "year")
  }else{
    append(black_list, country)
  }
}

# Write results to output
write.csv(gdp_output, "../data/output/gdp_estimates.csv")
write.csv(le_output, "../data/output/life_expectancy_estimates.csv")
write.csv(black_list, "../data/output/unrepresented_countries.csv")
