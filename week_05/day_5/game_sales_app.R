library(tidyverse)
library(plotly)
library(shiny)
library(bslib)
library(shiny)

game_sales <- CodeClanData::game_sales

genre_choices <- game_sales %>% 
  distinct(genre) %>% 
  pull()


ui <- fluidPage(
  titlePanel(tags$b("21st Century Game Sales")),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "genre_input",
        label = "Which Genre?",
        choices = genre_choices
      ),
      sliderInput(
        inputId = "year_input",
        label = "Which Year?",
        min = 2000,
        max = 2016,
        value = 2008,
        sep = ""
        
      )
    ),
  mainPanel(
    plotlyOutput(
      "game_sales_plot"
    )
  )
  )
)

server <- function(input, output, session) {
  output$game_sales_plot <- renderPlotly(
    expr = {
     
       p <-  game_sales %>% 
        filter(year_of_release == input$year_input,
               genre == input$genre_input) %>% 
        ggplot() +
        aes(x = platform,
            y = sales,
            fill = platform,
            text = name) +
        geom_col() +
         theme_minimal(
         )+
         guides(
           fill = "none"
         )+
         labs(
           x = "Platform",
           y = "Total Sales",
         )
         
      
       ggplotly(p, tooltip = "text")
         
    }
  )
  
}

shinyApp(ui, server)
