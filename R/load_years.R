# Function to load years used to load multiple International Input Output Tables,
# Internal function

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 17-1-2020
# Current Version: 17-1-2020

load_years <- function(version_database, directory = get("dir_data", envir = paramEnv)){
  # Function to load multiple International Input Output Tables within the same database into a list of input-output tables.
  # version: version of IOT
  # directory: Directory to the data. Version and year are managed. Default is loading via the internet.
  
  # In case of the default option for years (i.e. all years)
  dir_years = paste(directory, "/", version_database, "/" , version_database, "years.rds", sep = "")
    
  # Only difference here is for loading years
  # load_iot() will manage loading from the internet 
  if ( is_dir_http(dir_years) ){
    years <- load_Rd_internet(dir_years, message_failure = "File for years not found")
    return(years)
  }
    
  if ( !is_dir_http(dir_years) ){
    # Check whether years file already exists
    if (file.exists(dir_years)){
      years <- readRDS(dir_years)
      return(years)
    }
    if (!file.exists(dir_years)){
      dir.create(paste(directory, "/" , version_database, sep = ""), showWarnings = FALSE, recursive = TRUE)
      dir_data_online =  get("dir_data_online", envir = paramEnv)
      url_years <- paste(dir_data_online, "/", version_database, "/", version_database, "years", ".rds", sep = "")
      download_Rd(url_years, dir_years)
      years <- load_Rd_internet(years_url)
      return(years)
    }
  }
}
