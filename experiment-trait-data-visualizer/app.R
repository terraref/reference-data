library(shiny)

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedSeason', 'Season', c('Season 1', 'Season 2', 'Season 3')),
      selectInput('selectedVariable','Variable', c('Variable 1', 'Variable 2', 'Variable 3'))
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
