#' Adjust time
#'
#' @param timestamp integer, the `timestamp[s]` field of FIT file
#' @param timestamp_16 integer, the `timestamp_16[s]` field of FIT file
#' @param timezone character representing the timezone of input.
#' @param origin time origin.
#' @param min_time \code{[dttm]} minimum acceptable time, any output before this time
#'        will be NA. If NULL (default) no minimum constrains will be applied.
#' @param max_time \code{[dttm]} maximum acceptable time, any output after this time
#'        will be NA. If NULL (default) no maximum constrains will be applied .
#'
#' @return a \code{[dttm]} vector
#'
adjust_time <- function(timestamp,
                        timestamp_16,
                        timezone = 'UTC',
                        origin   = '1989-12-31  01:59:00',
                        min_time = NULL,
                        max_time = NULL
) {
  adjusted_time <- timestamp - timestamp %% 2^16 + timestamp_16 %>%
    lubridate::as_datetime(origin = origin)

  is.null(min_time) || {
    adjusted_time[adjusted_time < min_time] <- NA
  }

  is.null(max_time) || {
    adjusted_time[adjusted_time > max_time] <- NA
  }

  adjusted_time
}
