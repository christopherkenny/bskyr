#' Create a list
#'
#' @param name Character. Display name for list.
#' @param purpose Purpose of the list. One of `'modlist'`, `'curatelist'`, or `'referencelist'`
#' @param description Optional character. Description of the list.
#' @param avatar Optional character. Path to image to use as avatar. PNG or JPEG recommended.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of lists
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
#' [graph/defs.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/defs.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
#' bs_new_list(name = 'test list bskyr w avatar',
#'   description = 'to be deleted, just for testing bskyr',
#'   avatar = fs::path_package('bskyr', 'man/figures/logo.png'),
#'   purpose = 'curatelist')
bs_new_list <- function(name, purpose, description, avatar,
                    user = get_bluesky_user(), pass = get_bluesky_pass(),
                    auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(name)) {
    cli::cli_abort('{.arg name} must not be missing.')
  }

  if (missing(purpose)) {
    cli::cli_abort('{.arg purpose} must not be missing.')
  }

  rec <- list(
    `$type` = 'app.bsky.graph.list',
    'purpose' = paste0('app.bsky.graph.defs#', purpose),
    'name' = name,
    createdAt = bs_created_at()
  )

  if (!missing(description)) {
    rec$description <- description
  }

  if (!missing(avatar)) {
    if (is.list(avatar)) {
      # then we assume it's a blob
      blob <- avatar
    } else {
      # otherwise it's a set of paths
      blob <- bs_upload_blob(avatar, auth = auth, clean = FALSE)
    }

    rec$avatar <- blob[[1]]$blob
  }

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.createRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_body_json(
      data = list(
        repo = auth$did,
        collection = 'app.bsky.graph.list',
        record = rec
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
