# TfL colour standards
# http://content.tfl.gov.uk/tfl-colour-standards-issue04.pdf

oyster_colours <- c(
  oyster_blue = "#001df2",
  oyster_cyan = "#00f2f2",
  legible_london_yellow = "#f0bb00"
)

#' Extract Oyster colour hex codes
#'
#' @param ... Character names of oyster_colours
#' @export
oy_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols))
    return (oyster_colours)

  oyster_colours[cols]
}
