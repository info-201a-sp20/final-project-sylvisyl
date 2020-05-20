# Set up
library(dplyr)
library(lintr)
library(styler)
library(ggplot2)
library(plotly)

kc_housing <- read.csv("../data/kc_house_data.csv",
                       stringsAsFactors = FALSE)
kc_housing$date <- as.Date(kc_housing$date, "%Y%m%d")

#sold houses by month
#1 variables : yr_month
#plot ype : bar graph
#purpose : to see which period of timepeople are willing to buy
month_chart_14 <- kc_housing %>%
  filter(format(date, "%Y") == "2014") %>%
  mutate(month = format(date, "%m")) %>%
  group_by(month) %>%
  summarise(n = n()) %>%
  arrange(month)

month_chart_15 <- kc_housing %>%
  filter(format(date, "%Y") == "2015") %>%
  mutate(month = format(date, "%m")) %>%
  group_by(month) %>%
  summarise(n = n()) %>%
  arrange(month)

month_plot_14 <- ggplotly(ggplot(month_chart_14, aes(x = month,
                                               y = n)) +
  geom_bar(stat="identity", width=0.5)+
  labs(x = "sold month",
       y = "sold number",
       title = "number of sold houses by months in 2014"))
month_plot_15 <- ggplotly(ggplot(month_chart_15, aes(x = month,
                                                     y = n)) +
                            geom_bar(stat="identity", width=0.5)+
                            labs(x = "sold month",
                                 y = "sold number",
                                 title = "number of sold houses by months in 2015"))

