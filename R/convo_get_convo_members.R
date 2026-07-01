#' Retrieve conversation shared among specified members
#'
#' @param actors character vector of actor(s), such as `'chriskenny.bsky.social'`
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
#' [chat.bsky.convo.getConvoForMembers.json (2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getConvoForMembers.json)
#'
#' @section Function introduced:
#' `v0.4.0` (2025-05-16)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_convo_for_members(actors = c('bskyr.bsky.social', 'chriskenny.bsky.social'))
bs_get_convo_for_members <- function(actors,
                                     user = get_bluesky_user(), pass = get_bluesky_pass(),
                                     auth = bs_auth(user, pass), clean = TRUE) {
  session_url <- auth$didDoc$service[[1]]$serviceEndpoint

  actors <- actors |>
    purrr::map_chr(function(x) bs_resolve_handle(x, auth = auth)$did) |>
    purrr::set_names(rep('members', length(actors)))

  req <- bs_xrpc_request(
    endpoint = 'chat.bsky.convo.getConvoForMembers',
    auth = auth,
    host = session_url,
    headers = list('Atproto-Proxy' = 'did:web:api.bsky.chat#bsky_chat')
  ) |>
    httr2::req_url_query(members = actors, .multi = 'explode')

  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('convo') |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
