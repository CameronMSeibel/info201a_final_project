# Cameron Seibel
#
# This script will refactor the given CSV files such that they will be easier to use in
# linear modelling and nnet predictions.

gdp <- read.csv("../data/input/gdp_per_capita.csv", stringsAsFactors = F)

countries <- gdp$Country.Name

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
