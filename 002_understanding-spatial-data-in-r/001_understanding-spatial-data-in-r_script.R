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

## check crs
st_crs(world_countries)

# CRS transformation ----
target_crs_robinson <- "ESRI:54030"
world_countries_robinson <- world_countries |>
  st_transform(
    crs = target_crs_robinson
  )
st_crs(world_countries_robinson)

# Visualization ----
plot_original <- ggplot() +
  geom_sf(
    data = world_countries,
    linewidth = 0.5
  ) +
  labs(
    title = "Original (EPSG:4326)"
  ) +
  theme_minimal()

plot_transformed <- ggplot() +
  geom_sf(
    data = world_countries_robinson,
    linewidth = 0.2
  ) +
  labs(
    title = "Transformed (Robinson)"
  ) +
  theme_minimal()
