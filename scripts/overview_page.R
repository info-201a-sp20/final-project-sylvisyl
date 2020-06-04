#Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

# Overview page 
overview <- tabPanel(
  "Overview",
  titlePanel(h1("Overview")),
  fluidPage(
    h2("Data Set"),
    p("We chose to analyze a dataset called House Sales in King County, USA.
      The dataset contains house sale prices between May 2014 and May 2015
      in King County. We chose to look at this data set because homelessness
      rates are high in King County. We were hoping to use this data to better
      understand what the housing market is like in King County. As students
      at the University of Washington, this issue is important and relevant
      to us. The data set can be found here:
      https://www.kaggle.com/harlfoxem/housesalesprediction"),
    h2("Questions"),
    img("", src = "https://images.freeimages.com/images/large-previews/9b4/seattle-skyline-1541208.jpg"),
    p("The questions we aim to answer using this dataset will help to illustrate
      what housing in Seattle looked like in 2015. We will be looking at factors
      like zipcode, number of bedrooms, number of bathrooms, squarefootage,
      year built, condition and cost, and analyzing
      how they are correlated, if at all. Several specific
      questions we have are, how do houses vary by zipcode?
      How does crime vary by zipcode?
      How have houses changed from 1900 to 2015?")
   )
)