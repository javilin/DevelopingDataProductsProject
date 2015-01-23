library(googleCharts)

deaths = read.csv("SpanishRoadDeaths.csv")

shinyServer(function(input, output, session) {
  
  deathsRange <- reactive({
    deaths[deaths$year >= input$range[1] & deaths$year <= input$range[2],]
  })
  
  aggregateDeathsByType <- reactive({
    deathsRange = deathsRange()
    deathsRange$year = NULL
    deathsRange$total = NULL
    aggre = colSums(deathsRange)
    data.frame(type = colnames(deathsRange), deaths=as.vector(aggre))
  })
  
  getMean<- reactive({
    deathsRange = deathsRange()
    mean(deathsRange$total)
  })
  
  output$summary <- renderPrint({
    filterMean = getMean()
    cat(paste("The Average Deaths of the selected Range is:", round(getMean(),2)))
  })
  
  output$doc <- renderPrint({
    cat("This Shiny app allows you to analyze the spanish traffic-related deaths for a select range of years between 1993 and 2013. Use the slider at the left side to look at:
        \n- The average of deaths 
        \n- Total Deaths per Year
        \n- Total Deaths per type of Vehicle
        \n\n Every time the range is changed, the data set is filtered and aggregated to get the sum of deaths for each type of vehicle")
  })
  
  output$line <- reactive({
    data = deathsRange()
    list(data = googleDataTable(
        data.frame(Year = data$year,
                   Death = data$total)
    ),
    options = list(title= "Traffic-related Deaths by Year",
                   hAxis = list(title="Year"),
                   vAxis = list(title="Total Deaths")))
  })
  
  output$pie <- reactive({
    data = aggregateDeathsByType()
    list(data = googleDataTable(data),
      options = list(title = "Deaths by Type of Vehicle",is3D=TRUE)
    )
  })
})
