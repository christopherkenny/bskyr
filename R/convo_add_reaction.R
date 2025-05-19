#' Add a reaction (e.g. emoji) to a message in a conversation
#'
#' @param convo_id `r template_var_convo_id()`
#' @param message_id Character, length 1. Message ID.
#' @param value Character, length 1. Reaction value (e.g. an emoji).
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
#' [chat.bsky.convo.addReaction.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/addReaction.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_add_reaction(convo_id = '3ku7w6h4vog2d', message_id = '3lphbnrx7l32l', value = '👍')
bs_add_reaction <- function(convo_id, message_id, value,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {
  session_url <- auth$didDoc$service[[1]]$serviceEndpoint
  req_url <- paste0(session_url, '/xrpc/chat.bsky.convo.addReaction')

  req <- httr2::request(req_url) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_headers('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat') |>
    httr2::req_body_json(
      data = list(
        convoId = convo_id,
        messageId = message_id,
        value = value
      )
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    list_hoist() |>
    clean_names() |>
    add_req_url(req)
}
