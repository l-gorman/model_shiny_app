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
          
          selectInput(
            "vars",
            "Variables:",
            types,
            selected = NULL,
            multiple = FALSE,
            selectize = TRUE,
            width = NULL,
            size = NULL
          ),
          
          selectInput(
            "proj",
            "Project:",
            types,
            selected = NULL,
            multiple = FALSE,
            selectize = TRUE,
            width = NULL,
            size = NULL
          ),
          
          conditionalPanel(
            condition = "input.params == 'Country Effect'",
          selectInput(
            "country",
            "Country:",
            types,
            selected = NULL,
            multiple = FALSE,
            selectize = TRUE,
            width = NULL,
            size = NULL
          ))),
          


        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))