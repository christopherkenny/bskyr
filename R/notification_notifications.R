#' Get the user's (self) notifications
#'
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept notification
#'
#' @section Lexicon references:
#' [notification/listNotifications.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/notification/listNotifications.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a tibble with notifications
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_notifications()
bs_get_notifications <- function(cursor = NULL, limit = NULL,
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

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.notification.listNotifications') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching notifications')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_notifications) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_notifications <- function(resp) {
  resp |>
    purrr::pluck('notifications') |>
    list_hoist() |>
    add_singletons(resp) |>
    clean_names()
}
