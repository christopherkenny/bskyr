#' Find profiles matching search criteria
#'
#' @param query character. search query, Lucene query syntax is recommended when `typeahead = FALSE`.
#' @param typeahead logical. Use typeahead for search? Default is `FALSE`.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept actor
#'
#' @section Lexicon references:
#' [actor/searchActors.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/searchActors.json)
#' [actor/searchActorsTypeahead.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/searchActorsTypeahead.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @return a tibble of suggested accounts to follow
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_search_actors('political science')
bs_search_actors <- function(query, typeahead = FALSE,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass)) {

  base_url <- ifelse(
    typeahead,
    'https://bsky.social/xrpc/app.bsky.actor.searchActors',
    'https://bsky.social/xrpc/app.bsky.actor.searchActorsTypeahead'
  )
  req <- httr2::request(base_url) |>
    httr2::req_url_query(q = query) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    purrr::pluck('actors') |>
    proc() |>
    clean_names()
}
