#' Make a post on Bluesky Social
#'
#' @param text text of post
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [feed/post.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
#' [repo/createRecord.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return TODO
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_notification_count()
bs_post <- function(text,
                    user = get_bluesky_user(), pass = get_bluesky_pass(),
                    auth = bs_auth(user, pass)) {
  if (missing(text)) {
    cli::cli_abort('{.arg text} must not be missing.')
  }

}
