#' Get a list of actors suggested for following
#'
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept actor
#'
#' @section Lexicon references:
#' [actor/getSuggestions.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getSuggestions.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @return a [tibble::tibble] of suggested accounts to follow
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_actor_suggestions()
bs_get_actor_suggestions <- function(cursor = NULL, limit = NULL,
                                     user = get_bluesky_user(), pass = get_bluesky_pass(),
                                     auth = bs_auth(user, pass), clean = TRUE) {
  limit <- validate_limit(limit)
  req_seq <- make_req_seq(limit)

  req <- bs_xrpc_request(
    endpoint = 'app.bsky.actor.getSuggestions',
    query = list(limit = limit),
    auth = auth
  )

  resp <- repeat_request(req, req_seq, cursor, 'Retrieving suggestions')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_actor_suggestions) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_actor_suggestions <- function(resp) {
  resp |>
    purrr::pluck('actors') |>
    proc() |>
    clean_names()
}
