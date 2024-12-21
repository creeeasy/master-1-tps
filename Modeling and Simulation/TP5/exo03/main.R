illustrer_LLN <- function(n_max) {
  moyennes <- numeric(n_max)
  for (n in 1:n_max) {
    echantillon <- rnorm(n, mean = 0, sd = 1)
    moyennes[n] <- mean(echantillon)
  }
  plot(1:n_max, moyennes, type = "l", col = "black", lwd = 2, 
       xlab = "Taille de l'échantillon", ylab = "Moyenne des échantillons",
       main = "Illustration de la Loi des Grands Nombres")
  abline(h = 0, col = "red", lty = 2, lwd = 2) 
}

illustrer_LLN(10000)
