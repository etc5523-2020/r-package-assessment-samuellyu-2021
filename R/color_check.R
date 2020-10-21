#' This is a function used to assess if a string is a color 
#' 
#' @importFrom grDevices col2rgb
#' @noRd
color_check <- function(x) {
  sapply(x, function(X) {
    tryCatch(is.matrix(col2rgb(X)), 
             error = function(e) FALSE)
  })
}