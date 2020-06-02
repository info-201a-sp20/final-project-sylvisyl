library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

year_maxium <- max(kc_housing$yr_built, na.rm = TRUE)
year_minum <- min(kc_housing$yr_built, na.rm = TRUE)

year_selected <- kc_housing %>%
  group_by(yr_built) %>%
  summarize(
    total_bedroom = sum(bedrooms, na.rm = TRUE),
    total_bathroom = sum(bathrooms, na.rm = TRUE),
    total_floors = sum(floors, na.rm = TRUE),
    total_num = n()
  )

year_interval <- sliderInput(
  inputId = "Interval",
  label = "The year interval(years)",
  value = c(1900, 2015),
  min = 1900,
  max = 2015,
  step = 5
)

color_selected <- selectInput(
  inputId = "color",
  label = "Select the color you want to display on the chart",
  choices = list("red", "orange", "yellow", "green", "blue", "purple", "black"),
  selected = "Red"
)

Y_values <- selectInput(
  inputId = "y_axis",
  label = "Select the value you want to display on the y-axis",
  choices = list(
    "total bedroom" = "total_bedroom",
    "total bathroom" = "total_bathroom",
    "total floors" = "total_floors",
    "total built" = "total_num"
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