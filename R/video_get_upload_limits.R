# #' Get Video Upload Limits
# #'
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept video
# #'
# #' @return a [tibble::tibble] of video upload allowances
# #' @export
# #'
# #' @section Lexicon references:
# #' [video/getUploadLimits.json (2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/getUploadLimits.json)
# #'
# #' @section Function introduced:
# #' `v0.2.0` (2024-11-23)
# #'
# #' @examplesIf has_bluesky_pass() && has_bluesky_user()
# #' bs_get_video_upload_limits()
# bs_get_video_upload_limits <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
#                                auth = bs_auth(user, pass), clean = TRUE) {
#
#   req <- httr2::request('https://bsky.social/xrpc/app.bsky.video.getUploadLimits') |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt)
#
#   resp <- req |>
#     httr2::req_perform() |>
#     httr2::resp_body_json()
#
#   if (!clean) {
#     return(resp)
#   }
#
#   resp
# }
#
