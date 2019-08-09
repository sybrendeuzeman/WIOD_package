# Function to load supplemental data into international input-output tables.

# Created by: Sybren Deuzeman
# Maintained by: GGDC

# First version: 1 June 2019
# Current version: 11 June 2019

#' @title
#' Load extra data.
#' 
#' @description 
#' Function to load extra data to a single internation Input-Output Table (IOT).
#'
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @param extra: Name of the extra data that is required.
#' @param directory: directory to where the input-output tables are stored. 
#' 
#' @details 
#' Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
#' Default is loading via the internet. Users who use IOTs more often are advised to make a local copy.
#' Local copy of online data can be made via download_iots()
#'  
#' @examples
#' \dontrun{Using online data:}
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- load_extra_iot(iot, "SEA")
#' 
#' @examples
#' \dontrun{Using local data:
#' iot <- load_iot("WIOD2013", 2000, directory = "D:/Data")
#' iot <- load_extra_iot(iot, "SEA", directory = "D:/Data")
#' }
#' 
#'  
#' @export
load_extra_iot <- function(iot, extra, directory = get("dir_data", envir = paramEnv)){
  # Function to load extras for the International Input Output Table
  
  # iot: The already loaded international input-output table.
  # extra: Name of the extra data
  # directory: directory to where the input-output tables are stored. 
  # Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
  # Default is loading via the internet. 
  # Users are advised to make a local copy via download_extra_iot(). 
  
  # Version and Year data are collected from the International Input Output table.
  
  dir_file = paste(directory, "\\", iot$version, "\\", iot$version,"_", extra, iot$year, ".rds", sep = "")
  
  # Check for existence of file.
  # A message will be given in both cases.
  if (!(file.exists(dir_file))){
    print(paste("Extra data ", extra,  " for year ", iot$year, " not found.", sep = ""))
    return(iot)
  }
  # If file exists, the extra data is added to the international input-output data.
  if (file.exists(dir_file)){
    iot[[extra]] <- readRDS(dir_file)
    print(paste("Extra data ", extra,  " for year ", iot$year, " was found and added.", sep = ""))
    return(iot)
  }
  else return(iot)
}