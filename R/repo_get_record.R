#' Get an arbitrary record from a repo
#'
#' @param repo `r template_var_repo()`
#' @param collection `r template_var_collection()`
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [repo/getRecord.json (2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/getRecord.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-24)
#'
#' @return a [tibble::tibble] of upload blob information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_record('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
bs_get_record <- function(repo = NULL, collection = NULL, rkey = NULL,
                          user = get_bluesky_user(), pass = get_bluesky_pass(),
                          auth = bs_auth(user, pass), clean = TRUE) {
  if (is.null(repo)) {
    cli::cli_abort('You must provide a {.arg repo}.')
  }

  # we can convert these
  if (stringr::str_starts(repo, 'https://') || stringr::str_starts(repo, 'at://')) {
    repo <- parse_uri(repo)
  }

  # allow it to be passed as a list from parse_uri for re-use
  if (is.list(repo)) {
    if (all(c('repo', 'collection', 'rkey') %in% names(repo))) {
      rkey <- repo$rkey
      collection <- repo$collection
      repo <- repo$repo
    } else {
      cli::cli_abort('If {.arg repo} is a list, it must have named objects: {.val repo}, {.val collection}, and {.val rkey}.')
    }
  }

  # but then we need these elements
  if (is.null(collection)) {
    cli::cli_abort('You must provide a {.arg collection}.')
  }
  if (is.null(rkey)) {
    cli::cli_abort('You must provide a {.arg rkey}.')
  }

  # make the request once we've collected everything
  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.getRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      repo = repo,
      collection = collection,
      rkey = rkey
    )
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('value') |>
    widen() |>
    add_singletons(resp) |>
    add_req_url(req)
}
