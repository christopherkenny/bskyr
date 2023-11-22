# 2023-10-02 skipped as not listed at https://atproto.com/lexicons/app-bsky#appbskyfeed

# #' Find posts matching search criteria
# #'
# #' @param query character. search query, Lucene query syntax is recommended.
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept feed
# #'
# #' @section Lexicon references:
# #' [feed/searchPosts.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/searchPosts.json)
# #'
# #' @section Function introduced:
# #' `v0.0.1` (2023-10-02)
# #'
# #' @return a [tibble::tibble] of suggested accounts to follow
# #' @export
# #'
# #' @examplesIf has_bluesky_pass() & has_bluesky_user()
# #' bs_search_posts('redistricting')
# bs_search_posts <- function(query,
#                              user = get_bluesky_user(), pass = get_bluesky_pass(),
#                              auth = bs_auth(user, pass), clean = TRUE) {
#
#   req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.searchPosts') |>
#     httr2::req_url_query(q = query) |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt)
#
#   resp <- req |>
#     httr2::req_perform() |>
#     httr2::resp_body_json()
#
#   if (!clean) return(resp)
#
#   resp |>
#     purrr::pluck('posts') |>
#     proc() |>
#     clean_names()
# }
