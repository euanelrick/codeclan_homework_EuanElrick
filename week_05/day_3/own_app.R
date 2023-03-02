library(CodeClanData)
library(shiny)
library(tidyverse)
library(bslib)


game_sales <- CodeClanData::game_sales

genre_choices <- game_sales %>% 
  distinct(genre) %>% 
  pull()

platform_choices <-  game_sales %>% 
  distinct(platform) %>% 
  pull()

rating_choices <-  game_sales %>% 
  distinct(rating) %>% 
  pull()




ggplot(game_sales) +
  aes(x = user_score,
      y = critic_score) +
  geom_point() +
  theme_minimal() +
  scale_x_continuous(limits = c(0,10),
                     breaks = c(0, 2, 4, 6, 8, 10)) +
  scale_y_continuous(limits = c(0, 100),
                     breaks = c(0, 20, 40, 60, 80, 100)) +
  labs(
    x = "\nUser Score Out of 10",
    y = "Critic Score Out of 100\n"
  )

library(shiny)

ui <- fluidPage(
  titlePanel(tags$h1(tags$b("Game Picker"))),
  tags$br(),
  theme = bs_theme(bootswatch = "quartz"),
  
  fluidRow(
    column(
      width = 3,
      offset = 2,
      selectInput(
        inputId = "genre_input",
        label = tags$i("Which genre?"),
        choices = genre_choices
      )
    ),
    column(
      width = 3,
      offset =2,
      selectInput(
        inputId = "platform_input",
        label = tags$i("Which platform?"),
        choices = platform_choices
      )
    )
    
    
  ),
  
  fluidRow(
    column(
      width = 12,
      plotOutput(
        "reviews_plot",
        click = "reviews_plot_click")
    )
  ),
  
  fluidRow(
    column(width = 6,
           h4("Games near click"),
           verbatimTextOutput("click_info")
    )
  )

)


server <- function(input, output, session) {
  output$reviews_plot <- renderPlot(
    expr = {
      game_sales %>% 
        filter(genre == input$genre_input,
               platform == input$platform_input) %>% 
      ggplot() +
        aes(x = user_score,
            y = critic_score) +
        geom_point() +
        theme_minimal() +
        scale_x_continuous(limits = c(0,10),
                           breaks = c(0, 2, 4, 6, 8, 10)) +
        scale_y_continuous(limits = c(0, 100),
                           breaks = c(0, 20, 40, 60, 80, 100)) +
        labs(
          x = "\nUser Score Out of 10",
          y = "Critic Score Out of 100\n"
        )
    }
    )
  output$click_info <- renderPrint({
    # Because it's a ggplot2, we don't need to supply xvar or yvar; if this
    # were a base graphics plot, we'd need those.
    nearPoints(game_sales, input$reviews_plot_click, threshold = 2,
               maxpoints = 3, allRows = FALSE)
  })
}


shinyApp(ui, server)






  
