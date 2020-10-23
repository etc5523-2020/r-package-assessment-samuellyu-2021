globalVariables(c("iso3c", "date", "recovered", "soc_dist", "mov_rest", "pub_health", "gcmr_retail_recreation", "gcmr_grocery_pharmacy", "gcmr_transit_stations", "gcmr_workplaces", "gcmr_residential","cu_cases", "cu_cases_per_100k", "deaths_per_100k", "cu_deaths_per_100k", "cases", "cu_deaths", "deaths", "cases_per_100k", "deaths_per_100k", "log_cu_cases", "log_cases", "log_cu_deaths","days_from_1st_case", "pop", "download_merged_data"), add = TRUE)
#' Covid Data for Ireland and the United Kingdom
#' 
#' @description `covid_data_uk_irl( )` returns a dataset that contains covid19 related data for Ireland and the United Kingdom
#' 
#'@source The data has been collected from [tidycovid19](https://github.com/joachim-gassen/tidycovid19) package and the [covdata](https://github.com/kjhealy/covdata) package
#' 
#'@format `covid_data_uk_irl( )` returns a dataset that contains covid19 related data for Ireland and the United Kingdom. A tibble with 494 rows and 18 columns, that consist of the following variables
#' 
#' \itemize{
#'    \item `date` date in YYYY-MM-DD format
#'    \item `iso3` ISO3 country code (character)
#'    \item `Cumulative Confirmed Cases`Cumulative N reported COVID-19 cases up to and including this date
#'    \item `Cumulative Confirmed Cases per capita, 100,000` Cumulative N reported COVID-19 cases up to and including this date, per capita 100,000
#'    \item `Daily Death Total per capita, 100,000` N reported COVID-19 deaths on this date, per capita 100,000
#'    \item `Cumulative Death per capita, 100,000` Cumulative N reported COVID-19 deaths up to and including this date
#'    \item `Daily Confirmed Cases` Cumulative N reported COVID-19 cases up to and including this date
#'    \item `Cumulative Deaths`Cumulative N reported COVID-19 deaths up to and including this date
#'    \item `Daily Confirmed Deaths` N reported COVID-19 deaths on this date
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
#'# Create an object with the package and then call and work with any variable in the dataset
#' data <- covid_data_uk_irl()
#' data %>% select(`Log of Daily Confirmed Cases`, `Movement Restrictions`, `Public Health Measures`)
#'}
#'
#'@docType data
#'
#'@usage covid_data_uk_irl()
#'
#'@export
covid_data_uk_irl <- function() {
  download_data <-download_merged_data(cached = TRUE, silent = TRUE)
  tidycovid <- download_data %>%
    filter(iso3c %in% c("IRL", "GBR")) %>%
    select(iso3c, date, recovered, soc_dist, mov_rest, pub_health, 
           gcmr_retail_recreation, gcmr_grocery_pharmacy, gcmr_transit_stations, 
           gcmr_workplaces, gcmr_residential) %>%
    rename(iso3 = iso3c)
  covnat <- covnat
  covdata <- covnat %>%
    filter(iso3 %in% c("IRL", "GBR")) %>%
    left_join(tidycovid, by = c("date", "iso3"))
  cases_deaths_per_100k <- covdata %>%
    mutate(cases_per_100k = (cases/pop)*100000,
           deaths_per_100k = (deaths/pop)*10000,
           cu_cases_per_100k = (cu_cases/pop)*100000, 
           cu_deaths_per_100k = (cu_deaths/pop)*100000,
           log_cu_cases = log10(cu_cases),
           log_cases = log10(cases),
           log_cu_deaths = log10(cu_deaths))
  cases_uk_long <- cases_deaths_per_100k %>%
    filter(iso3 == "GBR",
           date >= "2020-01-31") %>% #updated the date to be day before first case
    mutate(days_from_1st_case = row_number(),
           days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
    select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, cases, 
           cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, log_cu_deaths,
           soc_dist, mov_rest, pub_health) 
  cases_irl_long <- cases_deaths_per_100k %>%
    filter(iso3 == "IRL",
           date >= "2020-03-01") %>% 
    mutate(days_from_1st_case = row_number(),
           days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
    select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, 
           cases, cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, 
           log_cu_deaths, soc_dist, mov_rest, pub_health) 
  
  rbind(cases_uk_long, cases_irl_long) %>%
    mutate(details = glue::glue("<br><b>Date: {date}
                          <b>Soc_dist: {soc_dist}
                          <b>Mov_rest: {mov_rest}
                          <b>Pub_health: {pub_health}")) %>%
    rename(`Cumulative Confirmed Cases` = cu_cases,
           `Cumulative Confirmed Cases per capita, 100,000` = cu_cases_per_100k,
           `Daily Death Total per capita, 100, 000` = deaths_per_100k,
           `Cumulative Death per capita, 100,000` = cu_deaths_per_100k,
           `Daily Confirmed Cases` = cases,
           `Cumulative Deaths` = cu_deaths,
           `Daily Confirmed Deaths` = deaths,
           `Daily Confirmed Cases per capita, 100,000` =  cases_per_100k,
           `Log of Cumulative Confirmed Cases` = log_cu_cases,
           `Log of Daily Confirmed Cases` = log_cases,
           `Log of Cumulative Deaths` = log_cu_deaths,
           `Social distancing measures` = soc_dist,
           `Movement Restrictions` = mov_rest,
           `Public Health Measures` = pub_health)
}
#'
#
#'
#'
#'
#'