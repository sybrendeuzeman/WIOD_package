# Function to load multiple International Input Output Tables,
# within the same database into a list of input-output tables.

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 3 May 2019
# Current Version: 7 September 2019

#' @title
#' Load a time-series of International Input-Output Table.
#' 
#' @description 
#' Function loads a time-series of internation Input-Output Tables (IOTs).
#'
#' @param version: version of IOTs
#' @param year: years for which you want the IOT. Default is all years.
#' @param directory: directory to where the input-output tables are stored. Most often preferable to change using change_dir_data().
#' 
#' @details 
#' Versions currently supported are WIOD2013 (World Input Output Database, version 2013), 
#' WIOD2016 (World Input Output Database, version 2013) 
#' and ICIOT (Inter-Country Input Output Tables, version 2018).
#' 
#' If directory is changed using change_dir_data, the function will download the requested data prior to loading.
#' One can also download data using download_iots.
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
#' change_dir_data("D:/Data")
#' iots <- load_iots("WIOD2013")}
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

