library(shiny)
library(traits)
library(ggplot2)

knitr::opts_chunk$set(echo = FALSE, cache = TRUE)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

experiments <- betydb_query(table='experiments')

traitData <- betydb_query(table='traits', date='~2016-08', limit=2000)
varIdsObserved <- as.numeric(unique(traitData$variable_id))

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedExp', 'Experiment', experiments$name),
      selectInput('selectedVariable','Variable', varIdsObserved)
    ),
    mainPanel(
      plotOutput('traitPlot')
    )
  )
)

server <- function(input, output) {
  output$traitPlot <- renderPlot({
    qplot(as.Date(traitData$date), traitData$mean, main="[Variable] for [Experiment]", 
          xlab="Date", ylab="Unit", geom="auto")
  })
}
shinyApp(ui=ui, server=server)
