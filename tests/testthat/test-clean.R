context("test-clean")

test_that("input data returns expected output", {
  expect_identical(class(oy_clean(journeys_read)), "data.frame")
  test_list <- list(x = 1:3, y = 1:3)
  expect_error(oy_clean())
  expect_error(oy_clean(NA))
  expect_error(oy_clean(NULL))
  expect_error(oy_clean(1))
  expect_error(oy_clean("string"))
  expect_error(oy_clean(c(1, 3, 5)))
  expect_error(oy_clean(c(1, "string")))
  expect_error(oy_clean(bare_string))
  expect_error(oy_clean(test_list))
})

test_that("invalid names produces error", {
  invalid_names <- read.csv("../testdata/invalid_names/invalid_names.csv")
  expect_error(oy_clean(invalid_names))
})
