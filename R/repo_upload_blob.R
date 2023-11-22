# #' Upload a blob to a repo
# #'
# #' @param blob TODO
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept repo
# #'
# #' @section Lexicon references:
# #' [repo/uploadBlob.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/uploadBlob.json)
# #'
# #' @section Function introduced:
# #' `v0.0.1` (2023-10-02)
# #'
# #' @return a tibble with a single column and row for the count
# #' @export
# #'
# #' @examplesIf has_bluesky_pass() & has_bluesky_user()
# #' bs_upload_blob()
# bs_upload_blob <- function(blob,
#                            user = get_bluesky_user(), pass = get_bluesky_pass(),
#                            auth = bs_auth(user, pass), clean = TRUE) {
#
# }
