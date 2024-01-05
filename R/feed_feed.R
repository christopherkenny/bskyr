#' Build feed from user's feed generator
#'
#' @param feed `r template_var_feed()`
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getFeed.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getFeed.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_feed('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team')
bs_get_feed <- function(feed, cursor = NULL, limit = NULL,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(feed)) {
    cli::cli_abort('{.arg feed} must list at least one user.')
  }
  if (!is.character(feed)) {
    cli::cli_abort('{.arg feed} must be a character vector.')
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


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getFeed') |>
    httr2::req_url_query(feed = feed) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching feed')

  if (!clean) return(resp)

  resp |>
    lapply(process_feed) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_feed <- function(resp) {
  lapply(resp$feed, function(x) {
    if (is.null(x$reply)) {
      dplyr::bind_cols(widen(x$post))
    } else {
      dplyr::bind_cols(widen(x$post), widen(x$reply))
    }
  }) |>
    dplyr::bind_rows() |>
    clean_names() |>
    add_singletons(resp)
}
