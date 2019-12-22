#' Simple Summary Statistics of Oyster Journeys
#'
#' Generate simple summaries of your Oyster journey history data for a quick
#' overview.
#'
#' @param data Data frame output from \code{link{oy_clean()}}.
#' @param mode Currently restricted to \code{"Train"}.
#' @return A list object where each element is some kind of data summary.
#' @export
#' @examples
#' \dontrun{
#' my_df <- oy_read("path/to/folder/")
#' my_df_clean <- oy_clean(my_df)
#' oy_summary(my_df_clean, mode = "Train")
#' }

oy_summary <- function(data, mode = "Train") {

  # Mode is only train and bus for now
  if(!mode %in% c("Train", "Bus")) {
    stop(
      "The mode argument must be 'Train' or 'Bus'. You provided '", mode, "'."
    )
  }

  if (mode == "Train") {

    # Isolate mode
    trains <- data[data$mode == mode, ]

    # Total journeys by train
    count_journeys <- nrow(trains)

    # Total journey duration
    duration_total <- sum(trains$journey_duration, na.rm = TRUE)

    # Stations most frequently tapped at
    stations_popular <- as.data.frame(table(
      c(trains$station_start,trains$station_end), useNA = "no"))
    names(stations_popular)[1] <- "Station"
    names(stations_popular)[2] <- "Frequency"
    stations_popular <- stations_popular[order(-stations_popular$Frequency), ]

    # Matrix of journey start and end
    stations_matrix <- table(trains$station_start, trains$station_end, useNA = "no")

    # Stations most frequently tapped at
    day_popular <- as.data.frame(table(trains$weekday_start, useNA = "no"))
    names(day_popular)[1] <- "Day"
    names(day_popular)[2] <- "Frequency"
    day_popular <- day_popular[order(-day_popular$Frequency), ]

    # Make each summary item a list element
    summary_list <- list(
      count_journeys = count_journeys,
      stations_popular = stations_popular,
      stations_matrix = stations_matrix,
      duration_total = duration_total,
      day_popular = day_popular
    )

  } else if (mode == "Bus") {

    # Isolate mode
    bus <- data[data$mode == mode, ]

    # Total journeys by train
    count_journeys <- nrow(bus)

    # Most popular routes
    routes_popular <- as.data.frame(table(
      c(bus$station_start, bus$station_end), useNA = "no"))

    # Make each summary item a list element
    summary_list <- list(
      count_journeys = count_journeys,
      routes_popular = routes_popular
    )

  }

  # Return the list
  return(summary_list)

}

