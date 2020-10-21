#' Function that sets the date range for the slider
#' 
#' @description This function will allow the user to repeatedly add date slider inputs by adding the appropriate params
#' 
#' @param inputId input id
#' @param label is the label
#' @param x is the date data
#' @param start is the start date for the range
#' @param ... is the rest of the inputs which are as follows
#' 
#' @return will return a date range  with chosen date values as specified by the user 
#' 
#' @export
dateInput_range <- function(inputId, label = "Chosen date range", x, start = min(x), ...) {
  date_range <- range(x, na.rm = TRUE)
  shiny::dateRangeInput(inputId, label = label, start = start, end = date_range[2], format = "yy-mm-dd", ...)
}
 