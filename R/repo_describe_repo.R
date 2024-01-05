#' Describe a repo
#'
#' @param repo `r template_var_repo()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept repo
#'
#' @section Lexicon references:
#' [repo/describeRepo.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/describeRepo.json)
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return a [tibble::tibble] of record information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_describe_repo('chriskenny.bsky.social')
bs_describe_repo <- function(repo,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass), clean = TRUE) {

  if (missing(repo)) {
    repo <- auth$did
  }

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.describeRepo') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      repo = repo
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    widen(i = 3) |>
    clean_names() |>
    add_req_url(req)

}
