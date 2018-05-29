library(dplyr)
library(ggplot2)
library(plotly)
library(maps)

gdp <- read.csv("../data/input/gdp_per_capita.csv", stringsAsFactors = F)

gdp <- gdp %>% select(Country.Name, Country.Code, X2016)
View(gdp)

gdp$dev_index <- "N/A"

gdp <- na.omit(gdp)


gdp[gdp$X2016 > 0, "dev_index"] <- "Undeveloped"
gdp[gdp$X2016 > 5000, "dev_index"] <- "Developing"

gdp[gdp$X2016 > 35000, "dev_index"] <- "Developed"

map_data <- map_data("world")
map_data <- map_data %>% mutate(iso_codes = iso.alpha(map_data$region, 3))

View(map_data)

map_data <- left_join(map_data, gdp, by = c("iso_codes" = "Country.Code"))

worldmap <- ggplot(data = map_data) +
  geom_polygon(mapping = aes(x=long, y = lat, group = group, fill = dev_index), color = "lightgray") +
  scale_fill_manual(values=c("#2ca25f","#99d8c9", "#e5f5f9")) +
  labs(
    title = "Economic Development of Countries (2016)", 
    fill = "Development Index"
  ) +
  theme(
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
  )
worldmap
