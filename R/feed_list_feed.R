# 2023-10-02 skipped as not listed at https://atproto.com/lexicons/app-bsky#appbskyfeed

# #' Retrieve recent posts from actors in a list
# #'
# #' @param actors `r template_var_actors()`
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept feed
# #'
# #' @return a tibble of likes
# #' @export
# #'
# #' @section Lexicon references:
# #' [feed/getListFeed.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getListFeed.json)
# #'
# #' @section Function introduced:
# #' `v0.0.1` (2023-10-01)
# #'
# #' @examplesIf has_bluesky_pass() && has_bluesky_user()
# #' bs_get_post_likes('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
# bs_get_post_likes <- function(actors,
#                               user = get_bluesky_user(), pass = get_bluesky_pass(),
#                               auth = bs_auth(user, pass), clean = TRUE) {
#   if (missing(actors)) {
#     cli::cli_abort('{.arg actors} must list at least one user.')
#   }
#   if (!is.character(actors)) {
#     cli::cli_abort('{.arg actors} must be a character vector.')
#   }
#
#   req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getListFeed') |>
#     httr2::req_url_query(list = actors) |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt)
#
#   resp <- req |>
#     httr2::req_perform() |>
#     httr2::resp_body_json()
#
#   if (!clean) return(resp)
#
#   resp |>
#     purrr::pluck('feed') |>
#     proc() |>
#     add_singletons(l = resp) |>
#     clean_names()
# }
