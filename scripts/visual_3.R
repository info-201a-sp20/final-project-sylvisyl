# Set up
library(dplyr)
library(lintr)
library(styler)
library(ggplot2)
library(plotly)

kc_housing <- read.csv("data/kc_house_data.csv", stringsAsFactors = FALSE)


#grouping and filtering datasets
#2variables: year_built vs avg_price
#plot type : line plot
#purpose: indicate the trend of price as built years vary
year_built_chart <- kc_housing %>%
   group_by(yr_built) %>%
   summarise(avg_price = mean(price))

year_build_plot <- ggplot(year_built_chart,aes(x=yr_built, y=avg_price)) +
  geom_line()+
  geom_point()+
  labs(x = "built year",
       y = "Average selling price",
       title = "Trends of mean price and built year")
ggplotly(year_build_plot)  
