# Load the International Input Output Data from CSV files.
# For use in library WIOD

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 3 May 2019
# Current Version: 11 june 2019

#' @title
#' Load a single International Input-Output Table.
#' 
#' @description 
#' Function loads a single internation Input-Output Table (IOT).
#'
#' @param version: version of IOT
#' @param year: year of IOT
#' @param directory: directory to where the input-output tables are stored. 
#' 
#' @details 
#' Versions currently supported are WIOD2013 (World Input Output Database, version 2013), 
#' WIOD2016 (World Input Output Database, version 2013) 
#' and ICIOT2018 (Inter-Country Input Output Tables, version 2018).
#' 
#' To load a time-series of international input-output tables use load_iots()
#' 
#' Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
#' Default is loading via the internet. Users who use IOTs more often are advised to make a local copy.
#' Local copy of online data can be made via download_iots()
#'  
#' @examples
#' \dontrun{Using online data:}
#' iot <- load_iot("WIOD2013", 2000)
#' 
#' @examples
#' \dontrun{Using local data:
#' iot <- load_iot("WIOD2013", 2000, directory = "D:/Data")}
#' 
#'  
#' @export
load_iot <- function(version, year, directory = get("dir_data", envir = paramEnv)){
  dir_file = paste(directory, "\\", version, "\\", version, toString(year), ".rds", sep = "")
  print(dir_file)
  iot <- readRDS(dir_file)
  return(iot)
}

