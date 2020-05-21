

kc_housing <- read.csv("data/kc_house_data.csv",
                 stringsAsFactors = FALSE)

library("dplyr")


get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  ret$col_names <- colnames(dataset)
  ret$avg_price <- mean(dataset$price)
  ret$year_of_oldest_house_built <- min(dataset$yr_built)
  ret$year_of_newest_house_built <- max(dataset$yr_built)
  ret$avg_sq_ft_above_ground <- mean(dataset$sqft_above)
  return (ret)
}



list <- get_summary_info(kc_housing)


