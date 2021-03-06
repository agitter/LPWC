% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bestlag.R
\name{best.lag}
\alias{best.lag}
\title{Best Lag}
\usage{
best.lag(data, timepoints, max.lag = NULL, C)
}
\arguments{
\item{data}{a matrix with columns representing different timepoints}

\item{timepoints}{a vector of time points used in the dataset}

\item{max.lag}{a numeric value of the maximum lag allowed}

\item{C}{a numeric value of C used in computing weighted correlation}
}
\value{
a vector of best lags used in the dataset
}
\description{
This function computes the best lags for a datset using weighted correlation
}
\author{
Thevaa Chandereng, Anthony Gitter
}
