#' Mark a conversation (optionally up to a specific message) as read
#'
#' @param convo_id `r template_var_convo_id()`
#' @param message_id Character, optional. Message ID up to which to mark as read.
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
#' [chat.bsky.convo.updateRead.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/updateRead.json)
#'
#' @section Function introduced:
#' `v0.3.1` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_update_read(convo_id = '3ku7w6h4vog2d')
bs_update_read <- function(convo_id, message_id = NULL,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {

  body <- list(convoId = convo_id)
  if (!is.null(message_id)) {
    body$messageId <- message_id
  }

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint
  req_url <- paste0(session_url, '/xrpc/chat.bsky.convo.updateRead')

  req <- httr2::request(req_url) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_headers('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat') |>
    httr2::req_body_json(body)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('convo') |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
