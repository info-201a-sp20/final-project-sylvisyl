first_side_widget <- 

page_one <- tabPanel(
  "Midwest Population",
  titlePanel("Information about midwest population"),
  sidebarLayout(
    sidebarPanel(
      first_side_widget,
      textOutput(outputId = "message"),
      second_side_widget
    ),
    mainPanel(
      h3("Visualization of midwest population based on state"),
      plotOutput(outputId = "graph")
    )
  )
)