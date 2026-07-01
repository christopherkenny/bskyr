#' List the conversations (direct message threads) for the authenticated user
#'
#' @param read_state Character, optional. Filter by read state, one of `c('unread')`.
#' Default: `NULL`.
#' @param status Character, optional. Filter by conversation status, one of
#' `c('accepted', 'request')`. Default: `NULL`.
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
#' [chat.bsky.convo.listConvos.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/listConvos.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_list_convos(limit = 5, status = 'accepted')
bs_list_convos <- function(read_state = NULL, status = NULL,
                           cursor = NULL, limit = NULL,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {
  limit <- validate_limit(limit)
  req_seq <- make_req_seq(limit)

  session_url <- auth$didDoc$service[[1]]$serviceEndpoint

  req <- bs_xrpc_request(
    endpoint = 'chat.bsky.convo.listConvos',
    query = list(
      cursor = cursor,
      limit = limit,
      readState = read_state,
      status = status
    ),
    auth = auth,
    host = session_url,
    headers = list('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat')
  )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Fetching conversations')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_convos) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_convos <- function(resp) {
  resp |>
    purrr::pluck('convos') |>
    list_to_row() |>
    purrr::list_rbind() |>
    clean_names()
}
