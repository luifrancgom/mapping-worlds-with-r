# Load libraries ----
library(sf)
library(tidyverse)
library(ggspatial)
library(rnaturalearth)

# Import data ----
depart_col <- st_read(
  dsn = "000_data/colombia/departamentos-de-colombia_2025-12-30.gpkg"
)
mun_col <- st_read(
  dsn = "000_data/colombia/municipios-de-colombia-2025-12-30.gpkg"
)

st_layers(dsn = "000_data/colombia/entidades-territoriales-de-colombia.gpkg")
iden_terr_col <- st_read(
  dsn = "000_data/colombia/entidades-territoriales-de-colombia.gpkg",
  layer = "Munpio"
)

world_boundaries_loaded <- st_read(
  dsn = "000_data/mapping-worlds-with-r/chapter-3/world_boundaries.gpkg"
)

country_indicators_loaded <- read_csv(
  file = "000_data/mapping-worlds-with-r/chapter-3/country_indicators.csv"
)

# Explore data ----
depart_col |>
  glimpse()

mun_col |>
  glimpse()

iden_terr_col |>
  glimpse()

world_boundaries_loaded |>
  glimpse()

country_indicators_loades |>
  glimpse()

depart_col |>
  st_drop_geometry() |>
  count(DeNorma)

mun_col |>
  st_drop_geometry() |>
  count(MpNorma)

mun_col |>
  st_drop_geometry() |>
  count(MpCategor)

mun_col |>
  st_drop_geometry() |>
  count(Restriccion) |>
  View()

depart_col |>
  class()

depart_col |>
  st_drop_geometry() |>
  count(DeCodigo, DeNombre) |>
  as_tibble() |>
  View()

# Filter
mun_col |>
  filter(is.na(MpNombre))

# Metadata
class(depart_col)
class(mun_col)

crs_info_depart_col <- st_crs(depart_col)
st_crs(mun_col)

st_crs(world_boundaries_loaded)

# Visualization
depart_col |>
  ggplot() +
  geom_sf(
    aes(geometry = SHAPE)
  ) +
  annotation_scale(
    location = "bl"
  ) +
  annotation_north_arrow(
    location = "tr"
  ) +
  coord_sf(datum = st_crs(x = 4626)) +
  theme_minimal()

mun_col |>
  ggplot() +
  geom_sf(
    aes(geometry = SHAPE)
  )

# Clean data ----
### Select and rename
world_selected <- world_boundaries_loaded |>
  select(
    NAME_ENGL,
    ISO3_CODE,
    geom
  )

world_remaned <- world_selected |>
  rename(
    country_name = NAME_ENGL,
    iso3 = ISO3_CODE,
    geometry = geom
  )

world_ne <- ne_countries(
  scale = "medium",
  returnclass = "sf"
) |>
  select(
    adm0_a3,
    continent
  ) |>
  st_drop_geometry()

### Join ----
world_remaned_with_cont <- world_remaned |>
  left_join(
    y = world_ne,
    by = join_by(iso3 == adm0_a3)
  )

world_data_joined <- world_remaned |>
  left_join(
    y = country_indicators_loaded,
    by = join_by(iso3 == iso3c)
  )

### Filter ----
africa_only <- world_remaned_with_cont |>
  filter(continent == "Africa")

#### Check if geometry is empty ----
africa_only |>
  filter(st_is_empty(geometry))

africa_only |>
  st_is_valid()

# Export ----
world_data_joined |>
  st_write(
    dsn = "000_data/mapping-worlds-with-r/chapter-3/world_data_cleaned_joined.gpkg",
    delete_layer = TRUE
  )

# Import ----
st_read(
  dsn = "000_data/mapping-worlds-with-r/chapter-3/world_data_cleaned_joined.gpkg"
) |>
  glimpse()
