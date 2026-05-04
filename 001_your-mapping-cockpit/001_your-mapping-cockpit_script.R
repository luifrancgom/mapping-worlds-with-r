# Load libraries ----
library(sf)
library(rnaturalearth)

# Import data ----
world_sf <- ne_countries(
  scale = "medium",
  returnclass = "sf"
)

# Check CRS ----
crs_info <- st_crs(world_sf)
crs_info$input
crs_info$wkt

class(crs_info)

# Transform CRS ----
## Robinson projection
target_crs_robinson <- "ESRI:54030"
world_robinson_sf <- world_sf |>
  st_transform(crs = target_crs_robinson)

st_crs(world_robinson_sf)

# Visualization
par(mfrow = c(1, 2))
plot(
  st_geometry(world_sf),
  main = "Original (EPSG:4326)",
  key.pos = NULL, # Do not draw a legend
  reset = FALSE,
  border = "grey"
)
plot(
  st_geometry(world_robinson_sf),
  main = "Transformed (Robinson)",
  key.pos = NULL,
  reset = FALSE,
  border = "blue"
)

par(mfrow = c(1, 1))
