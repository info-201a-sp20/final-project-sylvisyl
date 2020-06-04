# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

zipcode_summary <- kc_housing %>%
  group_by(zipcode) %>%
  select(
    zipcode, price, bedrooms, bathrooms,
    sqft_living, yr_built, condition
  ) %>%
  summarize(
    avg_price = round(mean(price, na.rm = TRUE), 1),
    avg_sqft_living = round(mean(sqft_living, na.rm = TRUE),1),
    num_bedrooms = round(mean(bedrooms, na.rm = TRUE), 0),
    num_bathrooms = round(mean(bathrooms, na.rm = TRUE), 0),
    avg_yr_built = round(mean(yr_built, na.rm = TRUE), 0),
    avg_condition = round(mean(condition, na.rm = TRUE), 1)
  )

# Widgets 

calculator_1 <- numericInput(
  inputId = "payment",
  label = "Monthly payments($)",
  value = 500,
  min = 1
)

calculator_2 <- numericInput(
  inputId = "period",
  label = "Mortgage period(years)",
  value = 30,
  min = 1
)
  
second_side_widget <- selectInput(
  inputId = "select",
  label = "Select the housing aspect you are interested about",
  choices = list(
    "Average living space(sqft)" = "avg_sqft_living",
    "Number of bedrooms" = "num_bedrooms",
    "Number of bathrooms" = "num_bathrooms",
    "Year built" = "avg_yr_built",
    "House condition" = "avg_condition"
  ),
  selected = "avg_sqft_living"
)

page_one <- tabPanel(
  "Housing Price",
  titlePanel(h1("King County Housing Price")),
  sidebarLayout(
    sidebarPanel(
      tags$div(class = "Calculator",
        h3("Mortgage Calculator"),
      ),
      br(),
      calculator_1,
      calculator_2,
      tags$div(class = "Calculator",
               textOutput(outputId = "result"),
      ),
      br(),
      second_side_widget
    ),
    mainPanel(
      p("The following visualization is a scatter plot that
        can help you to visualize different aspect of housing
        in relation to the housing price based on zipcode
        in King county."),
      tags$div(class = "interactive_map",
        plotlyOutput(outputId = "scatter")
      )
    )
  )
)