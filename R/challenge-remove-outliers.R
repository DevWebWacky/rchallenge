#' @keywords internal
challenge_remove_outliers <- list(
  id = "remove_outliers",
  title = "Filter and Clean Outliers (IQR Method)",
  category = "Base R Optimisation",
  difficulty = "Easy/Medium",

  description = paste(
    "Write a function `remove_outliers(x)` that takes a numeric vector",
    "`x` and returns a vector with all values outside 1.5 * IQR",
    "removed, where IQR = Q3 - Q1 (the interquartile range). Assume",
    "the input vector `x` contains no NA values.",
    "\n\nUse quantile() with type = 7 (R's default method) to compute",
    "Q1 and Q3, so results are consistent regardless of dataset size.",
    "\n\nExample: x <- c(10, 12, 11, 14, 13, 100)",
    "remove_outliers(x) -> c(10, 12, 11, 14, 13)"
  ),

  hint = paste(
    "quantile(x, 0.25, type = 7) and quantile(x, 0.75, type = 7) give",
    "you Q1 and Q3. Compute the IQR, then build the lower and upper",
    "bounds (Q1 - 1.5*IQR and Q3 + 1.5*IQR), and use boolean",
    "subsetting to keep only values within those bounds."
  ),

  explanation = paste(
    "Idiomatic solution:\n",
    "  q1 <- quantile(x, 0.25, type = 7)\n",
    "  q3 <- quantile(x, 0.75, type = 7)\n",
    "  iqr <- q3 - q1\n",
    "  lower <- q1 - 1.5 * iqr\n",
    "  upper <- q3 + 1.5 * iqr\n",
    "  x[x >= lower & x <= upper]\n\n",
    "type = 7 is specified explicitly because quantile() supports",
    "several different calculation methods (type 1 through 9) that",
    "can give slightly different Q1/Q3 values, especially on small",
    "vectors, pinning the type keeps results consistent and",
    "reproducible."
  ),

  test_cases = list(
    list(
      input = list(c(10, 12, 11, 14, 13, 100)),
      expected = c(10, 12, 11, 14, 13)
    ),
    list(
      input = list(c(1, 2, 3, 4, 5)),
      expected = c(1, 2, 3, 4, 5)
    ),
    list(
      input = list(c(5, 5, 5, 5, 5)),
      expected = c(5, 5, 5, 5, 5)
    ),
    list(
      input = list(c(-100, 1, 2, 3, 4, 5)),
      expected = c(1, 2, 3, 4, 5)
    )
  )
)
