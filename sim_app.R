library(shiny)
library(dplyr)




# Define UI for app -----------------------------------------------------------

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
 
# Sidebar layout with input and output definitions ----------------------------

  sidebarLayout(
    
# Sidebar panel for inputs ----------------------------------------------------

    sidebarPanel(
      #Set shape with Slider
      
      sliderInput(inputId = "trials",
                  label = "Select the number of trials to run",
                  min = 500,
                  max = 1000,
                  value = 500),
      
    ),

    


#Main Panel Output: Show scatter plots and data table -------------------------

    mainPanel(
       tableOutput(outputId = "datatable"),
       textOutput(sidebarPanel, outputId = "text"),
       
    )
)
)
       

    
  



#Define server -------------------------------------------------------------

server <- function(input, output, session) {
  
  output$datatable <- renderTable({
    {revenue = runif(input$trials,155000, 182500)
    fixed_cost = runif(input$trials,52000,57000)
    variable_cost = runif(input$trials,100000,105000)

    #total = min revenue, fixed_cost, variable

    results <- data.frame(revenue, fixed_cost, variable_cost)
    }
  })
  
  output$text <- renderText({
    
  #results$profit <- with(results, revenue - fixed_cost - variable_cost)
    
  results$profit <- with(results, revenue - fixed_cost - variable_cost)
  x <- sum(results$profit < 0) / input$trials *100
  paste("Risk Loss Score Percent: ", x)


  })
}

#Create a shiny appp object -------------------------------------------------

shinyApp(ui = ui, server = server)

