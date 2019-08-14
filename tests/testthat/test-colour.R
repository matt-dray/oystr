context("test-colour")

test_that("valid numeric input vector returns vector", {
  expect_identical(class(oy_cols(1)), "character")
  expect_identical(class(oy_cols(1, 2)), "character")
})

test_that("valid character input vector returns vector", {
  expect_identical(class(oy_cols("line_circle")), "character")
  expect_identical(class(oy_cols("line_circle", "line_victoria")), "character")
})

# test_that("valid mixed input vector returns vector", {
#   # TODO: mixed input (numeric and character) should yield result
#   # expect_identical(class(oy_cols("1", "line_victoria")), "character")
# })

test_that("non-vector input returns error", {
  test_list <- list(x = 1:3, y = 1:3)
  expect_error(oy_cols(test_list))
  test_df <- data.frame(x = 1:3, y = 1:3)
  expect_error(oy_cols(test_df))
  # TODO: multidimensional arrays and matrices should fail
})

test_that("invalid indices fail", {
  expect_error(oy_cols(length(oy_cols()) + 1))
  expect_error(oy_cols(999))
  # TODO: negative values should cause an error
})

test_that("invalid names fail", {
  expect_identical(class(oy_cols("line_circle")), "character")
  expect_identical(class(oy_cols("line_circle", "line_victoria")), "character")
  expect_identical(class(oy_cols(c("line_circle", "line_victoria"))), "character")
})
