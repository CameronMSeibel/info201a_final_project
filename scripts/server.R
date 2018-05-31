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
    "The goal of our project is to project a timeline for underdeveloped countries on their
way to development. We consider a country's wealth and life expectancies and use machine learning 
to identify and estimate its development. In our analysis we map the global distribution of wealth 
to reveal trends in geography and speed of development. The projections show a continuing uneven 
    distribution of wealth, with the countries nearest to other developed countries developing the fastest."

  })

    
  output$prediction_analysis <- renderText({
    "The graph above shows our model's prediction for country development from 2019-2119. As time progresses
    the distribution of development spreads from other developed countries, particularly in Europe with countries
    like Spain (2034), Austria (2035), and Lithuania (2038). Other parts of the world the undergo somewhat isolated 
    development are New Zealand (2023), and South Korea (2073)."
    
  })
  
  
  output$current_analysis <- renderText({
    "The above map displays information on the curent state of the world in terms of economic
    development. You may mouse over countries to view information about their current status of
    development, either developed or developing, and their GDP per capita."
  })
})