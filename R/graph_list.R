#' Get a view of a list
#'
#' @param list `r template_var_list()`
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
#' [graph/getList.json (2024-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getList.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-11-25)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_list('at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g')
bs_get_list <- function(list, limit = NULL,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass), clean = TRUE, cursor = NULL) {

  if (missing(list)) {
    cli::cli_abort('{.arg list} must list at least one user.')
  }
  if (!is.character(list)) {
    cli::cli_abort('{.arg list} must be a character vector.')
  }

  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    limit <- min(limit, 100L)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getList') |>
    httr2::req_url_query(list = list) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit,
      cursor = cursor
    )
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

   if (!clean) {
     return(resp)
   }

  dplyr::bind_cols(
    resp |>
      purrr::pluck('items') |>
      list_hoist() |>
      clean_names(),
    resp |>
      purrr::pluck('list') |>
      widen() |>
      clean_names() |>
      dplyr::rename_with(.fn = function(x) paste0('list_', x))
  ) |>
    clean_names()
}
