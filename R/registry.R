# We use an environment (not a plain list) to store the registry because
# environments in R are mutable "by reference", meaning we can update
# them from inside .onLoad() without needing to reassign anything at the
# package/global level.
rc_registry <- new.env(parent = emptyenv())

#' Register a challenge into the internal registry
#' @keywords internal
register_challenge <- function(challenge) {
  if (is.null(challenge$id)) {
    stop("Challenge is missing an 'id' field, cannot register.")
  }
  assign(challenge$id, challenge, envir = rc_registry)
}

#' Look up a challenge by id
#' @keywords internal
get_challenge <- function(challenge_id) {
  if (!exists(challenge_id, envir = rc_registry, inherits = FALSE)) {
    stop("Unknown challenge id: ", challenge_id)
  }
  get(challenge_id, envir = rc_registry, inherits = FALSE)
}

#' List all available challenge ids
#'
#' Returns the ids of every challenge currently registered in the
#' package. Use an id with [run_challenge()] to attempt that challenge.
#'
#' @return A character vector of challenge ids.
#'
#' @examples
#' list_challenges()
#'
#' @export
list_challenges <- function() {
  ls(envir = rc_registry)
}
