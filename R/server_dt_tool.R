globalVariables("DT")
#' Generate Datatable with Formatted Styling
#' 
#' @description dt_styler( ) generates a datatable with style formatting that will "color" the rows that belong to the
#' two key variables by coloring them according to the two colors assigned to the two key variable. dt_styler ( )
#' can be used for any two variables from a dataset and with any two colors from a dataset.   
#' 
#' Learn more in vignette ("covid19BFI")
#'
#'@details The drop down page length selection is fixed at 7, 10, 15 and 20.  
#' 
#' @param data A data frame that contains the data to be output in the datatable.
#' @param rownames Will create the first column as an index with the row numbers for each row when set to _TRUE_, rownames will not be shown when set to _FALSE_. 
#' @param id The column name that contains the _key_ variables and will be used as an index for the function to identify.
#' @param key1 A single argument that is the **first key** variable that is chosen to have each of its rows highlighted by being colored in the chosen color.
#' @param key2 A single argument that is the **second key** variable that is chosen to have each of its rows highlighted by being colored in the other chosen color.
#' @param clr1 The **first color** that will highlight all the rows that are associated with _key1_.
#' @param clr2 The **second color* that will highlight all the rows that are associated with _key1_.
#' @param plength The argument the specifies the **number of rows** to be displayed in the table on the first page. Can take up to any number
#' between 1 and the maximum length of the dataset.
#' 
#' @details  a datatable with colored rows according to the two chosen key variables.
#' 
#'@examples
#'\dontrun{ 
#' dt <- iris %>% filter(Species %in% c("setosa", "versicolor"))
#' 
#' #Builds a datatable of length 10, with red and blue rows.
#' dt_styler(dt, "Species", "setosa", "versicolor", "blue", "red", 10, rownames = FALSE) 
#'}
#' 
#' @export
#' @importFrom magrittr %>% 
#' @importFrom DT datatable
#' @importFrom DT formatStyle 
#' @importFrom DT styleEqual
dt_styler <- function (data, id, key1, key2, clr1, clr2, plength, rownames = FALSE) {
  
  stopifnot(
  color_check(c(clr1, clr2)) == TRUE)
  
  stopifnot(
    plength > 0
  )
  
  datatable(data, options = list(lengthMenu = c(7, 10, 15, 20), pageLength = plength, rownames)) %>% 
    formatStyle(id, 
                target = 'row',
                backgroundColor = styleEqual(c(key1,key2), c(clr1, clr2)))
}
#'
#'
#'@usage
#'
#'@author Samuel Lyubic as part of the **covid19BFI** package.
#'
#'@source The datatable, formatStyle and styleEqual function used in the `dt_styler` function has been originally developed for the [DT](https://cran.r-project.org/web/packages/DT/DT.pdf) package.
