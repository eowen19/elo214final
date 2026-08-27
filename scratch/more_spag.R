library(tidyverse)
library(lubridate)
BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM <- read_csv("data/RioMameyesPuenteRoto.csv")

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
result <- tibble(
  window_start = seq(ymd("1989-05-20"), ymd("1999-12-27"), by = "9 weeks"),
  k_mgl = NA,
  mg_mgl = NA,
  no3_mgl = NA,
  nh4_mgl = NA,
  ca_mgl = NA
)
result
for (i in 1:nrow(result)) {
  w1 <- result$window_start[i]
  w2 <- w1 + weeks(9)

  in_window <- df$Sample_Date >= w1 & df$Sample_Date < w2

  k_window <- df$K[in_window]
  mg_window <- df$Mg[in_window]
  no3_window <- df$`NO3-N`[in_window]
  nh4_window <- df$`NH4-N`[in_window]
  ca_window <- df$Ca[in_window]

  result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
  result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
  result$no3_mgl[i] <- mean(no3_window, na.rm = TRUE)
  result$nh4_mgl[i] <- mean(nh4_window, na.rm = TRUE)
  result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
}
result

glimpse(BQ1)
BQ1$Sample_Date


source("R/moving-average.R")
