library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(timevis)
library(cronR)

# set up scheduled execution of cache update
#cache_update_cmd <- cron_rscript("cache-refresh.R")
#try(cron_add(command = cache_update_cmd, frequency = 'daily', 
#            id = 'cache-update', description = 'daily update of BETYdb cache'))

# set page UI
ui <- fluidPage(theme = "style.css",
  
  title = "TERRA-REF Experiment Data",
  
  fluidRow(
    column(width = 8, offset = 2,
    
      fluidRow(
        class = 'title-row',
        
        h1('TERRA-REF Experiment Data'),
    
        tags$div(
          class = 'select-input-group',
          
          uiOutput('select_season'),
          hr(),
          uiOutput('select_variable'),
          uiOutput('select_cultivar')
        ),
        
        tags$div(
          class = 'hover-text',
          
          verbatimTextOutput('trait_hover_info')
        )
      ),
      
      plotOutput('trait_plot', hover = hoverOpts(id = 'plot_hover')),

      hr(),
      h3('Managements Data'),
      
      tags$div(
        class = 'management-select-info',
        
        verbatimTextOutput('management_hover_info')
      ),
      
      timevisOutput('timeline')
    )
  )
)

# render page elements
server <- function(input, output) {
  
  load('cache.RData')
  
  output$select_season <- renderUI({
    seasons <- names(full_cache_data)
    selectInput('selected_season', 'Season', seasons)
  })
  
  # render menu for variable selection
  output$select_variable <- renderUI({
    req(input$selected_season)
    
    variable_names <- names(full_cache_data[[ input$selected_season ]][[ 'trait_data' ]])
    
    selectInput('selected_variable', 'Variable', variable_names)
  })
  
  # render menu for cultivar selection
  output$select_cultivar <- renderUI({
    req(input$selected_season)
    req(input$selected_variable)
    
    variable_traits <- full_cache_data[[ input$selected_season ]][[ 'trait_data' ]]
    cultivars <- unique(
      variable_traits[[ input$selected_variable ]][[ 'traits' ]][[ 'cultivar_name' ]]
    )
    cultivar_menu <- c('None', cultivars)
    
    selectInput('selected_cultivar', 'Cultivar', cultivar_menu)
  })
  
  # render plot for selected variable, cultivar
  output$trait_plot <- renderPlot({
  
    req(input$selected_season)
    req(input$selected_variable)
    req(input$selected_cultivar)
      
    selected_season_data <- full_cache_data[[ input$selected_season ]]
    selected_variable <- input$selected_variable
    selected_cultivar <- input$selected_cultivar

    plot_data <- selected_season_data[[ 'trait_data' ]][[ selected_variable ]][[ 'traits' ]]
    data_max <- max(plot_data[[ 'mean' ]])

    units <- selected_season_data[[ 'trait_data' ]][[ selected_variable ]][[ 'units' ]]
    
    # generate timeseries of boxplots from mean value
    ggplot(plot_data, aes(as.Date(date), mean)) + 
    geom_boxplot(aes(group = cut_width(as.Date(date), 1)), outlier.alpha = 0.1) +
      
    { 
      if (selected_cultivar != 'None') {
        geom_point(data = subset(plot_data, cultivar_name == selected_cultivar), 
          size = 1, color = "red", aes(x = as.Date(date), y = mean))
      }
    } +
      
    labs(
      title = selected_variable,
      x = "Observation Dates",
      y = units
    ) +
      
    theme(text = element_text(size = 20), axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
    xlim(as.Date(selected_season_data[[ 'start_date' ]]), as.Date(selected_season_data[[ 'end_date' ]])) +
    ylim(0, data_max)

  })

  output$trait_hover_info <- renderText({
    
    req(input$plot_hover)
    
    paste0(
      'Date \n',
      toString(
        as.Date(input$plot_hover$x, origin = lubridate::origin)
      ),
      '\n\n',
      'Value \n',
      format(round(input$plot_hover$y, 2))
    )
  })
  
  # generate timeline visualization for management data
  output$timeline <- renderTimevis({

      req(input$selected_season)
    
      management_data <- full_cache_data[[ input$selected_season ]][[ 'managements' ]]
      types <- management_data[[ 'mgmttype' ]]
      dates <- management_data[[ 'date' ]]

      timeline_data <- data.frame(
        id = 1:nrow(management_data),
        content = types,
        start = dates
      )
      
      timevis(
        timeline_data,
        options = list(zoomable = FALSE)
      )
  })
  
  output$management_hover_info <- renderText({
    
    req(input$selected_season)
    req(input$timeline_selected)
    
    management_data <- full_cache_data[[ input$selected_season ]][[ 'managements' ]]
    selected_record <- management_data[ as.numeric(input$timeline_selected), ]
    
    paste0(
      selected_record[[ 'mgmttype' ]],
      '\n',
      selected_record[[ 'date' ]],
      '\n\n',
      selected_record[[ 'notes' ]]
    )

  })
}

shinyApp(ui = ui, server = server)