library(tidyverse)
library(lubridate)
bisley <- read_csv("data/QuebradaCuenca1-Bisley.csv")
glimpse(bisley)


bisley_2 <- tibble(
  start = seq(
    bisley$Sample_Date[1],
    bisley$Sample_Date[nrow(bisley)],
    by = "9*7"
  ),
  K = NA,
  Mg = NA,
  NO3 = NA,
  NH4 = NA
)
bisley_2


for (i in 1:nrow(bisley_2)) {
  start <- bisley_2$start[i]
  print(start)
  end <- start +
    (9 * 7)
  print(end)
  K_values <- bisley$K[
    bisley$Sample_Date >= start & bisley$Sample_Date < end
  ]
  print(K_values)
  Mg_values <- bisley$Mg[
    bisley$Sample_Date >= start & bisley$Sample_Date < end
  ]
  print(Mg_values)
  NO3_values <- bisley$`NO3-N`[
    bisley$Sample_Date >= start & bisley$Sample_Date < end
  ]
  print(NO3_values)
  NH4_values <- bisley$`NH4-N`[
    bisley$Sample_Date >= start & bisley$Sample_Date < end
  ]
  print(NH4_values)
  K_mean <- mean(K_values, na.rm = TRUE)
  print(K_mean)
  Mg_mean <- mean(Mg_values, na.rm = TRUE)
  print(Mg_mean)
  NO3_mean <- mean(NO3_values, na.rm = TRUE)
  print(NO3_mean)
  NH4_mean <- mean(NH4_values, na.rm = TRUE)
  bisley_2$K[i] <- K_mean
  bisley_2$Mg[i] <- Mg_mean
  bisley_2$NO3[i] <- NO3_mean
  bisley_2$NH4[i] <- NH4_mean
}

bisley_longer <- bisley_2 |>
  pivot_longer(
    names_to = "Ions",
    values_to = "Values",
    cols = c(K, Mg, NO3, NH4)
  )

ggplot(
  data = bisley_2,
  mapping = aes(x = start, y = K)
) +
  geom_line()

ggplot(
  data = bisley_2,
  mapping = aes(x = start, y = Mg)
) +
  geom_line()

ggplot(
  data = bisley_longer,
  mapping = aes(x = start, y = Values)
) +
  geom_line()
