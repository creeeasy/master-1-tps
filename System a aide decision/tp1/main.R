omega <- c(1,2,3,4)
compl <- list(c(1), c(2,3))
tribu <- list()

tribu <- append(tribu, list(omega))
tribu <- append(tribu, list(numeric(0)))

for (compl_sequence in compl) {
  exists <- FALSE
  
  for (item in tribu) {
    if (length(item) == length(compl_sequence) && all(item == compl_sequence)) {
      exists <- TRUE
      break
    }
  }
  
  if (!exists) {
    tribu <- append(tribu, list(compl_sequence))
  }
}

for (compl_sequence in compl) {
  compl_element <- setdiff(omega, compl_sequence)
  exists <- FALSE
  
  for (item in tribu) {
    if (length(item) == length(compl_element) && all(item == compl_element)) {
      exists <- TRUE
      break
    }
  }
  
  if (!exists) {
    tribu <- append(tribu, list(compl_element))
  }
}


print(tribu)
