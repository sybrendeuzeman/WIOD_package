#' @importFrom curl curl_download
#' 
#' @title Download Supplemental Data
#' @description Downloads supplemental data to the local system for a single IOT. 
#' Use download_extra_iots to download supplemental data for a whole dataset.
#' 
#' @param extra: The supplemental data to be downloaded
#' @param version: The international input-output database to be used
#' @param year: The year for which to add supplemental data
#' @param dir_data: The directory where to store the data. Using change_dir_data seperately is most often preferred.
#' 
#' @examples 
#' \dontrun{
#' Using change_dir_data
#' change_dir_data("D:/Data")
#' download_extra_iot("SEA", "WIOD2013", 2000)
#' 
#' Using dir_data parameter
#' download_extra_iot("SEA", "WIOD2013", 2000, dir_data = "D:/Data")
#' }
#' 
#' @export
download_extra_iot <- function(extra, version, year, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Create directory if not yet existent
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE, recursive = TRUE)
  
  # URL path to online data and local path where to store the data
  url <- paste(dir_data_online,"/", version, "/", version,"_", extra, year, ".rds", sep = "")
  local <-  paste(dir_data, "/", version, "/", version,"_", extra, year, ".rds", sep = "")
  
  # Some tests whether url points to actual data:
  if (tolower(substr(url, 1, 4)) == 'http' ){
    if (url.exists(url)){
      if (is.na(curl_fetch_memory(url)$type)){
        curl_download(url, local)
      }
      else{
        print(paste("Extra data ", extra,  " for year ", year, " not found online.", sep = ""))
      }
    }
  }
}