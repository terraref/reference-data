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
#           cultivars - vector (of unique cultivars)
#         Canopy Height
#         ...
#     season 2
#     ...

load("cache.RData")
seasons <- names(cache_data)

# set page UI
ui <- fluidPage(
  
  fluidRow(
    column(width = 8, offset = 2,
           
      title = "TERRA-REF Experiment Data",
    
      h1('TERRA-REF Experiment Data'),
  
      # season menu
      selectInput('selected_season', 'Season', seasons),
    
      hr(),
    
      # variable, cultivar menus to be rendered with variables, cultivars from the selected season
      fluidRow(
        h3('Trait Data'),
        column(width = 6, 
          uiOutput('select_variable'),
          uiOutput('select_cultivar')
        ),
        column(width = 6,
          verbatimTextOutput("hover_info")
        )
      ),
    
      plotOutput('trait_plot', height = 500, hover = hoverOpts(id = "plot_hover")),
    
      hr(),
      h3('Managements Data'),
    
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
  
  output$hover_info <- renderText({
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