#' @keywords internal
challenge_count_missing <- list(
  id = "count_missing",
  title = "Count Missing Values per Column",
  category = "Base R Optimisation",
  difficulty = "Easy",

  description = paste(
    "Write a function `count_missing(df)` that takes a data frame and",
    "returns a named integer vector containing the count of NA values",
    "in each column, with names matching the original column names.",
    "\n\nA data frame with zero rows should return an all-zero named",
    "vector. A column where every value is NA should return the total",
    "row count for that column.",
    "\n\nExample: df <- data.frame(a = c(1, NA, 3), b = c('x','y','z'))",
    "count_missing(df) -> c(a = 1, b = 0)"
  ),

  hint = paste(
    "is.na(df) applied to a whole data frame returns a logical matrix",
    "the same shape as df. Think about which function sums each",
    "column of a matrix at once, without needing sapply or a loop."
  ),

  explanation = paste(
    "Idiomatic solution: colSums(is.na(df))\n",
    "is.na(df) turns the whole data frame into a logical matrix (TRUE",
    "where a value is NA). colSums() then sums down each column in",
    "one vectorised operation, faster and cleaner than sapply() or",
    "looping over columns manually. This also naturally handles a",
    "zero-row data frame correctly, since colSums() of an empty",
    "logical matrix is just 0 for every column."
  ),

  test_cases = list(
    list(
      input = list(data.frame(a = c(1, NA, 3), b = c("x","y","z"), c = c(NA, NA, 1))),
      expected = c(a = 1L, b = 0L, c = 2L)
    ),
    list(
      input = list(data.frame(a = numeric(0), b = character(0))),
      expected = c(a = 0L, b = 0L)
    ),
    list(
      input = list(data.frame(a = c(NA, NA, NA))),
      expected = c(a = 3L)
    ),
    list(
      input = list(data.frame(a = c(1,2,3), b = c(4,5,6))),
      expected = c(a = 0L, b = 0L)
    )
  )
)
