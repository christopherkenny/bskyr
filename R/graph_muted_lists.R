#' Retrieve a user's (self) muted lists
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of actors
#' @export
#'
#' @section Lexicon references:
#' [graph/getListMutes.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getListMutes.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_muted_lists()
bs_get_muted_lists <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                               auth = bs_auth(user, pass), clean = TRUE) {
  req <- bs_xrpc_request(
    endpoint = 'app.bsky.graph.getListMutes',
    auth = auth
  )
  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('lists') |>
    proc() |>
    clean_names() |>
    add_req_url(req)
}
