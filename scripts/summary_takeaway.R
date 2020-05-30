# Set up

library(shiny)
library(dplyr)
library(ggplot2)
library(lintr)
library(styler)

kc_housing <- read.csv("../data/kc_house_data.csv", stringsAsFactors = FALSE)


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
  tableOutput(outputId = "table")
  )
)