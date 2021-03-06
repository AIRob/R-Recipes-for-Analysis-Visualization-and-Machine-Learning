
auto <- read.csv("auto-mpg.csv")

shinyServer(function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "mtcars" = mtcars)
   })

  output$var <- renderUI({
    radioButtons("varname","Pick a Variable", names(datasetInput()))
  })
  
  output$plot <- renderPlot({
    if (!is.null(input$varname)) {
      if (!input$varname %in% names(datasetInput())) {
         colname <- names(datasetInput())[1]
      }
      else {
        colname <- input$varname
      }
      hist(datasetInput()[,colname], main=paste("Histogram of ", colname), xlab=colname)
    }
  }) 
  
})
