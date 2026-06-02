#' Upload a video to be processed and stored
#'
#' @param video `r template_var_video()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [video/uploadVideo.json (2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/uploadVideo.json)
#' [video/getJobStatus.json (2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/getJobStatus.json)
#'
#' @section Function introduced:
#' `v0.5.0` (2026-06-01)
#'
#' @return a blob reference list, compatible with `bs_post()`
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' vid <- fs::path_package('bskyr', 'man/figures/pkgs.mp4')
#' bs_upload_video(vid)
bs_upload_video <- function(video,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass)) {
  n <- fs::file_size(video)
  if (n > 100 * 1024 * 1024) {
    cli::cli_abort('File is larger than 100MB and exceeds allowable upload size.')
  }

  mime_type <- mime::guess_type(video)

  video_token <- bs_get_service_token(auth, lxm = 'com.atproto.repo.uploadBlob')

  req <- httr2::request(paste0('https://video.bsky.app/xrpc/app.bsky.video.uploadVideo?did=', auth$did, '&name=', utils::URLencode(basename(video), reserved = TRUE))) |>
    httr2::req_auth_bearer_token(token = video_token) |>
    httr2::req_headers('Content-Type' = mime_type) |>
    httr2::req_body_file(path = video)

  resp <- req |>
    httr2::req_error(is_error = \(r) httr2::resp_status(r) != 409) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!is.null(resp$jobStatus)) {
    job_id <- resp$jobStatus$jobId
  } else {
    job_id <- resp$jobId
  }

  status_token <- bs_get_service_token(auth, lxm = 'app.bsky.video.getJobStatus')

  repeat {
    status_req <- httr2::request('https://video.bsky.app/xrpc/app.bsky.video.getJobStatus') |>
      httr2::req_auth_bearer_token(token = status_token) |>
      httr2::req_url_query(jobId = job_id)

    status <- status_req |>
      httr2::req_perform() |>
      httr2::resp_body_json()

    state <- status$jobStatus$state

    if (state == 'JOB_STATE_COMPLETED') {
      return(list(list(blob = status$jobStatus$blob)))
    } else if (state == 'JOB_STATE_FAILED') {
      cli::cli_abort('Video processing failed: {status$jobStatus$error}')
    }

    Sys.sleep(2)
  }
}
