# Helper: run code with storage redirected to a temp directory,
# and always clean up afterwards, even if the test fails.
# Files named helper-*.R are automatically loaded before any tests run.
with_temp_storage <- function(code) {
  old_option <- getOption("rgrind.storage_dir")
  temp_dir <- tempfile("rgrind_test_")
  dir.create(temp_dir)
  options(rgrind.storage_dir = temp_dir)

  on.exit({
    options(rgrind.storage_dir = old_option)
    unlink(temp_dir, recursive = TRUE)
  })

  force(code)
}
