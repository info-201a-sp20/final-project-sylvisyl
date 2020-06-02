library(dplyr)
library(lintr)
library(styler)
library(ggplot2)
library(plotly)

kc_housing <- read.csv("data/kc_house_data.csv",
                       stringsAsFactors = FALSE)

a_modified_df <- kc_housing %>%
  group_by(yr_built) %>%
  summarise(avg_price = mean(price))

a_bar_chart <- plot_ly(
  x = modified_df$yr_built,
  y = modified_df$avg_price,
  name = "Average price per year",
  type = "bar"
)


