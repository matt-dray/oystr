context("test-read")

test_that("an invalid path results in an error", {
  expect_error(oy_read(1234))
  expect_error(oy_read("not a valid filepath"))
  expect_error(oy_read(bare_string))
})

test_that("an empty folder results in a error", {
  expect_error(oy_read("../testdata/empty"))
})

test_that("an invalid CSV results in a warning", {
  expect_warning(oy_read("../testdata/invalid"))
})

test_that("output is a data frame with specific columns", {
  data <- oy_read("../testdata/valid")
  columns <- c("Date", "Start.Time", "End.Time", "Journey.Action", "Charge",
               "Credit", "Balance", "Note")
  expect_identical(class(data), "data.frame")
  expect_identical(typeof(data), "list")
  expect_length(data, 8)
  expect_identical(names(data), columns)
})
