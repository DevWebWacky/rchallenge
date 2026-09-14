#' @keywords internal
challenge_pivot_scores <- list(
  id = "pivot_long_scores",
  title = "Reshape Wide to Long (Pivot Tidy Data)",
  category = "Tidyverse Wrangling",
  difficulty = "Medium",

  description = paste(
    "Write a function `pivot_long_scores(df)` that takes a wide data",
    "frame with columns student_id, math, science, english, and",
    "pivots it into long format with exactly three columns:",
    "student_id, subject, score.",
    "\n\nThe subject column must contain the original column names",
    "exactly: 'math', 'science', 'english'. Row order does not matter.",
    "\n\nExample input: student_id=101, math=90, science=85, english=92",
    "Example output rows: (101,'math',90), (101,'science',85),",
    "(101,'english',92)"
  ),

  hint = paste(
    "Look into tidyr::pivot_longer(). You'll need to tell it which",
    "columns to pivot (everything except student_id), and use its",
    "names_to and values_to arguments to name the resulting subject",
    "and score columns."
  ),

  explanation = paste(
    "Idiomatic solution:\n",
    "  tidyr::pivot_longer(\n",
    "    df,\n",
    "    cols = c(math, science, english),\n",
    "    names_to = 'subject',\n",
    "    values_to = 'score'\n",
    "  )\n\n",
    "pivot_longer() is the standard tidyverse tool for going from wide",
    "format (one column per variable) to long/tidy format (one row",
    "per observation). names_to controls what the old column names",
    "become (as values in a new column), and values_to controls what",
    "the old cell values become."
  ),

  test_cases = list(
    list(
      input = list(data.frame(
        student_id = 101, math = 90, science = 85, english = 92
      )),
      expected = data.frame(
        student_id = c(101,101,101),
        subject = c("math","science","english"),
        score = c(90,85,92)
      )
    ),
    list(
      input = list(data.frame(
        student_id = c(101,102),
        math = c(90,70), science = c(85,75), english = c(92,80)
      )),
      expected = data.frame(
        student_id = c(101,101,101,102,102,102),
        subject = c("math","science","english","math","science","english"),
        score = c(90,85,92,70,75,80)
      )
    )
  )
)
