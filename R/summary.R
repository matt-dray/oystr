# train only
# list where each element is some kind of summary (inc plots)
# break down by week/month/year?

oy_summary <- function(data, mode = "Train") {

  if (mode == "Train") {

  # Isolate mode
  trains <- data[data$mode == mode, ]

  # The generic data.frame summary
  train_summary <- summary(trains)

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
    train_summary = train_summary,
    stations_popular = stations_popular,
    stations_matrix = stations_matrix,
    duration_total = duration_total,
    day_popular = day_popular
  )

  } else if (mode == "Bus") {

    # Isolate mode
    bus <- data[data$mode == mode, ]

    # The generic data.frame summary
    bus_summary <- summary(bus)

    # Most popular routes
    routes_popular <- as.data.frame(table(
      c(trains$station_start,trains$station_end), useNA = "no"))

  }

  # Return the list
  return(summary_list)

}
