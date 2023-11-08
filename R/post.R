#' Make a post on Bluesky Social
#'
#' Note: This function currently only supports text posts. Further support
#' planned for version 0.1.0
#'
#' @param text text of post
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [feed/post.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
#' [repo/createRecord.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a tibble of post information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_post('Test post from R CMD Check for r package `bskyr`')
bs_post <- function(text,
                    user = get_bluesky_user(), pass = get_bluesky_pass(),
                    auth = bs_auth(user, pass)) {
  if (missing(text)) {
    cli::cli_abort('{.arg text} must not be missing.')
  }

  post <- list(
    `$type` = 'app.bsky.feed.post',
    text = text,
    createdAt = format(lubridate::now('UTC'), format = '%Y-%m-%dT%H:%M:%OS6Z')
  )

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.createRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_body_json(
      data = list(
        repo = auth$did,
        collection = 'app.bsky.feed.post',
        record = post
      )
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    dplyr::bind_rows() |>
    clean_names()
}
