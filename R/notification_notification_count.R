#' Get the user's (self) number of unread notifications
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept notification
#'
#' @section Lexicon references:
#' [notification/getUnreadCount.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/notification/getUnreadCount.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a tibble with a single column and row for the count
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_notification_count()
bs_get_notification_count <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                                      auth = bs_auth(user, pass), clean = TRUE) {
  req <- bs_xrpc_request(
    endpoint = 'app.bsky.notification.getUnreadCount',
    auth = auth
  )

  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    tibble::as_tibble()
}
