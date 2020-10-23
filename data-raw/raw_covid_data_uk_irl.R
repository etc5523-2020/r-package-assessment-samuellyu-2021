#' Removing tidycovid19 pacakge from the package by importing the csv
#' 
#' Tidycovid19 wrangling and removal to date
library(tidycovid19)
library(here)
library(tidyverse)
library(tibble)
library(lubridate)
library(covdata)
library(glue)
tidy <- read_csv(here::here("inst/raw_covid/tidycovid.csv"))
tidy_covid <- tibble(tidy) %>%
  mutate(date = as.Date(date),
         recovered = as.numeric(as.character(recovered)),
         soc_dist = as.numeric(as.character(soc_dist)),
         mov_rest = as.numeric(as.character(mov_rest)),
         pub_health = as.numeric(as.character(pub_health)),
         gcmr_retail_recreation = as.numeric(as.character(gcmr_retail_recreation)),
         gcmr_grocery_pharmacy = as.numeric(as.character(gcmr_grocery_pharmacy)),
         gcmr_transit_stations = as.numeric(as.character(gcmr_transit_stations)),
         gcmr_workplaces = as.numeric(as.character(gcmr_workplaces)),
         gcmr_residential = as.numeric(as.character(gcmr_residential)))

covdata <- covnat %>%
  filter(iso3 %in% c("IRL", "GBR")) %>%
  left_join(tidy_covid, by = c("date", "iso3"))
apple_mobility_covdata <- apple_mobility %>%
  filter(country %in% c("Ireland", "United Kingdom"))

raw_covid_data_uk_irl <- covdata %>%
  mutate(cases_per_100k = (cases/pop)*100000,
         deaths_per_100k = (deaths/pop)*10000,
         cu_cases_per_100k = (cu_cases/pop)*100000,
         cu_deaths_per_100k = (cu_deaths/pop)*100000,
         log_cu_cases = log10(cu_cases),
         log_cases = log10(cases),
         log_cu_deaths = log10(cu_deaths))




usethis::use_data(raw_covid_data_uk_irl, overwrite = TRUE)
