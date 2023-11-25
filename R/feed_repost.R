#' Repost an existing post
#'
#' @param post Character vector, length 1. Link to a post to repost.
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @section Lexicon references:
#' [feed/post.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/repost.json)
#' [repo/createRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return a [tibble::tibble] of post information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
bs_repost <- function(post,
                      user = get_bluesky_user(), pass = get_bluesky_pass(),
                      auth = bs_auth(user, pass), clean = TRUE) {
  post_rcd <- bs_get_record(post, auth = auth, clean = FALSE)

  repost <- list(
    subject = list(
      uri = post_rcd$uri,
      cid = post_rcd$cid
    ),
    createdAt = format(lubridate::now('UTC'), format = '%Y-%m-%dT%H:%M:%OS6Z')
  )


  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.createRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_body_json(
      data = list(
        repo = auth$did,
        collection = 'app.bsky.feed.repost',
        record = repost
      )
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    tibble::as_tibble() |>
    clean_names()
}
