#' @importFrom curl curl_download
#' @export
download_iots <- function(version, dir_data =  get("dir_data", envir = paramEnv), dir_data_online =  get("dir_data_online", envir = paramEnv)){
  # Make sure the directory to store the data exists
  dir.create(paste(dir_data, "/" , version, sep = ""), showWarnings = FALSE, recursive = TRUE)
  
  # Load years for which data exists
  years_url <- paste(dir_data_online, "/", version, "/", version, "years", ".rds", sep = "")
  years <- readRDS(gzcon(url(years_url)))
  # Store years for which data exists locally
  years_local <- paste(dir_data, "/", version, "/", version, "years", ".rds", sep = "")
  curl_download(years_url, years_local)
  
  # Download the iots for all years
  for (year in years){
    download_iot(version, year, dir_data, dir_data_online)
    print(paste("Year ", year, " downloaded.", sep = ""))
  }
}