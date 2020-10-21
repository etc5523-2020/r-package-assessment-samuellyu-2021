globalVariables(names = c("month", "month_label", "iso3", "measures_group"), add = TRUE)
#' A function that wrangles selected variables into proportions and long form
#' 
#' @description Takes the chosen variable and calculates a proportion and then turns it into long form
#' 
#' @param data the dataset that is being used to generate the proportions and long form 
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
