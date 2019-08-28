#' @importFrom curl curl_download
#' @export
download_extra_iots <- function(extra, version, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Make sure directory for data exists
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE)
  
  # Find and load the years for which data is available
  years_url <- paste(dir_data_online, "/", version, "/", version, "years", ".rds", sep = "")
  years <- readRDS(gzcon(url(years_url)))
  
  # Download extra data for all the years using download_extra_iot
  for (year in years){
    download_extra_iot(extra, version, year, dir_data, dir_data_online)
  }
}