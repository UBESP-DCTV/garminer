#' Create a border datetime
#'
#' If a datetime is provided the function return that datetime, otherwise
#' it return a lower or upper border for datetime
#'
#' @param fit_date \code{[dttm]} a dttm or NULL
#' @param side \code{[chr]}lower or upper
#'
#' @return a \code{[dttm]}
border_date <- function(fit_date = NULL, side = c("low", "high")) {

  side <- match.arg(side)

  border <- magrittr::set_names(
    lubridate::as_datetime(c("0000-01-01 00:00:00", "9999-12-31 23:59:59")),
    c("low", "high")
  )[side]

  if (is.null(fit_date)) {
    border
  } else if (side == "high") {
    lubridate::as_datetime(paste0(fit_date, " 23:59:59"))
  } else {
    lubridate::as_datetime(paste0(fit_date, " 00:00:00"))
  }
}
