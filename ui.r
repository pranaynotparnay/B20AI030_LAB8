library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Interactive Iris Plots"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Plot Options"),
      selectInput("x_var", "Select X-axis variable:",
                  choices = colnames(iris)[1:4], selected = "Sepal.Length"),
      selectInput("y_var", "Select Y-axis variable:",
                  choices = colnames(iris)[1:4], selected = "Sepal.Width"),
      checkboxGroupInput("species", "Select species to display:",
                         choices = unique(iris$Species), selected = unique(iris$Species)),
      hr(), # Add a horizontal line
      h4("Additional Options"),
      checkboxInput("show_legend", "Show Legend", value = TRUE),
      sliderInput("point_size", "Point size:", min = 1, max = 10, value = 3, step = 1)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Histograms", plotlyOutput("histograms")),
        tabPanel("Scatter Plot", plotlyOutput("scatter_plot")),
        tabPanel("Violin Plot", plotlyOutput("violin_plot")),
        tabPanel("Box Plot", plotlyOutput("box_plot")),
        tabPanel("About", p("This Shiny app is designed to visualize the famous Iris dataset. Choose the desired plot type and options in the sidebar."))
      )
    )
  )
))

