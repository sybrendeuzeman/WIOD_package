#' @title Integer classification of countries
#' @description Function generates a vector with a classification 
#' of countries in integers
#' 
#' @param country_lists: List of vectors with countries that belong to a certain category.
#' @param iots: Timeseries list of lists with elements of input-output table.
#' @return vector with a classification of countries in integers.
#'  
#' @examples
#' iots <- load_iots("WIOD2013", 2000:2001)
#' primary <- c("AtB", "C") 
#' transport <- c("60", "61", "62", "63")
#' industries <- industrycat(list(primary, transport), iots)
#' @export
countrycat <- function(country_lists, iots){
  groups <- length(country_lists)
  categories <- rep(groups+1, iots[[1]]$c)
  for (i in 1:groups){
    for (j in 1:length(country_lists[[i]])){
      categories[which(iots[[1]]$countries[,1] == country_lists[[i]][[j]])] = i
    } 
  }
  return(categories)
}