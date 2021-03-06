% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_extra_iot.R
\name{load_extra_iot}
\alias{load_extra_iot}
\title{Load extra data.}
\usage{
load_extra_iot(iot, extra, directory = get("dir_data", envir = paramEnv))
}
\arguments{
\item{iot:}{List with elements in a Input-Output Table (load via [load_iot()])}

\item{extra:}{Name of the extra data that is required.}

\item{directory:}{directory to where the input-output tables are stored.}
}
\description{
Function to load extra data to a single internation Input-Output Table (IOT).
}
\details{
Directory only needs to direct to the main storage directory, right version and year will be taken care of. 
Default is loading via the internet. Users who use IOTs more often are advised to make a local copy.
Local copy of online data can be made via download_iots()
}
\examples{
\dontrun{Using online data:}
iot <- load_iot("WIOD2013", 2000)
iot <- load_extra_iot(iot, "SEA")

\dontrun{Using local data:
iot <- load_iot("WIOD2013", 2000, directory = "D:/Data")
iot <- load_extra_iot(iot, "SEA", directory = "D:/Data")
}

 
}
