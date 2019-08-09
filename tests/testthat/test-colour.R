context("test-colour")

test_that("colour output is a named character vector", {
  a <- oystr::oy_cols()
  expect_equal(class(a), "character")
})

