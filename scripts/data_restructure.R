# Cameron Seibel
#
# This script will refactor the given CSV files such that they will be easier to use in
# linear modelling and nnet predictions.

# Ensure that the working directory is properly set!
source("common.R")

gdp <- read.csv("../data/input/gdp_per_capita.csv", stringsAsFactors = F)

countries <- gdp$Country.Name
output_df <- data.frame(year = estimate_range)

# Keep track of countries that have no data such that we do not do any computation for them later
black_list <- c()

# For each country, model their GDP and estimate values for some time into the future.
for(country in countries){
  # Select only the columns of information, not meta-information
  data_vector <- as.numeric(as.vector(gdp_data[gdp_data$Country.Name == country, -4:-1]))
  select_data <- data.frame("gdp" = data_vector, "year" = year_range)
  select_data <- select_data[!is.na(select_data$gdp), ]
  # Can't model any countries whose data doesn't exist
  if(count(select_data) > 0){
    clean_country <- clean_string(country)
    model <- lm(gdp ~ year, select_data)
    predictions <- data.frame(
      predict.lm(model, newdata = data.frame(year = estimate_range)), 
      estimate_range
    )
    colnames(predictions) <- c(paste0(clean_country, "_GDP"), "year")
    output_df <- merge(output_df, predictions, by = "year")
  }else{
    append(black_list, country)
  }
}

# Write results to output
write.csv(output_df, "../data/output/gdp_estimates.csv")
