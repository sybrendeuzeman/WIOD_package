#' @importFrom curl curl_download
#' @importFrom curl curl_fetch_memory
#' @importFrom RCurl url.exists
#' 
#' @title Download Timeseries of IOTs
#' 
#' @description Download a timeseries IOT from the internet to your computer.
#' 
#' @param version: The international input-output database to be used
#' @param dir_data: The path towards the local directory in which to store the data. Most often using change_dir_data is preferred.
#' @param dir_data_online: the path towards the internet source with data. Normally no need to change this. 
#'
#' @examples 
#' \dontrun{
#' Using change_dir_data
#' change_dir_data("D:/Data")
#' download_iots("WIOD2013")
#' 
#' Using dir_data param
#' download_iots("WIOD2013", "D:/Data")
#' }
#'   
#' @export
download_iots <- function(version, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Make sure the directory to store the data exists
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE, recursive = TRUE)
  
  # Load years for which data exists
  years_url <- paste(dir_data_online, "/", version, "/", version, "years", ".rds", sep = "")

  # Store years for which data exists locally
  years_local <- paste(dir_data, "/", version, "/", version, "years", ".rds", sep = "")
  download_Rd(years_url, years_local)
  years <- load_Rd_internet(years_url)
  
  # Download the iots for all years
  for (year in years){
    download_iot(version, year, dir_data, dir_data_online)
    print(paste("Year ", year, " downloaded.", sep = ""))
  }
}