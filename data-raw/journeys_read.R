## code to prepare `journeys_read` dataset goes here

journeys_read <- oy_read("inst/extdata/")

usethis::use_data(journeys_read, overwrite = TRUE)
