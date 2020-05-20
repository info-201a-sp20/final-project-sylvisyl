# Set up
library(dplyr)
library(lintr)
library(styler)
library(ggplot2)
library(plotly)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)


# Visualization section

zipcode_summary <- kc_housing %>%
  group_by(zipcode) %>%
  select(zipcode, price, sqft_living) %>%
  summarize(
    avg_price = mean(price, na.rm = TRUE),
    avg_sqft_living = mean(sqft_living, na.rm = TRUE)
  )

zipcode_summary_plot <- ggplotly(ggplot(data = zipcode_summary) +
  geom_point(mapping = aes(x = avg_sqft_living, y = avg_price)) +
  geom_smooth(mapping = aes(x = avg_sqft_living, y = avg_price)) +
  labs(
    title = "Relationship between price and living space based on zipcode",
    x = "Average living space",
    y = "Average price"
  ))
