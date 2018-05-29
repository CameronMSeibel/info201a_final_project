# Cameron Seibel
#
# This script will refactor the given CSV files such that they will be easier to use in
# linear modelling and nnet predictions.

gdp <- read.csv("../data/input/gdp_per_capita.csv", stringsAsFactors = F)

countries <- gdp$Country.Name
estimate_range <- 2019:2039
output_df <- data.frame(year = estimate_range)

# For each country, model their GDP and estimate values for some time into the future.
for(country in countries){
  data_vector <- as.numeric(as.vector(gdp_data[gdp_data$Country.Name == country, -4:-1]))
  year_range <- 1960:2017
  select_data <- data.frame("gdp" = data_vector, "year" = year_range)
  select_data <- select_data[!is.na(select_data$gdp), ]
  # Can't model any countries whose data doesn't exist
  if(count(select_data) > 0){
    # Clean country names for column name.
    clean_country <- gsub(" ", "_", country)
    model <- lm(gdp ~ year, select_data)
    predictions <- data.frame(
      predict.lm(model, newdata = data.frame(year = estimate_range)), 
      estimate_range
    )
    colnames(predictions) <- c(paste0(country, "_GDP"), "year")
    output_df <- merge(output_df, predictions, by = "year")
  }
}

# Write results to output
write.csv(output_df, "../data/output/gdp_estimates.csv")
