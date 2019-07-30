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

  # Read and bind the outputs to data frame
  oy_df <- do.call(
    "rbind",                        # bind the rows of the output
    lapply(                         # map to a list
      oy_files,                     # for each file path...
      function(x) read.csv(         # ...read the CSV file
        file = x,                   # where x is each file path
        stringsAsFactors = FALSE,   # strings to characters, not factors
        skip = 1,                   # ignore blank first row
        header = TRUE,              # the first (non-blank) row is headers
        na.strings = c("", "<NA>")  # replace blanks with NA
      )
    )
  )

  return(oy_df)

}
