# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(BQ1) {
  result <- tibble(
    window_start = seq(
      ymd(df$Sample_Date[1]),
      ymd(df$Sample_Date[nrow(df)]),
      by = paste(num_weeks, "weeks")
    ),
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

    in_window <- BQ1$Sample_Date >= w1 & BQ1$Sample_Date < w2

    k_window <- BQ1$K[in_window]
    mg_window <- BQ1$Mg[in_window]
    no3_window <- BQ1$`NO3-N`[in_window]
    nh4_window <- BQ1$`NH4-N`[in_window]
    ca_window <- BQ1$Ca[in_window]

    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$no3_mgl[i] <- mean(no3_window, na.rm = TRUE)
    result$nh4_mgl[i] <- mean(nh4_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
  }
  return(moving_average)
}
moving_average(BQ1)
