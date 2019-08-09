# Function to extract measures from iots into a .csv file

# Created by: Sybren Deuzeman
# Maintained by: GGDC

# First version May 2019
# Current version: 11 June 2019

#' @import tcltk
#' @title Make a CSV file from measures in IOTs 
#' @description Function to extract measures from IOTs into a CSV file
#' @param measures: vector with the names of the measures
#' @param iots: list of input-output tables for which measures are already calculated
#' @param long: Whether data is in long or wide format.
#' @param filename: Where to store the data
#' 
#' @details
#' filename = "choose" is default and will prompt a file-choose dialog.
#' 
#' First element in vector will be used to find the description of the data
#' Make sure the output of the measures are of the same length. 
#' (i.e. all need to be on e.g. country-industry, country or industry level)
#' 
#' @seealso 
#' export_dataframe(): [export_dataframe()]
#' 
#' @examples 
#' \dontrun{
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- oniots(wiod_gii, iots)
#' 
#' Not specifying directory prompts a file-choose dialog
#' export_csv("gii", iots)
#' export_csv("gii", iots, long = TRUE)
#' 
#' Save table in working directory
#' export_csv("gii", iots, filename = "myresults.csv")
#'
#' Or specify a directory:
#' export_csv("gii", iots, filename = "D:/Research/myresults.csv")
#' }
#' 
#' @export
export_csv <- function(measures, iots, long = FALSE, filename = "choose"){
  # Create the dataframe
  df <- export_dataframe(measures, iots, long)
  
  # Either choose directory and filename via dialog box or use existing filename: 
  if (filename == "choose"){
    filename <- tclvalue(tkgetSaveFile(filetypes = "{ {Comma Seperated Values} {*.csv} }", defaultextension = ".csv", initialdir = getwd()))
  }
  # Save data:
  if (filename != ""){
  write.table(df, file = filename, row.names = FALSE, sep=';', dec = ".")    
  # Print filename such that it can be copied and checked
  print("Table saved to")
  print(filename)
  }
  else warning("No file selected. Data not saved")
}