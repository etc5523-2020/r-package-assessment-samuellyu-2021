#' Raw form of the covid data used for analysis in the application 
#' 
#' @description Covid data for Ireland and United Kingdom in the complete and raw form containing all the primary variables from the orginal collection.
#' 
#' @source The data has been collected from [tidycovid19](https://github.com/joachim-gassen/tidycovid19) package and the [covdata](https://github.com/kjhealy/covdata) package
#' 
#'@format `raw_covid_data_uk_irl` returns a dataset that contains covid19 related data for Ireland and the United Kingdom, updated as of the 21st of October 2020. 
#' 
#' \itemize{
#'    \item `date` Date in YYYY-MM-DD format
#'    \item `cname` Country name
#'    \item `iso3` ISO3 country code (character)
#'    \item `cu_cases`Cumulative number of reported COVID-19 cases up to and including this date updated as of the 21st of October 2020.
#'    \item `cu_cases_per_100k` Cumulative N reported COVID-19 cases up to and including this date, per capita 100,000 updated as of the 21st of October 2020.
#'    \item `deaths_per_100k` N reported COVID-19 deaths updated as of the 21st of October 2020., per capita 100,000 
#'    \item `cu_deaths_per_100k` Cumulative N reported COVID-19 deaths updated as of the 21st of October 2020.
#'    \item `cases_per_100k` Daily confirmed reported COVID-19 cases on this date, per capita 100,000
#'    \item `log_cu_cases` Log base 10 of cumulative N reported COVID-19 cases up to and including this date
#'    \item `log_cases` Log base 10 of N reported COVID-19 cases on this date
#'    \item `log_cu_deaths` Log base 10 of cumulative N reported COVID-19 deaths up to and including this date
#'    \item `cases` Number of daily reported COVID-19 cases on the chosen date up to the 21st of October 2020.
#'    \item `cu_deaths`Cumulative N reported COVID-19 deaths up to the 21st of October 2020.
#'    \item `deaths` Number reported COVID-19 daily deaths on the chosen date up to the 21st of October 2020.
#'    \item `recovered` Covid-19 recoveries as reported by JHU CSSE (accumulated)
#'    \item `gcmr_retail_recreation` Log base 10 of cumulative N reported COVID-19 cases up to and including this date
#'    \item `gcmr_grocery_pharmacy` Log base 10 of N reported COVID-19 cases on this date
#'    \item `gcmr_transit_stations` Log base 10 of cumulative N reported COVID-19 deaths up to and including this date
#'    \item `gcmr_workplaces` Google Community Mobility Reports data for the frequency that people visit workplaces expressed as a percentage*100 change relative to the baseline period Jan 3 - Feb 6, 2020
#'    \item `Social Distancing measures` Number of social distancing measures reported up to date by ACAPS, net of lifted restrictions
#'    \item `Movement Restrictions` Number of movement restrictions reported up to date by ACAPS, net of lifted restrictions
#'    \item `Public Health Measures` Number of public health measures reported up to date by ACAPS, net of lifted restrictions
#'    \item `pop` population for each country in 2019
#'}
#'
#'@author Samuel Lyubic
#'
#'@examples 
#'\dontrun{
#'# Directly call variables from the `raw_covid_data_uk_irl` dataset
#'raw_covid_data_uk_irl %>%
#'select(deaths, pop, cname)
#'}
#'
#'@docType data
#'
#'@name raw_covid_data_uk_irl
#'
#' @docType data
#' @usage raw_covid_data_uk_irl
"raw_covid_data_uk_irl"