#' Get suggested follows related to a given actor
#'
#' @param actor `r template_var_actor()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @section Lexicon references:
#' [graph/getSuggestedFollowsByActor.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getSuggestedFollowsByActor.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a [tibble::tibble] of actors
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_follow_suggestions('chriskenny.bsky.social')
bs_get_follow_suggestions <- function(actor,
                                      user = get_bluesky_user(), pass = get_bluesky_pass(),
                                      auth = bs_auth(user, pass), clean = TRUE) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getSuggestedFollowsByActor') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('suggestions') |>
    proc() |>
    clean_names() |>
    add_req_url(req)
}
