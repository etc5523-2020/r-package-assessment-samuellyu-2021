% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/covid_data.R
\docType{data}
\name{covid_data_uk_irl}
\alias{covid_data_uk_irl}
\title{Covid Data for Ireland and the United Kingdom}
\format{
\code{covid_data_uk_irl} returns a dataset that contains covid19 related data for Ireland and the United Kingdom, updated as of the 21st of October 2020.

\itemize{
\item \code{date} date in YYYY-MM-DD format
\item \code{iso3} ISO3 country code (character)
\item \verb{Cumulative Confirmed Cases}Cumulative number of reported COVID-19 cases up to and including this date updated as of the 21st of October 2020.
\item \verb{Cumulative Confirmed Cases per capita, 100,000} Cumulative N reported COVID-19 cases up to and including this date, per capita 100,000 updated as of the 21st of October 2020.
\item \verb{Daily Death Total per capita, 100,000} N reported COVID-19 deaths updated as of the 21st of October 2020., per capita 100,000
\item \verb{Cumulative Death per capita, 100,000} Cumulative N reported COVID-19 deaths updated as of the 21st of October 2020.
\item \verb{Daily Confirmed Cases} Number of daily reported COVID-19 cases on the chosen date up to the 21st of October 2020.
\item \verb{Cumulative Deaths}Cumulative N reported COVID-19 deaths up to the 21st of October 2020.
\item \verb{Daily Confirmed Deaths} Number reported COVID-19 daily deaths on the chosen date up to the 21st of October 2020.
\item \verb{Daily Confirmed Cases per capita, 100,000}N reported COVID-19 cases on this date, per capita 100,000
\item \verb{Log of Cumulative Confirmed Cases} Log base 10 of cumulative N reported COVID-19 cases up to and including this date
\item \verb{Log of Daily Confirmed Cases} Log base 10 of N reported COVID-19 cases on this date
\item \verb{Log of Cumulative Deaths} Log base 10 of cumulative N reported COVID-19 deaths up to and including this date
\item \verb{Social Distancing measures} Number of social distancing measures reported up to date by ACAPS, net of lifted restrictions
\item \verb{Movement Restrictions} Number of movement restrictions reported up to date by ACAPS, net of lifted restrictions
\item \verb{Public Health Measures} Number of public health measures reported up to date by ACAPS, net of lifted restrictions
\item \code{details} A list of information nested in the cell that contains the date and number of Social Distancing Measures, Movement Restrictions and Public Health Measures for that day
}
}
\source{
The data has been collected from \href{https://github.com/joachim-gassen/tidycovid19}{tidycovid19} package and the \href{https://github.com/kjhealy/covdata}{covdata} package
}
\usage{
covid_data_uk_irl
}
\description{
\code{covid_data_uk_irl} returns a dataset that contains the wrangled covid19 related data for Ireland and the United Kingdom with the variables listed below.
}
\examples{
\dontrun{
# Directly call variables from the `covid_data_uk_irl` dataset
 covid_data_uk_irl \%>\%
select(`Log of Daily Confirmed Cases`, `Movement Restrictions`, `Public Health Measures`)
}

}
\author{
Samuel Lyubic
}
\keyword{datasets}
