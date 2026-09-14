.onLoad <- function(libname, pkgname) {
  # Find every object in the package's namespace whose name starts with
  # "challenge_" (established naming convention) and register it.
  ns <- asNamespace(pkgname)
  all_names <- ls(envir = ns, all.names = TRUE)
  challenge_names <- grep("^challenge_", all_names, value = TRUE)

  for (nm in challenge_names) {
    challenge_obj <- get(nm, envir = ns)
    register_challenge(challenge_obj)
  }
}
