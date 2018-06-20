#' FitCSVTools
#'
#' This function possibly return the system-specific path to
#' the \code{FitCSVTool} program
#'
#' @return \code{[chr]} path to the \code{FitCSVTool} program
java_fit <- function() {
  java_check()
  FitCSVTool <- system.file("java/FitCSVTool.jar", package = "garminer")

  if (Sys.info()["sysname"] == "Windows")
    FitCSVTool <- Sys.which(FitCSVTool)

  FitCSVTool
}
