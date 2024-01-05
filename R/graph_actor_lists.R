#' Get a list of lists that belong to an actor.
#'
#' @param actor `r template_var_actor()`
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of lists
#' @export
#'
#' @section Lexicon references:
#' [graph/getLists.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getLists.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_actor_lists('profmusgrave.bsky.social')
bs_get_actor_lists <- function(actor, cursor = NULL, limit = NULL,
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
    req_seq <- diff(unique(c(seq(0, limit, 100), limit)))
  } else {
    req_seq <- list(NULL)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getLists') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching lists')

  if (!clean) return(resp)

  resp |>
    lapply(process_actor_lists) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_actor_lists <- function(resp) {
  resp |>
    purrr::pluck('lists') |>
    proc() |>
    clean_names()
}
