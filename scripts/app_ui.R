# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

source("first_page.R")
source("summary_takeaway.R")
source("overview_page.R")


ui <- navbarPage(
  "King County Housing",
  overview,
  page_one,
  summary_page
)