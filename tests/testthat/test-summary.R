context("test-summary")

test_that("input data object returns expected ouput", {
  expect_identical(class(oy_summary(journeys_clean)), "list")
  expect_error(oy_summary(data = 1234))
  expect_error(oy_summary(data = "a string"))
  expect_error(oy_summary(data = not_an_object))
  expect_error(oy_summary(data = FALSE))
})

test_that("input mode argument returns expcted output", {
  expect_error(oy_summary(journeys_clean, mode = "Hovercraft"))
  expect_identical(
    class(oy_summary(journeys_clean, mode = "Train")),
    "list"
  )
  expect_identical(
    class(oy_summary(journeys_clean, mode = "Bus")),
    "list"
  )
})
