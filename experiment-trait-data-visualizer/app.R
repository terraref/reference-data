library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(DataCache)
library(timevis)

# set options for BETYdb API
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)
options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

# get list of seasons for user to select from
experiments <- as.data.frame(betydb_query(table='experiments'))
seasons <- unique(experiments[c('start_date', 'end_date')])
rownames(seasons) <- paste0('[', seasons$start_date, ']', ' - ', '[', seasons$end_date, ']')

# set page UI
ui <- fluidPage(
  
  column(width=8, offset=2, 
    title = "TERRA-REF Experimental Data",
  
    h1('TERRA-REF Experimental Data'),

    # season menu
    selectInput('selectedSeason', 'Season', rownames(seasons)),
  
    hr(),
  
    h3('Trait Data'),
  
    # variable menu to be rendered when variables for a given season are parsed in server()
    uiOutput('selectVariable'),
  
    plotOutput('traitPlot'),
  
    hr(),
    h3('Managements Data'),
  
    timevisOutput('timeline')
  )
  
)

# load trait data from BETYdb
# function is used only by DataCache library to get and update data
loadTraitData <- function(startDate, endDate) {
  
  # set progress bar while API is queried
  withProgress(message="Retrieving BETYdb Data", value=0, {
    
    fullTraitData <- data.frame()
    
    initialDateDiff <- as.numeric(difftime(endDate, startDate, units="days"))
    currDate <- startDate
    # loop through all days in a given season
    while (endDate - currDate != 0) {
      # get trait data for each day
      currTraitData <- betydb_query(table='traits', date=paste0('~', currDate), limit='none')
      fullTraitData <- rbind(fullTraitData, currTraitData[c('date', 'mean', 'variable_id', 'specie_id')])
      currDate <- currDate + days(1)
      
      # update progress bar
      incProgress(1/initialDateDiff)
    }
  })
  
  # format data as for usability with DataCache library
  retData <- list(fullTraitData)
  names(retData) <- 'fullTraitData'
  
  return(retData)
}

getManagementsData <- function(startDate, endDate) {

    fullMgmtData <- data.frame()
    
    currDate <- startDate
    while (endDate - currDate != 0) {
      # get management data for each day
      currMgmtData <- betydb_query(table='managements', date=paste0('~', currDate))
      fullMgmtData <- rbind(fullMgmtData, currMgmtData[c('date', 'mgmttype')])
      currDate <- currDate + days(1)
    }
    
    return(fullMgmtData)
}

# handle all app logic
server <- function(input, output) {
  
  # set reactive start date and end date variables to change when selected season changes
  selectedSeasonRow <- reactive({ seasons[input$selectedSeason,] })
  seasonStartDate <- reactive({ as.Date(selectedSeasonRow()$start_date) })
  seasonEndDate <- reactive({ as.Date(selectedSeasonRow()$end_date) })
  
  # set unique cache name for date range for usability with DataCache library
  cacheName <- reactive({ paste0('TraitCache_', seasonStartDate(), '_', seasonEndDate()) })
  
  # render menu for selecting variable to view data for
  output$selectVariable <- renderUI({
    
    # get access to 'fullTraitData' from cache
    data.cache(cache.name=cacheName(), loadTraitData, startDate=seasonStartDate(), endDate=seasonEndDate(), frequency='daily')
 
    # get unique variable ids from observations in current season
    variableIds <- unique(as.numeric(fullTraitData$variable_id))
    
    # query API for readable names for variable ids, set names
    variableNames <- vector()
    for (variableId in variableIds) {
      varName <- betydb_query(table='variables', id=variableId)$name
      varName <- gsub('_', ' ', varName)
      variableNames <- c(variableNames, varName)
    }
    names(variableIds) <- variableNames
    
    selectInput('selectedVariable', 'Variable', variableIds)
  })
  
  # render plot for selected variable
  output$traitPlot <- renderPlot({

    # get access to 'fullTraitData' from cache
    data.cache(cache.name=cacheName(), loadTraitData, startDate=seasonStartDate(), endDate=seasonEndDate())
    
    # only render plot of a variable is selected
    if (!is.null(input$selectedVariable)) {
      # get observations for selected variable
      variableIdData <- betydb_query(table='variables', id=input$selectedVariable)
      variableTraitData <- subset(fullTraitData, variable_id==as.numeric(variableIdData$id))
      
      # get specie data for title
      specieId <- unique(as.numeric(variableTraitData$specie_id))
      specieData <- betydb_query(table='species', id=specieId)
      title <- paste0('Mean ', gsub('_', ' ', variableIdData$name), ' for ', specieData$scientificname)

      # generate timeseries of boxplots from mean value
      ggplot(variableTraitData, aes(as.Date(date), mean)) + 
      geom_boxplot(aes(group=cut_width(as.Date(date), 1))) +
      labs(title=title,
        x="Observation Dates", y=variableIdData$units) +
        theme(text = element_text(size=20), axis.text.x = element_text(angle=45, hjust=1)) +
        expand_limits(y=0) + xlim(seasonStartDate(), seasonEndDate())
    }
  })
  
  # generate timeline visualization for managements data
  output$timeline <- renderTimevis({
    mgmtData <- getManagementsData(startDate=seasonStartDate(), endDate=seasonEndDate())
    timelineData <- data.frame(
      id=1:nrow(mgmtData),
      content=paste0(mgmtData$mgmttype),
      start=as.Date(mgmtData$date)
    )
    timevis(timelineData)
  })
}

shinyApp(ui=ui, server=server)