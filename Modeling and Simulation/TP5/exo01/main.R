lln_uniforme <- function(n) {
  borne_gauche_intervalle <- 0
  borne_droite_intervalle <- 1
  moyennes <- numeric(n)
  for(i in 1:n) {
    echantillon <- runif(i, borne_gauche_intervalle, borne_droite_intervalle)
    moyennes[i] <- mean(echantillon)
  }
  plot(1:n, moyennes, type = "l", col = "blue", lwd = 2, 
       xlab = "Nombre d'échantillons", ylab = "Moyenne des échantillons",
       main = "Convergence de la moyenne des échantillons vers la moyenne théorique")
  abline(h = (borne_gauche_intervalle + borne_droite_intervalle) / 2, col = "red", lty = 2)
}

lln_uniforme(10000)
