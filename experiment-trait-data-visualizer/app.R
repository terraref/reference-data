library(shiny)
library(traits)
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

experiments <- betydb_query(table='experiments')

traitData <- betydb_query(table='traits', date='~2016-08')
varsIdsObserved <- as.numeric(unique(traitData[,'variable_id']))

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedExp', 'Experiment', experiments[,'name']),
      selectInput('selectedVariable','Variable', varsObserved)
    ),
    mainPanel(
      plotOutput('traitPlot')
    )
  )
)

server <- function(input, output) {
  output$traitPlot <- renderPlot({
  })
}
shinyApp(ui=ui, server=server)
