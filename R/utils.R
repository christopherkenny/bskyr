# devtools ----
# devtools not intended for use in production, not tested
lrj <- function() { # nocov start
  httr2::last_response() |>
    httr2::resp_body_json()
} # nocov end

.gl <- function(x) { # nocov start
  dplyr::glimpse(x)
} # nocov end

# general utils ----
clean_names <- function(x) {
  out <- x |>
    names() |>
    gsub('\\.', '_', x = _) |>
    gsub('([a-z])([A-Z])', '\\1_\\2', x = _) |>
    tolower()
  stats::setNames(object = x, nm = out)
}


widen <- function(x, i = 4) {
  x |>
    tibble::enframe() |>
    tidyr::pivot_wider() |>
    tidyr::unnest_wider(col = where(~purrr::pluck_depth(.x) < i), simplify = TRUE, names_sep = '_') |>
    dplyr::rename_with(.fn = function(x) substr(x, start = 1, stop = nchar(x) - 2), .cols = dplyr::ends_with('_1'))
}

list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
}

validate_user <- function(x) {
  # regex adapted from https://atproto.com/specs/handle#handle-identifier-syntax
  if (!stringr::str_detect(x,
                           '^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$')) {
    cli::cli_abort('{.arg user} must be a valid handle.')
  }
  invisible(x)
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

# reply helper ----
get_reply_refs <- function(uri, auth) {

  parent <- bs_get_record(repo = uri, auth = auth, clean = FALSE)

  parent_reply <- parent$value$reply

  if (!is.null(parent_reply)) {
    cat(parent_reply$root$uri)
    root <- bs_get_record(repo = parent_reply$root$uri, auth = auth, clean = FALSE)
  } else {
    root <- parent
  }

  list(
    root = list(
      uri = root$uri,
      cid = root$cid
    ),
    parent = list(
      uri = parent$uri,
      cid = parent$cid
    )
  )
}

# call details ----
add_cursor <- function(tb, l) {
  if (is.null(names(l))) {
    l_sub <- lapply(l, function(x) purrr::keep_at(x, at = c('cursor'))) |>
      purrr::list_flatten()
  } else {
    l_sub <- purrr::keep_at(l, at = c('cursor'))
  }

  `attr<-`(tb, 'cursor', l_sub)
}

add_req_url <- function(tb, l) {
  `attr<-`(tb, 'request_url', l$url)
}

repeat_request <- function(req, req_seq, cursor, txt = 'Fetching data') {
  resp <- vector(mode = 'list', length = length(req_seq))
  for (i in cli::cli_progress_along(req_seq, txt)) {
    resp[[i]] <- req |>
      httr2::req_url_query(
        cursor = cursor,
        limit = req_seq[[i]]
      ) |>
      httr2::req_perform() |>
      httr2::resp_body_json()
    cursor <- resp[[i]]$cursor
  }
  resp
}
