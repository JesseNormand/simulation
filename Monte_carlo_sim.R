#Monty Carlo Sim. Here I am running a revenue simulation.

#Start at 0
results = NULL

#Run random number sim with varianace. 500 trials. 

{revenue = runif(500,80000, 110000) 
  fixed_cost = runif(500,52000,57000)
  variable_cost = runif(500,100000,105000)

#total = min revenue, fixed_cost, variable

results <- data.frame(revenue, fixed_cost, variable_cost)
}

#Compute and print risk loss percentage

results$profit <- with(results, revenue - fixed_cost - variable_cost)
  x <- sum(results$profit < 0) / 500 * 100
  message("Risk Loss Score Percent: ", x)
  

ggplot(data = results, aes( x = profit, y = revenue, colour = profit)) + geom_point()





  
  
