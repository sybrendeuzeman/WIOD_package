% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_extra_iot.R
\name{download_extra_iot}
\alias{download_extra_iot}
\title{Download Supplemental Data}
\usage{
download_extra_iot(
  extra,
  version,
  year,
  dir_data = get("dir_data", envir = paramEnv),
  dir_data_online = get("dir_data_online", envir = paramEnv)
)
}
\arguments{
\item{extra:}{The supplemental data to be downloaded}

\item{version:}{The international input-output database to be used}

\item{year:}{The year for which to add supplemental data}

\item{dir_data:}{The directory where to store the data. Using change_dir_data seperately is most often preferred.}
}
\description{
Downloads supplemental data to the local system for a single IOT. 
Use download_extra_iots to download supplemental data for a whole dataset.
}
\examples{
\dontrun{
Using change_dir_data
change_dir_data("D:/Data")
download_extra_iot("SEA", "WIOD2013", 2000)

Using dir_data parameter
download_extra_iot("SEA", "WIOD2013", 2000, dir_data = "D:/Data")
}

}
