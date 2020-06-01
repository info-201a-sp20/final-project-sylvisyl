library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

year_maxium <- max(kc_housing$yr_built, na.rm = TRUE)
year_minum <- min(kc_housing$yr_built, na.rm = TRUE)
interval <- 5

year_selected <- kc_housing %>%
  group_by(yr_built) %>%
  summarize(
    total_bedroom = sum(bedrooms, na.rm = TRUE),
    total_bathroom = sum(bathrooms, na.rm = TRUE),
    total_price = sum(price, na.rm = TRUE),
    total_floors = sum(floors, na.rm = TRUE),
    total_num = n()
  )

year_interval <- numericInput(
  inputId = "Interval",
  label = "The year interval(years)",
  value = 5,
  min = 5,
  max = 100,
  step = 5
)

color_selected <- selectInput(
  inputId = "color",
  label = "Select the color you want to display on the chart",
  choices = list("Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Black"),
  selected = "Red"
)

Y_values <- selectInput(
  inputId = "y-axis",
  label = "Select the value you want to display on the y-axis",
  choices = list(
    "total_bedroom",
    "total_bathroom",
    "total_price",
    "total_floors",
    "total_num"
  ),
  selected = "total_bedroom"
)

page_three <- tabPanel(
  "Housing in different years",
  titlePanel("Year Informations"),
  sidebarLayout(
    sidebarPanel(
      year_interval,
      color_selected,
      Y_values
    ),
    mainPanel(
      plotlyOutput(outputId = "histogram")
    )
  )
)