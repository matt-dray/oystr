context("test-plot")

test_that("an invalid data object results in an error", {
  expect_identical(class(oy_lineplot(journeys_clean)), "NULL")
  expect_identical(
    class(oy_lineplot(journeys_clean, weekdays = TRUE)), "NULL"
  )
  expect_error(oy_lineplot(data = 1234))
  expect_error(oy_lineplot(data = "a string"))
  expect_error(oy_lineplot(data = not_an_object))
  expect_error(oy_lineplot(data = FALSE))
})

test_that("an invalid y_var argument causes an error", {
  expect_error(oy_lineplot(journeys_clean, x_var = "invalid"))
})

test_that("an invalid y_var argument causes an error", {
  expect_error(oy_lineplot(journeys_clean, y_var = "invalid"))
})

test_that("an invalid weekdays argument causes an error", {
  expect_error(oy_lineplot(journeys_clean, weekdays = "invalid"))
})

test_that("an invalid mode argument causes an error", {
  expect_error(oy_lineplot(journeys_clean, mode = "Hovercraft"))
})
