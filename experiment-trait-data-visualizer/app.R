library(shiny)
library(traits)
library(ggplot2)
library(lubridate)
library(timevis)
library(leaflet)
library(cronR)
library(shinythemes)

source('render-site-map.R')

# set up scheduled execution of cache update
#cache_update_cmd <- cron_rscript('cache-refresh.R')
#try(cron_add(command = cache_update_cmd, frequency = 'daily', 
#            id = 'cache-update', description = 'daily update of BETYdb cache'))

# set page UI
ui <- fluidPage( theme = shinytheme('flatly'),
  
  tags$link(rel = 'stylesheet', type = 'text/css', href = 'style.css'),
  title = 'TERRA-REF Experiment Data',
  
  tags$img(src = 'logo.png', class = 'push-out'),
  
  uiOutput('page_content')
)

render_season_ui <- function(season_name) {
  
  tabPanel(season_name,
           
    sidebarPanel(class = 'push-down',
      uiOutput(paste0('variable_select_', season_name)),
      uiOutput(paste0('cultivar_select_', season_name))
    ),
     
    uiOutput(paste0(paste0('plot_hover_info_', season_name))),
    
    mainPanel(class = 'main-panel',
    tabsetPanel(
        tabPanel('Plot',
          div(class = 'push-down',
            plotOutput(paste0('trait_plot_', season_name), 
                        hover = hoverOpts(id = paste0('plot_hover_', season_name)))
          ),
          hr(),
          uiOutput(paste0('mgmt_select_info_', season_name)),
          timevisOutput(paste0('mgmt_timeline_', season_name))
        ),
        tabPanel('Map',
          div(class = 'map-container push-out',
            leafletOutput(paste0('site_map_', season_name), width = '750px', height = '1000px')
          )
        )
      )
    )
  )
}

render_variable_menu <- function(season_name, output, full_cache_data) {
  
  variable_names <- names(full_cache_data[[ season_name ]][[ 'trait_data' ]])
  
  output[[ paste0('variable_select_', season_name) ]] <- renderUI({
    selectInput(paste0('selected_variable_', season_name), 'Variable', variable_names)
  })
}

render_cultivar_menu <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('cultivar_select_', season_name) ]] <- renderUI({
    
    req(input[[ paste0('selected_variable_', season_name) ]])
    
    trait_records <- full_cache_data[[ season_name ]][[ 'trait_data' ]][[ input[[ paste0('selected_variable_', season_name) ]] ]][[ 'traits' ]]
    unique_cultivars <- unique(trait_records[[ 'cultivar_name' ]])
    
    selectInput(paste0('selected_cultivar_', season_name), 'Cultivar', c('None', unique_cultivars))
  })
}

render_trait_plot <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('trait_plot_', season_name) ]] <- renderPlot({
    
    req(input[[ paste0('selected_variable_', season_name) ]])
    req(input[[ paste0('selected_cultivar_', season_name) ]])
    
    selected_season_data <- full_cache_data[[ season_name ]]
    selected_variable <- input[[ paste0('selected_variable_', season_name) ]]
    selected_cultivar <- input[[ paste0('selected_cultivar_', season_name) ]]
    
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
}

render_mgmt_timeline <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('mgmt_timeline_', season_name) ]] <- renderTimevis({
    
    management_data <- full_cache_data[[ season_name ]][[ 'managements' ]]
    
    if (nrow(management_data) > 0) {
      
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
    }
  })
}

render_plot_hover <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('plot_hover_info_', season_name) ]] <- renderUI({
    
    req(input[[ paste0('plot_hover_', season_name) ]])
    
    hover <- input[[ paste0('plot_hover_', season_name) ]]
    
    wellPanel(class = 'plot-hover-info push-down',
      HTML(paste0(
        'Date', '<br>',
        toString(
          as.Date(hover$x, origin = lubridate::origin)
        ),
        '<br><br>',
        'Value', '<br>',
        format(round(hover$y, 2))
      ))
    )
  })
}

render_timeline_hover <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('mgmt_select_info_', season_name) ]] <- renderUI({
    
    req(input[[ paste0('mgmt_timeline_', season_name, '_selected') ]])
    selected <- input[[ paste0('mgmt_timeline_', season_name, '_selected') ]]
    
    management_data <- full_cache_data[[ season_name ]][[ 'managements' ]]
    selected_record <- management_data[ as.numeric(selected), ]
    
    formatted_notes <- ''
    if (selected_record[[ 'notes' ]] != '')
      formatted_notes <- paste0('<br><br>', selected_record[[ 'notes' ]])
    
    wellPanel(class = 'mgmt-select-info',
      HTML(paste0(
        selected_record[[ 'mgmttype' ]], '<br>',
        selected_record[[ 'date' ]],
        formatted_notes
      ))
    )
  })
}

render_map <- function(season_name, output, full_cache_data) {
  
  output[[ paste0('site_map_', season_name) ]] <- renderLeaflet({
    render_site_map(full_cache_data[[ season_name ]][[ 'site_ids' ]])
  })
}

render_season_output <- function(season_name, input, output, full_cache_data) {
  
  render_variable_menu(season_name, output, full_cache_data)
  
  render_cultivar_menu(season_name, input, output, full_cache_data)
  
  render_trait_plot(season_name, input, output, full_cache_data)
  
  render_mgmt_timeline(season_name, input, output, full_cache_data)
  
  render_plot_hover(season_name, input, output, full_cache_data)
  
  render_timeline_hover(season_name, input, output, full_cache_data)

  render_map(season_name, output, full_cache_data)
}

# render page elements
server <- function(input, output) {
  
  load('cache.RData')
  
  output$page_content <- renderUI({
    
    season_tabs <- lapply(names(full_cache_data), render_season_ui)
    do.call(tabsetPanel, season_tabs)
  })
  
  lapply(names(full_cache_data), render_season_output, input, output, full_cache_data)
}

shinyApp(ui = ui, server = server)