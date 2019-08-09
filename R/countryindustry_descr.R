#' @title Country - Industry description
#' @description Function gives the common country-industry description to the data
#' 
#' @param iot: List with elements of input-output table.
#' @param countrycat: Vector with categorisation of countries (in integers).
#' @param industrycat: vector with categorisation of industries (in integers).
#' @return Array with the country-industry description of the data.
#' 
#' @details
#' Mostly for use within functions to provide the country-industry description 
#' with its output.
#' 
#' @examples
#' iot <- load_iot("WIOD2013", 2000)
#' descr <- countryindustry_descr(iot)
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' NAFTA <- c("USA", "MEX", "CAN")
#' BENELUX <- c("BEL", "NLD", "LUX") 
#' regions <- countrycat(list(NAFTA, BENELUX), iots)
#' primary <- c("AtB", "C") 
#' transport <- c("60", "61", "62", "63")
#' industries <- industrycat(list(primary, transport), iots)
#' descr_cat <- countryindustry_descr(iot, countrycat = regions, industrycat = industries) 
#' 
#' @export
countryindustry_descr <- function(iot, countrycat = "None", industrycat = "None"){
  countries_descr <- c()
  countries <- c()
  countries_cat <- c()
  
  for (i in 1:nrow(iot$countries)){
    countries <- c(countries, rep(iot$countries[i, 1],iot$n))
    try(countries_descr <- c(countries_descr, rep(iot$countries[i, 2],iot$n)), silent = TRUE)
    if (length(countrycat) != 1){
      countries_cat <- c(countries_cat, rep(countrycat[i],iot$n))
    }
  }

  industries <- rep(iot$industries[1:nrow(iot$industries), 1],iot$c)
  industries_descr <- rep(iot$industries[1:nrow(iot$industries), 2],iot$c)
  industries_cat <- c()
  if (length(industrycat) != 1){
    industries_cat <- rep(industrycat,iot$c)
  }
  return(cbind(countries, countries_descr, countries_cat, industries, industries_descr,industries_cat))
}