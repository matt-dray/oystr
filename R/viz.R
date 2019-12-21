#' Transport for London Colours
#'
#' @description A named vector of hexadecimal colour values from Transport for London's
#'     \href{http://content.tfl.gov.uk/tfl-colour-standards-issue04.pdf}{colour standard}.
#'     Includes corporate, mode-specific and safety colours, as well as London
#'     Underground line colours.
#' @param ... Provide either the names or indices of colours in the vector (see details).
#' @details An empty call returns the whole vector. The colour names are as follows:
#'    \itemize{
#'        \item corporate: corporate_blue, corporate_red, corporate_grey, corporate_dark_grey,
#'            corporate_yellow, corporate_green, corporate_black, corporate_white
#'        \item mode-specific: transport_for_london, line_elizabeth, london_overground,
#'            emirates_air_line, santander_cycles, london_river_services, london_underground,
#'            london_buses, london_dial_a_ride, taxi_private_hire, visitor_centre,
#'            london_coaches, docklands_light_railway, tfl_rail
#'        \item safety: safety_blue, corporate_red, corporate_yellow, corporate_green
#'    \item London Underground lines: line_bakerloo, line_hammersmith_city, line_piccadilly, line_central,
#'        line_jubilee, line_victoria, line_circle, line_metropolitan, line_waterloo_city,
#'        line_district, line_northern
#'    \item other logos and identities: oyster_blue, oyster_cyan, legible_london_blue,
#'        legible_london_yellow
#'    }
#' @return A named vector object.
#' @export
#' @examples
#' oy_cols()  # prints the vector
#' oy_cols("oyster_blue", "oyster_cyan")  # prints
#' oy_cols(1:5)  # provide indices

oy_cols <- function(...) {

  cols <- c(...)

  oyster_colours <- c(

    corporate_blue = "#0019A8",
    corporate_red = "#DC241F",
    corporate_grey = "#868F98",
    corporate_dark_grey = "#414B56",
    corporate_yellow = "#FFCE00",
    corporate_green = "#007229",
    corporate_black = "#000000",
    corporate_white = "#FFFFFF",

    transport_for_london = "#0019A8",
    line_elizabeth = "#9364CC",
    london_overground = "#EF7B10",
    london_trams = "#00BD19",
    emirates_air_line = "#DC241F",
    santander_cycles = "#DC241F",
    london_river_services = "#00A0E2",
    london_underground = "#0019A8",
    london_buses = "#DC241F",
    london_dial_a_ride = "#B727BF",
    taxi_private_hire = "#8480D7",
    visitor_centre = "#DC006B",
    london_coaches = "#F1AB00",
    docklands_light_railway = "#00AFAD",
    tfl_rail = "#0019A8",

    safety_blue = "#0060A8",

    line_bakerloo = "#B26300",
    line_hammersmith_city = "#F4A9BE",
    line_piccadilly = "#0019A8",
    line_central = "#DC241F",
    line_jubilee = "#A1A5A7",
    line_victoria = "#0098D8",
    line_circle = "#FFD329",
    line_metropolitan = "#9B0058",
    line_waterloo_city = "#93CEBA",
    line_district = "#007D32",
    line_northern = "#000000",

    oyster_blue = "#001df2",
    oyster_cyan = "#00f2f2",
    legible_london_blue = "061a30",
    legible_london_yellow = "#f0bb00"
  )

  if (is.null(cols)) {
    return (oyster_colours)
  }

  if (any(is.na(cols))) {
    stop("Please provide colour names or indices only.")
  }

  if (is.numeric(cols) & max(cols) > length(oyster_colours)) {
    stop(
      "You've provided an index that's out of range.\n",
      "Choose only values between 1 and ", length(oy_cols()), "."
    )
  }

  if (is.character(cols) & !all(cols %in% names(oyster_colours))) {
    stop(
      "You've provided an invalid colour name.\n",
      "See ?oy_cols for details or print colour names with names(oy_cols())."
    )
  }

  if (!is.null(cols)) {
    return(oyster_colours[cols])
  }

}

#' Line Plots of Oyster Journey Data
#'
#' @description Outputs a simple time series line plots of Oyster journey data.
#' @param data Data frame output from \code{oy_clean()}.
#' @param x_var The name of the variable from \code{data} that you want on the x axis
#' @param y_var The name of the continuous variable frm \code{data} for the y
#'     axis. Choose \code{"journey_duration"} or \code{"balance"}.
#' @param weekdays Logical. Restrict the output to Monday to Friday with
#'     \code{True}
#' @param mode Currently restricted to "Train".
#' @return A data.frame object.
#' @export

oy_lineplot <- function(
  data,
  x_var = "datetime_start",
  y_var = "journey_duration",
  weekdays = FALSE,
  mode = "Train"
) {

  # Stop if data not a data.frame
  if(!class(data) %in% c("data.frame", "tbl_df", "tbl")) {
    stop(
      "The data object should be of class 'data.frame'. You provided an object of class '", class(data), "'."
    )
  }

  # Stop if bad x_var (only tone options for now)
  if(x_var != "datetime_start") {
    stop(
      "For now, the x_var argument must be 'datetime_start'. You provided '", y_var, "'."
    )
  }

  # Stop if bad y_var (only two options for now)
  if(!y_var %in% c("journey_duration", "balance")) {
    stop(
      "For now, the y_var argument must be 'journey_duration' or 'balance'. You provided '", y_var, "'."
    )
  }

  # Stop if bad weekdays
  if(!weekdays %in% c(TRUE, FALSE)) {
    stop(
      "The weekdays argument must be TRUE or FALSE. You provided '", y_var, "'."
    )
  }

  # Stop if bad mode (only train for now)
  if(mode != "Train") {
    stop(
      "For now, the mode argument must be 'Train'. You provided '", mode, "'."
    )
  }

  # Wrangle
  df <- data[data$mode == mode, c(x_var, y_var)]  # train only
  df <- df[complete.cases(df), ]  # no rows with NA in x or y

  if (weekdays == TRUE) {
    df[df$weekday_start %in% c("Saturday, Sunday"), ] <- NA_character_
  }

  # Plot
  plot(
    x = df[, x_var],
    y = df[, y_var],
    type = "l",
    las = 1,
    xlab = "Date-time start",
    ylab = ifelse(y_var == "journey_duration", "Duration (minutes)",
                  ifelse(y_var == "credit", "Credit (£)",
                         ifelse(y_var == "balance", "Balance (£)", "ERROR"
                         )
                  )
    )
  )

  mytitle = paste(mode, "journeys")
  mysubtitle = ifelse(weekdays == TRUE, "Weekdays only", "All days of the week")
  mtext(side = 3, line = 2, adj = 0, cex = 1.2, mytitle)
  mtext(side = 3, line = 1, adj = 0, cex = 1, mysubtitle)

}
