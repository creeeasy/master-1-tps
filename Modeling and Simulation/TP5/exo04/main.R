f <- function(x) {
  x * sin(x)
}

b <- pi / 2
a <- 0
integral_sum <- 0 ;
n <- 1000 ;
interval <- (b - a) / n;

for(i in 0:999){
  x_mid <- a+ ( i+0.5)*interval 
  integral_sum <- integral_sum + f(x_mid)*interval
}
cat("The estimated value of the integral is:", integral_sum, "\n")