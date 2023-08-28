#------------------------------------------------------------------------------*
# Revisar datos de leads ----
#------------------------------------------------------------------------------*#--------------------------------------------------------------------------------*


# Load used packages
library(package = "tidyverse")


# read in exported data
leads <- read_tsv(
  "data/Cuestionario sobre acoso callejero_Leads_2023-08-15_2023-08-22.csv",
  locale = readr::locale(encoding = "UTF-16LE")
) %>%
  print()


responses <- leads %>%
  select(
    timestamp = created_time,
    is_organic,
    harassed = Alguna_vez_acosado,
    period = Cuando_ultimo_acoso,
    frequency = Veces,
    department = Departamento
  ) %>%
  mutate(
    period = factor(
      period,
      levels = c(
        "esta_semana",
        "este_mes",
        "el_último_trimestre"
      )
    ),
    frequency = factor(
      frequency,
      levels = c(
        "una_vez",
        "de_dos_a_cinco_veces",
        "más_de_cinco"
      )
    )
  ) %>%
  print()

# solo respondieron personas acosadas
responses %>%
  count(harassed)

# la mayoría no son respuestas orgánicas
responses %>%
  count(is_organic)

# la mayoría son acosos recientes
responses %>%
  count(period, frequency) %>%
  spread(frequency, n)
