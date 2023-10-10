#' Retrieve a user's (self) muted accounts
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept graph
#'
#' @return a tibble of actors
#' @export
#'
#' @section Lexicon references:
#' [graph/getMutes.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getMutes.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_mutes()
bs_get_mutes <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                         auth = bs_auth(user, pass)) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getMutes') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    purrr::pluck('mutes') |>
    proc() |>
    clean_names()
}