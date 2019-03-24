#' Read Oyster-history CSV files from a folder
#'
#' @param path A string describing a filepath to a folder of CSVs
#' @return A dataframe object.
#' @export
oy_read <- function(path) {

  oy_files <- list.files(
    path = path,
    pattern = "*.csv",
    full.names = TRUE
  )

  oy_df <- do.call(
    "rbind",
    lapply(
      oy_files,
      function(x) read.csv(
        file = x,
        stringsAsFactors = FALSE,
        skip = 1,
        header = TRUE,
        na.strings = ""
      )
    )
  )

  return(oy_df)

}
