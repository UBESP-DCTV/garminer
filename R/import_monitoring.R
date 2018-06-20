#' Import Monitoring FIT data
#'
#' the funciton aims to import the monitoring data from a FIT file. The intent
#' is to use it for a clinical project. Hence an optional structured path with
#' name and dates is provided as input.
#'
#' @param base_path the base path into start search the files
#' @param patient_name an optional patient's name (used as a subfolder of the
#'   \code{base_path} provided)
#' @param fit_date  an optional date used as a subfolder of the
#'        \code{patient_name}
#' once (if provided) or directly as a subfolder of the \code{base_path}
#' @param quietly \code{[lgl]} Would you like to know what the function is doing?
#'   (default is TRUE)
#' @param verbose \code{[lgl]} Would you like to know (also) what
#'   \code{\link[readr]{read_csv}} is doing?
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' \dontrun{
#'  import_monitoring("data-raw", fit_date = "2018-06-02")
#' }
import_monitoring <- function(
  base_path = ".", patient_name = NULL, fit_date = NULL,
  quietly = TRUE,
  verbose = FALSE
) {

  fits_path <- as.list(c(base_path, patient_name, fit_date)) %>%
    do.call(what = file.path)

  list.files(fits_path) %>%
    purrr::set_names(.) %>%
    purrr::map(~read_fit(
      paste0(file.path(fits_path, .x)),
      quietly = quietly,
      verbose = verbose
    )) %>%
    purrr::map_df("monitoring", .id = 'fit_file') %>%
    ggplot2::remove_missing(vars = c("timestamp[s]", "timestamp_16[s]")) %>%
    dplyr::distinct(`timestamp[s]`, `timestamp_16[s]`, .keep_all = TRUE) %>%
    dplyr::mutate(
      timestamp = adjust_time(`timestamp[s]`, `timestamp_16[s]`,
        min_time = border_date(fit_date, "low"),
        max_time = border_date(fit_date, "high")
      )
    ) %>%
    ggplot2::remove_missing(vars = "timestamp") %>%
    dplyr::select(-c("timestamp[s]", "timestamp_16[s]", "unknown"))
}
