# Load libraries ----
library(sf)
library(rnaturalearth)
library(tidyverse)

# Import ----
world_countries <- ne_countries(
  scale = "medium",
  returnclass = "sf"
)

world_cities <- ne_download(
  scale = "medium",
  type = "populated_places",
  category = "cultural",
  returnclass = "sf"
)

# Explore ----
## glimpse ----
world_countries |>
  glimpse()

world_cities |>
  glimpse()

## attribute table ----
### drops the geometry of tis argument
st_drop_geometry(world_countries)

## geometry column preserving metadata ----
st_geometry(world_countries)
