# Libraries ----
library(tidyverse)
library(sf)


map_col <- st_read(
  dsn = "../../Downloads/MGN2025_ADM_DPTO_POLITICO_(Geopackage) (2)/MGN_ADM_DPTO_POLITICO (Geopackage).gpkg"
)

map_col |>
  glimpse()

map_col |>
  st_drop_geometry() |>
  count(dpto_ccdgo, dpto_cnmbr)

map_col |>
  st_drop_geometry() |>
  count(dpto_nano)

map_col |>
  ggplot() +
  geom_sf(
    aes(geometry = geom)
  )

map_col$geom |> st_perimeter()
