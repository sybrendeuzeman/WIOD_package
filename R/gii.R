#' @title Calculate Global Import Intensity
#' @description Calculates the global import intensity measure as used by 
#' Marcel Timmer, Bart Los, Robert Stehrer and Gaaitzen de Vries; 
#' An Anatomy of the Global Trade Slowdown based on the WIOD 2016 Release.
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @param regions: Vector with categorisation of countries.
#' @param industries: Vector with categorisation of industries.
#' @return The input-output table list with the GII measure (gii) 
#' and a description of the countries and industries (gii_descr) 
#' for use in [export_dataframe()].
#' 
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- gii(iot)
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' NAFTA <- c("USA", "MEX", "CAN")
#' BENELUX <- c("BEL", "NLD", "LUX") 
#' regions <- countrycat(list(NAFTA, BENELUX), iots)
#' primary <- c("AtB", "C") 
#' transport <- c("60", "61", "62", "63")
#' industries <- industrycat(list(primary, transport), iots)
#' 
#' iots <- on_iots(gii, iots, regions = regions, industries = industries)
#' df_gii <- export_dataframe("gii", iots)
#' 
#' @export
gii <- function(iot, regions = "None", industries = "None"){
  A <- coefficient(iot)
  iot <- leontief(iot)
  
  temp = matrix(1, iot$c, iot$c)
  for (i in 1:iot$c){
    temp[i,i]=0
  }
  
  S = kronecker(temp, matrix(1, iot$n, iot$n))
  iot$gii <- t(colSums(S * A) %*% iot$L)
  
  iot$gii_descr <- countryindustry_descr(iot, regions, industries)
  return(iot)
}