#' Delete a record in a repo
#'
#' @param collection `r template_var_collection()`
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [repo/deleteRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return an `httr2` status code
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' # get info about a record
#' post_rcd <- bs_get_record('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
#' # create a record, to like the post
#' like <- list(
#'   subject = list(
#'     uri = post_rcd$uri,
#'     cid = post_rcd$cid
#'   ),
#'   createdAt = bs_created_at()
#' )
#'
#' rec <- bs_create_record(collection = 'app.bsky.feed.like', record = like)
#' bs_delete_record(
#'   collection = 'app.bsky.feed.like',
#'   rkey = bs_extract_record_key(rec$uri)
#' )
bs_delete_record <- function(collection, rkey,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass)) {
  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.deleteRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_body_json(
      data = list(
        repo = auth$did,
        collection = collection,
        rkey = rkey
      )
    )

  resp <- req |>
    httr2::req_perform()

  resp |>
    httr2::resp_status()
}
