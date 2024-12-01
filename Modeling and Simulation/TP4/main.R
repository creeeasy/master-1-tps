source("Algorithms/gcl-algo.R")
source("Algorithms/test-uniformity-chi-deux-algo.R")
source("Algorithms/test-uniformity-kolmogorov-algo.R")
source("Algorithms/test-independence-runs-up-and-runs-test-algo.R")
random_numbers <- gclNormalized()
# il est pre-defini dans le fichier consts.R

# commencant par l'uniformite

# En utilisant la methode du chi-deux

testUniformityWithChiSquare(random_numbers,alpha)

# En utilisant la méthode de Kolmogorov
testUniformityWithKolmogorov(random_numbers,alpha)

# commencant par l'independence
testRunAndTestUp(random_numbers,alpha)