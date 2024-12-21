illustrer_LLN_exponentielle <- function(n_max, lambda) {
  moyennes <- numeric(n_max)
  for (n in 1:n_max) {
    echantillon <- rexp(n, rate = lambda)
    moyennes[n] <- mean(echantillon)
  }
  moyenne_theorique <- 1 / lambda
  plot(1:n_max, moyennes, type = "l", col = "blue", lwd = 2,
       xlab = "Taille de l'échantillon", ylab = "Moyenne des échantillons",
       main = "Illustration de la Loi des Grands Nombres (Exponentielle)")
  abline(h = moyenne_theorique, col = "red", lty = 2, lwd = 2)
  legend("topright", legend = c("Moyennes", "Moyenne théorique"),
         col = c("blue", "red"), lty = c(1, 2), lwd = c(2, 2))
}

illustrer_LLN_exponentielle(10000, lambda = 2)
