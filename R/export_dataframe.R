# Function to extract measures from iots into a dataframe

# Created by: Sybren Deuzeman
# Maintained by: GGDC

# First version May 2019
# Current version: 11 June 2019

#' @importFrom tidyr gather spread
#' 
#' @title Make a dataframe from measures in IOTs 
#' @description Function to extract measures from IOTs into a dataframe.
#' @param measures: vector with the names of the measures.
#' @param iots: list of input-output tables for which measures are already calculated.
#' @param long: Whether data is in long or wide format.
#' 
#' @details
#' First element in vector will be used to find the description of the data
#' Make sure the output of the measures are of the same length. 
#' (i.e. all need to be on e.g. country-industry, country or industry level)
#' 
#' @examples 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- on_iots(gii, iots)
#' df_wide <- export_dataframe("gii", iots)
#' df_long <- export_dataframe("gii", iots, long = TRUE)
#' 
#' @export
export_dataframe <- function(measures, iots, years = NULL, long = FALSE){
  # Start empty list to make into dataframe in the end
  df_list = list()
  
  if (!is.null(years)){
    iots_new = list()
    for (year in years){
      iots_new[[paste("iot", toString(year), sep = "")]] <- iots[[paste("iot", toString(year), sep = "")]]
    }
    iots <- iots_new
  }
  
  # Find the description of the data
  # Use first element of measures for this.
  # Get the description from the first IOT in list that contains it.
  name_descr = paste(measures[1], "_descr", sep = "")
  notfound = T
  i = 1
  while (notfound){
    if (!is.null(iots[[i]][[name_descr]])){
      # if description found, add description to the list
      descr <- iots[[i]][[name_descr]]
      notfound = F
    }
    else {
      # if description not in list, add one to counter 
      i = i + 1
    }
    if (i >= length(iots)){
      # Ends loop if all IOTs in list are checked.
      notfound = F
    }
    if (i >= 1000){
      # Ends loop after 1000 iterations. In that case something went wrong.
      print("Something went wrong. More than 1000 iterations have occured to find description.")
      print("Check whether function is correctly specified")
      notfound = F
    }
  }

  # Go through all measures and years to add the data to the list
  if (!is.null(descr)){
    df_list <- list(descr)  
  }
  
  for (measure in measures){
  for (i in 1:length(iots)){
    # If a measure has only one column, the naming of that column is included.
    # Otherwise, the naming of the original columns is incorporated
    # into the new column names
    if (!is.null(iots[[i]][[measure]])){
    if (ncol(iots[[i]][[measure]]) == 1){
      # Find year of data and make column name
      year = iots[[i]]$year 
      name_col <- paste(measure, toString(year), sep = "")
      # Add data to list
      df_list[[name_col]] = iots[[i]][[measure]]  
    }
    
    if (ncol(iots[[i]][[measure]]) > 1){
      # Check whether column names are given to data.
      # If not, create names with column position
      year = iots[[i]]$year
      if (is.null(colnames(iots[[i]][[measure]]))){
        for (j in 1:ncol(iots[[i]][[measure]])){
          name_col <- paste(measure,"_", toString(j) , toString(year), sep = "")
          df_list[[name_col]] = iots[[i]][[measure]][,j]
        }
      }
      # Otherwise, create names using the given column names
      else{
        colname_vec = colnames(iots[[i]][[measure]]) # Find column names
        colname_vec[is.na(colname_vec)] = which(is.na(colname_vec)) # Replace NA values
        colname_vec[is.nan(colname_vec)] = which(is.nan(colname_vec)) # Replace NaN
        colname_vec <- make.names(colnames(iots[[i]][[measure]]), unique = TRUE) # Make sure names are unique
      
        for (j in 1:ncol(iots[[i]][[measure]])){
          name_col <- paste(measure,"_", colname_vec[j] , toString(year), sep = "")  
          df_list[[name_col]] = iots[[i]][[measure]][,j]
        }
      }
    }
  }
  }
  
  # Combine list into a dataframe
  df <- do.call(cbind.data.frame, df_list)
  
  if (long == TRUE){
    extra = list()
    df_long <- gather(df, key = "variable", value = "value", -c(colnames(descr)[]))
    extra$year <- substr(df_long$variable, start = (nchar(df_long$variable) - 3), stop = nchar(df_long$variable))
    extra$var <- substr(df_long$variable, start = 1, stop = nchar(df_long$variable) - 4)
    extra_df <-   do.call(cbind.data.frame, extra)
    df_long$variable <- NULL
    df_long <- cbind(df_long, extra_df)
    df <- spread(df_long, "var", "value")
    df$year <- as.numeric(levels(df$year))
    }
  return(df)
}
}