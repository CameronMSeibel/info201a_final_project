library(shiny)

source("./scripts/current.R")

# Define UI for application that draws a linePlot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GDP Comparisons!"),
  
  # Sidebar with a selector to choose a country
  sidebarLayout(
    sidebarPanel(
      selectInput("countryName", "Select a country",  choices),
      sliderInput("year", "Year", 2019:2119)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("map"),
      plotlyOutput("linePlot")
    )
  )
))