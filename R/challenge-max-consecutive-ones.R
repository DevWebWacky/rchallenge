#' @keywords internal
challenge_max_consecutive_ones <- list(
  id = "max_consecutive_ones",
  title = "Run-Length Encoding for Consecutive Hits",
  category = "Base R Optimisation",
  difficulty = "Medium/Hard",

  description = paste(
    "Write a function `max_consecutive_ones(x)` that takes a vector",
    "`x` (either numeric 0/1 or logical TRUE/FALSE) and returns the",
    "length of the longest run of consecutive 1s (or TRUEs) as a",
    "single integer. Return 0 if there are no 1s/TRUEs at all, or if",
    "the input is empty.",
    "\n\nExample: max_consecutive_ones(c(1,1,0,1,1,1,0,1)) -> 3"
  ),

  hint = paste(
    "R's built-in rle() function (run-length encoding) compresses a",
    "vector into runs of consecutive equal values, giving you the",
    "length of each run and the value it repeats. Once you have that,",
    "you just need the longest run where the value is TRUE/1."
  ),

  explanation = paste(
    "Idiomatic solution:\n",
    "  x <- as.logical(x)\n",
    "  if (length(x) == 0) return(0L)\n",
    "  runs <- rle(x)\n",
    "  ones_lengths <- runs$lengths[runs$values]\n",
    "  if (length(ones_lengths) == 0) return(0L)\n",
    "  max(ones_lengths)\n\n",
    "rle() (run-length encoding) is a Base R function most people",
    "never discover, it compresses a vector like c(1,1,0,1,1,1) into",
    "'lengths' (2,1,3) and 'values' (1,0,1), i.e. how long each",
    "unbroken run is. This turns a problem that looks like it needs a",
    "loop with a running counter into a couple of vectorised",
    "operations."
  ),

  test_cases = list(
    list(input = list(c(1,1,0,1,1,1,0,1)), expected = 3L),
    list(input = list(c(TRUE,TRUE,FALSE,TRUE)), expected = 2L),
    list(input = list(c(0,0,0)), expected = 0L),
    list(input = list(c(1,1,1,1)), expected = 4L),
    list(input = list(c(1,0,1,0,1)), expected = 1L),
    list(input = list(integer(0)), expected = 0L)
  )
)
