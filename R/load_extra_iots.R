# Function to load supplemental data into a list of international input-output tables.

# Created by: Sybren Deuzeman
# Maintained by: GGDC

# First version: 1 June 2019
# Current version: 11 June 2019

#' @title
#' Load extra data to multiple IOTs.
#' 
#' @description 
#' Function to load extra data to a single internation Input-Output Table (IOT).
#'
#' @param iots: List of Input-Output Tables (load via [load_iots()])
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
#' iots <- load_iots("WIOD2013")
#' iots <- load_extra_iots(iots, "SEA")
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- load_extra_iots(iots, "SEA")
#' 
#' @examples
#' \dontrun{Using local data:
#' iots <- load_iots("WIOD2013", directory = "D:/Data")
#' iots <- load_extra_iots(iots, "SEA", directory = "D:/Data")
#' }
#' 
#'  
#' @export
load_extra_iots <- function(iots, extra, directory = get("dir_data", envir = paramEnv)){
  # Function to load supplemental data for list of International Input Output Tables
  
  # iots: The already loaded list of international input-output tables.
  # extra: Name of the supplemental data
  # directory: directory to where the input-output tables are stored. 
  #   Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
  #   Default is loading via the internet. 
  #   Users are advised to make a local copy via download_extra_iots(). 
  
  # Apply load_extra_iot on all international input output tables in the list.
  iots <- lapply(iots, load_extra_iot, extra, directory)
  return(iots)
}

