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

