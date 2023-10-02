#' Get a list of feed suggestions
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept feed
#'
#' @section Lexicon references:
#' [feed/getSuggestedFeeds.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getSuggestedFeeds.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a tibble of suggested feeds
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_feed_suggestions()
bs_get_feed_suggestions <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                                     auth = bs_auth(user, pass)) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getSuggestedFeeds') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    purrr::pluck('feeds') |>
    proc() |>
    clean_names()
}
