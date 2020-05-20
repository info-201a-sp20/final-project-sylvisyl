# Set up
library(dplyr)
library(lintr)
library(styler)
library(ggplot2)
library(plotly)

<<<<<<< HEAD
kc_housing <- read.csv("data/kc_house_data.csv",
                       stringsAsFactors = FALSE)
=======
kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)
>>>>>>> 8a5ce49bf98455bc2fe8e59a0a8e2622fe60eba0


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
