# set up 
library(shiny)
library(ggplot2)
library(dplyr)

# source
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)