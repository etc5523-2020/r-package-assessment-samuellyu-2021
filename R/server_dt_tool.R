globalVariables("DT")
#' Datatable function 
#' 
#' @description This function will build a datatable and color it for the inputted countries and color choices
#' 
#' @param data this is the dataset where the information lies
#' @param cnt1 this is country one
#' @param cnt2 this is country two
#' @param clr1 this is color one
#' @param clr2 this is color two
#' 
#' @return will return a datatable with colored rows according to the inputed country index
#' 
#' @export
#' @importFrom magrittr %>% 
#' @importFrom DT datatable
#' @importFrom DT formatStyle 
#' @importFrom DT styleEqual
dt_styler <- function (data, cnt1, cnt2, clr1, clr2) {
  datatable(data, rownames = FALSE, options = list(lengthMenu = c(7, 10, 15, 20), pageLength = 7)) %>% 
    formatStyle("Country", 
                target = 'row',
                backgroundColor = styleEqual(c(cnt1,cnt2), c(clr1, clr2)))
}