library(shiny)
shinyServer(function(input, output) {

  cars <- reactive({
    carmodel <- filter(mtcars, disp <= input$slider1, cyl <= input$slider2)
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
