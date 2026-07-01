#' Exit a conversation so you no longer receive messages or see it in your inbox
#'
#' @param convo_id `r template_var_convo_id()`
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
#' [chat.bsky.convo.leaveConvo.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/leaveConvo.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_leave_convo(convo_id = '3lpidxucy2g27')
bs_leave_convo <- function(convo_id,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {
  session_url <- auth$didDoc$service[[1]]$serviceEndpoint

  req <- bs_xrpc_request(
    endpoint = 'chat.bsky.convo.leaveConvo',
    body = list(convoId = convo_id),
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
