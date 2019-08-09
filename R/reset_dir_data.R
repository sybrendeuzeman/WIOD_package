#' @title
#' Reset data directory to online
#' 
#' @description 
#' The function changes the directory from where the data is loaded back to the online data repository
#'
#' @export
reset_dir_data <- function(){
  assign('dir_data', paramEnv$dir_data_online, envir = paramEnv)
}