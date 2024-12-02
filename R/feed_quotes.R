#' Retrieve a list of quotes for a given post
#'
#' @param uri `r template_var_uri()`
#' @param cid Optional, character. Filters to quotes of specific version (by CID) of the post record
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of quote posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getQuotes.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getQuotes.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_quotes('at://did:plc:5c2r73erhng4bszmxlfdtscf/app.bsky.feed.post/3lc5c5qv72r2w')
bs_get_quotes <- function(uri, cid, cursor = NULL, limit = NULL,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must not be missing.')
  }

  if (!stringr::str_starts(uri, 'at://')) {
    uri <- bs_url_to_uri(uri)
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getQuotes') |>
    httr2::req_url_query(uri = uri) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching quotes')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_quotes) |>
    purrr::list_rbind() |>
    clean_names() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_quotes <- function(resp) {
  dplyr::bind_cols(
    tibble::tibble(post_uri = resp$uri),
    proc_posts(resp$posts)
  )
}
