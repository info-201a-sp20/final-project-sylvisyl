#setup

library(dplyr)
library(leaflet)
library(shiny)
kc_housing <- read.csv("../data/kc_house_data.csv",
                       stringsAsFactors = FALSE)
crime <- read.csv("../data/SPD_Officer_Involved_Shooting__OIS__Data.csv",
                  stringsAsFactors = FALSE)
crime <- crime %>%
  filter(State == "WA")

#widget 1 : sliderbar for zipcode
widget_1 <- sliderInput(
  "zc",
  "1. Select the range of zipcode:",
  value = c(98101, 98199),
  min = 98101,
  max = 98199
)

#widget 2: sliderbar for price
widget_2 <- sliderInput(
  "prices",
  "2. Select the budget:",
  value = c(75000, 7700000),
  min = 75000,
  max = 7700000
)

#widget 3: checkbox group for crime status
widget_3 <- selectInput("case", "3.Select the cases shown:",
                               c("serve cases" = "Yes",
                                 "normal cases" = "No")
)
#layout
map_page <- tabPanel(
  "Crime and housing",
  titlePanel(h1("King couty housing and security")),
  sidebarLayout(
    sidebarPanel(
      widget_1,
      br(),
      widget_2,
      br(),
      widget_3
      ),
    mainPanel(
      p("In this section, the following intereact map
        would demonstrate the correlation between houses
        sites and the crime cases, to see whether safety
        is a huge factor for housing price."),
      tags$div(class = "interactive_map",
      leafletOutput("crime_map")
      )
    )
  )
)

ui <- fluidPage(
  mainPanel(
    map_page
  )
)

#server
server <- function(input, output) {
  crime_filtered <- reactive({
    crime %>%
      filter(Officer.Injured == input$case) %>%
      select(Date,
             Longitude,
             Latitude,
             Officer.Injured)
  })
  kc_filtered <- reactive({
    kc_housing %>%
      filter(zipcode >= input$zc[1]) %>%
      filter(zipcode <= input$zc[2]) %>%
      filter(price >= input$prices[1]) %>%
      filter(price <= input$prices[2]) %>%
      select(price,
             bedrooms,
             bathrooms,
             zipcode,
             lat,
             long)
  })
  output$crime_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      addCircleMarkers(
        data = crime_filtered(),
        lng = ~Longitude,
        lat = ~Latitude,
        color = "red",
        popup = paste0(crime_filtered()$Longtitude,
                       "\n",
                       crime_filtered()$Latitude)
      ) %>%
      addCircleMarkers(
        data = kc_filtered(),
        lng = ~long,
        lat = ~lat,
        color = "blue",
        popup = paste0("price:",
                       kc_filtered()$price,
                       "\n",
                       "bedroom#:",
                       kc_filtered()$bedrooms,
                       "\n",
                       "bathroom#:",
                       kc_filtered()$bathrooms,
                       "\n",
                       "zipcode:",
                       kc_filtered()$zipcode)
      )
  })
}
