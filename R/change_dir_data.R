#' @title
#' Change data directory
#' 
#' @description 
#' The function changes the directory from where the data is loaded
#'
#' @param newdirectory: the new directory from which to load the data and where to store data
#' 
#' @details 
#' Use this function to change the directory from where to load downloaded IOTs with load_iot or load_iots. 
#' If a requested IOT is not yet downloaded, load_iot or load_iots will store the data first in this directory
#' and load the newly downloaded local file.
#'  
#' @examples
#' \dontrun{change_dir_data("X://data")}
#'  
#' @export
change_dir_data <- function(newdirectory){
  # paramEnv defined in paramEnv.R
  assign('dir_data', newdirectory, envir = paramEnv)
}

