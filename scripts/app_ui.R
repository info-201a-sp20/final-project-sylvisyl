# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

source("first_page.R")


ui <- navbarPage(
  "King County Housing",
  overview_page,
  page_one,
  page_two,
  page_three,
  summary_page
)