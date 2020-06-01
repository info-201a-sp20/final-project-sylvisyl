# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)
kc_crime <- kc_housing %>%
  filter(price >= 25000)
crime <- read.csv("../data/SPD_Officer_Involved_Shooting__OIS__Data.csv",
                  stringsAsFactors = FALSE)
crime_filtered_summary <- crime %>%
  filter(State == "WA") %>%
  filter(Officer.Injured == "No")
summary_crime_map <- leaflet() %>%
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
    color = "blue")

summary_page <- tabPanel(
  "Conclusion",
  titlePanel("Summary Takeaways"),
  fluidPage(
  h3("First summary takeaway"),
  p("Overall, by looking at the following table, it is evident
    to say that most of the houses in King County tends to have
    three to four bedrooms and two to three bathrooms. Most of
    the houses in King county have less than 3000 sqft living
    space and the accordingly price remain below one million
    dollar"),
  h4("Some implications:"),
  p("Through analyzing the data, it is obvious to say that
    King county housing condition is closely related to King
    county household condition. The King county housing dataset
    implies that families living in King county tend to have
    three to four people per household. King county people
    feel comfortable living and are able to afford a house
    that is less than 3000 sqft living space."),
  tableOutput(outputId = "table"),
  br(),
  h3("Second summary takeaway"),
  p("Based on the crime rates intereact maps and the following attache
  chart (blue = houses, and red = crime cases), we can notice that the
    region that often happen crime cases tend to have lower selling prices,
    compared with the high selling prices regions. The houses have higher prices
    tend to locate in suburb. Many factors play the role in that correlations but
    no doubuts that the security is one of the main one."),
  h4("Implications:"),
  p("By play with the graph and analyzing the correlation between crime rates and 
    housing prices, we could conclude that safety has played a huge role in affecting
    housing prices in king county. By using the map, we could predit : first, which 
    region might need a higher proportion of armed gurads to stabilize the community; 
    second, we could vaguely predict the prices of a house based on the region and 
    the crime rates around it."),
  leafletOutput(outputId = "summary_crime_map"),
  br(),
  )
)