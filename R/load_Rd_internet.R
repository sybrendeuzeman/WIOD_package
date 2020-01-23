# Load the International Input Output Data from CSV files.
# For use in library WIOD

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 18-01-2020
# Current Version: 18-01-2020


load_Rd_internet <- function(dir_file, message_success = NULL, message_failure = "Data not found"){
  # Check whether file some file exist and whether of right type
  if (url.exists(dir_file) && is.na(curl_fetch_memory(dir_file)$type)){
    # Download and laod data
    file_rds <- readRDS(gzcon(url(dir_file)))
    if (!is.null(message_success)){
      print(message_success)
    }
    return(file_rds)
  }
  else{
    # If no file, inform user
    print(message_failure)
    return(NULL)
  }
}
