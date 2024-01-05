#' Retrieve the user's home timeline
#'
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
#' [feed/getTimeline.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getTimeline.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_timeline()
bs_get_timeline <- function(cursor = NULL, limit = NULL,
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getTimeline') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching timeline')

  if (!clean) return(resp)

  resp |>
    lapply(process_timeline) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_timeline <- function(resp) {
  out <- resp |>
    purrr::pluck('feed')

  if (purrr::is_empty(out)) {
    return(tibble::tibble())
  }

  out <- out |>
    lapply(function(x) {
      x |>
        unlist(recursive = FALSE) |>
        lapply(function(z) {
          if (length(z) != 1) {
            list(z)
          } else {
            z
          }
        }) |>
        tibble::as_tibble_row()
    }) |>
    dplyr::bind_rows() |>
    clean_names()

  out <- out |>
    dplyr::mutate(
      post_author = proc(.data$post_author),
      post_record = lapply(.data$post_record, widen),
      dplyr::across(dplyr::any_of('post_embed'), .fns = function(x) lapply(x, widen))
    ) |>
    add_singletons(resp)

  out
}
