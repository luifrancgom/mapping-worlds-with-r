# Load libraries ----
library(tidyverse)
library(readxl)

# Import ----
pob_dept_area_2018_2050 <- read_excel(
  path = "000_data/colombia/proyeccion-poblacion-departamento-area-2018-2050.xlsx",
  sheet = "PobDepartamentalxÁrea",
  range = "A10:E2946",
  col_names = c(
    "departamento_codigo",
    "departamento_nombre",
    "ano",
    "area_geografica",
    "poblacion_total"
  )
)

# Explore ----
pob_dept_area_2018_2050 |>
  glimpse()

# Export ----
pob_dept_area_2018_2050 |>
  write_csv(
    file = "000_data/colombia/proyeccion-poblacion-departamento-area-2018-2050.csv"
  )
