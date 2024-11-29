source("./Matrix/loi-normale-table.R")
testRunAndTestUp <- function(random_numbers, alpha) {
  n <- length(random_numbers)
  R <- 1;
  for (i in 2:n) {
    if (random_numbers[i] > random_numbers[i - 1]) {
      R <- R + 1
    }
  }
  V <- (16 * n - 29) / 90;
  E <- (2 * n - 1) / 3;
  Z <- (R - E) / sqrt(V);
   critical_value <- findTheCriticalValuNormalDistrubtionMatrix(alpha);

  if (abs(Z) > critical_value) {
    cat("Les valeurs sont indépendantes (rejeter H0) - Test des runs.\n")
  } else {
    cat("Les valeurs ne sont pas indépendantes (ne pas rejeter H0) - Test des runs.\n")
  }
}