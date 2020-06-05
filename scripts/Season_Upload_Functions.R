#############################################################################
####################### HOW TO ADD A NEW SEASON #############################
#############################################################################

##################################################
########### uploading plot definitions ###########
##################################################
sitesUpload <- function(file_name, file_dir, sitename_pattern, season_num){
  # query sites table for records with sitename that match 'sitename_pattern'
  library(RPostgreSQL)
  dbcon <- dbConnect(RPostgreSQL::PostgreSQL(),
                     dbname = "bety", 
                     password = 'bety', 
                     host = 'localhost', 
                     user = 'bety', 
                     port = 5432)
  sites_query <- paste0("select * from sites where sitename like '", sitename_pattern, "';")
  sites_table <- dbGetQuery(dbcon, sites_query)
  bety_sitenames <- sites_table$sitename # sites already uploaded in the bety database that match user search pattern
  
  #read in subplot data
  file_path <- paste0(gsub('/$', '', file_dir), '/', file_name)
  sites_data <- read.csv(file_path, stringsAsFactors = FALSE)
  subplots <- gsub("  ", " ", sites_data$site)
  subplots_to_upload <- subplots[which(!(subplots %in% bety_sitenames))] # sitenames that have not been uploaded
  if(length(subplots_to_upload) != 0){ 
    # upload new records to the sites table for new season
    # use plot definitions from previous season
    prev_season_num <- as.numseason_num - 1
    insert_state <- paste0("with season", season_num, " as ( select city, state, replace(sitename, 'Season ", prev_season_num, "', 'Season ",
                           season_num, "') as sitename, greenhouse, geometry, time_zone from sites where sitename like '%Season ", prev_season_num,
                           "%') insert into sites (city, state, sitename, greenhouse, geometry, time_zone) select * from season", season_num, ";")
    sites_table_upload <- dbSendStatement(dbcon, insert_state)
    dbGetRowsAffected(sites_table_upload)
    output_message <- paste0(dbGetRowsAffected(sites_table_upload), " rows inserted.")
    message(output_message)
  }else{ # no new upload necessary # all sites already in database
    output_message <- paste0("\n0 rows inserted. All season ", season_num, " sites already in database.")
    message(output_message)
  }
}

# example
sitesUpload(file_name = 'S7_SorghumAug_subplots.csv', file_dir = '~/Downloads', sitename_pattern = 'MAC Field Scanner Season 7%', season_num = 7)

##########################################################
########### associating experiments with sites ###########
##########################################################
expSitesUpload <- function(sitename_pattern, experiment_name){
  exp_site_query <- paste0("select * from experiments_sites where site_id in (select id from sites where sitename like '", sitename_pattern, "') ",
                           "and experiment_id = (select id from experiments where name = '", experiment_name, "');")
  exp_site_table <- dbGetQuery(dbcon, exp_site_query)
  if(nrow(exp_site_table) == 0){ # no experiments and sites have been associated
    insert_statement <- paste0("insert into experiments_sites (experiment_id, site_id) select e.experiment_id, s.site_id from (select id as experiment_id from   experiments where name = '", experiment_name, "') as e cross join (select id as site_id from sites where sitename like '", sitename_pattern, "') as s")
    exp_sites_upload <- dbSendStatement(dbcon, insert_statement)
    output_message <- paste0("No sites associated with experiment yet. ", dbGetRowsAffected(exp_sites_upload), " rows inserted.")
    message(output_message)
  }else{ # not all experiments and sites have been associated
    sites_query <- paste0("select id from sites where sitename like '", sitename_pattern, "'")
    site_ids_table <- dbGetQuery(dbcon, sites_query)
    site_ids <- site_ids_table$id # all site ids for sitenames that match the sitename_pattern
    exp_site_ids <- exp_site_table$site_id # all site ids associated with experiment so far
    # see which site ids have not yet been associated
    site_ids_to_upload <- site_ids[which(!(site_ids %in% exp_site_ids))]
    # associate these site ids with experiment
    insert_statement <- paste0("insert into experiments_sites (experiment_id, site_id) select e.experiment_id, s.site_id from (select id as experiment_id from experiments where name = '", experiment_name, "') as e cross join (select id as site_id from sites where id in (", paste(site_ids_to_upload[11:20], collapse = ', '), ")) as s")
    exp_sites_insert <- dbSendStatement(dbcon, insert_statement)
    output_message <- paste0(dbGetRowsAffected(exp_sites_insert), " rows inserted.")
    message(output_message)
  }
}

# example
expSitesUpload(sitename_pattern = 'MAC Field Scanner Season 7%', experiment_name = 'MAC Season 7: Sorghum Aug')

##############################################
########### add cultivars records  ###########
##############################################
# question : is there generally only one species for a season?
cultivarsUpload <- function(file_name, file_dir){
  file_path <- paste0(gsub('/$', '', file_dir), '/', file_name) # read in season data
  season_data <- read.csv(file_path, stringsAsFactors = FALSE)
  unq_season_cultivar <- unique(season_data$cultivar) # unique cultivars for season
  
  # query cultivars table and get cultivars already uploaded
  library(RPostgreSQL)
  dbcon <- dbConnect(RPostgreSQL::PostgreSQL(),
                     dbname = "bety", 
                     password = 'bety', 
                     host = 'localhost', 
                     user = 'bety', 
                     port = 5432)
  cultivars_query <- "select name from cultivars;"
  cultivars_table <- dbGetQuery(dbcon, cultivars_query)
  bety_cultivars <- cultivars_table$name # cultivars already uploaded in bety
  
  # determine which season cultivars need to be uploaded
  cultivars_to_upload <- unq_season_cultivar[which(!(unq_season_cultivar %in% bety_cultivars))]
  
  if(length(cultivars_to_upload) != 0){
    cultivars_to_upload <- gsub("^ ", "", cultivars_to_upload) # remove starting space if present
    
    # need specie id for insert statement # get id from bety
    season_spp <- unique(season_data$species) # get unique species for season # need specie id for insert statement
    season_spp_gen <- strsplit(season_spp, ' ')[[1]][1]
    id_query <- paste0("select id from species where genus = '", season_spp_gen, "';" )  
    id_table <- dbGetQuery(dbcon, id_query)
    season_spp_id <- id_table$id
    
    #create sql insert statements
    insert_values <- vector('character', length = length(cultivars_to_upload))
    for(i in 1:length(cultivars_to_upload)){
      cultivar <- cultivars_to_upload[i]
      insert_val <- paste0("(", season_spp_id, ", '", cultivar, "')")
      insert_values[i] <- insert_val
    }
    
    sql_insert_full <- paste0("insert into cultivars (specie_id, name) values ", paste(insert_values, collapse = ", "), ";")
    cultivar_insert <- dbSendStatement(dbcon, sql_insert_full) #insert new rows into bety
    output_message <- paste0(dbGetRowsAffected(cultivar_insert), " rows inserted into cultivars table.")
    message(output_message)
  }else{ # no new uploads necessary # all cultivars already present
    output_message <- '0 rows inserted. All cultivars already uploaded'
    message(output_message)
  }
}

# example
cultivarsUpload(file_name = 'S7_SorghumAug_subplots.csv', file_dir = '~/Downloads')


