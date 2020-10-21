globalVariables("DT")
#' Datatable function 
#' 
#' @description This function will build a datatable and color it for the inputted countries and color choices
#' 
#' @param data this is the dataset where the information lies
#' @param id is the variable column id where the variables are being targetted
#' @param key1 this is country one
#' @param key2 this is country two
#' @param clr1 this is color one
#' @param clr2 this is color two
#' @param plength this is the length of the table 
#' 
#' @return will return a datatable with colored rows according to the inputed country index
#' 
#' @export
#' @importFrom magrittr %>% 
#' @importFrom DT datatable
#' @importFrom DT formatStyle 
#' @importFrom DT styleEqual
dt_styler <- function (data, id, key1, key2, clr1, clr2, plength) {
  
  stopifnot(
  color_check(c(clr1, clr2)) == TRUE)
  
  stopifnot(
    plength > 0
  )
  
  datatable(data, rownames = FALSE, options = list(lengthMenu = c(7, 10, 15, 20), pageLength = plength)) %>% 
    formatStyle(id, 
                target = 'row',
                backgroundColor = styleEqual(c(key1,key2), c(clr1, clr2)))
}