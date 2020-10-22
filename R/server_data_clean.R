globalVariables(names = c("month", "month_label", "iso3", "measures_group"), add = TRUE)
#' Data wrangling functions specific to covid19BFI package.
#' 
#' @description `data_wrangle( )` a **covid19BFI** package specifc function that has refactored repititive tasks from the **Covid19: The Battle For Independence** application by performing a range of cleaning and wrangling operations on the provided dataset. 
#' 
#' @details `data_wrangle( )` is a **covid19BFI** package specific function that summarises the proportions in the dataset as grouped by the stated variables and takes the provided dataset and turns dataset into a wider format by using the variables `measures_group` and `porportion` with some further wrangling and cleaning.
#' 
#' @param data the dataset that is passed in on which the wrangling and cleaning will be performed. Must contain the following variables: `month, month_label, iso3 and measures_group.`
#' 
#' @export
#' @importFrom utils globalVariables
#' @importFrom tidyr pivot_wider
#' @import dplyr
data_wrangle <- function(data) {
  data %>%
    group_by(.data$month, .data$month_label, .data$iso3, .data$measures_group) %>%
    summarise(proportion = sum(.data$proportion)) %>%
    pivot_wider(names_from = "measures_group",
                values_from = "proportion") %>%
    mutate_all(~replace(., is.na(.), 0)) %>%
    rename(Month = month, 
           Country = iso3,
           `Month Label` = month_label)  
}
#'
#' @usage
#'
#' @author Samuel Lyubic