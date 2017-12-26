library(shiny)

# Define UI for application that plays with mtcars
shinyUI(fluidPage(
  # Application title
  titlePanel("Annoyed mtcars"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p("Check number of cylinders you want to see:"),
      checkboxGroupInput(inputId = "cyl", label = "Cylinders", c("4-cyl" = "4", "6-cyl" = "6", "8-cyl" = "8"), selected = "4"),
      sliderInput(inputId = "disp", label = "Disp range:", min = 70, max = 470, value = c(70, 470), step = 20),
      uiOutput("disp_range")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("date"),
      h4("Play with mpg ~ wt plot"),
      p("This is ordinary plot of annoyed mtcars data. Don't try to find amazing results and bloody-good models. Of course, all is possible, but not here:) Have a nice play!"),
      p("lm model is fitted based on disp values you choose (set a range you limit observation to those, which has disp value in range), additionally model has cyl, wt and am variables."),
      plotOutput("mpgPlot"),
      h4("Play with mpg prediction based on disp, cyl, wt and am"),
      p("Enter disp value (in selected range above) to predict mpg. cyl is fixed to 4, wt is fixed to 2.5, am is fixed to 1."),
      verbatimTextOutput("observations"),
      verbatimTextOutput("predict")
    )
  )
))
