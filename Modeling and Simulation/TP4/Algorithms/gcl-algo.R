gclNormalized <- function() {
  period <- 1
  current <- 1;
  history <- c(current)
  normalized <- c(current / 2^12)
  
  repeat {
    next_val <- (125 * current + 1) %% 2^12
    if (next_val %in% history) {
      break
    }
    history <- c(history, next_val)
    normalized <- c(normalized, next_val / 2^12)
    current <- next_val
    period <- period + 1
  }
  return(normalized)
}
gclNormalized()