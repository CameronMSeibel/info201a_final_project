library(shiny)

source("current.R")

# Define UI for application that draws a linePlot

ui_1 <- fluidPage(
  
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
)

ui_2 <- fluidPage(
  titlePanel("Degree of Development"),
  navlistPanel(
    "Current",
    tabPanel(
      "Current GDP Map",
      plotlyOutput("map")
    ),
    tabPanel(
      "GDP Comparisons",
      sidebarLayout(
        sidebarPanel(
          selectInput("countryName", "Select a country",  choices)
        ),
        # Show a plot of the generated distribution
        mainPanel(
          plotlyOutput("linePlot")
        )
      )
    ),
    "Prediction",
    tabPanel(
      "Prediction Map",
      sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Year", 2019, 2119, value = 2019)
        ),
        
        mainPanel(
          # Show a plot of the generated distribution
          plotOutput('prediction')
        )
      )
    )
  )
)

ui_3 <- navbarPage("GDP",
  tabPanel(
    "Introduction",
    textOutput('introduction')
  ),
  navbarMenu(
    "Current",
    tabPanel(
      "Current GDP Map",
      plotlyOutput("map")
    ),
    tabPanel(
      "GDP Comparisons",
      sidebarLayout(
        sidebarPanel(
          selectInput("countryName", "Select a country",  choices)
        ),
        mainPanel(
          plotlyOutput("linePlot")
        )
      )
    )
  ),
  tabPanel(
    "Prediction Map",
    sidebarLayout(
      sidebarPanel(
        sliderInput("year", "Year", 2019, 2119, value = 2019)
      ),
      
      mainPanel(
        plotOutput('prediction'),
        textOutput('prediction_analysis')
      )
    )
  )
)

shinyUI(ui_3)