#' Check for Java
#' @return invisible()
java_check <- function() {
  if (system2("java", stdout = FALSE, stderr = FALSE) == 127)
    stop("java binaries not installed/on system path", call. = FALSE)
  invisible()
}
