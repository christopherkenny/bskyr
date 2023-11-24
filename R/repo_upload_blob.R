#' Upload a blob to a repo
#'
#' @param blob files to upload to a repo
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [repo/uploadBlob.json (2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/uploadBlob.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-24)
#'
#' @return a [tibble::tibble] of upload blob information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' fig <- fs::path_package('bskyr', 'man/figures/logo.png')
#' bs_upload_blob(fig)
bs_upload_blob <- function(blob,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {

  types <- fs::path_ext(blob)
  raw_data <- lapply(blob, function(x) readBin(x, what = 'raw', n = file.size(x)))
  mime_types <- mime::guess_type(blob)

  out <- lapply(seq_along(blob), function(i) {
    req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.uploadBlob') |>
      httr2::req_auth_bearer_token(token = auth$accessJwt) |>
      httr2::req_headers(
        'Content-Type' = mime_types[[i]]
      ) |>
      httr2::req_body_raw(
        raw_data[[i]]
      )
    resp <- req |>
      httr2::req_perform() |>
      httr2::resp_body_json()
    if (!clean) return(resp)

    resp |>
      list_hoist() |>
      clean_names()
  })

  if (!clean) return(out)
  out |>
    purrr::list_rbind()
}
