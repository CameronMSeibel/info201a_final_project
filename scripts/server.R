library(shiny)
library(stringr)

source("current.R")
source("prediction_map.R")

# Define server logic required to draw a line chart
shinyServer(function(input, output) {
  processed_data <- reactive({
    data <- read.csv("data/output/development_classifications.csv", stringsAsFactors = FALSE)
    year_of_interest <- 2050#input$year
    
    data <- data %>% filter(year == year_of_interest) %>% select(-X, -year)
    data <- data.frame(t(data))
    
    data <- data %>% mutate(country = rownames(data))
    data$country <- chartr("_", " ", data$country)
    data$country <- substr(data$country,0, nchar(data$country) - 15)
    
    data <- fix_country_names(data)
   
    return(data)
  })
  
  output$prediction <- renderPlot(make_map(processed_data))
  output$map <- renderPlotly(world_map)
  
  output$linePlot <- renderPlotly({
   # draw the plot for the selected country and USA
    compare.gdp(input$countryName)
  })
  
})