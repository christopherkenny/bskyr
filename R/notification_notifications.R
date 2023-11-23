#' Get the user's (self) notifications
#'
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
bs_get_notifications <- function(limit = NULL,
                                 user = get_bluesky_user(), pass = get_bluesky_pass(),
                                 auth = bs_auth(user, pass), clean = TRUE) {

  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    limit <- min(limit, 100L)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.notification.listNotifications') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('notifications') |>
    list_hoist() |>
    add_singletons(resp) |>
    clean_names()
}
