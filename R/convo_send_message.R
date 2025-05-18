#' Send a message in a conversation (DM thread)
#'
#' @param convo_id `r template_var_convo_id()`
#' @param text Character, length 1. Message text.
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
#' [chat.bsky.convo.sendMessage.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/sendMessage.json)
#'
#' @section Function introduced:
#' `v0.3.1` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_send_message(convo_id = '3ku7w6h4vog2d', text = '[example] sent with bskyr')
bs_send_message <- function(convo_id, text,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint
  req_url <- paste0(session_url, '/xrpc/chat.bsky.convo.sendMessage')

  req <- httr2::request(req_url) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_headers('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat') |>
    httr2::req_body_json(
      data = list(
        convoId = convo_id,
        message = list(text = text)
      )
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
