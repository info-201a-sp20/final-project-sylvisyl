# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)
library(leaflet)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)
crime <- read.csv("../data/SPD_Officer_Involved_Shooting__OIS__Data.csv",
                  stringsAsFactors = FALSE)



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
  leafletOutput("crime_map_summary"),
  br(),
  h3("Third summary takeaway"),
  p("The Housing in Different Years tab shows several clear trends in housing from
    1900 to 2015. Overall, it's clear that houses are gettting bigger and are 
    built more frequently. The total number of houses built, total bedrooms, total
    bathrooms, and total floors, all show a clear trend upwards from 1900 to 2015."),
  h4("Implications"),
  p("We can infer that there was an increased demand for housing over the last century
    because of the fast increase in number of houses built. It's interesting to then
    see that the houses built were also increasingly larger. This shows that perhaps
    the average person looking for housing in Seattle was growing increasingly 
    wealthy. This could help explain the lack of affordable housing and increasing 
    homelessness population in Seattle."),
  plotlyOutput("bar_chart")
  )
)

