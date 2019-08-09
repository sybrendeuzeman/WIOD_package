# Function to run a function over a list of international input-output tables.

# Created by: Sybren Deuzeman
# Maintained by: GGDC

# First version: 10 May 2019
# Currect version: 11 June 2019


#' @title Run over a list of International Input-Output Tables (IOTs)
#' 
#' @description [oniots()] executes the same function 
#' on a list of international input-output tables (IOTs)
#' 
#' @param fun: The function to run over.
#' @param iots: the list of IOTs
#' @param ...: Any other arguments needed for function in fun,
#' @return List of international input-output tables with the output of the 
#' function call added to each IOT.
#'  
#' @details
#' fun should be a function that appends its output to the IOT.
#' 
#' @examples 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- on_iots(gii, iots)
#'  
#' \dontrun{Example with extra arguments}
#' NAFTA <- c("USA", "MEX", "CAN")
#' BENELUX <- c("BEL", "LUX", "NLD") 
#' regions <- countrycat(list(NAFTA, BENELUX), iots)
#' primary <- c("AtB", "C") 
#' transport <- c("60", "61", "62", "63")
#' industries <- industrycat(list(primary, transport), iots)
#' 
#' iots <- on_iots(gii, iots, regions = regions, industries = industries)
#' df_gii <- export_dataframe("gii", iots)
#' 
#' @export 
on_iots <- function(fun, iots, ...){
  # Run a function over a list of international input-output tables
  #
  # fun: function designed for international input-output table
  # iots: list of international input-output tables already loaded
  # ...: extra arguments needed to run fun in order of single iot function (all except iot)
  
  # Run function fun over all iots.
  iots <- lapply(iots, fun, ...)
  gc()
  return(iots)
}