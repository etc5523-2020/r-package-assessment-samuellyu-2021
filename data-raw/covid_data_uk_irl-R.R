#' Creating the final covid data output used in analysis
library(tidycovid19)
library(here)
library(tidyverse)
library(tibble)
library(lubridate)
library(covdata)
library(glue)

cases_uk_long <- raw_covid_data_uk_irl %>%
  filter(iso3 == "GBR",
         date >= "2020-01-31") %>% #updated the date to be day before first case
  mutate(days_from_1st_case = row_number(),
         days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
  select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, cases, 
         cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, log_cu_deaths, 
         soc_dist, mov_rest, pub_health) 


cases_irl_long <- raw_covid_data_uk_irl %>%
  filter(iso3 == "IRL",
         date >= "2020-03-01") %>% 
  mutate(days_from_1st_case = row_number(),
         days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
  select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, 
         cases, cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, 
         log_cu_deaths, soc_dist, mov_rest, pub_health) 

cases_bind <- rbind(cases_uk_long, cases_irl_long) %>%
  mutate(details = glue::glue("<br><b>Date: {date}
                          <b>Soc_dist: {soc_dist}
                          <b>Mov_rest: {mov_rest}
                          <b>Pub_health: {pub_health}")) 

covid_data_uk_irl <-  cases_bind %>%
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

usethis::use_data(covid_data_uk_irl, overwrite = TRUE)
