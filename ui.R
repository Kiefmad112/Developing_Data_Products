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
                  #tabPanel("Summary", br(),  dataTableOutput("out3")),
                  textOutput("pred1")
      )
    )
  )
))
