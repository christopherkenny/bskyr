#' Repost an existing post
#'
#' @param post `r template_var_post()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept record
#'
#' @section Lexicon references:
#' [feed/repost.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/repost.json)
#' [repo/createRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return a [tibble::tibble] of post information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_repost('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
bs_repost <- function(post,
                      user = get_bluesky_user(), pass = get_bluesky_pass(),
                      auth = bs_auth(user, pass), clean = TRUE) {
  post_rcd <- bs_get_record(post, auth = auth, clean = FALSE)

  repost <- list(
    subject = list(
      uri = post_rcd$uri,
      cid = post_rcd$cid
    ),
    createdAt = bs_created_at()
  )


  req <- bs_xrpc_request(
    endpoint = 'com.atproto.repo.createRecord',
    body = list(
      repo = auth$did,
      collection = 'app.bsky.feed.repost',
      record = repost
    ),
    auth = auth
  )

  resp <- req |>
    httr2::req_perform() |>
    bs_xrpc_response()

  if (!clean) {
    return(resp)
  }

  resp |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
