#' @keywords internal
challenge_first_duplicate <- list(
  id = "first_duplicate",
  title = "Find First Duplicate",
  category = "Base R Optimisation",
  difficulty = "Easy/Medium",

  description = paste(
    "Write a function `first_duplicate(x)` that returns the first",
    "value in `x` (scanning left to right) that has appeared before,",
    "or NA if there are no duplicates. Assume `x` is an atomic vector",
    "(numeric, character, or logical, not a list or data frame). If",
    "x contains NA and an NA appears more than once, treat NA itself",
    "as a duplicate value.",
    "\n\nExample: first_duplicate(c(1,2,3,2,4)) -> 2"
  ),

  hint = paste(
    "x[duplicated(x)] gives you every element that's a repeat of an",
    "earlier one, in order of occurrence. Think about what indexing",
    "the very first element of that gives you, and what it gives you",
    "when there are no duplicates at all."
  ),

  explanation = paste(
    "Idiomatic solution: x[duplicated(x)][1]\n",
    "duplicated(x) flags TRUE from an element's second occurrence",
    "onward. Subsetting x by that mask gives just the repeated values",
    "in order, and [1] grabs the first one. If there are no",
    "duplicates, x[duplicated(x)] is an empty vector of the correct",
    "type, and indexing position [1] of an empty vector naturally",
    "returns NA of the matching type, no if/else needed."
  ),

  test_cases = list(
    list(input = list(c(1,2,3,2,4)),           expected = 2),
    list(input = list(c(1,2,3)),                expected = NA_real_),
    list(input = list(c("a","b","a","c")),      expected = "a"),
    list(input = list(c(1, NA, 3, NA)),         expected = NA_real_),
    list(input = list(character(0)),            expected = NA_character_)
  )
)
