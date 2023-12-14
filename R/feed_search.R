#' Find posts matching search criteria
#'
#' @param query character. search query, Lucene query syntax is recommended.
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @section Lexicon references:
#' [feed/searchPosts.json (2023-12-13)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/searchPosts.json)
#'
#' @section Function introduced:
#' `v0.1.1` (2023-12-13)
#'
#' @return a [tibble::tibble] of suggested accounts to follow
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_search_posts('redistricting')
bs_search_posts <- function(query,  limit = NULL,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.searchPosts') |>
    httr2::req_url_query(q = query) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('posts') |>
    lapply(function(x) {
      lapply(x, function(y) {
        if (length(y) != 1) {
          list(y)
        } else {
          y
        }
      }) |>
        tibble::as_tibble_row()
    }) |>
    dplyr::bind_rows() |>
    add_singletons(resp) |>
    clean_names()
}
