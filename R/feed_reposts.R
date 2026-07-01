#' Retrieve actors who reposted a post
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
#' @return a [tibble::tibble] of actors
#' @export
#'
#' @section Lexicon references:
#' [feed/getRepostedBy.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getRepostedBy.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_reposts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3kaa2gxjhzr2a')
bs_get_reposts <- function(uri, cursor = NULL, limit = NULL,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must list at least one user.')
  }
  if (!is.character(uri)) {
    cli::cli_abort('{.arg uri} must be a character vector.')
  }

  limit <- validate_limit(limit)
  req_seq <- make_req_seq(limit)

  req <- bs_xrpc_request(
    endpoint = 'app.bsky.feed.getRepostedBy',
    query = list(uri = uri, limit = limit),
    auth = auth
  )
  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching reposts')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_reposts) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_reposts <- function(resp) {
  resp |>
    purrr::pluck('repostedBy') |>
    proc() |>
    add_singletons(resp) |>
    clean_names()
}
