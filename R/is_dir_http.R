# Function to load years used to load multiple International Input Output Tables,
# Internal function

# Created by Sybren Deuzeman
# Maintained by GGDC

# First version: 17-1-2020
# Current Version: 17-1-2020

is_dir_http <- function(directory){
  if (tolower(substr(directory, 1, 4)) == 'http' ){
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}
