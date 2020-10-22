globalVariables(c("iso3c", "date", "recovered", "soc_dist", "mov_rest", "pub_health", 
                  "gcmr_retail_recreation", "gcmr_grocery_pharmacy", "gcmr_transit_stations", 
                  "gcmr_workplaces", "gcmr_residential","cu_cases", "cu_cases_per_100k", 
                  "deaths_per_100k", "cu_deaths_per_100k", "cases", "cu_deaths", "deaths", 
                  "cases_per_100k", "deaths_per_100k", "log_cu_cases", "log_cases", "log_cu_deaths",
                  "days_from_1st_case", "pop", "download_merged_data"), add = TRUE)
#' IRL and UK Covid data
#' 
#' @description Function that produces the covid data for IRL and UK
#' 
#' @source [tidycovid19](https://github.com/joachim-gassen/tidycovid19) and [covdata](https://github.com/kjhealy/covdata)
#' 
#' @export
covid_data_uk_irl <- function() { 
  tidycovid <- download_merged_data(cached = TRUE, silent = TRUE) %>%
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
           days_from_1st_case, soc_dist, mov_rest, pub_health) 
  cases_irl_long <- cases_deaths_per_100k %>%
    filter(iso3 == "IRL",
           date >= "2020-03-01") %>% 
    mutate(days_from_1st_case = row_number(),
           days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
    select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, 
           cases, cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, 
           log_cu_deaths, days_from_1st_case, soc_dist, mov_rest, pub_health) 
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