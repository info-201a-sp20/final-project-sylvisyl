# Set up
library(dplyr)
library(lintr)
library(styler)

kc_housing <- read.csv("data/kc_house_data.csv", stringsAsFactors = FALSE)

# Summary table

# Summary table function
summary_table <- function(dataset) {
  dataset %>%
    group_by(zipcode) %>%
    select(zipcode, price, bedrooms, bathrooms, 
           sqft_living, yr_built, condition) %>%
    summarize(
      avg_price = round(mean(price, na.rm = TRUE), 0),
      num_bedrooms = round(mean(bedrooms, na.rm = TRUE), 0),
      num_bathrooms = round(mean(bathrooms, na.rm = TRUE), 0),
      avg_sqft_living = round(mean(sqft_living, na.rm = TRUE), 1),
      avg_yr_built = round(mean(yr_built, na.rm = TRUE), 0),
      avg_condition = round(mean(condition, na.rm = TRUE), 1)
    ) 
}

# Important information sectiob

# Finding the zipcode that has the highest sale price
most_expensive_zip <- summary_table(kc_housing) %>%
  select(zipcode, avg_price) %>%
  filter(avg_price == max(avg_price, na.rm = TRUE)) %>%
  pull(zipcode)

most_expensive_price <- summary_table(kc_housing) %>%
  select(zipcode, avg_price) %>%
  filter(avg_price == max(avg_price, na.rm = TRUE)) %>%
  pull(avg_price)

# Finding the zipcode that has the oldest houses in average

oldest_zipcode <- summary_table(kc_housing) %>%
  select(zipcode, avg_yr_built) %>%
  filter(avg_yr_built == min(avg_yr_built, na.rm = TRUE)) %>%
  pull(zipcode)

oldest_year <- summary_table(kc_housing) %>%
  select(zipcode, avg_yr_built) %>%
  filter(avg_yr_built == min(avg_yr_built, na.rm = TRUE)) %>%
  pull(avg_yr_built)
