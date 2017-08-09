### A Shiny app for visualizing trait data in BETYdb

#### Time series box, line plots and heatmaps for every available season

#### Dependencies

- shiny
- shinythemes
- lubridate
- dplyr
- ggplot2
- timevis
- rgeos
- leaflet
- cronR

```{r echo=FALSE}
lapply(list('shiny', 'shinythemes', 'lubridate', 'dplyr', 'ggplot2', 'timevis', 'rgeos', 'leaflet', 'cronR'),
       install.packages)
```

to install cron (Ubuntu)

```sh
apt-get update
apt-get install cron
```

#### Setup and Notes

* Data are cached in a file `cache.RData` and updated using the cronR R interface to cron
* Access to BETYdb remote access requires ssh tunnel `ssh -Nf -L 5432:localhost:5432 bety6.ncsa.illinois.edu`
  * requires access, which can be [requested here](https://identity.ncsa.illinois.edu/join/TU49BUUEDM)
* Set the following environment variables

- bety_dbname ('bety')
- bety_password
- bety_host ('localhost')
- bety_port ('5432')
- bety_user ('bety')
