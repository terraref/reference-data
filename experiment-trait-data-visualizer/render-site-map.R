library(rgeos)
library(dplyr)

# render leaflet map from traits for a given date
render_site_map <- function(traits, render_date, legend_title) {

  # get most recent traits for each site
  latest_traits <- subset(traits, date <= render_date & !is.na(geometry)) %>% 
    group_by(geometry) %>% top_n(1, date)

  pal <- colorNumeric(
    palette = 'Greens',
    domain = traits[[ 'mean' ]]
  )
  
  map <- leaflet(options = leafletOptions(minZoom = 20, maxZoom = 21)) %>% addTiles()

  # add polygon for each site, color by trait mean value
  if (nrow(latest_traits) > 0) {
    for (i in 1:nrow(latest_traits)){
      curr_trait <- latest_traits[i,]
      
      site_poly <- readWKT(curr_trait[[ 'geometry' ]])
  
      if ('polygons' %in% names(attributes(site_poly))) {
        trait_value <- curr_trait[[ 'mean' ]]
        map <- addPolygons(map, data = site_poly, color = pal(trait_value))
      }
    }
  }
  
  map <- addLegend(map, "bottomright", pal = pal, 
                   title = legend_title,
                   values = traits[[ 'mean' ]])
  map
}
