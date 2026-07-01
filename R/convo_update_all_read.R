#' Mark all conversations as read for the authenticated user
#'
#' @param status `r template_var_status()`
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
#' [chat.bsky.convo.updateAllRead.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/updateAllRead.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_update_all_read()
bs_update_all_read <- function(status = c('accepted', 'request'),
                               user = get_bluesky_user(), pass = get_bluesky_pass(),
                               auth = bs_auth(user, pass), clean = TRUE) {
  status <- rlang::arg_match(status)

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint

  req <- bs_xrpc_request(
    endpoint = 'chat.bsky.convo.updateAllRead',
    body = list(status = status),
    auth = auth,
    host = session_url,
    headers = list('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat')
  )

  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
