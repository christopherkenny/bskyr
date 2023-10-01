clean_names <- function(x) {
  out <- x |>
    names() |>
    gsub('\\.', '_', x = _) |>
    gsub('([a-z])([A-Z])', '\\1_\\2', x = _) |>
    tolower()
  stats::setNames(object = x, nm = out)
}

validate_pass <- function(x) {
  if (nchar(x) != 19) {
    cli::cli_abort('{.arg pass} must have 19 characters.')
  }
  if (!all(unlist(gregexpr('-', x)) == c(5, 10, 15))) {
    cli::cli_abort('{.arg pass} must be of the form {.val "xxxx-xxxx-xxxx-xxxx"}.')
  }
  invisible(x)
}
