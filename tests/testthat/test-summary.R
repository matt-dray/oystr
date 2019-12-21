context("test-summary")

test_that("an invalid data object results in an error", {
  expect_error(oy_summary(data = 1234))
  expect_error(oy_summary(data = "a string"))
  expect_error(oy_summary(data = not_an_object))
  expect_error(oy_summary(data = FALSE))
})

test_that("a valid object outputs a list", {
  expect_identical(class(oy_summary(journeys_clean)), "list")
})

test_that("an invalid mode argument causes an error", {
  expect_error(oy_summary(journeys_clean, mode = "Hovercraft"))
})
