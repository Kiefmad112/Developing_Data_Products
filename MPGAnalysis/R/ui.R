#' MPG Analysis
#'
#' This function displays a tren analysis based MPG and engind displacement, filtered by
#' cylinder count and displacement size.
#'
#' @param slider1 selects engine displacement size
#' @param slider2 selects number of cylinders
#' @param showModel1 determines if model will be displayed in graph
#' @return a 'lm' object representing the linear model with the relevant values from mtcars
#' @name MPG Analysis
#' @author Kiefer Maddex
#' @title MPG Analysis UI R code
#' @description
#' This function displays the user interface of a trend analysis of MPG against engine displacement and number of cylinders
#' the raw data is automatically filter and displayed as the displacement and/or number of cylinders
#' change.
#' @details Using the mtcars dataframe to show trends of MPG based on the vehicles
#' engine displacement and cylinder size.
#' @seealso \code{lm}
#' @export
#' @importFrom shiny shinyUI

library(shiny)
shinyUI(fluidPage(

  titlePanel("MPG by Engine displacement and Cylinders:"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", "What is the vehicle's engine displacement?", 50, 500, value=300, step=25),
      sliderInput("slider2", "How many cylinders?", 4, 8, value=6, step = 2),
      checkboxInput("showModel1", "Show/Hide Model", value = TRUE),
      submitButton("Submit")
    ),

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Graph", br(), plotOutput("plot")),
                  tabPanel("Raw data", br(), dataTableOutput("data")),
                  textOutput("pred1")
      )
    )
  )
))
