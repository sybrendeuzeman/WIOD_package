#' @title Integer classification of Industries
#' @description Function generates a vector with a classification 
#' of industries in integers
#' 
#' @param industry_lists: List of vectors with industries that belong to a certain category.
#' @param iots: Timeseries list of lists with elements of input-output table.
#' @return vector with a classification of countries in integers.
#'  
#' @examples
#' iots <- load_iots("WIOD2013", 2000:2001)
#' NAFTA <- c("USA", "MEX", "CAN")
#' BENELUX <- c("BEL", "NLD", "LUX") 
#' regions <- countrycat(list(NAFTA, BENELUX), iots)
#' @export
industrycat <- function(industry_lists, iots){
  groups <- length(industry_lists)
  categories <- rep(groups+1, iots[[1]]$n)
  for (i in 1:groups){
    for (j in 1:length(industry_lists[[i]])){
      categories[which(iots[[1]]$industries[,1] == industry_lists[[i]][[j]])] = i
    } 
  }
  return(categories)
}