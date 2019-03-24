context("test-colour")
library(oystr)

test_that("colour output is a named character vector", {
  a <- oystr::oy_cols()
  expect_equal(class(a), "character")
  expect_equal(length(a), 3)
})

