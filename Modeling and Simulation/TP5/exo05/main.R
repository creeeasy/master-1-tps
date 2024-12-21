estimer_integrale <- function(n) {
  x <- runif(n, min = -1, max = 1)
  y <- runif(n, min = 0, max = 2)
  f <- x^2 + 2 * x * y
  mean(f) * (2 - (-1)) * (2 - 0)
}

n_points <- 1000000
integrale_estimation <- estimer_integrale(n_points)
valeur_theorique <- 8 / 3
cat("Valeur estimée de l'intégrale avec", n_points, "points :", integrale_estimation, "\n")
cat("Valeur théorique de l'intégrale :", valeur_theorique, "\n")
