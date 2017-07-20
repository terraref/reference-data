library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(timevis)
library(cronR)

# set up scheduled execution of cache update
cache_update_cmd <- cron_rscript("cache-update.R")
try(cron_add(command = cache_update_cmd, frequency = 'daily', 
             id = 'cache-update', description = 'daily update of BETYdb cache'))

# load data from file
# cache structure:
#   cache_data - list (of seasons)
#     season 1 - list 
#       start_date - string
#       end_date - string
#       managements - data frame (date, mgmttype)
#       trait_data - list (of variables)
#         Emergence Count - list
#           units - string
#           traits - data frame (date, mean, cultivar_id)
#           cultivars - vector (of unique cultivars with names)
#         Canopy Height
#         ...
#     season 2
#     ...

load("cache.RData")
seasons <- names(cache_data)

# set page UI
ui <- fluidPage(
  
  title = "TERRA-REF Experiment Data",
  
  fluidRow(
    column(width = 8, offset = 2,
    
      fluidRow(
        style = 'margin-bottom: 25px',
        
        h1('TERRA-REF Experiment Data'),
    
        tags$div(
          style = "
            width: 250px;
            float: left;
          ",
          selectInput('selected_season', 'Season', seasons),
          hr(),
          uiOutput('select_variable'),
          uiOutput('select_cultivar')
        ),
        
        tags$div(
          style = "
            width: 200px;
            float: left;
            margin-top: 125px;
            margin-left: 50px;
          ",
          verbatimTextOutput("trait_hover_info")
        )
      ),
      
      plotOutput('trait_plot', hover = hoverOpts(id = "plot_hover")),

      hr(),
      h3('Managements Data'),
      
      tags$div(
        style = "
          width: 500px;
          height: auto;
        ",
        verbatimTextOutput("management_hover_info")
      ),
      
      timevisOutput('timeline')
    )
  )
)

# render page elements
server <- function(input, output) {
  
  # selected_season_data: list of BETYdb data associated with selected season
  selected_season_data <- reactive({ cache_data[[ input$selected_season ]] })
  
  # render menu for variable selection
  output$select_variable <- renderUI({
    selectInput('selected_variable', 'Variable', names(selected_season_data()[[ 'trait_data' ]]))
  })
  
  # render menu for cultivar selection
  output$select_cultivar <- renderUI({
    
    if (!is.null(input$selected_variable)) {
      cultivar_ids <- selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'cultivars' ]]
      unique_cultivar_ids <- cultivar_ids
      cultivar_select_menu <- c('None', unique_cultivar_ids)
      selectInput('selected_cultivar', 'Cultivar', cultivar_select_menu)
    }
  })
  
  # render plot for selected variable, cultivar
  output$trait_plot <- renderPlot({
    
    if (!is.null(input$selected_variable) & !is.null(input$selected_cultivar)) {
      
      plot_data <- selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'traits' ]]
      data_max <- max(plot_data[[ 'mean' ]])

      units <- selected_season_data()[[ 'trait_data' ]][[ input$selected_variable ]][[ 'units' ]]
      
      # generate timeseries of boxplots from mean value
      ggplot(plot_data, aes(as.Date(date), mean)) + 
      geom_boxplot(aes(group=cut_width(as.Date(date), 1)), outlier.alpha = 0.1) +
        
      { 
        if (input$selected_cultivar != 'None') {
          geom_point(data = subset(plot_data, cultivar_id == input$selected_cultivar), 
            size = 1, color = "red", aes(x = as.Date(date), y = mean))
        }
      } +
        
      labs(
        title = input$selected_variable,
        x = "Observation Dates",
        y = units
      ) +
      theme(text = element_text(size = 20), axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
      xlim(as.Date(selected_season_data()[[ 'start_date' ]]), as.Date(selected_season_data()[[ 'end_date' ]])) +
      ylim(0, data_max)
    }
  })
  
  output$trait_hover_info <- renderText({
    if(!is.null(input$plot_hover)){
      paste0(
        'Date \n',
        toString(
          as.Date(input$plot_hover$x, origin = lubridate::origin)
        ),
        '\n\n',
        'Value \n',
        format(round(input$plot_hover$y, 2))
      )
    }
  })
  
  output$management_hover_info <- renderText({
    if(!is.null(input$timeline_selected)){
      selected_record <- subset(
          selected_season_data()[[ 'managements' ]],
          id == input$timeline_selected
      )
      paste0(
        selected_record[[ 'mgmttype' ]],
        '\n',
        selected_record[[ 'date' ]],
        '\n\n',
        selected_record[[ 'notes' ]]
      )
    }
  })
  
  # generate timeline visualization for management data
  output$timeline <- renderTimevis({
    management_data <- selected_season_data()[[ 'managements' ]]
    timeline_data <- data.frame(
      id = management_data$id,
      content = management_data$mgmttype,
      start = as.Date(management_data$date)
    )
    
    timevis(
      timeline_data,
      options = list(zoomable = FALSE)
    )
  })
}

shinyApp(ui=ui, server=server)