#' Read FIT files
#'
#' @param path_to_fit \code{[chr]} the path to the FIT file
#' @param ... additional argument passed to \code{\link[readr]{read_csv}}
#' @param quietly \code{[lgl]} Would you like to know what the function is doing?
#'   (default is FALSE)
#' @param verbose \code{[lgl]} Would you like to know (also) what
#'   \code{\link[readr]{read_csv}} is doing?
#'
#' @return a list of dataframe, each one for each kind of data stored into the
#'   FIT file provided.
#' @export
#'
#' @examples
#' \dontrun{
#'   read_fit("./data-raw/2018-06-02/21188777597.fit")
#' }
read_fit <- function(path_to_fit, # = 'data-raw/2018-06-02/21189460514.fit',
                     ...,
                     quietly = FALSE,
                     verbose = FALSE
) {
  tmp <- tempfile()

  if (!quietly) message("Reading .fit file...")

  log_fit <- system2("java",
    args   = c(
      "-jar", java_fit(),
      "-b",   path_to_fit, tmp,
      "--data"
    ),
    stdout = TRUE
  )

  if (!quietly) message(paste(log_fit, collapse = '\r\n'))

  fit_df <- if (!quietly && verbose) {
    readr::read_csv(paste0(tmp, "_data.csv"), ...)
  } else {
    suppressWarnings(suppressMessages(
      readr::read_csv(paste0(tmp, "_data.csv"), ...)
    ))
  }

  fit_df %>%
    dplyr::mutate(num = row.names(.)) %>%
    tidyr::gather("key", "value", na.rm = TRUE, -num) %>%
#    dplyr::distinct(key, value, .keep_all = TRUE) %>%
    tidyr::separate(key, c("which", "what"), '\\.') %>%
    dplyr::group_by(which) %>%
    tidyr::nest() %>%
    dplyr::mutate(
      data = purrr::set_names(purrr::map(data,
        ~tidyr::spread(., what, value, convert = TRUE) %>%
          dplyr::select(-num) %>%
          dplyr::distinct(.keep_all = TRUE)
      ), which)
    ) %>%
    `[[`(2)
}
