source("Algorithms/gcl-algo.R")
chi_deux_critical_values <- function() {
  numbers_length<-length( gclNormalized())
  alpha_levels <- c(0.9, 0.8, 0.7, 0.5, 0.3, 0.2, 0.1, 0.05, 0.02, 0.01)
  degrees_of_freedom <- 1:numbers_length
  chi_squared_table <- matrix(NA, nrow = length(degrees_of_freedom), ncol = length(alpha_levels))
  for (i in 1:length(degrees_of_freedom)) {
    for (j in 1:length(alpha_levels)) {
      chi_squared_table[i, j] <- qchisq(1 - alpha_levels[j], df = degrees_of_freedom[i])
    }
  }
  rownames(chi_squared_table) <- degrees_of_freedom
  colnames(chi_squared_table) <- alpha_levels
  return(chi_squared_table)

}
findTheCriticalValueChiDeuxMatrix <- function(df, alpha) {
  chi_matrix <- chi_deux_critical_values()
  df_index <- match(df, rownames(chi_matrix))
  alpha_index <- match(alpha, colnames(chi_matrix))
  return(chi_matrix[df_index, alpha_index])

}