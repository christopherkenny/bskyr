#' Get the lists created by an actor
#'
#' @param actor `r template_var_actor()`
#' @param limit `r template_var_limit(100)`
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
#' [graph/getLists.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getLists.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2023-11-25)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_actor_lists('chriskenny.bsky.social')
#' bs_get_actor_lists('pfrazee.com')
bs_get_actor_lists <- function(actor, limit = NULL,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(actor)) {
    cli::cli_abort('{.arg actor} must list at least one user.')
  }
  if (!is.character(actor)) {
    cli::cli_abort('{.arg actor} must be a character vector.')
  }

  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    limit <- min(limit, 100L)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getLists') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

   if (!clean) {
     return(resp)
   }

    resp |>
      purrr::pluck('lists') |>
      proc() |>
      clean_names()
}
