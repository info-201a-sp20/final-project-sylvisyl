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
source("third_page.R")
source("overview_page.R")
source("crime_map.R")

ui <- fluidPage(
  includeCSS("styles.css"),
    navbarPage(
    "King County Housing",
    overview,
    page_one,
    page_three,
    map_page,
    summary_page
  )
)

