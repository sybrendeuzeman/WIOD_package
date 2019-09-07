#' @importFrom curl curl_download
#' @importFrom curl curl_fetch_memory
#' @importFrom RCurl url.exists
#' 
#' @title Download Single IOT
#' 
#' @description Download a single IOT from the internet to your computer.
#' download_iots will download a full dataset of IOTs.
#' 
#' @param version: The international input-output database to be used
#' @param year: The year for which to add supplemental data
#' @param dir_data: The path towards the local directory in which to store the data. Most often using change_dir_data is preferred.
#' @param dir_data_online: the path towards the internet source with data. Normally no need to change this. 
#'
#' @examples 
#' \dontrun{
#' Using change_dir_data
#' change_dir_data("D:/Data")
#' download_iot("WIOD2013", 2000)
#' 
#' Using dir_data param
#' download_iot("WIOD2013", 2000, "D:/Data")
#' }
#'   
#' @export
download_iot <- function(version, year, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Create directory if not yet existent
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE, recursive = TRUE)
  
  # URL path to online data and local path where to store the data
  url <- paste(dir_data_online, "/", version, "/", version, toString(year), ".rds", sep = "")
  local <-  paste(dir_data, "/", version, "/", version, toString(year), ".rds", sep = "")
  
  # Some tests whether url points to actual data:
  #Website redirect wrong URLs without proper code. Ugly, so sorry if you have to debug because of this.
  if (tolower(substr(url, 1, 4)) == 'http' ){
    if (url.exists(url)){
      if (is.na(curl_fetch_memory(url)$type)){
        curl_download(url, local)
      }
      else{
        print("Requested data could not be downloaded.")
      }
    }
  }
}