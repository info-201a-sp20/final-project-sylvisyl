# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)
library(plotly)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)
crime <- read.csv("../data/SPD_Officer_Involved_Shooting__OIS__Data.csv",
                  stringsAsFactors = FALSE)
crime <- crime %>%
  filter(State == "WA")

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

# Third page visualization
  output$liner <- renderPlotly({
    liner_plot <- ggplot(data = year_selected) +
    geom_line(mapping = aes_string(x = "yr_built", y = input$y_axis), color = input$color) +
    scale_x_continuous(limits = input$Interval) +
      labs(
        title = "Overview of King County Housing each year",
        x = "Year built (years)",
        y = "Number of built"
      )
    return(liner_plot)
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


# summary page bar chart for house price by year
  modified_df <- kc_housing %>%
    group_by(yr_built) %>%
    summarise(avg_sqft = mean(sqft_living))
  
  bar_chart <- plot_ly(
    x = modified_df$yr_built,
    y = modified_df$avg_sqft,
    name = "Average price per year",
    type = "bar"
  )

output$year_table <- renderPlotly({
  bar_chart
})

# server for crime map
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
        radius = 0.05,
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
    
#not reactive map for summary takeaway
    output$crime_map_summary <- renderLeaflet({
      kc_crime <- kc_housing %>%
        filter(price >= 2500000)
      crime_sumarry <- crime %>%
        filter(Officer.Injured == "No")
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addCircleMarkers(
          data = crime_sumarry,
          lng = ~Longitude,
          lat = ~Latitude,
          color = "red",
          popup = paste0(crime_sumarry$Longtitude,
                         "\n",
                         crime_sumarry$Latitude)
        ) %>%
        addCircleMarkers(
          data = kc_crime,
          lng = ~long,
          lat = ~lat,
          color = "blue",
          popup = paste0("price:",
                         kc_crime$price,
                         "\n",
                         "bedroom#:",
                         kc_crime$bedrooms,
                         "\n",
                         "bathroom#:",
                         kc_crime$bathrooms,
                         "\n",
                         "zipcode:",
                         kc_crime$zipcode)
        )
    })
    
}
