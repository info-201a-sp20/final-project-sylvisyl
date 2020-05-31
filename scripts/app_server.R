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
}
