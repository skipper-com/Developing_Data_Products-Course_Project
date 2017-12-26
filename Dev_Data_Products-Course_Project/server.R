library(shiny)
library(ggplot2)

# Define server logic required to draw and predict
shinyServer(function(input, output, session) {
   
  output$mpgPlot <- renderPlot({
    if (!is.null(input$cyl)) {
    mtcars_cyled <- mtcars[mtcars$cyl %in% input$cyl, ]
      g <- ggplot(data = mtcars_cyled, aes(x = wt, y = mpg)) +
        geom_point(aes(color = as.factor(cyl))) +
        geom_smooth(method = "lm") +
        facet_wrap(~ cyl)
      g
    }
  })
  
  output$cyl <- renderPrint({
    as.factor(input$cyl)
  })
  
  output$observations <- renderPrint({
    mtcars_disped <- mtcars[mtcars$disp > input$disp[1] & mtcars$disp < input$disp[2],]
    dim(mtcars_disped)[1]
  })
  
  output$disp_range <- renderUI({
    numericInput(inputId = 'disp_val', label = 'disp value to predict mpg', value = input$disp[1], min = input$disp[1], max = input$disp[2])
  })
  
  output$predict <- renderPrint({
    mtcars_disped <- mtcars[mtcars$disp > input$disp[1] & mtcars$disp < input$disp[2],]
    fitmod <- lm(mpg ~ disp + cyl + wt + am, data = mtcars_disped)
    pred_data <- data.frame(disp = input$disp_val, cyl = 6, wt = 2.5, am = 1)
    predict(fitmod, newdata = pred_data)
  })
})