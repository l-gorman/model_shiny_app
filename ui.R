#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

model_summary <- readr::read_csv("./data/full_model_summary.csv")


types <- unique(model_summary$type)
vars <- unique(model_summary$variable)
vars <- vars[!is.na(vars)]


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bayesian Hierarchical Meta-Analysis of Individual Farm Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput(
        "params",
        "Parameter Type:",
        types,
        selected = NULL,
        multiple = FALSE,
        selectize = TRUE,
        width = NULL,
        size = NULL
      ),
      
      
      conditionalPanel(
        condition = "input.params == 'Project Random Effects'",
        selectInput(
          "vars",
          "Variables:",
          vars,
          selected = NA,
          multiple = FALSE
          
        )),
      
      
      
      conditionalPanel(
        condition = "input.params != 'Intercept'",
        checkboxInput("sort", "Sort", FALSE)         
      ),
      
      checkboxInput("rangeselect", "Select Xlim Range", FALSE),         
      
      
      conditionalPanel(
        condition = "input.rangeselect == true",
        sliderInput("x_range", "Range:",
                    min = -2, max = 2, value = c(-1, 1), step = 0.01))),
        
    
      # 
      # selectInput(
      #   "proj",
      #   "Project:",
      #   types,
      #   selected = NULL,
      #   multiple = FALSE,
      #   selectize = TRUE,
      #   width = NULL,
      #   size = NULL
      # ),
      # 
      # conditionalPanel(
      #   condition = "input.params == 'Country Effect'",
      # selectInput(
      #   "country",
      #   "Country:",
      #   types,
      #   selected = NULL,
      #   multiple = FALSE,
      #   selectize = TRUE,
      #   width = NULL,
      #   size = NULL
      # ))),
      
      
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("distPlot")
      )
    )
  ))
  