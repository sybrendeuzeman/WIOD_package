#' @importFrom curl curl_download
#' 
#' @title Download Supplemental Data
#' @description Downloads supplemental data to the local system for a time series of IOTs. 
#' 
#' @param extra: The supplemental data to be downloaded
#' @param version: The international input-output database to be used
#' @param dir_data: The directory where to store the data. Using change_dir_data seperately is most often preferred.
#' 
#' @examples 
#' \dontrun{
#' Using change_dir_data
#' change_dir_data("D:/Data")
#' download_extra_iots("SEA", "WIOD2013")
#' 
#' Using dir_data parameter
#' download_extra_iots("SEA", "WIOD2013", dir_data = "D:/Data")
#' }
#' 
#' @export
download_extra_iots <- function(extra, version, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Make sure directory for data exists
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE, recursive = TRUE)
  
  # Find and load the years for which data is available
  years_url <- paste(dir_data_online, "/", version, "/", version, "years", ".rds", sep = "")
  years <- readRDS(gzcon(url(years_url)))
  
  # Download extra data for all the years using download_extra_iot
  for (year in years){
    download_extra_iot(extra, version, year, dir_data, dir_data_online)
  }
}