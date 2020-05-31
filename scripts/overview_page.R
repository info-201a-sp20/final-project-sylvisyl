library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

overview <- tabPanel(
  "Overview",
  titlePanel("Overview"),
  fluidPage(
    h3("Data Set"),
    p("We chose to analyze a dataset called House Sales in King County, USA. 
      The dataset contains house sale prices between May 2014 and May 2015
      in King County. We chose to look at this data set because homelessness
      rates are high in King County. We were hoping to use this data to better
      understand what the housing market is like in King County. As students
      at the University of Washington, this issue is important and relevant
      to us. The data set can be found here: 
      https://www.kaggle.com/harlfoxem/housesalesprediction"),
    h3("Questions"),
    p("*Insert questions we are analyzing*"),
    img("", src = "https://images.freeimages.com/images/large-previews/9b4/seattle-skyline-1541208.jpg")
   )
)