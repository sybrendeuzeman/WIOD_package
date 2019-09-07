
# If the location of the online data changes, only one change is necessary
dir_data_online <- "http://www.wiod.org/Rdata"

# Start paramEnv
paramEnv <- new.env()

# Set both the "local" link and the online link the online data location
assign('dir_data', dir_data_online, envir = paramEnv)
assign('dir_data_online', dir_data_online, envir = paramEnv)
