#' @keywords internal
challenge_bootstrap_ci <- list(
  id = "bootstrap_ci",
  title = "Bootstrap Confidence Interval for the Mean",
  category = "Statistical Algorithms",
  difficulty = "Medium/Hard",

  description = paste(
    "Write a function `bootstrap_ci(x, n_boot = 1000, conf = 0.95,",
    "seed = 42)` that returns a named numeric vector",
    "c(lower = ..., upper = ...).",
    "\n\nMethod (required, for reproducibility): call set.seed(seed)",
    "once, then use replicate(n_boot, mean(sample(x, length(x),",
    "replace = TRUE))) to generate bootstrap means, this exact",
    "method is required so results are reproducible, since other",
    "sampling approaches (e.g. matrix-based sampling) consume random",
    "numbers in a different order and produce different results even",
    "with the same seed.",
    "\n\nThen take the alpha/2 and 1-alpha/2 quantiles",
    "(alpha = 1 - conf) of the bootstrap means as your lower/upper",
    "bounds. Grading allows a small numeric tolerance, but the",
    "resampling METHOD must match exactly or results will diverge",
    "beyond that tolerance."
  ),

  hint = paste(
    "set.seed(seed) once, then use replicate(n_boot, mean(sample(x,",
    "length(x), replace = TRUE))) to generate your bootstrap means.",
    "Then use quantile() with names = FALSE and the right",
    "probabilities to get your lower and upper bounds."
  ),

  explanation = paste(
    "Idiomatic solution:\n",
    "  set.seed(seed)\n",
    "  boot_means <- replicate(n_boot, mean(sample(x, length(x), replace = TRUE)))\n",
    "  alpha <- 1 - conf\n",
    "  c(lower = quantile(boot_means, alpha / 2, names = FALSE),\n",
    "    upper = quantile(boot_means, 1 - alpha / 2, names = FALSE))\n\n",
    "Note the names = FALSE inside quantile(), without it, R attaches",
    "awkward names like '2.5%' that would clash with our own",
    "lower/upper names. Bootstrapping estimates a sampling",
    "distribution empirically by resampling your own data, rather",
    "than assuming normality."
  ),

  test_cases = list(
    list(
      input = list(c(1,2,3,4,5,6,7,8,9,10), 1000, 0.95, 42),
      expected = {
        set.seed(42)
        bm <- replicate(1000, mean(sample(c(1,2,3,4,5,6,7,8,9,10), 10, replace = TRUE)))
        c(lower = quantile(bm, 0.025, names = FALSE),
          upper = quantile(bm, 0.975, names = FALSE))
      },
      tolerance = 0.05
    ),
    list(
      input = list(c(3,3,3), 1000, 0.95, 42),
      expected = c(lower = 3, upper = 3),
      tolerance = 0.05
    )
  )
)
