library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(DataCache)

knitr::opts_chunk$set(echo = FALSE, cache = TRUE)

options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

experiments <- as.data.frame(betydb_query(table='experiments'))
seasons <- unique(experiments[c('start_date', 'end_date')])
rownames(seasons) <- paste0(seasons$start_date, ' - ', seasons$end_date)

ui <- fluidPage(
  titlePanel("BETYdb Trait Data"),
  sidebarLayout (
    sidebarPanel(
      selectInput('selectedSeason', 'Season', rownames(seasons)),
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
    currTraitData <- betydb_query(table='traits', date=paste0('~', currDate))
    fullTraitData <- rbind(fullTraitData, currTraitData)
    currDate <- currDate + days(1)
  }
  
  retData <- list(fullTraitData)
  names(retData) <- 'fullTraitData'
  
  return(retData)
}

server <- function(input, output) {
  
  selectedSeasonRow <- reactive({ seasons[input$selectedSeason,] })
  seasonStartDate <- reactive({ as.Date(selectedSeasonRow()$start_date) })
  seasonEndDate <- reactive({ as.Date(selectedSeasonRow()$end_date) })
  
  cacheName <- reactive({ paste0('TraitCache_', seasonStartDate(), '_', seasonEndDate()) })

  output$selectVariable <- renderUI({
    
    data.cache(cache.name=cacheName(), loadTraitData, startDate=seasonStartDate(), endDate=seasonEndDate())
 
    variableIds <- as.numeric(unique(fullTraitData$variable_id))
    variableNames <- vector()
    for (variableId in variableIds) {
      varName <- betydb_query(table='variables', id=variableId)$name
      varName <- gsub('_', ' ', varName)
      variableNames <- c(variableNames, varName)
    }
    names(variableIds) <- variableNames
    
    selectInput('selectedVariable', 'Variable', variableIds)
  })
  
  output$traitPlot <- renderPlot({

    data.cache(cache.name=cacheName(), loadTraitData, startDate=seasonStartDate(), endDate=seasonEndDate())
    
    variableIdData <- betydb_query(table='variables', id=input$selectedVariable)
    variableTraitData <- subset(fullTraitData, variable_id==variableIdData$id)
    
    qplot(as.Date(variableTraitData$date), variableTraitData$mean, 
          main="Mean Values", 
          xlab="Date", ylab=variableIdData$units)
  })
  
}

shinyApp(ui=ui, server=server)