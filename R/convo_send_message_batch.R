#' Send multiple messages across different conversations
#'
#' @param convo_id `r template_var_convo_id()`
#' @param text Character vector of message texts.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept chat
#'
#' @return A [tibble::tibble] or a `list` if `clean = FALSE`.
#' @export
#'
#' @section Lexicon references:
#' [chat.bsky.convo.sendMessageBatch.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/sendMessageBatch.json)
#'
#' @section Function introduced:
#' `v0.3.1` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_send_message_batch(
#'   convo_id = c('3ku7w6h4vog2d', '3lpidxucy2g27'),
#'   text = c('Hello', 'Hi there')
#' )
bs_send_message_batch <- function(convo_id, text,
                                  user = get_bluesky_user(), pass = get_bluesky_pass(),
                                  auth = bs_auth(user, pass), clean = TRUE) {

  # Recycle text if length is 1
  if (length(text) == 1) {
    text <- rep(text, length(convo_id))
  }

  if (length(convo_id) != length(text)) {
    cli::cli_abort('`convo_id` and `text` must be the same length.')
  }

  items <- purrr::map2(convo_id, text, ~ list(convoId = .x, message = list(text = .y)))

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint
  req_url <- paste0(session_url, '/xrpc/chat.bsky.convo.sendMessageBatch')

  req <- httr2::request(req_url) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_headers('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat') |>
    httr2::req_body_json(list(items = items))

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('items') |>
    lapply(widen) |>
    purrr::list_rbind() |>
    clean_names() |>
    add_req_url(req)
}
