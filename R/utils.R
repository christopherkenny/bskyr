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
    stringr::str_replace('\\.', '_') |>
    stringr::str_replace('([a-z])([A-Z])', '\\1_\\2') |>
    tolower()
  stats::setNames(object = x, nm = out)
}


widen <- function(x, i = 4) {
  x |>
    tibble::enframe() |>
    tidyr::pivot_wider() |>
    tidyr::unnest_wider(col = where(~ purrr::pluck_depth(.x) < i), simplify = TRUE, names_sep = '_') |>
    dplyr::rename_with(.fn = function(x) substr(x, start = 1, stop = nchar(x) - 2), .cols = dplyr::ends_with('_1')) |>
    clean_names()
}

list_to_row <- function(l) {
  l |>
    lapply(function(x) {
      lapply(x, function(y) {
        if (length(y) != 1) {
          list(widen(y))
        } else {
          y
        }
      }) |>
        tibble::as_tibble_row()
    })
}

list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
}

validate_user <- function(x) {
  # regex adapted from https://atproto.com/specs/handle#handle-identifier-syntax
  if (!is.character(x)) {
    cli::cli_abort('{.arg user} must be a character vector.')
  }
  if (length(x) != 1) {
    cli::cli_abort('{.arg user} must be a single character string.')
  }
  if (x == '') {
    cli::cli_abort(
      c(
        x = '{.arg user} is {.val {x}}, the empty string, not a username.',
        i = 'Add a username using {.fn bs_set_user}.'
      )
    )
  }
  if (!stringr::str_detect(
    x,
    '^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$'
  )) {
    cli::cli_abort('{.arg user} is {.val {x}}, which is not a valid handle.')
  }
  invisible(x)
}

validate_pass <- function(x) {
  if (!is.character(x)) {
    cli::cli_abort('{.arg pass} must be a character vector.')
  }
  if (length(x) != 1) {
    cli::cli_abort('{.arg pass} must be a single character string.')
  }
  if (x == '') {
    cli::cli_abort(
      c(
        x = '{.arg pass} is {.val {x}}, the empty string, not a password.',
        i = 'Add a password using {.fn bs_set_pass}.'
      )
    )
  }
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
    if (is.null(cursor)) {
      break
    }
  }
  resp |>
    purrr::discard(is.null)
}

# emoji parsing ----

pad_emoji <- function(emo) {
  paste0(':', emo, ':')
}

replace_emoji <- function(emo) {
  if (!rlang::is_installed('emoji')) {
    return(emo)
  }

  emo <- stringr::str_remove_all(emo, ':')

  noms <- names(emoji::emoji_name)

  if (emo %in% noms) {
    emoji::emoji_name[emo]
  } else {
    pad_emoji(emo)
  }
}

# general helpers ----
is_user_did <- function(x) {
  stringr::str_starts(x, stringr::fixed('did:'))
}

is_online_link <- function(x) {
  stringr::str_starts(x, 'https://') | stringr::str_starts(x, 'http://')
}


# handle blob tibbles ----

blob_tb_to_list <- function(tb) {
  lapply(
    seq_len(nrow(tb)),
    function(r) {
      list(
        blob = list(
          `$type` = tb[[r, '$type']],
          ref = list(
            `$link` = tb[[r, 'ref_$link']]
          ),
          mimeType = tb[[r, 'mime_type']],
          size = as.integer(tb[[r, 'size']])
        )
      )
    }
  )
}
