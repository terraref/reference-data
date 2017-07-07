library(traits)

# set options for BETYdb API
knitr::opts_chunk$set(echo = FALSE, cache = TRUE)
options(betydb_key = readLines('~/.betykey', warn = FALSE),
        betydb_url = "https://terraref.ncsa.illinois.edu/bety/",
        betydb_api_version = 'beta')

cache_data <- list()

experiments <- as.data.frame(betydb_query(table='experiments'))
seasons <- unique(experiments[c('start_date', 'end_date')])

unique_experiments <- experiments[rownames(seasons),]
unique_experiment_names <- gsub(":.*$","", unlist(unique_experiments['name']))
rownames(seasons) <- unique_experiment_names


