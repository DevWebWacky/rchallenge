#' @keywords internal
challenge_sum_evens <- list(
  id = "sum_evens",
  title = "Sum of Even Numbers",
  category = "Base R Optimisation",
  difficulty = "Easy",

  description = paste(
    "Write a function `sum_evens(x)` that takes a numeric vector `x`",
    "and returns the sum of all even numbers in it.",
    "Do it WITHOUT using a for-loop.",
    "\n\nNote: if `x` contains NA values, they should be ignored",
    "(treated as if they weren't there)."
  ),

  hint = paste(
    "Think vectorised: `x %% 2 == 0` gives you a logical vector of",
    "which elements are even. You can use that directly to subset `x`.",
    "Don't forget to handle NA values with na.rm = TRUE in sum()."
  ),

  explanation = paste(
    "Idiomatic solution: sum(x[x %% 2 == 0], na.rm = TRUE)\n",
    "This avoids a for-loop entirely by using R's vectorised modulo",
    "operator to build a logical mask, then subsetting. This is",
    "roughly 50-100x faster than a for-loop for large vectors because",
    "R's C-level vectorised operations avoid per-element interpreter",
    "overhead."
  ),

  # The test cases: each one is a list of inputs plus the expected output.
  # We keep these as plain data (not testthat calls yet) so run_challenge()
  # can loop over them generically for ANY challenge.
  test_cases = list(
    list(input = list(c(1, 2, 3, 4, 5, 6)), expected = 12),
    list(input = list(c(1, 3, 5, 7)),        expected = 0),
    list(input = list(c(2, 4, 6, 8)),        expected = 20),
    list(input = list(numeric(0)),           expected = 0),
    list(input = list(c(-2, -4, 1, 3)),      expected = -6),
    list(input = list(c(0, 1, 3)),           expected = 0),
    list(input = list(c(1, 2, NA, 4)),       expected = 6)
  )
)
