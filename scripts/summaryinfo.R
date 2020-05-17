
rm(list = ls())

kc_housing <- read.csv("data/kc_house_data.csv",
                 stringsAsFactors = FALSE)

library("dplyr")
View(kc_housing)

summary_table <- kc_housing %>%
  summarize(avg_price = mean(price),
            max_price = max(price),
            min_price = min(price),
            oldest_house_year_built = min(yr_built),
            newest_house_year_built = max(yr_built)
  )
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

get_summary_info(kc_housing)

