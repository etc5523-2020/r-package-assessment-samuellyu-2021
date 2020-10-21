#' This is a launch function
#' 
#' @description This function allows the user to access the covid19BFI application.
#' 
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "covid19BFI")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `covid19BFI`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
} 