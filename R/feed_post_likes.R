#' Retrieve likes on a post
#'
#' @param uri `r template_var_uri()`
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
#' [feed/getLikes.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getLikes.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_post_likes('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
bs_get_post_likes <- function(uri, cursor = NULL, limit = NULL,
                              user = get_bluesky_user(), pass = get_bluesky_pass(),
                              auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must list at least one uri.')
  }
  if (!is.character(uri)) {
    cli::cli_abort('{.arg uri} must be a character vector.')
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getLikes') |>
    httr2::req_url_query(uri = uri) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching post likes')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_post_likes) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_post_likes <- function(resp) {
  resp |>
    purrr::pluck('likes') |>
    proc() |>
    add_singletons(l = resp) |>
    clean_names()
}
