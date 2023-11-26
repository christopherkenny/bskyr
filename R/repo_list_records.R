#' List records in a repo
#'
#' @param repo `r template_var_repo()`
#' @param collection `r template_var_collection()`
#' @param limit `r template_var_limit(100L)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [repo/createRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return a [tibble::tibble] of record information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_list_records(repo = 'chriskenny.bsky.social', collection = 'app.bsky.feed.post')
bs_list_records <- function(repo, collection, limit = NULL,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(repo)) {
    repo <- auth$did
  }
  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    limit <- min(limit, 100L)
  }

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.listRecords') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      repo = repo,
      collection = collection,
      limit = limit
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('records') |>
    list_hoist() |>
    add_singletons(resp) |>
    clean_names()
}
