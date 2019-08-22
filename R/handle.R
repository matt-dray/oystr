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
      "You provided an object of class ", class(path)[1], ""
    )
  }

  # Extract the CSV filenames
  data_paths <- list.files(
    path = path,        # filpath specified by user
    pattern = "*.csv",  # must be a csv file
    full.names = TRUE   # returns full path
  )

  # Warning if empty folder at provided path
  if (length(data_paths) == 0) {
    stop(paste0("No CSV files found at filepath '", path, "'\n"))
  }

  # Read the CSV files into a list
  data_list_all <- lapply(               # map to a list
    X = data_paths,                      # for each file path...
    FUN = function(x) utils::read.csv(   # ...read the CSV file
      file = x,                          # where x is each file path
      stringsAsFactors = FALSE,          # strings to characters, not factors
      skip = 1,                          # ignore blank first row
      header = TRUE,                     # the first (non-blank) row is headers
      na.strings = ""                    # replace blanks with NA
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
  if (length(data_list_subset) < length(data_list_all)) {
    count_removed <- length(data_list_all) - length(data_list_subset)
    if(count_removed == 1) {
      warning(paste(count_removed, "CSV file wasn't in the expected format and was discarded"))
    } else {
      warning(paste(count_removed, "CSV files weren't in the expected format and were discarded"))
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
#'     data. Could be a raw file as received by email from Transport for London
#'     or the output from oy_read().
#' @param x A data.frame object containing Oyster history journey.
#' @return A data.frame object.
#' @export

oy_clean <- function(x) {

  if(class(x) != "data.frame") {
    stop(
    "\nYou must provide an object of class data.frame.\n",
    "You provided an object of class ", class(x)[1], "."
    )
  }

  # TODO: additional stopping rules dependent on final shape/classes/column names

  # Meta: make names lowercase and use underscore instead of period
  names(x) <- tolower(gsub("\\.", "_", names(x)))

  # Date: make date class
  x$date_start <- as.Date(x$date, format = "%d-%b-%Y")
  x$date_end <- x$date_start  # new column, date class

  # Datetime: create datetime
  x$datetime_start <- as.POSIXct(paste(x$date, x$start_time),"%d-%b-%Y %H:%M", tz = "GMT")
  x$datetime_end <- as.POSIXct(paste(x$date, x$end_time), "%d-%b-%Y %H:%M", tz = "GMT")


  # Date: increment end_date by +1 where journey finishes after midnight
  x$date_end <- as.Date(
    ifelse(
      test = format(x$datetime_start, '%H') %in% c("22", "23") &
        format(x$datetime_end, "%H") %in% c("00", "01", "02"),
      yes = x$date_end + 1,
      no = x$date_end
    ),
    origin = "1970-01-01"
  )

  # Datetime: recreate datetime_end with the updated date_end
  x$datetime_end <- as.POSIXct(
    paste(x$date_end, x$end_time),
    "%Y-%m-%d %H:%M",
    tz = "GMT"
  )

  # Datetime: journey duration
  x$journey_duration <- difftime(
    time2 = x$datetime_start,
    time1 = x$datetime_end,
    units = "mins", tz = "GMT"
  )

  # Date: day of the week
  x$weekday_start <- weekdays(x$date_start)
  x$weekday_end <- weekdays(x$date_end)

  # Pay: extract mode of transport
  # TODO: rewrite with if(){}?
  x$mode <- ifelse(
    test = grepl("Bus journey", x$journey_action),
    yes = "Bus",
    no = ifelse(
      test = (grepl(" to ", x$journey_action)),
      yes = "Train",
      no = NA
    )
  )

  # Pay: extract type of payment
  # TODO: rewrite with if(){}?
  x$payment <- ifelse(
    test = grepl("Season ticket", x$journey_action),
    yes = "Season ticket",
    no = ifelse(
      test = (grepl("topped", x$journey_action)),
      yes = "Top-up",
      no = NA
    )
  )

  # Train: split stations (in form 'x to y')
  # TODO: if it doesn't have 'to', then it should get an NA for station_start, rather than being filled
  x$station_start <- sapply(strsplit(as.character(x$journey_action), " to "), "[", 1)
  x$station_end <- sapply(strsplit(as.character(x$journey_action), " to "), "[", 2)

  # Bus: extract route
  x$bus_route <- ifelse(
    test = x$mode == "Bus",
    yes = gsub("Bus journey, route ", "", x$journey_action),
    no = NA
  )

  # Retain only the columns of interest
  x <- x[, c(
    "datetime_start", "datetime_end", "weekday_start", "journey_duration",
    "mode", "station_start", "station_end", "bus_route",
    "payment", "charge", "credit", "balance",
    "note"
  )]

  return(x)

}
