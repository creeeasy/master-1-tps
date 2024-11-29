source("./Matrix/loi-normale-table.R")
source("./Matrix/ks-matrix.R")

testUniformityWithKolmogorov <- function(random_numbers, alpha) {
  
  n <- length(random_numbers)
  differences <- numeric(n)
  differences_2 <- numeric(n)
  
  sorted_numbers <- sort(random_numbers)
  
  for (i in 1:n) {
    r_i <- i / n
    r_prev <- (i - 1) / n
    difference_1 <- r_i - r_prev
    difference_2 <- abs(i / n - r_i)
    
    differences[i] <- difference_1
    differences_2[i] <- difference_2
  }
  
  max_D1 <- max(differences)
  max_D2 <- max(differences_2)
  max_diff <- max(max_D1, max_D2)
  
  critical_value <- findTheCriticalValueKsMatrix(n, alpha)
  
  if (max_diff > critical_value) {
    cat("La distribution n'est pas uniforme (rejeter H0) - Kolmogorov-Smirnov.\n")
  } else {
    cat("La distribution est uniforme (ne pas rejeter H0) - Kolmogorov-Smirnov.\n")
  }
  
}
