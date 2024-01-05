#' Resolve a Handle to Decentralized Identifier (DID)
#'
#' @param handle `r template_var_handle()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept identity
#'
#' @section Lexicon references:
#' [identity/resolveHandle.json (2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/identity/resolveHandle.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-24)
#'
#' @return a [tibble::tibble] of decentralized identifier
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_resolve_handle('chriskenny.bsky.social')
bs_resolve_handle <- function(handle,
                              user = get_bluesky_user(), pass = get_bluesky_pass(),
                              auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(handle)) {
    cli::cli_abort('{.arg handle} must not be missing.')
  }

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.identity.resolveHandle') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_method('GET') |>
    httr2::req_url_query(
      handle = handle
    )
  resp <- NULL
  try({
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  }, silent = TRUE)

  if (is.null(resp)) {
    resp <- list(did = NA_character_)
  }
  if (!clean) {
    return(resp)
  }

  resp |>
    tibble::as_tibble() |>
    add_req_url(req)
}
