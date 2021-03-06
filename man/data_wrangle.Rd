% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/server_data_clean.R
\name{data_wrangle}
\alias{data_wrangle}
\title{Data wrangling functions specific to covid19BFI package.}
\usage{
data_wrangle(data)
}
\arguments{
\item{data}{the dataset that is passed in on which the wrangling and cleaning will be performed. Must contain the following variables: \verb{month, month_label, iso3 and measures_group.}}
}
\description{
\code{data_wrangle( )} a \strong{covid19BFI} package specifc function that has refactored repititive tasks from the \strong{Covid19: The Battle For Independence} application by performing a range of cleaning and wrangling operations on the provided dataset.
}
\details{
\code{data_wrangle( )} is a \strong{covid19BFI} package specific function that summarises the proportions in the dataset as grouped by the stated variables and takes the provided dataset and turns dataset into a wider format by using the variables \code{measures_group} and \code{porportion} with some further wrangling and cleaning.
}
