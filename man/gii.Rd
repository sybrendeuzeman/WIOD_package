% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gii.R
\name{gii}
\alias{gii}
\title{Calculate Global Import Intensity}
\usage{
gii(iot, regions = "None", industries = "None")
}
\arguments{
\item{iot:}{List with elements in a Input-Output Table (load via [load_iot()])}

\item{regions:}{Vector with categorisation of countries.}

\item{industries:}{Vector with categorisation of industries.}
}
\value{
The input-output table list with the GII measure (gii) 
and a description of the countries and industries (gii_descr) 
for use in [export_dataframe()].
}
\description{
Calculates the global import intensity measure as used by 
Marcel Timmer, Bart Los, Robert Stehrer and Gaaitzen de Vries; 
An Anatomy of the Global Trade Slowdown based on the WIOD 2016 Release.
}
\examples{
iot <- load_iot("WIOD2013", 2000)
iot <- gii(iot)

iots <- load_iots("WIOD2013", 2000:2001)
NAFTA <- c("USA", "MEX", "CAN")
BENELUX <- c("BEL", "NLD", "LUX") 
regions <- countrycat(list(NAFTA, BENELUX), iots)
primary <- c("AtB", "C") 
transport <- c("60", "61", "62", "63")
industries <- industrycat(list(primary, transport), iots)

iots <- on_iots(gii, iots, regions = regions, industries = industries)
df_gii <- export_dataframe("gii", iots)

}
