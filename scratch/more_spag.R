library(tidyverse)
library(lubridate)
bisley <- read_csv("data/QuebradaCuenca1-Bisley.csv")

result <- tibble(
  window_start = seq(
    bisley$Sample_Date[1],
    bisley$Sample_Date[nrow(bisley)],
    by = 9 * 7
  ),
  k_mgl = NA,
  mg_mgl = NA,
  # Fill in the rest of the ions
)
