#' Get Video Upload Limits
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept video
#'
#' @return a [tibble::tibble] of video upload allowances, or a list if `clean = FALSE`
#' @export
#'
#' @section Lexicon references:
#' [video/getUploadLimits.json (2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/getUploadLimits.json)
#'
#' @section Function introduced:
#' `v0.5.0` (2026-06-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_video_upload_limits()
bs_get_video_upload_limits <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                                       auth = bs_auth(user, pass), clean = TRUE) {
  video_token <- bs_get_service_token(auth, lxm = 'app.bsky.video.getUploadLimits', aud = 'did:web:video.bsky.app')

  req <- httr2::request('https://video.bsky.app/xrpc/app.bsky.video.getUploadLimits') |>
    httr2::req_auth_bearer_token(token = video_token)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    tibble::as_tibble_row() |>
    clean_names()
}
