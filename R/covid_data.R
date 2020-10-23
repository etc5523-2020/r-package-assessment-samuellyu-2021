#' Covid Data for Ireland and the United Kingdom
#' 
#' @description `covid_data_uk_irl` returns a dataset that contains the wrangled covid19 related data for Ireland and the United Kingdom with the variables listed below.
#' 
#'@source The data has been collected from [tidycovid19](https://github.com/joachim-gassen/tidycovid19) package and the [covdata](https://github.com/kjhealy/covdata) package
#' 
#'@format `covid_data_uk_irl` returns a dataset that contains covid19 related data for Ireland and the United Kingdom, updated as of the 21st of October 2020.
#' 
#' \itemize{
#'    \item `date` date in YYYY-MM-DD format
#'    \item `iso3` ISO3 country code (character)
#'    \item `Cumulative Confirmed Cases`Cumulative number of reported COVID-19 cases up to and including this date updated as of the 21st of October 2020.
#'    \item `Cumulative Confirmed Cases per capita, 100,000` Cumulative N reported COVID-19 cases up to and including this date, per capita 100,000 updated as of the 21st of October 2020.
#'    \item `Daily Death Total per capita, 100,000` N reported COVID-19 deaths updated as of the 21st of October 2020., per capita 100,000 
#'    \item `Cumulative Death per capita, 100,000` Cumulative N reported COVID-19 deaths updated as of the 21st of October 2020.
#'    \item `Daily Confirmed Cases` Number of daily reported COVID-19 cases on the chosen date up to the 21st of October 2020.
#'    \item `Cumulative Deaths`Cumulative N reported COVID-19 deaths up to the 21st of October 2020.
#'    \item `Daily Confirmed Deaths` Number reported COVID-19 daily deaths on the chosen date up to the 21st of October 2020.
#'    \item `Daily Confirmed Cases per capita, 100,000`N reported COVID-19 cases on this date, per capita 100,000
#'    \item `Log of Cumulative Confirmed Cases` Log base 10 of cumulative N reported COVID-19 cases up to and including this date
#'    \item `Log of Daily Confirmed Cases` Log base 10 of N reported COVID-19 cases on this date
#'    \item `Log of Cumulative Deaths` Log base 10 of cumulative N reported COVID-19 deaths up to and including this date
#'    \item `Social Distancing measures` Number of social distancing measures reported up to date by ACAPS, net of lifted restrictions
#'    \item `Movement Restrictions` Number of movement restrictions reported up to date by ACAPS, net of lifted restrictions
#'    \item `Public Health Measures` Number of public health measures reported up to date by ACAPS, net of lifted restrictions
#'    \item `details` A list of information nested in the cell that contains the date and number of Social Distancing Measures, Movement Restrictions and Public Health Measures for that day
#'}
#'
#'@author Samuel Lyubic
#'
#'@examples 
#'\dontrun{
#'# Directly call variables from the `covid_data_uk_irl` dataset
#'  covid_data_uk_irl %>%
#' select(`Log of Daily Confirmed Cases`, `Movement Restrictions`, `Public Health Measures`)
#'}
#'
#'@docType data
#'
#'@name covid_data_uk_irl
#'
#'@usage covid_data_uk_irl
#'
"covid_data_uk_irl"
#'
#
#'
#'
#'
#'