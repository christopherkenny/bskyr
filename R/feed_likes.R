#' Retrieve posts liked by an actor (self)
#'
#' @param actor `r template_var_actor()`
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of likes
#' @export
#'
#' @section Lexicon references:
#' [feed/getActorLikes.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getActorLikes.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_likes(bs_get_user())
bs_get_likes <- function(actor, cursor = NULL, limit = NULL,
                         user = get_bluesky_user(), pass = get_bluesky_pass(),
                         auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(actor)) {
    cli::cli_abort('{.arg actor} must list at least one user.')
  }
  if (!is.character(actor)) {
    cli::cli_abort('{.arg actor} must be a character vector.')
  }

  if (!auth$accessJwt == '' & !actor %in% c(auth$did, auth$handle)) {
    cli::cli_abort('{.arg actor} must be the authenticated user (self).')
  }

  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    req_seq <- diff(unique(c(seq(0, limit, 100), limit)))
  } else {
    req_seq <- list(NULL)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getActorLikes') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching likes')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_likes) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_likes <- function(resp) {
  resp |>
    purrr::pluck('feed') |>
    lapply(widen) |>
    lapply(function(x) tidyr::unnest_wider(x, col = dplyr::everything())) |>
    purrr::list_rbind() |>
    tidyr::unnest_wider(col = dplyr::everything(), names_sep = '_') |>
    dplyr::rename_with(.fn = function(x) substr(x, start = 1, stop = nchar(x) - 2), .cols = dplyr::ends_with('_1')) |>
    clean_names()
}
