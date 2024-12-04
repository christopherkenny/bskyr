#' Create a new starter pack
#'
#' @param name Character. Display name for starter pack
#' @param list Character. List to base the starter pack on. If not provided,
#' a new list will be created.
#' @param description Optional character. Description of the list.
#' @param feeds Optional character. List of feed items to include in starter pack.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept record
#'
#' @section Lexicon references:
#' [graph/starterpack.json (2024-12-04)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/starterpack.json)
#' [repo/createRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-04)
#'
#' @return a [tibble::tibble] of post information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_new_starter_pack('bskyr test')
bs_new_starter_pack <- function(name, list, description, feeds,
                      user = get_bluesky_user(), pass = get_bluesky_pass(),
                      auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(name)) {
    cli::cli_abort('{.arg name} must not be missing.')
  }

  if (missing(list)) {
    list <- bs_new_list(name = name, purpose = 'curatelist',
                        description = description, auth = auth)
  }

  if (is.data.frame(list)) {
    list <- list$uri
  }

  rec <- list(
    `$type` = 'app.bsky.graph.starterpack',
    'name' = name,
    'list' = list,
    createdAt = bs_created_at()
  )

  if (!missing(description)) {
    rec$description <- description
  }

  if (!missing(feeds)) {
    rec$feeds <- feeds
  }

  bs_create_record(
    collection = 'app.bsky.graph.starterpack',
    record = rec,
    auth = auth,
    clean = clean
  )
}
