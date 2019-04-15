library(shiny)
library(SmarterPoland)
library(dplyr)

ui <- fluidPage(
  
  titlePanel("Simple Shiny App"),
  
  h2("Scatterplot"),
  plotOutput("countries_plot", height = 600, click = "country_click"),
  verbatimTextOutput("country_click_value")
)

server <- function(input, output) {
  
  countries_reactive <- reactiveValues(countries)
  output[["country_click_value"]] <- renderPrint({
    str(nearPoints(countries, input[["country_click"]], maxpoints=1))
  })
  
  continent_colors <- c(Asia = "red", Europe = "green", Africa = "orange", Americas = "black", 
                        Oceania = "blue")
  
  output[["countries_plot"]] <- renderPlot({
    ggplot(countries, aes(x = birth.rate, y = death.rate, color = continent)) +
    geom_point() +
    scale_color_manual(values = continent_colors) +
    theme_bw()
  })
  
}

shinyApp(ui = ui, server = server)
