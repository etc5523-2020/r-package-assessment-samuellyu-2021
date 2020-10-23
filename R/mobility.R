#' Mobility data for the major cities in Ireland and the United Kingdom
#' 
#' @description `mobility_major_cities` returns a dataset that contains the mobility scores for the major cities in Ireland and the United Kingdom, as well as latitude and longitude location. All the variables are listed below.
#' 
#'@source The data has been collected from the [covdata](https://github.com/kjhealy/covdata) package
#'
#'@format `mobility_major_cities` returns a dataset that has 9,755 rows and 12 columns, as follows
#'
#' \itemize{
#'    \item `geo_type` character Type geographical unit. Values: city or country/region
#'    \item `region` character Name of geographical unit.
#'    \item `transportation_type`character Mode of transport. Values: Driving, Transit, or Walking
#'    \item `alternative_name` character Name of region in local language
#'    \item `sub_region` character country Subregion
#'    \item `country` character Country name (not provided for all countries)
#'    \item `date` date Date in yyyy-mm-dddd format
#'    \item `score`double Activity score. Indexed to 100 on the first date of observation for a given mode of transport.
#'    \item `lat` Latitude
#'    \item `lng` Longitude
#'    \item `population`Population of the region
#'    \item `Details` List of information containing city name and country
#'}
#'
#'@name mobility_major_cities
#'
#'@examples 
#'\dontrun{
#'# Directly call variables from the `mobility_major_cities` dataset
#'mobility_major_cities %>%
#'ggplot(aes(x = lng, y = lat)) +
#'geom_point()
#'}
#'
#'@details Data from Apple Maps on relative changes in mobility in various cities and countries.
#'
#'@usage mobility_major_cities
#'
#'@docType data
#'
#'@author Samuel Lyubic
"mobility_major_cities"