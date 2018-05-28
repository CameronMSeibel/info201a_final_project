# Cameron Seibel, INFO 201
# Modelling Demo
#
# This file serves to demo the technique used for modelling data as a function of time, which
# we will employ to naively predict how values will change given time. This will then be the 
# basis of our neural network predictions.

library(dplyr)

# For this, we will use data from the World Bank, probably data we'll end up using for the 
# final project - be sure working directory is set to source file location.
gdp_data <- read.csv("../data/gdp_per_capita.csv", stringsAsFactors = F)

# Selecting a random country for this analysis, reformatting the data.
data_vector <- as.numeric(as.vector(gdp_data[gdp_data$Country.Name == "Burundi", c(-1, -2, -3, -4)]))
year_range <- 1960:2017
select_data <- data.frame(gdp = data_vector, year = 1960:2017)
select_data <- select_data %>% 
  filter(!is.na(gdp))

# Our model describes GDP as a function of year, which is based on our data for Burundi.
model <- lm(gdp ~ year, data = select_data)

# Using the predict.lm method for a data frame with a year column predicts values for each year.
predictions <- data.frame(gdp = predict.lm(model, newdata = data.frame(year = 2018:2038)), 
                          year = 2018:2038)

View(predictions)
