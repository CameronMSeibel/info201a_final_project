library(dplyr)
library(ggplot2)
library(maps)


make_map <- function(predictions)
{
  map_data <- map_data("world")
  View(map_data)
  map_data <- left_join(map_data, data, by = c("region" = "country"))
  
prediction_map <- ggplot(data = map_data) +
  geom_polygon(mapping = aes(x=long, y = lat, group = group, fill = t.data.), color = "lightgray") +
  scale_fill_manual(values=c("#b30000", "#fef0d9")) +
  labs(
    title = "CO2 Emissions by Country (metric tons per capita, 2014)", 
    fill = "CO2 Emission Level"
  ) +
  theme(
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
  )

return(prediction_map)
}

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
