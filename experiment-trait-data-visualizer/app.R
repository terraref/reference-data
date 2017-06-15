library(shiny)
library(traits)
library(ggplot2)

knitr::opts_chunk$set(echo = FALSE, cache = TRUE)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

experiments <- betydb_query(table='experiments')
#varIdsObserved <- as.numeric(unique(traitData$variable_id))

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedExp', 'Experiment', experiments$name)
      #selectInput('selectedVariable','Variable', varIdsObserved)
    ),
    mainPanel(
      plotOutput('traitPlot')
    )
  )
)

server <- function(input, output) {
  
  output$traitPlot <- renderPlot({
    
    fullTraitData = data.frame()
    
    selectedExpRow <- subset(experiments, name==input$selectedExp)
    experimentStartDate <- as.Date(selectedExpRow$start_date)
    experimentEndDate <- as.Date(selectedExpRow$end_date)
    
    currDate <- experimentStartDate
    while (experimentEndDate - currDate != 0) {
      currTraitData <- betydb_query(table='traits', date=paste0('~', currDate), limit='5')
      fullTraitData <- rbind(fullTraitData, currTraitData)
      currDate <- currDate + days(1)
    }
    
    qplot(as.Date(fullTraitData$date), fullTraitData$mean, main="[Variable] for [Experiment]", 
          xlab="Date", ylab="Unit", geom="auto")
  })
}
shinyApp(ui=ui, server=server)
