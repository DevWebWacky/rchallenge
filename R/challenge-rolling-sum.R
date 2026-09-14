#' @keywords internal
challenge_rolling_sum <- list(
  id = "rolling_sum",
  title = "Rolling Sum Without a Loop",
  category = "Vectorisation Efficiency",
  difficulty = "Medium",

  description = paste(
    "Write a function `rolling_sum(x, k)` that returns a vector the",
    "same length as `x`, where each element is the sum of the current",
    "element and the (k-1) elements before it. Positions without",
    "enough prior elements (including when k > length(x)) should be",
    "NA. Do NOT use a for-loop. Assume `x` contains no NA values.",
    "\n\nExample: rolling_sum(c(1,2,3,4,5), 3) -> c(NA, NA, 6, 9, 12)"
  ),

  hint = paste(
    "Look into cumsum(). A rolling sum can be built from a cumulative",
    "sum: the sum of the last k elements ending at position i equals",
    "cumsum(x)[i] minus cumsum(x)[i-k]. Think about how to shift the",
    "cumulative sum vector by k positions using plain vector slicing."
  ),

  explanation = paste(
    "Idiomatic solution (Base R only, no extra packages needed):\n",
    "  cs <- cumsum(x)\n",
    "  n <- length(x)\n",
    "  pad_cs <- c(numeric(min(k, n)), cs[seq_len(max(0, n - k))])\n",
    "  result <- cs - pad_cs\n",
    "  result[seq_len(min(k - 1, n))] <- NA\n",
    "  result\n\n",
    "This is O(n) instead of the naive O(n*k) approach of summing a",
    "window at every position, cumsum computes the running total",
    "once, then rolling sums become simple subtraction. (If you have",
    "dplyr loaded, dplyr::lag(cs, k, default = 0) does the same shift",
    ", but the version above needs no packages at all.)"
  ),

  test_cases = list(
    list(input = list(c(1,2,3,4,5), 3),   expected = c(NA,NA,6,9,12)),
    list(input = list(c(1,2,3,4,5), 1),   expected = c(1,2,3,4,5)),
    list(input = list(c(1,2,3), 5),       expected = c(NA_real_,NA_real_,NA_real_)),
    list(input = list(c(10,20,30,40), 2), expected = c(NA,30,50,70)),
    list(input = list(c(5), 1),           expected = c(5))
  )
)
