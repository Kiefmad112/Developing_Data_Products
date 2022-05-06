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
#' @title MPG Analysis Server R code
#' @description
#' This function runs a trend analysis of MPG against engine displacement and number of cylinders
#' the raw data is automatically filter and displayed as the displacement and/or number of cylinders
#' change.
#' @details Using the mtcars dataframe to show trends of MPG based on the vehicles
#' engine displacement and cylinder size.
#' @seealso \code{lm, shiny, dplyr}
#' @importFrom shiny shinyServer
#' @importFrom dplyr filter

library(shiny)
library(dplyr)
shinyServer(function(input, output) {

  cars <- reactive({
    carmodel <- filter(mtcars, mtcars$disp <= input$slider1, mtcars$cyl <= input$slider2)
  })

  model1 <- lm(disp ~ mpg, data = mtcars)

  model1pred <- reactive({
    dispInput <- input$slider1
    cylInput <- input$slider2
    predict(model1, newdata = data.frame(cyl <= mpgInput, disp <= dispInput))
  })

  #Plot Output
  #--------------------
   output$plot <- renderPlot({
     carmodel <- filter(mtcars, disp <= input$slider1, cyl <= input$slider2)
     plot(carmodel$mpg, carmodel$disp, ylab = "Engine Disp", xlab = "MPG", pch = 16, col = carmodel$cyl)

     #Display Legend
     legend(30, 147, c("8 Cylinders", "6 Cylinders", "4 Cylinders"), pch = 16,
            col = c("grey", "darkmagenta", "dodgerblue"), bty = "n", cex = 1 )

     #Display Model
     if(input$showModel1){
       abline(model1, col = "blue", lwd = 2, lty = 3)
     }

  })


  #Raw data Output
  #--------------------
   cars <- reactive({
     carmodel <- filter(mtcars, disp <= input$slider1, cyl <= input$slider2)
  })

    output$data <- renderDataTable({ cars()
  })


})
