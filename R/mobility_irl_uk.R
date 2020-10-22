globalVariables(c("lat", "lng", "region", "country", "population", "country", "major_cities",
                "country.y", "country", "Details", "country.x"), add = TRUE)
#' IRL and UK Covid mobility data
#' 
#' @description Function that produces the covid mobility data for the major cities of IRL and UK
#' 
#' @source [tidycovid19](https://github.com/joachim-gassen/tidycovid19) and [covdata](https://github.com/kjhealy/covdata)
#' 
#' @export
covid_mobility_irl_uk <- function() {
  apple_mobility <- apple_mobility
  apple_mobility_covdata <- apple_mobility %>%
    filter(country %in% c("Ireland", "United Kingdom"))
  major_cities <- tibble(lat = c("55.953251", "51.481312", "54.597286", "52.486244","55.861147", "53.797419", "53.405472", "53.479147","53.349307", "51.897928", "53.274412", "52.661258", "51.507276"), 
                         lng = c("-3.188267","-3.180500", "-5.930120", "-1.890401", "-4.249989", "-1.543794", "-2.980539","-2.244745", "-6.261175", "-8.470581", "-9.049063", "-8.630208", "-0.12766"), 
                         region = c("Edinburgh","Cardiff","Belfast","Birmingham","Glasgow","Leeds","Liverpool","Manchester","Dublin","Cork", "Galway","Limerick", "London"),
                         country = c("GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "IRL", "IRL", "IRL", "IRL", "GBR"),
                         population = c("482005", "335145", "280211", "1086000", "598830", "474632", "552267", "510746", "1388000", "124391", "79934", "194899", "8982000"))
  
  apple_maps_major_cities <- apple_mobility_covdata %>%
    left_join(major_cities, by = "region") %>%
    select(-country.y) %>%
    rename(country = country.x) %>%
    mutate(lat = as.numeric(lat),
           population = as.numeric(population),
           lng = as.numeric(lng),
           Details = case_when(
             country == "United Kingdom" ~ glue::glue("<br><b>City: {region}
                          <b>Country: {sub_region}, {country}"),
             country == "Ireland" ~ glue::glue("<br><b>City: {region}
                          <b>Country:{country}"))) %>%
    filter(region %in% c("Edinburgh","Cardiff","Belfast","Birmingham","Glasgow","Leeds",
                         "Liverpool","Manchester","Dublin","Cork", "Galway","Limerick", "London"))
  return(apple_maps_major_cities)
}