# Compare actual vs expected output for grading, ignoring superficial differences (class, row order, attributes) while enforcing real ones (column names, values).

Compare actual vs expected output for grading, ignoring superficial
differences (class, row order, attributes) while enforcing real ones
(column names, values).

## Usage

``` r
rc_check_equal(actual, expected, ignore_row_order = TRUE, tolerance = NULL)

rc_check_equal(actual, expected, ignore_row_order = TRUE, tolerance = NULL)
```

## Arguments

- actual:

  The user's function output.

- expected:

  The correct/reference output.

- ignore_row_order:

  Logical. If TRUE (default), rows can be in any order. Set FALSE for
  problems where order is part of the answer.

- tolerance:

  Numeric or NULL. If provided, numeric comparisons allow differences up
  to this tolerance instead of requiring exact equality. Useful for
  challenges involving randomness (e.g. bootstrap). Ignored for data
  frame column-name checks.

## Value

TRUE if equal under our grading rules, otherwise a character string
explaining what didn't match (so it can be shown in feedback).
