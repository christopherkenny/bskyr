#' Retrieve thread of posts
#'
#' @param uri `r template_var_uri()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept feed
#'
#' @return a tibble of posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getPostThread.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getPostThread.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_post_thread('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
bs_get_post_thread <- function(uri,
                              user = get_bluesky_user(), pass = get_bluesky_pass(),
                              auth = bs_auth(user, pass)) {
  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must list at least one uri.')
  }
  if (!is.character(uri)) {
    cli::cli_abort('{.arg uri} must be a character vector.')
  }
  
  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getPostThread') |>
    httr2::req_url_query(uri = uri) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  out <- resp |>
    purrr::pluck('thread') |>
    widen() |>
    tidyr::unnest_wider('post') |>
    tidyr::unnest_wider('author', names_sep = '_') |>
    tidyr::unnest_wider('author_viewer', names_sep = '_')

  out$record <- proc_record(out$record)
  out$embed <- proc_embed(out$embed)

  out |>
    clean_names()
}
