#' Add a subject to a list
#'
#' @param subject `r template_var_subject()`
#' @param uri Character, length 1. URI of the list to add the subject to.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept record
#'
#' @return a [tibble::tibble] of list item information
#' @export
#'
#' @section Lexicon references:
#' [graph/listitem.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
#' [repo/createRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' lst <- bs_new_list(name = 'test list listitem bskyr', purpose = 'curatelist')
#' bs_new_list_item(subject = 'chriskenny.bsky.social', uri = lst$uri)
#' # see the list item
#' bs_get_list(lst$uri)
bs_new_list_item <- function(subject, uri,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(subject)) {
    cli::cli_abort('{.arg subject} must not be missing.')
  }

  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must not be missing.')
  }

  if (!is_user_did(subject)) {
    subject <- bs_resolve_handle(subject, auth = auth)$did
  }

  rec <- list(
    `$type` = 'app.bsky.graph.listitem',
    'subject' = subject,
    'list' = uri,
    createdAt = bs_created_at()
  )

  bs_create_record(
    collection = 'app.bsky.graph.listitem',
    record = rec,
    auth = auth,
    clean = clean
  )
}
