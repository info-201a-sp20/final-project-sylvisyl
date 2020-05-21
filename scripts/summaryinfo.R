

kc_housing <- read.csv("data/kc_house_data.csv",
                 stringsAsFactors = FALSE)

library("dplyr")


get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  ret$col_names <- colnames(dataset)
  ret$avg_price <- round(mean(dataset$price), 1)
  ret$year_of_oldest_house_built <- min(dataset$yr_built)
  ret$year_of_newest_house_built <- max(dataset$yr_built)
  ret$avg_sq_ft_above_ground <- round(mean(dataset$sqft_above), 1)
  return (ret)
}



