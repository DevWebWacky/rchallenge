test_that("all expected challenges are registered", {
  ids <- list_challenges()
  expect_true("sum_evens" %in% ids)
  expect_true("count_na" %in% ids)
  expect_true("first_duplicate" %in% ids)
  expect_true("avg_above" %in% ids)
  expect_true("rolling_sum" %in% ids)
  expect_true("bootstrap_ci" %in% ids)
  expect_true("count_missing" %in% ids)
  expect_true("remove_outliers" %in% ids)
  expect_true("pivot_long_scores" %in% ids)
  expect_true("max_consecutive_ones" %in% ids)
  expect_length(ids, 10)
})

test_that("every registered challenge has required fields", {
  ids <- list_challenges()
  for (id in ids) {
    challenge <- get_challenge(id)
    expect_false(is.null(challenge$id))
    expect_false(is.null(challenge$title))
    expect_false(is.null(challenge$category))
    expect_false(is.null(challenge$description))
    expect_false(is.null(challenge$hint))
    expect_false(is.null(challenge$explanation))
    expect_true(length(challenge$test_cases) > 0)
  }
})

test_that("get_challenge errors clearly on unknown id", {
  expect_error(get_challenge("not_a_real_challenge"), "Unknown challenge id")
})
