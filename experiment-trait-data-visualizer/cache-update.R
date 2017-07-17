library(traits)
library(lubridate)
library(tools)

# set options for BETYdb API
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)
options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')
# disable scientific notation (prevent issues with BETYdb API)
options(scipen = 999)

cache_data <- list()

get_variable_metadata<- function(variable_id) {
  
  variable_metadata <- list()
  
  variable_data <- betydb_query(table = 'variables', id = variable_id)
  variable_name <- toTitleCase(gsub('_', ' ', variable_data$name))
  variable_metadata <- c(variable_metadata, name = variable_name, units = variable_data$units)
  
  return(variable_metadata)
}

refresh_cache_for_season <- function(season) {
  
  season_full_cache_data <- list(start_date = toString(season['start_date']), end_date = toString(season['end_date']))

  curr_date <- as.Date(season[['start_date']])
  stop_date <- as.Date(season[['end_date']])
  
  season_all_trait_records = NULL
  season_management_records = NULL
  
  experiment_associated_sites <- betydb_experiment(season[['id']])[[ 'site' ]][[ 'site.id' ]]
  
  while (stop_date - curr_date != 0) {
    
    curr_date_management_records <- betydb_query(table = 'managements', date = paste0('~', curr_date))
    season_management_records <- rbind(season_management_records, curr_date_management_records[c('id', 'date', 'mgmttype')])
    
    curr_date_trait_records <- betydb_query(table = 'traits', date = paste0('~', curr_date), limit = 'none')
    trait_records_for_experiment <- subset(curr_date_trait_records, 'site_id' %in% experiment_associated_sites)
      
    season_all_trait_records <- rbind(season_all_trait_records, trait_records_for_experiment[c('id', 'variable_id', 'date', 'mean', 'cultivar_id')])
    
    curr_date = curr_date + days(1)
  }
  
  season_all_trait_records <- data.frame(season_all_trait_records)
  season_management_records <- data.frame(season_management_records)
  
  season_trait_data <- list()
  
  trait_variable_ids = unique(as.numeric(season_all_trait_records$variable_id))
  for (curr_variable_id in trait_variable_ids) {
    
    curr_variable_cache_data <- list()
    
    curr_variable_trait_records <- subset(season_all_trait_records, variable_id == curr_variable_id)[c('id', 'date', 'mean', 'cultivar_id')]
    curr_variable_metadata <- get_variable_metadata(curr_variable_id)
    
    curr_variable_cache_data[[ 'units' ]] <- curr_variable_metadata$units
    curr_variable_cache_data[[ 'traits' ]] <- curr_variable_trait_records
    
    unique_cultivars <- unique(as.numeric(curr_variable_trait_records[[ 'cultivar_id' ]]))
    unique_cultivar_names <- NULL
    for (cultivar_id in unique_cultivars) {
      cultivar_name <- betydb_query(table = 'cultivars', id = cultivar_id)['name']
      unique_cultivar_names <- c(unique_cultivar_names, cultivar_name)
    }
    names(unique_cultivars) <- unique_cultivar_names
    
    curr_variable_cache_data[[ 'cultivars' ]] <- unique_cultivar_names
    
    season_trait_data[[ curr_variable_metadata$name ]] <- curr_variable_cache_data
  }
  
  season_full_cache_data[[ 'managements' ]] <- season_management_records
  season_full_cache_data[[ 'trait_data' ]] <- season_trait_data
  
  cache_data[[ toString(season['name']) ]] <- season_full_cache_data
  
  save(cache_data, file = "cache.RData")
}

refresh_cache <- function() {
  
  experiments <- as.data.frame(betydb_query(table = 'experiments'))
  seasons <- unique(experiments[c('start_date', 'end_date')])
  
  unique_experiments <- experiments[rownames(seasons),]
  experiment_names <- gsub(":.*$","", unlist(unique_experiments['name']))
  
  seasons <- cbind(seasons, name = experiment_names, unique_experiments['id'])
  
  apply(seasons, 1, refresh_cache_for_season)
  
  save(cache_data, file = "cache.RData")
  Sys.setenv(last_cache_update_date = toString(Sys.Date()))
}

refresh_cache()
