#' @title Find the coefficient matrix of an International Input-Output Table
#' 
#' @description Function calculates the coefficient matrix for 
#' a given International Input-Output table. 
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @return The coefficient matrix of the Input-Output Table.
#' 
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' coef <- coefficient(iot)
#'    
#' @export 
coefficient <- function(iot){
    A = t(t(iot$I) / iot$S[,1])
    A[is.nan(A)] <- 0
    return(A)
}