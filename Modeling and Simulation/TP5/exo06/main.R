estimer_pi <- function(n) {
  x <- runif(n, 0, 1)
  y <- runif(n, 0, 1)
  dans_cercle <- (x^2 + y^2) <= 1
  4 * sum(dans_cercle) / n
}

n_points <- 1000000
pi_estimation <- estimer_pi(n_points)
cat("Valeur estimée de π avec", n_points, "points :", pi_estimation, "\n")
