# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

source("first_page.R")
source("summary_takeaway.R")


ui <- navbarPage(
  "King County Housing",
  page_one,
  summary_page
)