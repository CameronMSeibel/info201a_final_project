library(shiny)

source("current.R")

# Define UI for application that draws a linePlot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GDP Comparisons!"),
  
  tabsetPanel(
    type = 'tabs',
    tabPanel(
      'Current', 
      sidebarLayout(
        sidebarPanel(
          selectInput("countryName", "Select a country",  choices)
        ),
        # Show a plot of the generated distribution
        mainPanel(
          plotlyOutput("map"),
          plotlyOutput("linePlot")
        )
      )
    ),
    tabPanel(
      'Prediction',
      sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Year", 2019, 2119, value = 2019)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput('prediction')
        )
      )
    )
  )
))