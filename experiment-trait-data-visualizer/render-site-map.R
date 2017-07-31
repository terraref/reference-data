library(rgeos)
library(dplyr)

bety_src <- src_postgres(
  dbname = Sys.getenv('bety_dbname'),
  password = Sys.getenv('bety_password'),
  host = Sys.getenv('bety_host'),
  port = Sys.getenv('bety_port'),
  user = Sys.getenv('bety_user')
)

render_site_map <- function(traits, legend_title, render_date) {

  site_ids <- na.omit(unique(traits[[ 'site_id' ]]))
  sites <- tbl(bety_src, sql("select ST_AsText(sites.geometry) AS geometry, id from sites")) %>% 
    filter(!is.na(geometry)) %>% 
    filter(id %in% site_ids) %>% 
    collect() %>% data.frame()
  
  latest_traits <- subset(traits, date <= render_date) %>% group_by(site_id) %>% top_n(1, date)

  pal <- colorNumeric(
    palette = 'Greens',
    domain = traits[[ 'mean' ]]
  )
  
  map <- leaflet(options = leafletOptions(minZoom = 20, maxZoom = 21)) %>% addTiles()
  
  if (nrow(sites) > 0) {
    for (i in 1:nrow(sites)){
      site <- sites[i,]
      
      geo_object <- readWKT(site[['geometry']])
      if ('polygons' %in% names(attributes(geo_object))) {
        
        trait <- subset(latest_traits, site_id == site[[ 'id' ]])
        map <- addPolygons(map, data = geo_object, color = pal(trait[['mean']]))
      }
    }
  }
  
  map <- addLegend(map, "bottomright", pal = pal, 
                   title = legend_title,
                   values = traits[[ 'mean' ]])
  map
}
