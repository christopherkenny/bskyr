#' Retrieve user (self) blocks
#'
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of blocked accounts
#' @export
#'
#' @section Lexicon references:
#' [graph/getBlocks.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getBlocks.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_blocks()
bs_get_blocks <- function(cursor = NULL, limit = NULL,
                          user = get_bluesky_user(), pass = get_bluesky_pass(),
                          auth = bs_auth(user, pass), clean = TRUE) {

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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getBlocks') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching blocks')

  if (!clean) return(resp)

  resp |>
    lapply(process_blocks) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_blocks <- function(resp) {
  resp |>
    purrr::pluck('blocks') |>
    proc() |>
    clean_names()
}
