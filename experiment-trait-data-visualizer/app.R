library(shiny)
library(traits)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')
experiments <- betydb_query(table='experiments')

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedExp', 'Experiment', experiments[,'name']),
      selectInput('selectedVariable','Variable', c('Variable 1', 'Variable 2'))
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
