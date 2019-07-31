#' Read Oyster-history CSV files from a folder
#'
#' @param path A string describing a filepath to a folder of CSVs
#' @return A data.frame object.
#' @export

oy_read <- function(path) {

  if(!is.character(path)) {
    stop(
      "You must provide a character string to the path argument.\n",
      "You provided an object of class ",
      class(path)[1])
  }

  # Extract the CSV filenames
  oy_files <- list.files(
    path = path,        # filpath specified by user
    pattern = "*.csv",  # must be a csv file
    full.names = TRUE   # returns full path
  )

  # Read the CSV files into a list
  oy_list_all <- lapply(          # map to a list
    oy_files,                     # for each file path...
    function(x) read.csv(         # ...read the CSV file
      file = x,                   # where x is each file path
      stringsAsFactors = FALSE,   # strings to characters, not factors
      skip = 1,                   # ignore blank first row
      header = TRUE,              # the first (non-blank) row is headers
      na.strings = ""             # replace blanks with NA
    )
  )

  # Filter for elements with conditions of a TfL Oyster history statement
  # TODO: filter for elements that have the expected column names
  oy_list_filter <- Filter(function(x) length(x) == 8, oy_list)

  # Warning that elements were removed
  if(length(oy_list_filter) < length(oy_list_all)) {
    count_removed <- length(oy_list_all) - length(oy_list_filter)
    cat(paste(count_removed, "element(s) weren't in the expected format and were discarded\n\n"))
  }

  # Bind the rows from each list element (data frame)
  oy_df <- do.call("rbind", oy_list_filter)

  # Return the object
  return(oy_df)

}
