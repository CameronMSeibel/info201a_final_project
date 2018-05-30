# Setting up
library("dplyr")
library("maps")
library("plotly")

source("common.R")

gdp <- read.csv("../data/input/gdp_per_capita.csv")

gdp <- gdp %>% mutate(category = sapply(Country.Name, initial_classification))

g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)

l <- list(color = toRGB("grey"), width = 0.5)

world_map <- plot_geo(gdp) %>%
  add_trace(
    z = ~X2016, color = ~X2016, colors = 'Blues',
    text = ~category, locations = ~Country.Code, marker = list(line = l)
  ) %>%
  colorbar(title = 'GDP', tickprefix = '$') %>%
  layout(
    title = 'World GDP <br> Source:<a href="(http://databank.worldbank.org/data/home.aspx">World Bank</a>',
    geo = g
  )

choices <- gdp$Country.Name

years <- year_range

gdp_t <- gdp %>% select(-Country.Code, -Indicator.Name, -Indicator.Code, -category) %>% t()
colnames(gdp_t) = gdp_t[1, ]
gdp_t = gdp_t[-1, ] 

usa_data <- gdp_t[, "United States"]

compare.gdp <- function(other_country){

  other_country_data<- gdp_t[, other_country]
    
  p <- plot_ly(gdp, x = ~years, y = ~usa_data, name = 'United States', type = 'scatter', mode = 'lines',
               line = list(color = 'rgb(205, 12, 24)', width = 2)) %>%
    add_trace(y = ~other_country_data, name = ~other_country, line = list(color = 'rgb(22, 96, 167)', width = 2))  %>% 
    layout(title = paste("Comparison of GDP/capita between United States and", other_country),
           xaxis = list(title = "Years"),
           yaxis = list(title = "GDP/capita", nticks = 10, tickformat = ',d'))
  p
}

compare.gdp("India")

