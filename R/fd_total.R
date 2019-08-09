#' @title Total Final Demand
#' 
#' @description Function returns the aggregated total final demand at the country-industry level
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @return List with elements of Input-Output Table and added the total final demand (fd) 
#' and a country-industry categorization (fd_descr)
#' 
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- fd_total(iot)
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- on_iots(fd_total, iots)
#' iots <- on_iots(gii, iots)
#' df_fs <- export_dataframe(c("fd_total", "gii"), iots)
#'    
#' @export 
fd_total <- function(iot, regions = "None", industries = "None"){
  iot$fd_total = rowSums(iot$FD)
  iot$fd_total_descr <- countryindustry_descr(iot, countrycat = regions, industrycat = industries)
  return(iot)
}