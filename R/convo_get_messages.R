#' Retrieve messages from a conversation, optionally paginated
#'
#' @param convo_id `r template_var_convo_id()`
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
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
#' [chat.bsky.convo.getMessages.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getMessages.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_messages(convo_id = '3ku7w6h4vog2d', limit = 10)
bs_get_messages <- function(convo_id,
                            cursor = NULL,
                            limit = NULL,
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

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint
  req_url <- paste0(session_url, '/xrpc/chat.bsky.convo.getMessages')

  req <- httr2::request(req_url) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_headers('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat') |>
    httr2::req_url_query(
      convoId = convo_id,
      cursor = cursor,
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching messages')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_messages) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_messages <- function(resp) {
  resp |>
    purrr::pluck('messages') |>
    list_to_row() |>
    purrr::list_rbind() |>
    clean_names()
}
