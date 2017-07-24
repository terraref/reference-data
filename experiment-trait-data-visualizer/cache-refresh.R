library(dplyr)
library(tools)
options(scipen=999)

get_data_for_season <- function(season) {
  
  season_data <- list(start_date = season[[ 'start_date' ]], end_date = season[[ 'end_date' ]])
  
  season_site_ids <- tbl(bety_src, 'experiments_sites') %>% 
    filter(experiment_id == season[[ 'id' ]]) %>%
    select(site_id) %>%
    collect() %>% unlist(use.names = FALSE)
  
  if (is.null(season_site_ids))
    return()
  
  season_trait_table <- tbl(bety_src, 'traits') %>%
    filter(date >= season[[ 'start_date' ]] & date <= season[[ 'end_date' ]]) %>%
    filter(site_id %in% season_site_ids) %>%
    select(date, mean, variable_id, cultivar_id, treatment_id)
  
  trait_cultivars <- tbl(bety_src, 'cultivars') %>%
    mutate(cultivar_id = id, cultivar_name = name) %>%
    select(cultivar_id, cultivar_name)
  
  season_traits <- season_trait_table %>% left_join(trait_cultivars, by = 'cultivar_id') %>%
    collect() %>% as.data.frame()
  
  if (nrow(season_traits) == 0)
    return()
  
  season_variable_ids <- unique(na.omit(
    season_traits[[ 'variable_id' ]]
  ))
  
  season_trait_data <- list()
  for (curr_variable_id in season_variable_ids) {
    
    variable_data <- list()
    
    variable_record <- tbl(bety_src, 'variables') %>%
      filter(id == curr_variable_id) %>%
      select(name, units) %>% collect()
    
    variable_name <- toTitleCase(gsub('_', ' ', variable_record[[ 'name' ]]))
    variable_traits <- subset(season_traits, variable_id == curr_variable_id)
    
    variable_data[[ 'units' ]] <- variable_record[[ 'units' ]]
    variable_data[[ 'traits' ]] <- variable_traits
    
    season_trait_data[[ variable_name ]] <- variable_data
  }
  season_data[[ 'trait_data' ]] <- season_trait_data
  
  season_treatment_ids <- unique(na.omit(
    season_traits[[ 'treatment_id' ]]
  ))
  
  season_management_ids <- tbl(bety_src, 'managements_treatments') %>%
    filter(treatment_id %in% season_treatment_ids) %>%
    collect() %>% unlist(use.names = FALSE)
  ""
  season_managements <- tbl(bety_src, 'managements') %>%
    filter(date >= season[[ 'start_date' ]] & date <= season[[ 'end_date' ]]) %>%
    filter(id %in% season_management_ids) %>%
    select(id, date, mgmttype, notes) %>%
    collect() %>% as.data.frame()
  
  season_data[[ 'managements' ]] <- season_managements
  
  full_cache_data <- list()
  if (file.exists("cache.RData"))
    load("cache.RData")
  full_cache_data[[ toString(season[[ 'name' ]]) ]] <- season_data
  
  save(full_cache_data, file = "cache.RData", compress = FALSE)
}

bety_src <- src_postgres(
  dbname = "bety",
  password = "KakvoSeHoroIzvilo",
  host = "localhost",
  port = "5432",
  user = "bety"
)

experiments <- tbl(bety_src, 'experiments') %>% 
  select(id, name, start_date, end_date) %>% 
  collect() %>% as.data.frame()

seasons <- experiments[
    rownames(
      unique(experiments[c('start_date', 'end_date')])
    ), 
  ]

seasons[[ 'name' ]] <- gsub(":.*$","", seasons[[ 'name' ]])

apply(seasons, 1, get_data_for_season)
