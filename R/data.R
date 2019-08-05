#' Read Oyster journey history files
#'
#' @description Read one or more Oyster journey history files from a single folder
#'     and combine them. Assumes journey histories are raw CSV files as received
#'     by email from Transport for London. Ignores files that are not identified
#'     as Oyster history journey files.
#' @param path A string describing a filepath to a folder of CSVs
#' @return A data.frame object.
#' @export

oy_read <- function(path) {

  if (!is.character(path)) {
    stop(
      "You must provide a character string to the path argument.\n",
      "You provided an object of class ", class(path)[1])
  }

  # Extract the CSV filenames
  data_paths <- list.files(
    path = path,        # filpath specified by user
    pattern = "*.csv",  # must be a csv file
    full.names = TRUE   # returns full path
  )

  # Warning if empty folder at provided path
  if (length(data_paths) == 0) {
    stop(paste("No CSV files found at filepath", path, "\n"))
  }

  # Read the CSV files into a list
  data_list_all <- lapply(        # map to a list
    X = data_paths,               # for each file path...
    FUN = function(x) read.csv(   # ...read the CSV file
      file = x,                   # where x is each file path
      stringsAsFactors = FALSE,   # strings to characters, not factors
      skip = 1,                   # ignore blank first row
      header = TRUE,              # the first (non-blank) row is headers
      na.strings = ""             # replace blanks with NA
    )
  )

  names(data_list_all) <- data_paths

  # Filter for elements with conditions of a TfL Oyster history statement

  # Vector of expected column names
  match_cols <- c(
    "Date", "Start.Time", "End.Time", "Journey.Action", "Charge", "Credit",
    "Balance", "Note"
  )

  # Filter by list elements that match the expected column names
  data_list_subset <-
    Filter(f = function(x) { identical(names(x), match_cols) }, data_list_all)

  # Warning that elements were removed
  if(length(data_list_subset) < length(data_list_all)) {
    count_removed <- length(data_list_all) - length(data_list_subset)
    if(count_removed == 1) {
      cat(paste(count_removed, "element wasn't in the expected format and was discarded\n\n"))
    } else {
      cat(paste(count_removed, "elements weren't in the expected format and were discarded\n\n"))
    }
  }

  # Bind the rows from each list element (data frame)
  data_df <- do.call("rbind", data_list_subset)
  rownames(data_df) <- c()

  # Return the object
  return(data_df)

}

#' Clean Oyster journey history data
#'
#' @description Process a data.frame object containing Oyster journey history
#'     data. . Could be a raw file as received by email from Transport for London
#'     or the output from oy_read().
#' @param df A data.frame object containing Oyster history journey.
#' @return A data.frame object.
#' @export

oy_clean <- function(x) {

  # Make names lowercase and use underscore instead of period
  names(x) <- tolower(gsub("\\.", "_", names(x)))

  # Date-times
  x$date_start <- as.POSIXct(paste(x$date, x$start_time), "%d-%b-%Y %H:%M", tz = "GMT")
  x$date_end <- as.POSIXct(paste(x$date, x$end_time), "%d-%b-%Y %H:%M", tz = "GMT")

  # Day of the week
  x$weekday_start <- weekdays(x$date_start)
  x$weekday_end <- weekdays(x$date_end)

  # Split stations (in form 'x to y')
  # TODO: when it's a differnet mode of transport, or not a journey (e.g. top-up)
  x$station_start <- sapply(strsplit(as.character(x$journey_action), " to "), "[", 1)
  x$station_end <- sapply(strsplit(as.character(x$journey_action), " to "), "[", 2)

  # Retain only the columns of interest
  x <- x[, c(
    "date_start", "date_end", "weekday_start", "weekday_end",
    "station_start", "station_end",
    "charge", "credit", "balance",
    "note"
  )]

  return(x)

}

