#' Retrieve the chat event log for the authenticated user
#'
#' @param cursor `r template_var_cursor()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept chat
#'
#' @return a [tibble::tibble] or a `list` if `clean = FALSE`
#' @export
#'
#' @section Lexicon references:
#' [chat.bsky.convo.getLog.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getLog.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_convo_log()
bs_get_convo_log <- function(cursor = NULL,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass), clean = TRUE) {
  session_url <- auth$didDoc$service[[1]]$serviceEndpoint

  req <- bs_xrpc_request(
    endpoint = 'chat.bsky.convo.getLog',
    auth = auth,
    host = session_url,
    headers = list('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat')
  )

  if (!is.null(cursor)) {
    req <- req |>
      httr2::req_url_query(cursor = cursor)
  }

  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('logs') |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
