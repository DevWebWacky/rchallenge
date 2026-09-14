# Helper: run code with storage redirected to a temp directory,
# and always clean up afterwards, even if the test fails

test_that("rc_get_history returns empty data frame when no history exists", {
  with_temp_storage({
    history <- rc_get_history()
    expect_equal(nrow(history), 0)
    expect_true(all(c("challenge_id", "timestamp", "passed") %in% names(history)))
  })
})

test_that("rc_log_attempt correctly appends rows", {
  with_temp_storage({
    rc_log_attempt("sum_evens", TRUE)
    rc_log_attempt("count_na", FALSE)
    history <- rc_get_history()
    expect_equal(nrow(history), 2)
    expect_equal(history$challenge_id, c("sum_evens", "count_na"))
    expect_equal(history$passed, c(TRUE, FALSE))
  })
})

test_that("rc_reset_history clears all data", {
  with_temp_storage({
    rc_log_attempt("sum_evens", TRUE)
    rc_reset_history()
    history <- rc_get_history()
    expect_equal(nrow(history), 0)
  })
})

test_that("rc_get_streak returns 0 with no history", {
  with_temp_storage({
    expect_equal(rc_get_streak(), 0L)
  })
})

test_that("rc_get_streak counts an active streak ending yesterday", {
  with_temp_storage({
    fake_history <- data.frame(
      challenge_id = c("a", "b", "c"),
      timestamp = as.POSIXct(c(Sys.Date() - 3, Sys.Date() - 2, Sys.Date() - 1)),
      passed = TRUE
    )
    saveRDS(fake_history, rc_storage_path())
    expect_equal(rc_get_streak(), 3L)
  })
})

test_that("rc_get_streak returns 0 when most recent solve is too old", {
  with_temp_storage({
    fake_history <- data.frame(
      challenge_id = "a",
      timestamp = as.POSIXct(Sys.Date() - 5),
      passed = TRUE
    )
    saveRDS(fake_history, rc_storage_path())
    expect_equal(rc_get_streak(), 0L)
  })
})

test_that("rc_get_streak stops counting across a gap", {
  with_temp_storage({
    fake_history <- data.frame(
      challenge_id = c("a", "b", "c"),
      timestamp = as.POSIXct(c(Sys.Date() - 10, Sys.Date() - 1, Sys.Date())),
      passed = TRUE
    )
    saveRDS(fake_history, rc_storage_path())
    expect_equal(rc_get_streak(), 2L)
  })
})

test_that("rc_longest_streak finds the best historical run, not just current", {
  with_temp_storage({
    fake_history <- data.frame(
      challenge_id = c("a", "b", "c", "d", "e"),
      timestamp = as.POSIXct(c(
        Sys.Date() - 20, Sys.Date() - 19, Sys.Date() - 18, Sys.Date() - 17,  # 4-day streak, long ago
        Sys.Date()  # isolated solve today
      )),
      passed = TRUE
    )
    saveRDS(fake_history, rc_storage_path())
    expect_equal(rc_longest_streak(), 4L)
    expect_equal(rc_get_streak(), 1L)  # current streak is just today
  })
})
