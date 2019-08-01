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

  if (is.null(cols))
    return (oyster_colours)

  oyster_colours[cols]

}
