#' Retrieve posts on an actor's feed
#'
#' @param actor `r template_var_actor()`
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
#' [feed/getAuthorFeed.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getAuthorFeed.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_author_feed('chriskenny.bsky.social')
bs_get_author_feed <- function(actor,
                               user = get_bluesky_user(), pass = get_bluesky_pass(),
                               auth = bs_auth(user, pass)) {
 if (missing(actor)) {
   cli::cli_abort('{.arg actor} must list at least one user.')
 }
 if (!is.character(actor)) {
   cli::cli_abort('{.arg actor} must be a character vector.')
 }
 
 req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getAuthorFeed') |>
   httr2::req_url_query(actor = actor) |>
   httr2::req_auth_bearer_token(token = auth$accessJwt)
 resp <- req |>
   httr2::req_perform() |>
   httr2::resp_body_json()

 resp |>
   purrr::pluck('feed') |>
   list_hoist() |>
   clean_names()
}
