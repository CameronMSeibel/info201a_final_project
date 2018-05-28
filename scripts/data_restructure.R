# Cameron Seibel
#
# This script will refactor the given CSV files such that they will be easier to use in
# linear modelling and nnet predictions.

gdp <- read.csv("../data/gdp_per_capita.csv", stringsAsFactors = F)