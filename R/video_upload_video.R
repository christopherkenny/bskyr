# #' Upload a video to a repo
# #'
# #' @param video `r template_var_video()`
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept repo
# #'
# #' @section Lexicon references:
# #' [video/uploadVideo.json (2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/video/uploadVideo.json)
# #'
# #' @section Function introduced:
# #' `v0.2.0` (2024-11-23)
# #'
# #' @return a [tibble::tibble] of upload video information
# #' @export
# #'
# #' @examplesIf has_bluesky_pass() & has_bluesky_user()
# #' vid <- fs::path_package('bskyr', 'man/figures/pkgs.mp4')
# #' bs_upload_video(vid)
# bs_upload_video <- function(video,
#                            user = get_bluesky_user(), pass = get_bluesky_pass(),
#                            auth = bs_auth(user, pass), clean = TRUE) {
#
#   types <- fs::path_ext(video)
#   raw_data <- readBin(video, what = 'raw', n = file.size(video))
#   mime_type <- mime::guess_type(video)
#
#   req <- httr2::request('https://bsky.social/xrpc/app.bsky.video.uploadVideo') |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt) |>
#     httr2::req_headers(
#       'Content-Type' = mime_type
#     ) |>
#     httr2::req_body_raw(
#       raw_data
#     )
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
