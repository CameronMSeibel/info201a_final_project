# Maxwell Warchol
# Functions related to the creation and utilization of the prediction map
library(dplyr)
library(ggplot2)
library(maps)


# Processes data from the models predictions so that it can be used with the maps package
make_prediction_map <- function(year_of_interest)
{
  # Year is input from sliders
  prediction_data <- read.csv("../data/output/development_classifications.csv", stringsAsFactors = FALSE)
  prediction_data <- prediction_data %>% filter(year == year_of_interest) %>% select(-X, -year)
  prediction_data <- data.frame(t(prediction_data))
  colnames(prediction_data) <- "development"
  prediction_data <- prediction_data %>% mutate(country = rownames(prediction_data))
  prediction_data$country <- gsub('_Classification', '', prediction_data$country)
  prediction_data$country <- gsub('_', ' ', prediction_data$country)
  prediction_data <- fix_country_names(prediction_data)
  

  map_data <- map_data("world")
  map_data <- left_join(map_data, prediction_data, by = c("region" = "country"))
  
  prediction_map <- ggplot(data = map_data) +
    geom_polygon(mapping = aes(x=long, y = lat, group = group, fill = development), color = "lightgray") +
    scale_fill_manual(values=c("#b30000", "#fef0d9")) +
    labs(
      title = paste0("World Development Level in ", year_of_interest, " (Prediction)"), 
      fill = "Develpoment Level"
    ) +
    theme(
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      plot.title = element_text(hjust = 0.5)
    )

return(prediction_map)
}



# Certain country names are retrieved in a different format. These are reformatted so they can be mapped.
fix_country_names <- function(names)
{
  names[names$country == "Iran. Islamic Rep.", "country"] <- "Iran"
  names[names$country == "Korea. Rep.", "country"] <- "South Korea"
  names[names$country == "Bahamas. The", "country"] <- "Bahamas"
  names[names$country == "Congo. Dem. Rep.", "country"] <- "Democratic Republic of the Congo"
  names[names$country == "Congo. Rep.", "country"] <- "Republic of Congo"
  names[names$country == "Cote d.Ivoire", "country"] <- "Ivory Coast"
  names[names$country == "Egypt. Arab Rep.", "country"] <- "Egypt"
  names[names$country == "Gambia. The", "country"] <- "Gambia"
  names[names$country == "Guinea.Bissau", "country"] <- "Guinea-Bissau"
  names[names$country == "Lao PDR", "country"] <- "Laos"
  names[names$country == "Macedonia. FYR", "country"] <- "Macedonia"
  names[names$country == "Micronesia. Fed. Sts.", "country"] <- "Micronesia"
  names[names$country == "Russian Federation", "country"] <- "Russia"
  names[names$country == "United Kingdom", "country"] <- "Great Britain"
  names[names$country == "United States", "country"] <- "USA"
  names[names$country == "Venezuela. RB", "country"] <- "Venezuela"
  names[names$country == "Yemen. Rep.", "country"] <- "Yemen"
  
  return(names)
  
}
