library(googleCharts)

deaths = read.csv("SpanishRoadDeaths.csv")


shinyUI(fluidPage(
  titlePanel("Spanish Accident Mortality"),
  sidebarLayout(
    sidebarPanel(HTML('<img src="http://upload.wikimedia.org/wikipedia/en/9/9a/Flag_of_Spain.svg" height="60" width="60"/>'),
                 tags$head(
                   tags$style(type="text/css", "label.radio { display: inline-block; }", ".radio input[type=\"radio\"] { float: none; }"),
                   tags$style(type="text/css", "select { max-width: 100px; }"),
                   tags$style(type="text/css", "textarea { max-width: 120px; }"),
                   tags$style(type="text/css", ".jslider { max-width: 110px; }"),
                   tags$style(type='text/css', ".well { max-width: 300px; }"),
                   tags$style(type='text/css', ".span4 { max-width: 130px; }")
                 ),
                 sliderInput("range","Select the Years Range",min = min(deaths$year),max = max(deaths$year),value = c(min(deaths$year),max(deaths$year)), step = 1, round = TRUE, ticks = TRUE, animate = TRUE)),
    mainPanel(googleChartsInit(),
              verbatimTextOutput("doc"),
              verbatimTextOutput("summary"),
              googleLineChart('line', width='100%', height='300px'),
              googlePieChart('pie', width='400px', height='400px')
    )
    
  )))