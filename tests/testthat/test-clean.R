context("test-clean")

test_that("valid input returns a data.frame", {
  expect_identical(class(oy_clean(journeys_read)), "data.frame")
})

test_that("invalid input causes an error", {
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
