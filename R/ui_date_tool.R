#' Generate a date range input 
#' 
#' @description `dateInput_range( )` will create a pair of text inputs from the the specified date variable which, when clicked on, bring up calanders that the 
#' user can click on to select the specific dates they wish to choose. 
#' 
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param date The date input that contains the date information for the dataset. Either a Date object, or  string in `yyyy-mm-dd` formart. Must be a _date_ vector of at least length 2. A column from a dataset can be directly called using "$". 
#' @param start The initial start date. Either a Date object, or a string in yyyy-mm-dd format. If `start` is NULL, it will be reated as `min(date)` which is the default and the minimum date from the `date` variable provided will be selected.
#' @param ... The rest of the arguments that can be used have been sourced from the `?dateRangeInput` and detailed below in "details":
#' 
#' 
#' @details  `dateInput_range( )` will return a date range  with chosen date values as specified by the user. The `date`` input can directly call a date variable from a dataset with the start, end and mximum dates being automatically generated from the provided date dataset if their fields are left NULL. 
#' @details The date format string specifies how the date will be displayed in the browser. It allows the following values:
#'
#' \itemize{
#'   \item `yy` Year without century (12)
#'   \item `yyyy` Year with century (2012)
#'   \item `mm` Month number, with leading zero (01-12)
#'   \item `m` Month number, without leading zero (1-12)
#'   \item `M` Abbreviated month name
#'   \item `MM` Full month name
#'   \item `dd` Day of month with leading zero
#'   \item `d` Day of month without leading zero
#'   \item `D` Abbreviated weekday name
#'   \item `DD` Full weekday name
#' }
#' @details The remaining arguments that can be used with `dateInput_range( )` function are as follows: 
#' \itemize{
#'   \item `end` The initial end date. Either a Date object, or a string in yyyy-mm-dd format. If `end` is NULL, the maximum date from the provided dataset will be chosen.
#'   \item `max` The maximum allowed date. Either a Date object, or a string in yyyy-mm-dd format. If `max` is NULL, the maximum date from the provided dataset will be chosen.
#'   \item `startview` The date range shown when the input object is first clicked. Can be "month" (the default), "year", or "decade".
#'   \item `weekstart` 	Which day is the start of the week. Should be an integer from 0 (Sunday) to 6 (Saturday).
#'   \item `language `The language used for month and day names. Default is "en". Other valid values include "ar", "az", "bg", "bs", "ca", "cs", "cy", "da", "de", "el", "en-AU", "en-GB", "eo", "es", "et", "eu", "fa", "fi", "fo", "fr-CH", "fr", "gl", "he", "hr", "hu", "hy", "id", "is", "it-CH", "it", "ja", "ka", "kh", "kk", "ko", "kr", "lt", "lv", "me", "mk", "mn", "ms", "nb", "nl-BE", "nl", "no", "pl", "pt-BR", "pt", "ro", "rs-latin", "rs", "ru", "sk", "sl", "sq", "sr-latin", "sr", "sv", "sw", "th", "tr", "uk", "vi", "zh-CN", and "zh-TW".
#'   \item `serperator` String to display between the start and end input boxes. 
#'   \item `width `The width of the input, e.g. '400px', or '100%.
#'   \item `autoclose` Whether or not to close the datepicker immediately when a date is selected. Takes arguments TRUE or FALSE.
#'   \item `format` is the date format presented to the user, the options are detailed below. The default is `yy-mm-dd`.
#'   }
#'  
#' @export
dateInput_range <- function(inputId, label = "Chosen date range", date, start = min(date), ...) {
  date_range <- range(date, na.rm = TRUE)
  shiny::dateRangeInput(inputId, label = label, start = start, end = date_range[2], format = "yy-mm-dd", ...)
}
#'
#'@examples
#'\dontrun{ 
#'
#'# The date variable from the dataset "data" will selected and given the rest of the fields were left NULL, the `start` date will be the minimum date in the "data" dataset and `end` and `max` dates will be the maximum date of the "data" dataset.
#'dateInput_range(inputId = "myDate", label = "Date range for chosen date range", date = data$date)
#'
#'# Date range input with a string as the `date` input, specified `start`, `end` and `max` dates in a display format MM/dd/yy and using "to" as the seperator between the two date boxes.
#' dateInput_range(inputId = "otherDate", date = c("2001-10-10", "2002-10-10", "2003-10-10, "2004-10-10", "2005-10-10"), start = "2002-10-10", end = "2004-10-10", max = "2005-10-10", format = "MM/dd/yy", seperator = "to") 
#'}
#'
#'@usage 
#'
#'
#'@source The dateRangeInput function used in the `dateInput_range` function has been originally developed for the [shiny](https://cran.r-project.org/web/packages/shiny/index.html) package.
#'
#'@author Samuel Lyubic