# Function to load years used to load multiple International Input Output Tables,
# Internal function

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 17-1-2020
# Current Version: 17-1-2020

load_years <- function(version_database, directory = get("dir_data", envir = paramEnv)){
  # Function to load multiple International Input Output Tables within the same database into a list of input-output tables.
  # version: version of IOT
  # year: list or array of years
  # directory: Directory to the data. Version and year are managed. Default is loading via the internet.
  
  # In case of the default option for years (i.e. all years)
  dir_years = paste(directory, "/", version_database, "/" , version_database, "years.rds", sep = "")
    
  # Check whether directory is an internet-address (HTTP-protocol) of local
  if (tolower(substr(dir_years, 1, 4)) == 'http' ){
    http_dir = TRUE
  }
  else {
    http_dir = FALSE
  }
    
  # Only difference here is for loading years
  # load_iot() will manage loading from the internet 
  if ( http_dir ){
    years <- readRDS(gzcon(url(dir_years)))
    return(years)
  }
    
  if ( !http_dir ){
    # Check whether years file already exists
    if (file.exists(dir_file)){
      years <- readRDS(dir_file)
      return(years)
    }
    if (!file.exists(dir_file)){
      dir.create(paste(directory, "/" , version_database, sep = ""), showWarnings = FALSE, recursive = TRUE)
      dir_data_online =  get("dir_data_online", envir = paramEnv)
      years_url <- paste(dir_data_online, "/", version_database, "/", version_database, "years", ".rds", sep = "")
        
      if ( (url.exists(years_url) ) && ( is.na(curl_fetch_memory(years_url)$type)) ){
        curl_download(years_url, dir_file)
        years <- readRDS(gzcon(url(years_url)))
        return(years)
      }
      else{
        print("Requested data could not be downloaded.")
        return(NULL)
      }
    }
  }
}
