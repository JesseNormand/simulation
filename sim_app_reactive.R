library(shiny)
library(dplyr)
library(ggplot2)




# Define UI for app -----------------------------------------------------------

ui <- fluidPage(

  titlePanel("Profit Loss Simulation"),
  sidebarLayout(
    sidebarPanel(
      
      
      sliderInput(inputId = "trials",
                  label = "Select the number of trials to run",
                  min = 500,
                  max = 1000,
                  value = 500),
      
      sliderInput(inputId = "min",
                  label = "Select mininmal expected revenue",
                  min = 100000,
                  max = 300000,
                  value = 100000),
      
      sliderInput(inputId = "max",
                  label = "Select maximum expected revenue",
                  min = 100000,
                  max = 300000,
                  value = 185000),
      
      textOutput(outputId = "text")
  
),


mainPanel(
  
  tabsetPanel(type = "tabs",
              tabPanel("Profit Plot", plotOutput("plot")),
              tabPanel("Data Table", tableOutput("datatable"))
             
              
  )
)
)
)

              
#Define server -------------------------------------------------------------

server <- function(input, output, session) {
  
  
    
   dfInput <- reactive({revenue = runif(input$trials,input$min, input$max)
    fixed_cost = runif(input$trials,52000,57000)
    variable_cost = runif(input$trials,100000,105000)
    results <- data.frame(revenue, fixed_cost, variable_cost) %>% 
    mutate(profit = revenue - fixed_cost - variable_cost)
    
    })
   
   output$text <- renderText({
   
     x <- sum(dfInput()$profit < 0) / input$trials * 100
     paste("Percentage risk of running in the red: ", x)
     
   })
   
   output$plot <- renderPlot({
     ggplot(dfInput(), aes(x = revenue, y = profit)) +
       geom_bar(stat="identity", color="gray", position=position_dodge())+
       theme_minimal()
    
     
   })

   output$datatable <- renderTable({dfInput()})
   
   }

  



#Create a shiny appp object -------------------------------------------------

shinyApp(ui = ui, server = server)

