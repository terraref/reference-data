library(shiny)
library(ggplot2)
library(lubridate)
library(timevis)
library(leaflet)
library(cronR)
library(shinythemes)

source('render-site-map.R')

# schedule daily execution of cache refresh
cache_update_cmd <- cron_rscript('cache-refresh.R')

if(!grepl('cache-update', cronR::cron_ls())){
  cron_add(command = cache_update_cmd, frequency = 'daily', 
           id = 'cache-update', description = 'daily update of BETYdb cache')
}


# set page UI
ui <- fluidPage(theme = shinytheme('flatly'),
  
  tags$link(rel = 'stylesheet', type = 'text/css', href = 'style.css'),
  title = 'TERRA-REF Experiment Data',
  
  tags$img(src = 'logo.png', class = 'push-out'),
  
  # destination for all dynamic UI elements
  uiOutput('page_content')
)

# render UI for a given season
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
            uiOutput(paste0('map_date_slider_', season_name)),
            leafletOutput(paste0('site_map_', season_name), width = '600px', height = '600px')
          )
        )
      )
    )
  )
}

# render selection menu from available variables in a given season
render_variable_menu <- function(season_name, output, full_cache_data) {
  
  variable_names <- names(full_cache_data[[ season_name ]][[ 'trait_data' ]])
  
  output[[ paste0('variable_select_', season_name) ]] <- renderUI({
    selectInput(paste0('selected_variable_', season_name), 'Variable', variable_names)
  })
}

# render selection menu from available cultivars in a given season, for the selected variable
render_cultivar_menu <- function(season_name, input, output, full_cache_data) {
  
  output[[ paste0('cultivar_select_', season_name) ]] <- renderUI({
    
    req(input[[ paste0('selected_variable_', season_name) ]])
    
    trait_records <- full_cache_data[[ season_name ]][[ 'trait_data' ]][[ input[[ paste0('selected_variable_', season_name) ]] ]][[ 'traits' ]]
    unique_cultivars <- unique(trait_records[[ 'cultivar_name' ]])
    
    selectInput(paste0('selected_cultivar_', season_name), 'Cultivar', c('None', unique_cultivars))
  })
}

# render box plot time series from trait records in a given season, for the selected variable
# if a cultivar is selected, render line plot from trait records for that cultivar
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
    title <- ifelse(units == '', selected_variable, paste0(selected_variable, ' (', units, ')'))
    
    trait_plot <- ggplot() + 
      geom_violin(data = plot_data, scale = 'width', width = 0.75,
                   aes(x = as.Date(date), y = mean, 
                       group = as.Date(date))) +
      geom_boxplot(data = plot_data, 
                  aes(x = as.Date(date), y = mean, 
                      group = as.Date(date)), 
                  outlier.alpha = 0.25, width = 0.2)  
#      geom_point(data = plot_data, 
#                 aes(x = as.Date(date), y = mean), 
#                 alpha = 0.1, size = 0.1, position = position_jitter(width = 0.1))
      
    if (selected_cultivar != 'None') {
        title <- paste0(title, '\nCultivar ', selected_cultivar, ' in red')
        trait_plot <- trait_plot + 
          geom_point(data = subset(plot_data, cultivar_name == selected_cultivar), 
                     color = 'red', aes(x = as.Date(date), y = mean, group = site_id)) +
          geom_line(data = subset(plot_data, cultivar_name == selected_cultivar), 
                     size = 0.5, color = 'red', aes(x = as.Date(date), y = mean, group = site_id)) 
    }
    
    trait_plot + 
      labs(
        title = paste0(title, '\n'),
        x = "Date",
        y = units
      ) +
      
      theme_bw() + 
      theme(text = element_text(size = 20), axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
      xlim(as.Date(selected_season_data[[ 'start_date' ]]), as.Date(selected_season_data[[ 'end_date' ]])) +
      ylim(0, data_max)
  })
}

# render timeline from management records in a given season
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

# render info box for date and value of cursor when hovering box/line plot
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

# render info box for date, type, and notes of selected (clicked) timeline item
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

render_map <- function(season_name, input, output, full_cache_data) {
  
  # render slider input from dates in a given season
  output[[ paste0('map_date_slider_', season_name) ]] <- renderUI({
    sliderInput(paste0('map_date_', season_name), 'Date', 
                as.Date(full_cache_data[[ season_name ]][[ 'start_date']]), 
                as.Date(full_cache_data[[ season_name ]][[ 'end_date' ]]),
                as.Date(full_cache_data[[ season_name ]][[ 'end_date' ]]))
  })
  
  # render heat map of sites from trait records in a given season, for the selected date, variable and cultivar
  output[[ paste0('site_map_', season_name) ]] <- renderLeaflet({
    
    req(input[[ paste0('selected_variable_', season_name) ]])
    req(input[[ paste0('selected_cultivar_', season_name) ]])
    req(input[[ paste0('map_date_', season_name) ]])
    
    selected_variable <- input[[ paste0('selected_variable_', season_name) ]]
    selected_cultivar <- input[[ paste0('selected_cultivar_', season_name) ]]
    render_date <- input [[ paste0('map_date_', season_name) ]]
    
    traits <- full_cache_data[[ season_name ]][[ 'trait_data' ]][[ selected_variable ]][[ 'traits' ]]
    
    if (selected_cultivar != 'None')
      traits <- subset(traits, cultivar_name == selected_cultivar)
    
    units <- full_cache_data[[ season_name ]][[ 'trait_data' ]][[ selected_variable ]][[ 'units' ]]
    if (units != '')
      units <- paste0('(', units, ')')
    legend_title <- paste0(selected_variable, ' ', units)
    
    render_site_map(traits, render_date, legend_title)
  })
}

# render outputs for a given season
render_season_output <- function(season_name, input, output, full_cache_data) {
  
  render_variable_menu(season_name, output, full_cache_data)
  
  render_cultivar_menu(season_name, input, output, full_cache_data)
  
  render_trait_plot(season_name, input, output, full_cache_data)
  
  render_mgmt_timeline(season_name, input, output, full_cache_data)
  
  render_plot_hover(season_name, input, output, full_cache_data)
  
  render_timeline_hover(season_name, input, output, full_cache_data)

  render_map(season_name, input, output, full_cache_data)
}

server <- function(input, output) {
  
  # load 'full_cache_data' object from cache file
  if (!file.exists('cache.RData')){
    source('cache-refresh.R')
  }
    
  load('cache.RData')
  
  # render UI for all available seasons
  output$page_content <- renderUI({
    season_tabs <- lapply(names(full_cache_data), render_season_ui)
    do.call(tabsetPanel, season_tabs)
  })
  
  # render outputs for all available seasons
  lapply(names(full_cache_data), render_season_output, input, output, full_cache_data)
}

shinyApp(ui = ui, server = server)
