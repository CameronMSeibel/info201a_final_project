library(shiny)

source("scripts/current.R")

# Define server logic required to draw a line chart
shinyServer(function(input, output) {
  
  output$map <- renderPlotly(world_map)
  
  output$linePlot <- renderPlotly({
   # draw the plot for the selected country and USA
    compare.gdp(input$countryName)
  })
  
})