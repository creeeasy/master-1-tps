source("Algorithms/gcl-algo.R")
kolmogorov_critical_values <- function() {
  random_numbers <- length(gclNormalized())
  n_values <- 1:random_numbers
  alpha_values <- c(0.2, 0.15, 0.1, 0.05, 0.01)
  critical_matrix <- matrix(nrow = length(n_values), ncol = length(alpha_values))

  for (i in 1:length(n_values)) {
    for (j in 1:length(alpha_values)) {
      critical_matrix[i, j] <- sqrt(-0.5 * log(alpha_values[j] / 2)) / sqrt(n_values[i])
    }
  }

  rownames(critical_matrix) <- n_values
  colnames(critical_matrix) <- alpha_values

  return(critical_matrix)
}
kolmogorov_critical_values()
findTheCriticalValueKsMatrix <- function(n, alpha) {
  ks_matrix <- kolmogorov_critical_values()
  n_index <- match(n, rownames(ks_matrix))
  alpha_index <- match(alpha, colnames(ks_matrix))
  return(ks_matrix[n_index, alpha_index])
}

