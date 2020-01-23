download_Rd <- function(url, local, message_success = NULL, message_failure = "Data not found"){
  # Check whether file some file exist and whether of right type
  if (url.exists(url) && is.na(curl_fetch_memory(url)$type)){
    # Download and laod data
    curl_download(url, local)
    if (!is.null(message_success)){
      print(message_success)
    }
  }
  else{
    # If no file, inform user
    print(message_failure)
    return(NULL)
  }
}