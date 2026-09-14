#' Compare actual vs expected output for grading, ignoring superficial
#' differences (class, row order, attributes) while enforcing real ones
#' (column names, values).
#'
#' @param actual The user's function output.
#' @param expected The correct/reference output.
#' @param ignore_row_order Logical. If TRUE (default), rows can be in
#'   any order. Set FALSE for problems where order is part of the answer.
#'
#' @return TRUE if equal under our grading rules, otherwise a character
#'   string explaining what didn't match (so it can be shown in feedback).
#' @keywords internal
rc_check_equal <- function(actual, expected, ignore_row_order = TRUE) {

  #Case 1: both are data.frame-like (covers tibble, data.frame, etc)
  if (is.data.frame(actual) && is.data.frame(expected)) {

    actual_df   <- as.data.frame(actual)
    expected_df <- as.data.frame(expected)

    if (!setequal(names(actual_df), names(expected_df))) {
      return(sprintf(
        "Column names don't match. Expected: %s | Got: %s",
        paste(names(expected_df), collapse = ", "),
        paste(names(actual_df), collapse = ", ")
      ))
    }

    actual_df <- actual_df[, names(expected_df), drop = FALSE]

    if (ignore_row_order) {
      sort_df <- function(df) {
        if (nrow(df) == 0) return(df)
        ord <- do.call(order, as.list(df))
        df[ord, , drop = FALSE]
      }
      actual_df   <- sort_df(actual_df)
      expected_df <- sort_df(expected_df)
    }

    rownames(actual_df) <- NULL
    rownames(expected_df) <- NULL

    result <- isTRUE(all.equal(actual_df, expected_df, check.attributes = FALSE))

    if (!result) {
      return("Data frame values don't match expected output.")
    }
    return(TRUE)
  }

  # Case 2: everything else (vectors, numbers, lists)
  result <- isTRUE(all.equal(actual, expected, check.attributes = FALSE))
  if (!result) {
    return(sprintf(
      "Expected %s, got %s",
      paste(deparse(expected), collapse = " "),
      paste(deparse(actual), collapse = " ")
    ))
  }
  return(TRUE)
}

#' @param tolerance Numeric or NULL. If provided, numeric comparisons
#'   allow differences up to this tolerance instead of requiring exact
#'   equality. Useful for challenges involving randomness (e.g. bootstrap).
#'   Ignored for data frame column-name checks.
rc_check_equal <- function(actual, expected, ignore_row_order = TRUE, tolerance = NULL) {

  # helper so we don't repeat the tolerance-vs-exact logic in two branches
  values_equal <- function(a, b) {
    if (is.null(tolerance)) {
      isTRUE(all.equal(a, b, check.attributes = FALSE))
    } else {
      isTRUE(all.equal(a, b, check.attributes = FALSE, tolerance = tolerance))
    }
  }

  if (is.data.frame(actual) && is.data.frame(expected)) {
    actual_df   <- as.data.frame(actual)
    expected_df <- as.data.frame(expected)

    if (!setequal(names(actual_df), names(expected_df))) {
      return(sprintf(
        "Column names don't match. Expected: %s | Got: %s",
        paste(names(expected_df), collapse = ", "),
        paste(names(actual_df), collapse = ", ")
      ))
    }

    actual_df <- actual_df[, names(expected_df), drop = FALSE]

    if (ignore_row_order) {
      sort_df <- function(df) {
        if (nrow(df) == 0) return(df)
        ord <- do.call(order, as.list(df))
        df[ord, , drop = FALSE]
      }
      actual_df   <- sort_df(actual_df)
      expected_df <- sort_df(expected_df)
    }

    rownames(actual_df) <- NULL
    rownames(expected_df) <- NULL

    if (!values_equal(actual_df, expected_df)) {
      return("Data frame values don't match expected output.")
    }
    return(TRUE)
  }

  if (!values_equal(actual, expected)) {
    return(sprintf(
      "Expected %s, got %s",
      paste(deparse(expected), collapse = " "),
      paste(deparse(actual), collapse = " ")
    ))
  }
  return(TRUE)
}
