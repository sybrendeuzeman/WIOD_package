dirdata <- "C:/Documents/Werk/RUG/Data"
change_dir_data(dirdata)

## Installing the WIOD-package
# Install package
# Remove # and run code if necessary
# Some code goes here

# Use the WIOD library
library(WIOD)


## Load International Input Output Tables
# Load single iot for WIOD2016, year 2000
iot <- load_iot("WIOD2016", 2000)

# View content of iot
View(iot)

# Load list of International Input Output Tables (complete)
WIOD2016 <- load-iots("WIOD2016")
WIOD2016_0510 <- load_iots("WIOD2016", 2005:2010)

# Load Extra Data
iot <- load_extra_iot(iot, "SEA")
WIOD2016 <- load_extra_iots(WIOD2016, "SEA")