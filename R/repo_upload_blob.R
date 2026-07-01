#' Upload a blob to a repo
#'
#' @param blob `r template_var_blob()`
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
  lapply(blob, function(x) {
    n <- file.size(x)
    if (n > 1024 * 1024) {
      cli::cli_abort('File is larger than 1MB and exceeds allowable upload size.')
    }
  })
  mime_types <- mime::guess_type(blob)

  out <- lapply(seq_along(blob), function(i) {
    req <- bs_xrpc_request(
      endpoint = 'com.atproto.repo.uploadBlob',
      auth = auth,
      host = bs_pds(auth)
    ) |>
      httr2::req_headers(
        'Content-Type' = mime_types[[i]]
      ) |>
      httr2::req_body_file(
        path = blob[[i]]
      )
    resp <- req |>
      httr2::req_perform() |>
      bs_xrpc_response()
    if (!clean) {
      return(resp)
    }

    resp |>
      list_hoist() |>
      clean_names()
  })

  if (!clean) {
    return(out)
  }

  out |>
    purrr::list_rbind()
}
