#' @import Matrix
#' @title Leontief Inverse of an International Input-Output Table
#' 
#' @description Function calculates the Leontief inverse for 
#' a given International Input-Output table. 
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @return List with elements of Input-Output Table and the Leontief inverse.
#' 
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- leontief(iot)
#'    
#' @export 
leontief <- function(iot){
  A <- coefficient(iot)
  
  # Only calculate the Leontief inverse if necessary
  if (!is.null(iot$L)){
    return(iot)
  }
  else {
    intermediate <- Matrix(diag((iot$c * iot$n)) - A)
    L = solve(intermediate)
    iot$L <- as.matrix(L)
    return(iot)
  }
}