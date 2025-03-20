#' Get a view of a list
#'
#' @param list `r template_var_list()`
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
#' [graph/getList.json (2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getList.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-11-25)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_list('at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g')
#' bs_get_list('at://did:plc:hgyzg2hn6zxpqokmp5c2xrdo/app.bsky.graph.list/3laygnmmcfc2x')
bs_get_list <- function(list, cursor = NULL, limit = NULL,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass), clean = TRUE) {

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
    req_seq <- diff(unique(c(seq(0, limit, 100), limit)))
  } else {
    req_seq <- list(NULL)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getList') |>
    httr2::req_url_query(list = list) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching list views')

   if (!clean) {
     return(resp)
   }

  lapply(resp, function(f) {
    dplyr::bind_cols(
      f |>
        purrr::pluck('items') |>
        list_hoist() |>
        clean_names(),
      f |>
        purrr::pluck('list') |>
        widen() |>
        clean_names() |>
        dplyr::rename_with(.fn = function(x) paste0('list_', x))
    )
  }) |>
    purrr::list_rbind() |>
    clean_names() |>
    add_req_url(req) |>
    add_cursor(resp) |>
    clean_names()

}
