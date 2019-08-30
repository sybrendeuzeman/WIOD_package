# Function to load multiple International Input Output Tables,
# within the same database into a list of input-output tables.

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 3 May 2019
# Current Version: 11 June 2019

#' @title
#' Load a time-series of International Input-Output Table.
#' 
#' @description 
#' Function loads a time-series of internation Input-Output Tables (IOTs).
#'
#' @param version: version of IOTs
#' @param year: years for which you want the IOT. Default is all years.
#' @param directory: directory to where the input-output tables are stored. 
#' 
#' @details 
#' Versions currently supported are WIOD2013 (World Input Output Database, version 2013), 
#' WIOD2016 (World Input Output Database, version 2013) 
#' and ICIOT2018 (Inter-Country Input Output Tables, version 2018).
#' 
#' Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
#' Default is loading via the internet. Users who use IOTs more often are advised to make a local copy.
#' Local copy of online data can be made via download_iots()
#'  
#' @examples
#' \dontrun{Using online data:}
#' iots <- load_iots("WIOD2013")
#' 
#' \dontrun{Using online data, only some years:}
#' iots <- load_iots("WIOD2013", 2000:2002)
#' 
#' @examples
#' \dontrun{Using local data:
#' iots <- load_iots("WIOD2013", directory = "D:/Data")}
#' 
#' @export
load_iots <- function(version_database, years = NULL, directory = get("dir_data", envir = paramEnv)){
  # Function to load multiple International Input Output Tables within the same database into a list of input-output tables.
  # version: version of IOT
  # year: list or array of years
  # directory: Directory to the data. Version and year are managed. Default is loading via the internet.

  # In case of the default option for years (i.e. all years)
  if (is.null(years)){
    dir_file = paste(directory, "/", version_database, "/" , version_database, "years.rds", sep = "")
    if (tolower(substr(dir_file, 1, 4)) == 'http' ){
      years <- readRDS(gzcon(url(dir_file)))
    }
    else{
      if (file.exists(dir_file)){
        years <- readRDS(dir_file)  
      }
      else{
        dir.create(paste(directory, "/" , version_database, sep = ""), showWarnings = FALSE, recursive = TRUE)
        dir_data_online =  get("dir_data_online", envir = paramEnv)
        years_url <- paste(dir_data_online, "/", version_database, "/", version_database, "years", ".rds", sep = "")
        if (tolower(substr(years_url, 1, 4)) == 'http' ){
          if (url.exists(years_url)){
            if (is.na(curl_fetch_memory(years_url)$type)){
              curl_download(years_url, dir_file)
              years <- readRDS(gzcon(url(years_url)))
            }
            else{
              print("Requested data could not be downloaded.")
            }
          }
        }
      }
    }
  }
  
  # Create actual list of international input output tables.
  iots <- list()
  for (year in years){
    name = paste("iot", toString(year), sep = "")
    iots[[name]] <- load_iot(version_database, year, directory)
  }
  return(iots)
}

