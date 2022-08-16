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
       tableOutput(outputId = "datatable")),

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
  
  # output$scatterplotR <- renderPlot({
  #   a <- c_dat$units
  #   lst <- list(a)
  #   #inputID changes last variable in column for new data input. 
  #   
  #   a[29] <- input$NewData
  #   
  #   #build matrix for qcc to compute moving ragne.
  #   
  #   mr <- matrix(cbind(a[1:length(a)-1], a[2:length(a)]), ncol=2)
  #   
  #   #R chart
  #   rc <- qcc(mr[1:27,], type="R", newdata= mr[28:29,])
  
  # })
}

#Create a shiny appp object -------------------------------------------------

shinyApp(ui = ui, server = server)

