#' Get information about a list of starter packs
#'
#' @param starter_packs `r template_var_starter_packs()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of starter packs
#' @export
#'
#' @section Lexicon references:
#' [graph/getStarterPacks.json (2024-11-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getStarterPacks.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-11-20)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_starter_packs(
#'   'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r'
#' )
#' bs_get_starter_packs(
#'   c('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r',
#'   'at://did:plc:bmc56x6ksb7o7sdkq2fgm7se/app.bsky.graph.starterpack/3laywns2q2v27')
#' )
bs_get_starter_packs <- function(starter_packs,
                                user = get_bluesky_user(), pass = get_bluesky_pass(),
                                auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(starter_packs)) {
    cli::cli_abort('{.arg starter_pack} must list at least one user.')
  }
  if (!is.character(starter_packs)) {
    cli::cli_abort('{.arg starter_pack} must be a character vector.')
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getStarterPacks')

  uris <- starter_packs |>
    as.list() |>
    purrr::set_names('uris')
  req <- rlang::inject(httr2::req_url_query(req, !!!uris))

  req <- req |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    process_starter_packs() |>
    add_req_url(req) |>
    add_cursor(resp) |>
    clean_names()
}

