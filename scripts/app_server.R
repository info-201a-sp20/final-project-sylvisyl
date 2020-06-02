# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)
library(plotly)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)

# first page visualization dataset 
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

# Server
server <- function(input, output) {
  
# mortgage calculator 
  output$result <- renderText({
    return(paste0("Total cost of mortgage is $",
                  input$payment * 12 * input$period))
  })

# first page main visualization 
  output$scatter <- renderPlotly({
    title <- paste0("Relationship between price and ",
                    input$select, " based on zipcode")
    plot <- ggplot(data = zipcode_summary) +
      geom_point(mapping = aes_string(x = input$select, y = "avg_price")) +
      labs(
        title = title,
        x = "Your interested housing aspect",
        y = "Average price"
      )
    return(plot)
  })
  
# summary page table
summary_table <- kc_housing %>%
    group_by(zipcode) %>%
    select(
      zipcode, price, bedrooms, bathrooms,
      sqft_living, yr_built, condition
    ) %>%
    summarize(
      avg_price = round(mean(price, na.rm = TRUE), 0),
      num_bedrooms = round(mean(bedrooms, na.rm = TRUE), 0),
      num_bathrooms = round(mean(bathrooms, na.rm = TRUE), 0),
      avg_sqft_living = round(mean(sqft_living, na.rm = TRUE), 1),
      avg_yr_built = round(mean(yr_built, na.rm = TRUE), 0),
      avg_condition = round(mean(condition, na.rm = TRUE), 1)
    )
colnames(summary_table) <-  c("Zipcode", "Average Price", "Bedrooms", "Bathrooms",
                              "Average living space", "Year built", "Condition")


  output$table <- renderTable({
    summary_table
  })
  
  #crime map server
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
    kc_crime <- kc_housing %>%
      filter(price >= 2500000)
    crime_filtered_summary <- crime %>%
      filter(State == "WA") %>%
      filter(Officer.Injured == "No")
    output$crime_map_summary <- renderLeaflet({
      map <- leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addCircleMarkers(
          data = crime_filtered_summary,
          lng = ~Longitude,
          lat = ~Latitude,
          color = "red"
        ) %>%
        addCircleMarkers(
          data = kc_crime,
          lng = ~long,
          lat = ~lat,
          color = "blue"
        )
    })

}
