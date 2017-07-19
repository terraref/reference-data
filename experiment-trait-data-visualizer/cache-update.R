library(traits)
library(lubridate)
library(tools)

# set options for BETYdb API
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)
options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

# main data structure to be stored in cache.RData
cache_data <- list()

get_variable_metadata<- function(variable_id) {
  
  variable_metadata <- list()
  
  variable_data <- betydb_query(table = 'variables', id = variable_id)
  variable_metadata['name'] <- toTitleCase(gsub('_', ' ', variable_data$name))
  variable_metadata['units'] <- variable_data$units
  
  return(variable_metadata)
}

get_managements_from_treatments <- function(treatments) {

  management_ids <- NULL
  
  for (treatment in treatments) {
    treatment_record <- betydb_record(treatment, 'treatments')
    management_ids <- c(management_ids, treatment_record[[ 'managements' ]][[ 'management.id' ]])
  }
  
  return(management_ids)
}

refresh_cache_for_season <- function(season) {
  
  season_cache_data <- list(start_date = toString(season['start_date']), end_date = toString(season['end_date']))

  associated_sites <- betydb_experiment(season[['id']])[[ 'sites' ]][[ 'site.id' ]]
  
  trait_records = NULL
  management_records = NULL
  
  curr_date <- as.Date(season[['start_date']])
  stop_date <- as.Date(season[['end_date']])
  
  while (stop_date - curr_date != 0) {
    
    curr_date_management_records <- betydb_query(table = 'managements', date = paste0('~', curr_date))
    if (!is.null(curr_date_management_records)) {
      management_records <- rbind(
        management_records,
        curr_date_management_records[c('id', 'date', 'mgmttype')]
      )
    }
    
    curr_date_trait_records <- betydb_query(table = 'traits', date = paste0('~', curr_date), limit = 'none')
    if (!is.null(curr_date_trait_records)) {
      valid_trait_records <- subset(curr_date_trait_records, site_id %in% associated_sites)
      trait_records <- rbind(
        trait_records, 
        valid_trait_records[c('id', 'variable_id', 'date', 'mean', 'cultivar_id', 'treatment_id')]
      )
    }
      
    curr_date <- curr_date + days(1)
  }
  
  treatment_ids <- unique(na.omit(as.numeric(trait_records[[ 'treatment_id' ]])))
  management_ids <- get_managements_from_treatments(treatment_ids)

  management_records <- data.frame(
    subset(
      management_records,
      id %in% management_ids
    )
  )
  
  season_trait_data <- list()
  
  variable_ids = unique(as.numeric(trait_records[[ 'variable_id' ]]))
  
  for (curr_variable_id in variable_ids) {
    
    variable_cache_data <- list()
    
    variable_trait_records <- data.frame(
      subset(
        trait_records,
        variable_id == curr_variable_id
      )[c('id', 'date', 'mean', 'cultivar_id')]
    )
    
    variable_metadata <- get_variable_metadata(curr_variable_id)
    
    variable_cache_data[[ 'units' ]] <- variable_metadata[[ 'units' ]]
    variable_cache_data[[ 'traits' ]] <- variable_trait_records
    
    cultivar_ids <- unique(as.numeric(variable_trait_records[[ 'cultivar_id' ]]))
    
    cultivar_names <- NULL
    for (cultivar_id in cultivar_ids) {
      cultivar_name <- betydb_query(table = 'cultivars', id = cultivar_id)[[ 'name' ]]
      cultivar_names <- c(cultivar_names, cultivar_name)
    }
    names(cultivar_ids) <- cultivar_names
    
    variable_cache_data[[ 'cultivars' ]] <- cultivar_ids
    
    season_trait_data[[ variable_metadata$name ]] <- variable_cache_data
  }
  
  season_cache_data[[ 'managements' ]] <- management_records
  season_cache_data[[ 'trait_data' ]] <- season_trait_data
  
  cache_data[[ toString(season[[ 'name' ]]) ]] <- season_cache_data
  
  save(cache_data, file = "cache.RData")
}

refresh_cache <- function() {
  
  experiments <- as.data.frame(betydb_query(table = 'experiments'))
  seasons <- unique(experiments[c('start_date', 'end_date')])
  
  unique_seasons <- experiments[rownames(seasons),]
  season_names <- gsub(":.*$","", unlist(unique_seasons['name']))
  
  seasons <- cbind(seasons, name = season_names, unique_seasons['id'])

  apply(seasons, 1, refresh_cache_for_season)
  
  save(cache_data, file = "cache.RData")
  Sys.setenv(last_cache_update_date = toString(Sys.Date()))
}

refresh_cache()