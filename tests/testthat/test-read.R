context("test-read")

test_that("output is a data frame with specific columns", {
  data <- oy_read("../testdata/valid")
  columns <- c("Date", "Start.Time", "End.Time", "Journey.Action", "Charge",
               "Credit", "Balance", "Note")
  expect_identical(class(data), "data.frame")
  expect_identical(typeof(data), "list")
  expect_length(data, 8)
  expect_identical(names(data), columns)
})

test_that("an invalid input path results in an error", {
  expect_error(oy_read(1234))
  expect_error(oy_read("not a valid filepath"))
  expect_error(oy_read(bare_string))
  expect_error(oy_read(FALSE))
})

test_that("reading from a folder with an invalid CSV results in a warning", {
  expect_warning(oy_read("../testdata/invalid"))
  expect_warning(oy_read("../testdata/invalid_multi"))
  expect_error(oy_read("../testdata/invalid_empty"))
})
