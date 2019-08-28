#' @importFrom curl curl_download
#'
#' @export
download_extra_iot <- function(extra, version, year, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Create directory if not yet existent
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE)
  
  # URL path to online data and local path where to store the data
  url <- paste(dir_data_online,"/", version, "/", version,"_", extra, year, ".rds", sep = "")
  local <-  paste(dir_data, "/", version, "/", version,"_", extra, year, ".rds", sep = "")
  
  # Some tests whether url points to actual data:
  if (tolower(substr(url, 1, 4)) == 'http' ){
    if (url.exists(url)){
      if (is.na(curl_fetch_memory(url)$type)){
        curl_download(url, local)
        return(iot)
      }
      else{
        print(paste("Extra data ", extra,  " for year ", iot$year, " not found online.", sep = ""))
      }
    }
  }
}