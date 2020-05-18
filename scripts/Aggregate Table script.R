# Set up
library(dplyr)
library(lintr)
library(styler)

kc_housing <- read.csv("data/kc_house_data.csv", stringsAsFactors = FALSE)

# Summary table

summary_table <- function(dataset) {
  dataset %>%
    group_by(zipcode) %>%
    select(zipcode, price, bedrooms, bathrooms, 
           sqft_living, yr_built, condition) %>%
    summarize(
      avg_price = round(mean(price, na.rm = TRUE), 1),
      avg_bedrooms = round(mean(bedrooms, na.rm = TRUE),0),
      avg_bathrooms = round(mean(bathrooms, na.rm = TRUE), 0),
      avg_sqft_living = round(mean(sqft_living, na.rm = TRUE), 1),
      avg_yr_built = round(mean(yr_built, na.rm = TRUE), 0),
      avg_condition = round(mean(condition, na.rm = TRUE), 0)
    ) 
}

