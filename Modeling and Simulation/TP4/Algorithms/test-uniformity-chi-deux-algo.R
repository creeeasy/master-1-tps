  source("./Matrix/chi-deux-matrix.R")
testUniformityWithChiSquare <- function(random_numbers, alpha) {
  n <- length(random_numbers)
  k = as.integer(n / 5)
  pj = 1 / k
  
  df <- k - 1
  intervale <- seq(0, 1, length.out = k + 1)
  
  observed <- hist(random_numbers, breaks = intervale, plot = FALSE)$counts
  expected <- rep(n * pj, k)
  
  chi_squared <- sum((observed - expected)^2 / expected)
   la_valeur_critic <- findTheCriticalValueChiDeuxMatrix(df, alpha)
  
  if (chi_squared > la_valeur_critic) {
    cat("La distribution n'est pas uniforme (rejeter H0) - Chi-Square.\n")
  } else {
    cat("La distribution est uniforme (ne pas rejeter H0) - Chi-Square.\n")
  }
  
}
