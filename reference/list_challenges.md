# List all available challenge ids

Returns the ids of every challenge currently registered in the package.
Use an id with
[`run_challenge()`](https://devwebwacky.github.io/rgrind/reference/run_challenge.md)
to attempt that challenge.

## Usage

``` r
list_challenges()
```

## Value

A character vector of challenge ids.

## Examples

``` r
list_challenges()
#>  [1] "avg_above"            "bootstrap_ci"         "count_missing"       
#>  [4] "count_na"             "first_duplicate"      "max_consecutive_ones"
#>  [7] "pivot_long_scores"    "remove_outliers"      "rolling_sum"         
#> [10] "sum_evens"           
```
