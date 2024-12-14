X0 <- 7182
xi_arr <- c(X0)
ri_arr <- c(X0/10000)
xi_carry_arr <- c(X0^2)
XI_carry = -1
print(X0)
while (X0 != 0) {
  XI_carry <- X0^2
  string_xi_carry <- toString(XI_carry)
  if (nchar(string_xi_carry) == 8) {
    X0 <- as.integer(substring(string_xi_carry, 3, 6))
  } else {
    string_new_xi_carry <- toString(XI_carry)
    while (nchar(string_new_xi_carry) != 8) {
      string_new_xi_carry <- paste("0", string_new_xi_carry, sep = "")
    }
    
    X0 <- as.integer(substring(string_new_xi_carry, 3, 6))
  }
  xi_arr <- c(xi_arr, X0)
  ri_arr <- c(ri_arr, X0 / 10000)
  xi_carry_arr <- c(xi_carry_arr, XI_carry)
}

print(xi_arr)
print(ri_arr)
print(xi_carry_arr)
