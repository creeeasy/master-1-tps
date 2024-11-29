

normal_distribution_table <- function() {
  col1 <- seq(0, 0.09, by = 0.01)
  col2 <- seq(0, 2.9, by = 0.1)
  table <- matrix(nrow = length(col2), ncol = length(col1))
  for (i in 1:length(col2)) {
    for (j in 1:length(col1)) {
      z <- col2[i] + col1[j]
      table[i, j] <- pnorm(z)
    }
  }
  rownames(table) <- col2
  colnames(table) <- col1
  return(table)
}


findTheCriticalValuNormalDistrubtionMatrix <- function(alpha) {
  value_crendetial <- 1 - alpha / 2;
  distribution_table <- normal_distribution_table();
  closest_value <- which.min(abs(distribution_table - value_crendetial))
  x_1_index <- (closest_value - 1) %% nrow(distribution_table) + 1
  x_2_index <- (closest_value - 1) %/% nrow(distribution_table) + 1
  row_name <- as.numeric(gsub("z=", "", rownames(distribution_table)[x_1_index]))
  col_name <- as.numeric(gsub("0\\.", "0.", colnames(distribution_table)[x_2_index]))
  z_score <- row_name + col_name
  return(z_score)
}
