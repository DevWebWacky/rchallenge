test_that("rg_check_equal handles simple numeric equality", {
  expect_true(isTRUE(rg_check_equal(12, 12)))
  expect_false(isTRUE(rg_check_equal(12, 13)))
})

test_that("rg_check_equal respects tolerance for numeric comparisons", {
  # relative difference 0.002 -> well within 0.05 tolerance
  expect_true(isTRUE(rg_check_equal(10.02, 10, tolerance = 0.05)))
  # relative difference 0.5 -> well beyond 0.05 tolerance
  expect_false(isTRUE(rg_check_equal(15, 10, tolerance = 0.05)))
})

test_that("rg_check_equal ignores row order in data frames by default", {
  a <- data.frame(group = c("b", "a"), avg = c(20, 15))
  b <- data.frame(group = c("a", "b"), avg = c(15, 20))
  expect_true(isTRUE(rg_check_equal(a, b)))
})

test_that("rg_check_equal catches column name mismatches", {
  a <- data.frame(group = "a", mean_value = 15)
  b <- data.frame(group = "a", avg = 15)
  result <- rg_check_equal(a, b)
  expect_type(result, "character")
  expect_match(result, "Column names don't match")
})

test_that("rg_check_equal treats tibbles and data.frames as equal", {
  skip_if_not_installed("tibble")
  a <- tibble::tibble(group = "a", avg = 15)
  b <- data.frame(group = "a", avg = 15)
  expect_true(isTRUE(rg_check_equal(a, b)))
})

test_that("rg_check_equal catches genuine value mismatches in data frames", {
  a <- data.frame(group = "a", avg = 99)
  b <- data.frame(group = "a", avg = 15)
  result <- rg_check_equal(a, b)
  expect_type(result, "character")
})
