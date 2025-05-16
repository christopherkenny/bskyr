#' Follow an account
#'
#' @param subject `r template_var_subject()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept record
#'
#' @return a [tibble::tibble] of follow information
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
#' [repo/createRecord.json (2024-12-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_follow(subject = 'chriskenny.bsky.social')
bs_follow <- function(subject,
                      user = get_bluesky_user(), pass = get_bluesky_pass(),
                      auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(subject)) {
    cli::cli_abort('{.arg subject} must not be missing.')
  }

  if (!is_user_did(subject)) {
    subject <- bs_resolve_handle(subject, auth = auth)$did
  }

  rec <- list(
    `$type` = 'app.bsky.graph.follow',
    'subject' = subject,
    createdAt = bs_created_at()
  )

  bs_create_record(
    collection = 'app.bsky.graph.follow',
    record = rec,
    auth = auth,
    clean = clean
  )
}
