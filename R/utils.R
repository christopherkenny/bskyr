# devtools
lrj <- function() { # nocov start
  httr2::last_response() |>
    httr2::resp_body_json()
} # nocov end

.gl <- function(x) { # nocov start
  dplyr::glimpse(x)
} # nocov end

# general utils
clean_names <- function(x) {
  out <- x |>
    names() |>
    gsub('\\.', '_', x = _) |>
    gsub('([a-z])([A-Z])', '\\1_\\2', x = _) |>
    tolower()
  stats::setNames(object = x, nm = out)
}

widen <- function(x) {
  x |>
    tibble::enframe() |>
    tidyr::pivot_wider() |>
    tidyr::unnest_wider(col = where(~purrr::pluck_depth(.x) < 4), simplify = TRUE, names_sep = '_') |>
    dplyr::rename_with(.fn = function(x) substr(x, start = 1, stop = nchar(x) - 2), .cols = dplyr::ends_with('_1'))
}

list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
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
