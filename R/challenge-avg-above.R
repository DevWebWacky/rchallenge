#' @keywords internal
challenge_avg_above <- list(
  id = "avg_above",
  title = "Group-wise Average Above Threshold",
  category = "Tidyverse Wrangling",
  difficulty = "Medium",

  description = paste(
    "Given a data frame `df` with columns `group` and `value`, write a",
    "function `avg_above(df, threshold)` that returns a data frame",
    "containing only the groups whose AVERAGE value exceeds `threshold`.",
    "\n\nThe output must have exactly two columns, named `group` and `avg`.",
    "If no group's average exceeds the threshold, return a data frame",
    "with zero rows but still with the `group` and `avg` columns.",
    "\n\nIf a group contains NA values, ignore them when computing the average."
  ),

  hint = paste(
    "You'll need group_by() + summarise() to collapse to one row per",
    "group, THEN filter() on the summarised average, filtering",
    "individual rows before summarising will NOT give you group averages.",
    "Don't forget na.rm = TRUE inside mean()."
  ),

  explanation = paste(
    "Idiomatic solution:\n",
    "  df |>\n",
    "    dplyr::group_by(group) |>\n",
    "    dplyr::summarise(avg = mean(value, na.rm = TRUE), .groups = 'drop') |>\n",
    "    dplyr::filter(avg > threshold)\n\n",
    "Common mistake: filtering `value > threshold` BEFORE grouping,",
    "that filters individual rows, not group averages, giving wrong",
    "results silently (no error, just wrong numbers)."
  ),

  test_cases = list(
    # Standard case
    list(
      input = list(
        data.frame(group = c("a","a","b","b"), value = c(10,20,1,2)),
        5
      ),
      expected = data.frame(group = "a", avg = 15)
    ),
    # Multiple groups pass
    list(
      input = list(
        data.frame(group = c("x","x","y","y","z"), value = c(10,10,20,20,5)),
        8
      ),
      expected = data.frame(group = c("x","y"), avg = c(10,20))
    ),
    # No groups pass -> zero-row result with correct columns
    list(
      input = list(
        data.frame(group = c("a","a","b","b"), value = c(10,20,1,2)),
        100
      ),
      expected = data.frame(group = character(0), avg = numeric(0))
    ),
    # The "trap": catches row-filter-before-group mistake
    list(
      input = list(
        data.frame(group = c("a","a"), value = c(10,20)),
        16
      ),
      expected = data.frame(group = character(0), avg = numeric(0))
    ),
    # NA handling
    list(
      input = list(
        data.frame(group = c("a","a","b"), value = c(10, NA, 20)),
        5
      ),
      expected = data.frame(group = c("a","b"), avg = c(10,20))
    )
  )
)
