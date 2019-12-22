#' Example Oyster Journey History File (Read In)
#'
#' An anonymised example of a single month's journey history data received
#' originally as a CSV from Transport for London and read with
#' \code{\link{oy_read()}}.
#'
#' @docType data
#' @usage data(journeys_read)
#' @format An object of class \code{data.frame}.
#' @source Data generated and received originally from
#'     (\href{https://tfl.gov.uk/}{Transport for London}).
#' @examples
#' data(journeys_read)
"journeys_read"

#' Example Oyster Journey History File (Cleaned)
#'
#' An anonymised example of a single month's journey history data received
#' originally as a CSV from Transport for London, read with
#' \code{\link{oy_read()}} and cleaned with \code{\link{oy_clean()}}.
#'
#' @docType data
#' @usage data(journeys_clean)
#' @format An object of class \code{"data.frame"}.
#' @source Data generated and received originally from
#'     (\href{https://tfl.gov.uk/}{Transport for London}).
#' @examples
#' data(journeys_clean)
"journeys_clean"
