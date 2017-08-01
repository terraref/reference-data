### A Shiny app for visualizing trait data in BETYdb

#### Time series box, line plots and heatmaps for every available season

#### Dependencies
- shiny
- shinythemes
- tools
- lubridate
- dplyr
- ggplot2
- timevis
- rgeos
- leaflet
- cronR

#### Data cached in 'cache.RData'
#### BETYdb remote access uses ssh tunnel: ssh -Nf -L 5432:localhost:5432 bety6.ncsa.illinois.edu
#### [Request access](https://identity.ncsa.illinois.edu/join/TU49BUUEDM)
#### Set the following environment variables
- bety_dbname ('bety')
- bety_password
- bety_host ('localhost')
- bety_port ('5432')
- bety_user ('bety')
