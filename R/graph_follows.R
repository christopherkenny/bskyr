#' Retrieve an actor's follows
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
#' [graph/getFollows.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getFollows.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_follows('chriskenny.bsky.social')
bs_get_follows <- function(actor, limit = NULL,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(actor)) {
    cli::cli_abort('{.arg actor} must list one user.')
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getFollows') |>
    httr2::req_url_query(actor = actor) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  dplyr::bind_cols(
    resp |>
      purrr::pluck('follows') |>
      proc() |>
      clean_names(),
    resp |>
      purrr::pluck('subject') |>
      unlist() |>
      dplyr::bind_rows() |>
      clean_names() |>
      dplyr::rename_with(.fn = function(x) paste0('subject_', x))
  )
}
