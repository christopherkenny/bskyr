#' Get information on one starter pack
#'
#' @param starter_pack `r template_var_starter_pack()`
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
#' [graph/getStarterPack.json (2024-11-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getStarterPack.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-11-20)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_starter_pack(
#'   'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r'
#' )
bs_get_starter_pack <- function(starter_pack,
                                user = get_bluesky_user(), pass = get_bluesky_pass(),
                                auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(starter_pack)) {
    cli::cli_abort('{.arg starter_pack} must list at least one user.')
  }
  if (!is.character(starter_pack)) {
    cli::cli_abort('{.arg starter_pack} must be a character vector.')
  }


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getStarterPack') |>
    httr2::req_url_query(starterPack = starter_pack) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('starterPack') |>
    widen() |>
    tidyr::unnest_wider(col = dplyr::any_of('record'), names_sep = '_', simplify = TRUE) |>
    dplyr::mutate(
      dplyr::across(dplyr::any_of(c('feeds')), .fns = function(x) lapply(x, list_hoist)),
      dplyr::across(dplyr::any_of(c('list', 'listItemsSample')), .fns = function(x) lapply(x, widen)),
    ) |>
    add_req_url(req) |>
    add_cursor(resp) |>
    clean_names()
}
