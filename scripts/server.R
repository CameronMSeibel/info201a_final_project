library(shiny)
library(stringr)

source("current.R")
source("prediction_map.R")

# Define server logic required to draw a line chart
shinyServer(function(input, output) {
  
  output$prediction <- renderPlot({
    make_prediction_map(input$year)
  })
  output$map <- renderPlotly(world_map)
  
  output$linePlot <- renderPlotly({
   # draw the plot for the selected country and USA
    compare.gdp(input$countryName)
  })
  
  
  output$introduction <- renderText({
    "balabala"
  })
})