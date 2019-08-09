dir_data_online <- "X:/Projects/WIOD Stata Command/R program/Data"
paramEnv <- new.env()
assign('dir_data', dir_data_online, envir = paramEnv)
assign('dir_data_online', dir_data_online, envir = paramEnv)


#' @title
#' Change data directory
#' 
#' @description 
#' The function changes the directory from where the data is loaded
#'
#' @param newdirectory: the new directory from which to load the data
#' 
#' @details 
#' One can download the data using download_iots() and then use this function to change the directory with this function.
#' Manual change of the data directory is also possible when loading data.
#'  
#' @examples
#' \dontrun{change_dir_data("X://data")}
#'  
#' @export
change_dir_data <- function(newdirectory){
  assign('dir_data', newdirectory, envir = paramEnv)
}

