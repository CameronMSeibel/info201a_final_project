# Cameron Seibel
#
# This file will define a number of constants and functions shared between the scripts for
# wrangling and analysis of data.

# Range of the data set; although there is a better way to do this, I won't bother.
year_range <- 1960:2017

# Range of years to estimate values for; about a century of values from the present.
estimate_range <- 2019:2119


# clean_string takes a string, str, as a parameter.
# Returns a "cleaned" version of the string, replacing problematic characters as needed.
clean_string <- function(str){
  return(gsub(" ", "_", str))
}