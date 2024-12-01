#' Retrieve posts on an actor's feed
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
#' @return a [tibble::tibble] of posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getAuthorFeed.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getAuthorFeed.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_author_feed('chriskenny.bsky.social')
bs_get_author_feed <- function(actor, cursor = NULL, limit = NULL,
                               user = get_bluesky_user(), pass = get_bluesky_pass(),
                               auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(actor)) {
    cli::cli_abort('{.arg actor} must list at least one user.')
  }
  if (!is.character(actor)) {
    cli::cli_abort('{.arg actor} must be a character vector.')
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getAuthorFeed') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching followers')

  if (!clean) {
    return(resp)
  }

  lapply(resp,function(f) {
    lapply(f$feed, function(x) {
      dplyr::bind_cols(
        proc_post(x$post),
        widen(x$reply)
      )
    }) |>
      purrr::list_rbind() |>
      clean_names()
  }) |>
    purrr::list_rbind() |>
    clean_names() |>
    add_req_url(req) |>
    add_cursor(resp)
}
