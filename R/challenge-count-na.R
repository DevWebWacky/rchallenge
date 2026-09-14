#' @keywords internal
challenge_count_na <- list(
  id = "count_na",
  title = "Count Missing Values",
  category = "Base R Optimisation",
  difficulty = "Easy",

  description = paste(
    "Write a function `count_na(x)` that takes a vector `x` (of any",
    "atomic type, numeric, character, or logical) and returns the",
    "number of NA values in it, as a single integer.",
    "\n\nExample: count_na(c(1, NA, 3, NA, 5)) -> 2"
  ),

  hint = paste(
    "is.na(x) gives a logical vector marking which elements are NA.",
    "You can sum() a logical vector directly, TRUE counts as 1,",
    "FALSE as 0."
  ),

  explanation = paste(
    "Idiomatic solution: sum(is.na(x))\n",
    "This is the simplest possible vectorised pattern in R: is.na()",
    "builds a logical mask, and summing a logical vector counts the",
    "TRUEs. This exact pattern (mask + sum) is the foundation you'll",
    "reuse constantly, it's the same idea behind sum_evens, just",
    "applied to a different condition."
  ),

  test_cases = list(
    list(input = list(c(1, NA, 3, NA, 5)), expected = 2),
    list(input = list(c("a", "b", "c")),    expected = 0),
    list(input = list(c(NA, NA, NA)),       expected = 3),
    list(input = list(numeric(0)),          expected = 0),
    list(input = list(c(TRUE, NA, FALSE)),  expected = 1)
  )
)
