# set up 
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(leaflet)
library(shinythemes)

# source
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)