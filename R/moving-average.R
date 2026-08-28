# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(df, num_week) {
  result <- tibble(
    window_start = seq(
      ymd(df$Sample_Date[1]),
      ymd(df$Sample_Date[nrow(df)]),
      by = paste(num_week, "weeks")
    ),
    k_mgl = NA,
    mg_mgl = NA,
    no3_mgl = NA,
    nh4_mgl = NA,
    ca_mgl = NA,
    site = NA
  )
  result

  for (i in 1:nrow(result)) {
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(num_week)
    site <- df$Sample_ID

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
    result$site[i] <- df$Sample_ID
  }
  return(result)
}
moving_average(df = BQ1, num_week = 9)
