# devtools ----
# devtools not intended for use in production, not tested
lrj <- function() { # nocov start
  httr2::last_response() |>
    httr2::resp_body_json()
} # nocov end

.gl <- function(x) { # nocov start
  dplyr::glimpse(x)
} # nocov end

# service URL helpers ----
bs_pds <- function(auth) {
  if (!is.null(auth$bskyr_pds)) {
    auth$bskyr_pds
  } else {
    get_bluesky_pds()
  }
}

# env var helpers ----
set_bluesky_env <- function(value, name, arg, test_val = NULL, test_val_msg = NULL,
                            overwrite = FALSE, install = FALSE, r_env = NULL) {
  value <- list(value)
  names(value) <- name

  if (!is.null(test_val) && value[[1]] == test_val) {
    cli::cli_inform(test_val_msg)
    return(invisible(value))
  }

  if (install) {
    if (is.null(r_env)) {
      r_env <- file.path(Sys.getenv('HOME'), '.Renviron')
      if (interactive()) {
        utils::askYesNo(paste0('Install to ', r_env, '?'))
      } else {
        cli::cli_abort(c(
          'No path set and not run interactively.',
          i = 'Rerun with {.arg r_env} set, possibly to {.file {r_env}}'
        ))
      }
    }

    if (!file.exists(r_env)) {
      file.create(r_env)
    }

    lines <- readLines(r_env)
    newline <- paste0(name, "='", value[[1]], "'")
    exists <- grepl(x = lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort('Multiple entries in .Renviron found.\nEdit manually with {.fn usethis::edit_r_environ}.')
      }
      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, value)
      } else {
        cli::cli_inform('{.arg {name}} already exists in .Renviron. \nEdit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.')
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, value)
    }
  } else {
    do.call(Sys.setenv, value)
  }

  invisible(value)
}

# general utils ----
clean_names <- function(x) {
  out <- x |>
    names() |>
    stringr::str_replace_all('\\.', '_') |>
    stringr::str_replace_all('([a-z])([A-Z])', '\\1_\\2') |>
    tolower()
  purrr::set_names(x = x, nm = out)
}

pack <- function(v) {
  if (is.null(v)) {
    NA
  } else if (length(v) == 1L) {
    v
  } else {
    list(v)
  }
}

widen_field <- function(nm, v, i) {
  if (!is.list(v)) {
    purrr::set_names(list(pack(v)), nm)
  } else if (purrr::pluck_depth(v) + 1L >= i) {
    purrr::set_names(list(list(v)), nm)
  } else if (length(v) > 0L) {
    sub_nms <- names(v)
    if (is.null(sub_nms)) {
      sub_nms <- as.character(seq_along(v))
    }
    purrr::set_names(lapply(v, pack), paste0(nm, '_', sub_nms))
  } else {
    list()
  }
}

widen <- function(x, i = 4) {
  if (is.null(x) || length(x) == 0L) {
    return(tibble::tibble())
  }
  if (is.null(names(x))) {
    names(x) <- as.character(seq_along(x))
  }
  flat <- purrr::list_flatten(lapply(names(x), function(nm) {
    widen_field(nm, x[[nm]], i)
  }))
  if (length(flat) == 0L) {
    return(tibble::tibble())
  }
  tibble::as_tibble_row(flat) |>
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

bs_get_service_token <- function(auth, lxm, aud = NULL) {
  services <- auth$didDoc$service
  pds_service <- purrr::detect(services, function(x) identical(x$id, '#atproto_pds'))
  if (is.null(pds_service)) {
    pds_service <- services[[1]]
  }
  pds_url <- pds_service$serviceEndpoint
  if (is.null(aud)) {
    aud <- paste0('did:web:', sub('https://', '', pds_url))
  }
  req <- bs_xrpc_request(
    endpoint = 'com.atproto.server.getServiceAuth',
    query = list(aud = aud, lxm = lxm),
    auth = auth,
    host = pds_url
  )

  req |>
    httr2::req_perform() |>
    bs_xrpc_response() |>
    purrr::pluck('token')
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

validate_limit <- function(limit) {
  if (is.null(limit)) {
    return(NULL)
  }
  if (!is.numeric(limit)) {
    cli::cli_abort('{.arg limit} must be numeric.')
  }
  max(as.integer(limit), 1L)
}

make_req_seq <- function(limit) {
  if (!is.null(limit)) {
    diff(unique(c(seq(0, limit, 100), limit)))
  } else {
    list(NULL)
  }
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
      bs_xrpc_response()
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

  ifelse(emo %in% noms, emoji::emoji_name[emo], pad_emoji(emo))
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
