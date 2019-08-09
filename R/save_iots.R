
#' @import tcltk
#' @export
save_iots <- function(iots, filename = "choose"){
  if (filename == "choose"){
    filename <- tclvalue(tkgetSaveFile(filetypes = "{ {Comma Seperated Values} {*.rds} }", defaultextension = ".rds", initialdir = getwd()))
  }
  saveRDS(iots, filename)
}