library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(timevis)

# set options for BETYdb API
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)
options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

# load data from file
load("cache.RData")
seasons <- names(cache_data)

# set page UI
ui <- fluidPage(
  
  column(width=8, offset=2,
         
    title = "TERRA-REF Experimental Data",
  
    h1('TERRA-REF Experimental Data'),

    # season menu
    selectInput('selected_season', 'Season', seasons),
  
    hr(),
    h3('Trait Data'),
  
    # variable, cultivar menus to be rendered with variables, cultivars from the selected season
    uiOutput('select_variable'),
    uiOutput('select_cultivar'),
  
    plotOutput('trait_plot'),
  
    hr(),
    h3('Managements Data'),
  
    timevisOutput('timeline')
  )
  
)

# render page elements
server <- function(input, output) {
  
  selected_season_data <- reactive({ cache_data[[ input$selected_season ]] })
  
  # render menu for variable selection
  output$select_variable <- renderUI({
    selectInput('selected_variable', 'Variable', names(selected_season_data()[[ 'trait_data' ]]))
  })
  
  # render menu for cultivar selection
  output$select_cultivar <- renderUI({
    
    if (!is.null(input$selected_variable)) {
      cultivar_ids <- selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'traits' ]][[ 'cultivar_id' ]]
      unique_cultivar_ids <- sort(unique(as.numeric(cultivar_ids)))
      cultivar_select_menu <- c('All Cultivars', unique_cultivar_ids)
      selectInput('selected_cultivar', 'Cultivar', cultivar_select_menu)
    }
  })
  
  # render plot for selected variable, cultivar
  output$trait_plot <- renderPlot({
    
    if (!is.null(input$selected_variable)) {
      
      units <- selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'units' ]]
      
      # generate timeseries of boxplots from mean value
      ggplot(selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'traits' ]], aes(as.Date(date), mean)) + 
      geom_boxplot(aes(group=cut_width(as.Date(date), 1))) +
      labs(
        title = paste0(input$selected_variable),
        x = "Observation Dates",
        y = units
      ) +
      theme(text = element_text(size = 20), axis.text.x = element_text(angle = 45, hjust = 1)) +
      expand_limits(y = 0) + 
      xlim(as.Date(selected_season_data()[[ 'start_date' ]]), as.Date(selected_season_data()[[ 'end_date' ]]))
    }
  })
  
  # generate timeline visualization for management data
  output$timeline <- renderTimevis({
    management_data <- selected_season_data()[[ 'managements' ]]
    timeline_data <- data.frame(
      id = 1:nrow(management_data),
      content = management_data$mgmttype,
      start = as.Date(management_data$date)
    )
    
    timevis(timeline_data)
  })
}

shinyApp(ui=ui, server=server)