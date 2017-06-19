library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(DataCache)

knitr::opts_chunk$set(echo = FALSE, cache = TRUE)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

experiments <- betydb_query(table='experiments')

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedExp', 'Experiment', experiments$name),
      uiOutput('selectVariable')
    ),
    mainPanel(
      plotOutput('traitPlot')
    )
  )
)

# load traits function used for cache functionality
loadTraitData <- function(startDate, endDate) {
  
  fullTraitData <- data.frame()
  
  currDate <- startDate
  while (endDate - currDate != 0) {
    currTraitData <- betydb_query(table='traits', data=paste0('~', currDate))
    fullTraitData <- rbind(fullTraitData, currTraitData)
    currDate <- currDate + days(1)
  }
  
  retData <- list(fullTraitData)
  names(retData) <- 'fullTraitData'
  
  return(retData)
}

server <- function(input, output) {
  
  output$traitPlot <- renderPlot({
    
    fullTraitData <- data.frame()
    
    selectedExpRow <- subset(experiments, name==input$selectedExp)
    experimentStartDate <- as.Date(selectedExpRow$start_date)
    experimentEndDate <- as.Date(selectedExpRow$end_date)
    
    data.cache(cache.name='TraitCache', loadTraitData, startDate=experimentStartDate, endDate=experimentEndDate)
    
    output$selectVariable <- renderUI({
      variableIds <- as.numeric(unique(fullTraitData$variable_id))
      selectInput('selectedVariable', 'Variable ID', variableIds)
    })
    variableTraitData <- subset(fullTraitData, variable_id=input$selectedVariable)
    
    qplot(as.Date(variableTraitData$date), variableTraitData$mean, main="[Variable] for [Experiment]", 
          xlab="Date", ylab="Unit", geom="auto")
  })
}
shinyApp(ui=ui, server=server)
