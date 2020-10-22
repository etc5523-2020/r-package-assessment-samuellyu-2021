#' Generate the shiny application : **Covid19: The Battle of Independence**
#' 
#' @description launch_app( ) builds and produces the shiny application _Covid19: The Battle of Independence._ The application
#' displays a comparative and interactive analysis between the impact and response to covid19 between Ireland and the United Kingdom.  
#' 
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "covid19BFI")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `covid19BFI`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
} 

#'@usage

