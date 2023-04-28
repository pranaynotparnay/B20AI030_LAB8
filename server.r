library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
  output$histograms <- renderPlotly({
    hist_plots <- lapply(names(iris)[-5], function(x) {
      p <- ggplot(iris, aes_string(x)) +
        geom_histogram(bins = 30) +
        labs(title = paste("Histogram of", x))
      ggplotly(p, tooltip = "text") %>%
        layout(
          updatemenus = list(
            list(
              buttons = list(
                list(
                  args = list("xbins", list(size = 5)),
                  label = "Bin size: 5",
                  method = "restyle"
                ),
                list(
                  args = list("xbins", list(size = 10)),
                  label = "Bin size: 10",
                  method = "restyle"
                )
              ),
              type = "buttons"
            )
          )
        )
    })
    subplot(hist_plots, nrows = 2, shareX = FALSE, shareY = FALSE)
  })
  
  output$scatter_plot <- renderPlotly({
    scatter_data <- iris[iris$Species %in% input$species, ]
    scatter_plot <- ggplot(scatter_data, aes_string(input$x_var, input$y_var, color = "Species", symbol = "Species")) +
      geom_point(size = 4) +
      labs(title = "Scatter Plot of Iris Data")
    
    ggplotly(scatter_plot, tooltip = "text")
  })
  
  output$violin_plot <- renderPlotly({
    violin_plot <- ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
      geom_violin() +
      labs(title = "Violin Plot of Iris Data")
    
    ggplotly(violin_plot, tooltip = "text")
  })
})
