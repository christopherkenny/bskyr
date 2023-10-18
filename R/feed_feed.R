#' Build feed from user's feed generator
#'
#' @param feed `r template_var_feed()`
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
#' [feed/getFeed.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getFeed.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_feed('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team')
bs_get_feed <- function(feed,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass)) {
  if (missing(feed)) {
    cli::cli_abort('{.arg feed} must list at least one user.')
  }
  if (!is.character(feed)) {
    cli::cli_abort('{.arg feed} must be a character vector.')
  }


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getFeed') |>
    httr2::req_url_query(feed = feed) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  lapply(resp$feed, function(x) {
    dplyr::bind_cols(widen(x$post), widen(x$reply))
  }) |>
    dplyr::bind_rows() |>
    clean_names() |>
    add_singletons(resp)
}
