#load libraryies tidyverse and lubridate
library(tidyverse)
library(lubridate)
BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM <- read_csv("data/RioMameyesPuenteRoto.csv")

#call moving-average function
source("R/moving-average.R")

#filter dataframes to years in questions (1988-1994)
BQ1_filtered <- BQ1 |>
  select("Sample_ID", "Sample_Date", "K", "Mg", "NH4-N", "NO3-N", "Ca") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

BQ2_filtered <- BQ2 |>
  select("Sample_ID", "Sample_Date", "K", "Mg", "NH4-N", "NO3-N", "Ca") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

BQ3_filtered <- BQ3 |>
  select("Sample_ID", "Sample_Date", "K", "Mg", "NH4-N", "NO3-N", "Ca") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

PRM_filtered <- PRM |>
  select("Sample_ID", "Sample_Date", "K", "Mg", "NH4-N", "NO3-N", "Ca") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

#perfrom moving average function on cleaned dataframes
BQ1_moving_average <- moving_average(BQ1_filtered, 9)

BQ2_moving_average <- moving_average(BQ2_filtered, 9)

BQ3_moving_average <- moving_average(BQ3_filtered, 9)

PRM_moving_average <- moving_average(PRM_filtered, 9)

#bind averaged dataframes together
bind_data <- bind_rows(
  BQ1_moving_average,
  BQ2_moving_average,
  BQ3_moving_average,
  PRM_moving_average
)

#put bound dataframe into output folder
write_csv(bind_data, "output/binddata.csv")

#designate the hurricane date
hurricane_date <- ymd("1989-09-10")

#pivot the dataframe
bind_longer <- bind_data |>
  pivot_longer(
    cols = k_mgl:ca_mgl,
    names_to = "Ions",
    values_to = "Concentrations",
  ) |>
  mutate(
    Ions = factor(
      Ions,
      levels = c("k_mgl", "mg_mgl", "ca_mgl", "no3_mgl", "nh4_mgl"),
    )
  ) |>
  mutate(
    site = factor(
      site,
      levels = c("Q1", "Q2", "Q3", "MPR"),
      labels = c("BQ1", "BQ2", "BQ3", "PRM")
    )
  )
#create the ggplot
ggplot(
  data = bind_longer,
  mapping = aes(
    x = window_start,
    y = Concentrations,
    linetype = site,
    color = Ions,
  )
) +
  geom_line() +
  geom_vline(
    xintercept = hurricane_date,
    linetype = "dashed"
  ) +
  theme_bw() +
  facet_wrap(vars(Ions), scales = 'free', ncol = 1, strip.position = "left") +
  labs(
    x = "Years",
    y = "Ions",
    linetype = NULL
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.position = "outside"
  )
