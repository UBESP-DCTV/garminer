#' Adjust time
#'
#' @param timestamp integer, the timestamp\[s\] field of FIT file
#' @param timestamp_16 integer, the timestamp_16\[s\] field of FIT file
#' @param convert if TRUE convert the string into a datetime object (default
#'        is TRUE)
#' @param timezone character representing the timezone of input
#'
#' @return
#' @export
#'
#' @examples
adjust_time <- function(timestamp, timestamp_16,
                        convert  = TRUE,
                        timezone = 'UTC',
                        alternate = FALSE
) {

  timestamp_16[is.na(timestamp_16)] <- 0L
  if (alternate) {
    adjusted <- timestamp + timestamp_16
  } else {
    adjusted <- stringr::str_replace_all(
      string      = timestamp,
      pattern     = paste0('.{5}$'),
      replacement = sprintf("%05d", timestamp_16)
    )
  }

  if (convert) {
    adjusted <- lubridate::as_datetime(as.integer(adjusted),
      origin = paste0('1989-12-31 ')
    )
  }
  adjusted
}
