# Run an rchallenge puzzle against your own solution

Tests a user-submitted function against a challenge's test cases,
printing styled pass/fail feedback to the console. On a full pass, shows
an explanation of the idiomatic solution and updates your local solving
streak. On any failure, shows details for the failed tests and a hint.

## Usage

``` r
run_challenge(challenge_id, user_fun)
```

## Arguments

- challenge_id:

  Character. The id of the challenge to run. See
  [`list_challenges()`](https://devwebwacky.github.io/rchallenge/reference/list_challenges.md)
  for all available ids.

- user_fun:

  Function. Your own solution to test — written and defined in your own
  R session, then passed in directly.

## Value

Invisibly, a list with `passed` (number of test cases passed) and
`total` (total number of test cases).

## Examples

``` r
if (FALSE) { # \dontrun{
my_solution <- function(x) sum(x[x %% 2 == 0], na.rm = TRUE)
run_challenge("sum_evens", my_solution)
} # }
```
