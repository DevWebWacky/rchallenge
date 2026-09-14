test_that("run_challenge reports full pass for a correct solution", {
  with_temp_storage({
    result <- run_challenge("sum_evens", function(x) sum(x[x %% 2 == 0], na.rm = TRUE))
    expect_equal(result$passed, result$total)
  })
})

test_that("run_challenge reports partial/zero pass for a wrong solution", {
  with_temp_storage({
    result <- run_challenge("count_na", function(x) 999)
    expect_equal(result$passed, 0)
    expect_true(result$total > 0)
  })
})

test_that("run_challenge errors clearly for an unknown challenge id", {
  with_temp_storage({
    expect_error(
      run_challenge("not_a_real_challenge", function(x) x),
      "Unknown challenge id"
    )
  })
})

test_that("run_challenge handles a user function that errors internally", {
  with_temp_storage({
    result <- run_challenge("sum_evens", function(x) stop("deliberate test error"))
    expect_equal(result$passed, 0)
  })
})
