#' Retrieve recent posts from actors in a list
#'
#' @param list `r template_var_list()`
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
#' [feed/getListFeed.json (2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getListFeed.json)
#'
#' @section Function introduced:
#' `v0.3.0` (2025-03-20)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_list_feed('at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g')
bs_get_list_feed <- function(list, cursor = NULL, limit = NULL,
                              user = get_bluesky_user(), pass = get_bluesky_pass(),
                              auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(list)) {
    cli::cli_abort('{.arg list} must be an at-uri for a list.')
  }
  if (!is.character(list)) {
    cli::cli_abort('{.arg actors} must be a character vector.')
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getListFeed') |>
    httr2::req_url_query(list = list) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching list feed')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_timeline) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}
