#' Retrieve the user's home timeline
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getTimeline.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getTimeline.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_timeline()
bs_get_timeline <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getTimeline') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  out <- resp |>
    purrr::pluck('feed') |>
    lapply(function(x) {
      x |>
        unlist(recursive = FALSE) |>
        lapply(function(z) {
          if (length(z) != 1) {
            list(z)
          } else {
            z
          }
        }) |>
        tibble::as_tibble_row()
    }) |>
    dplyr::bind_rows() |>
    clean_names()

  out <- out |>
    dplyr::mutate(
      post_author = proc(.data$post_author),
      post_record = lapply(.data$post_record, widen),
      post_embed = lapply(.data$post_embed, widen)
    ) |>
    add_singletons(resp)

  out
}
