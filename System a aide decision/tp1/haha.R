Ordre <- function ( matrice ) {
ref = 0
anti = 0
trans = 0
ordre = FALSE
2
equiv = FALSE
for ( i in 1:4) {
for ( j in 1:4) {
if ( i == j ) {
if ( M [i , j ] == 1) ref = 1
if ( M [i , j ] == 1 && M [j , i ] == 1) ref =
1
}
for ( k in 1:4) {
if ( M [i , j ] == 1 && M [j , k ] == 1 &&
M [k , j ] == 1 && M [j , i ] == 1) ref
= 1
}
for ( k in 1:4) {
if ( M [i , j ] == 1 && M [j , k ] == 1) trans = 1
}
if ( M [i , j ] == 1 && M [j , i ] == 1 &&
j == i ) anti = 1
}
}
if ( ref == 1 && trans == 1 && anti == 1) {
ordre = TRUE
return ( ordre )
} else if ( ref != 1) {
print (" pas reflexive ")
ordre = FALSE
return ( ordre )
} else if ( trans != 1) {
print (" pas transitive ")
ordre = FALSE
return ( ordre )
} else if ( anti != 1) {
print (" pas antisymetrique ")
ordre = FALSE
return ( ordre )
}
}
3
equiv <- function ( matrice ) {
ref = 0
sym = 0
trans = 0
equiv = FALSE
for ( i in 1:4) {
for ( j in 1:4) {
if ( i == j ) {
if ( M [i , j ] == 1) ref = 1
if ( M [i , j ] == 1 && M [j , i ] == 1)
ref = 1
}
for ( k in 1:4) {
if ( M [i , j ] == 1 && M [j , k ] == 1 &&
M [k , j ] == 1 && M [j , i ] == 1) ref
= 1
}
for ( k in 1:4) {
if ( M [i , j ] == 1 && M [j , k ] == 1)
trans = 1
}
if ( M [i , j ] == 1 && M [j , i ] == 1)
sym = 1
}
}
if ( ref == 1 && trans == 1 && sym == 1) {
ordre = TRUE
return ( ordre )
} else if ( ref != 1) {
print (" pas reflexive ")
ordre = FALSE
return ( ordre )
} else if ( trans != 1) {
print (" pas transitive ")
ordre = FALSE
return ( ordre )
} else if ( sym != 1) {
4
print (" pas symetrique ")
ordre = FALSE
return ( ordre )
}
}
M <- matrix (c(0 , 1 , 0 , 0 ,
1 , 0 , 1 , 0 ,
0 , 1 , 0 , 1 ,
1 , 0 , 0 , 0) , nrow = 4 , ncol = 4)
resultat <- Ordre ( M )
cat (" ordre :", resultat , "\n")
resultat2 <- equiv ( M )
cat (" equiv :", resultat2 , "\n")