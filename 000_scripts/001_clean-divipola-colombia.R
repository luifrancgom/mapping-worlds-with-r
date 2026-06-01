# Load library ----
library(tidyverse)
library(readxl)
library(janitor)

# Import ----
divipola_departamentos <- read_excel(
  path = "000_data/colombia/divipola-departamentos.xlsx",
  range = "A10:D43"
)

divipola_municipios <- read_excel(
  path = "000_data/colombia/divipola-municipios.xlsx",
  range = "A12:G1133",
  col_names = c(
    "departamento_codigo",
    "departamento_nombre",
    "municipio_codigo",
    "municipio_nombre",
    "municipio_tipo",
    "municipio_longitud",
    "municipio_latitud"
  )
)

# Clean ----
divipola_departamentos <- divipola_departamentos |>
  clean_names() |>
  rename_with(.fn = \(x) paste0("departamento_", x))

# Explore ----
divipola_departamentos |>
  glimpse()

divipola_municipios |>
  glimpse()

# Export ----
divipola_departamentos |>
  write_csv(file = "000_data/colombia/divipola-departamentos.csv")

divipola_municipios |>
  write_csv(file = "000_data/colombia/divipola-municipios.csv")

# Import ----
read_csv(file = "000_data/colombia/divipola-departamentos.csv") |>
  glimpse()

read_csv(file = "000_data/colombia/divipola-municipios.csv") |>
  glimpse()
