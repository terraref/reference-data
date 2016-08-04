# plot_boxes <- function(x_origin = 0, y_origin = 0,
#                        length = 3.5,
#                        alley = 0.5,
#                        row_spacing = 30, 
#                        ranges = 54, 
#                        columns = 16){

require(udunits2)
library(dplyr)
library(ggplot2)

x_origin = 0 
y_origin = 0
length = 3.5
alley = 0.5
row_spacing = 30
ranges = 54
columns = 16

row_spacing_cm <- ud.convert(row_spacing, 'in', 'm')

dx <- 2 * row_spacing_cm
dy <- length

x <- x_origin + (1:columns - 1) * dx
y <- y_origin + (1:ranges - 1) * (length + alley) 

grid <- data.frame(expand.grid(x,y)) %>% 
  transmute(plot = 1:(ranges*columns), x1 = Var1, y1 = Var2, x2 = x1 + dx, y2 = y1 + dy)

theme_set(theme_bw())
ggplot(data = grid) + 
  geom_text(aes(x1+dx/2, y1+dy/2, label = plot), size = 2) +
  geom_point(aes(x1,y1), size = 1, alpha = 0.4) + 
  geom_point(aes(x2,y2), col = 'red', size = 1, alpha = 0.4) +
  ggtitle('gantry plot layout') + xlab('x') + ylab('y')

#' Cultivars
bety <- src_postgres(dbname = 'bety', host = 'localhost', user = 'bety', password = 'bety')

cultivars <- tbl(bety, 'cultivars')

specie_id <- tbl(bety, 'species') %>% filter(scientificname == 'Sorghum bicolor') %>% select(id)

#library(googlesheets)
#accessions <- read_sheets("https://docs.google.com/spreadsheets/d/1Nfabx_n1rNlO6NW3olD8MAibJ3KHnOMmMwOYYw4wwGc", 'accessions')
accessions <- read.csv("~/Downloads/accessions.csv")

sorghum_cultivars <- accessions %>% 
  transmute(specie_id = 2588, name = Source)

insert <- sorghum_cultivars %>% 
  mutate(insert = paste('insert into cultivars values (specie_id, name, created_at, updated_at) values(', 
                        specie_id, ",", name, ", now(), now());")) %>% 
  select(insert)

writeLines(insert$insert, 'sorghum_cultivars.sql')
