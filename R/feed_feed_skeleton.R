# #' Get feed generator skeleton for an existing feed
# #'
# #' @param feed `r template_var_feed()`
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept feed
# #'
# #' @return
# #' @export
# #'
# #' @section Lexicon references:
# #' [feed/getFeedSkeleton.json (2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getFeedSkeleton.json)
# #'
# #' @section Function introduced:
# #' `v0.1.0` (2023-11-24)
# #'
# #' @examplesIf has_bluesky_pass() && has_bluesky_user()
# #' bs_get_feed_skeleton('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team')
# bs_get_feed_skeleton <- function(feed,
#                                  user = get_bluesky_user(), pass = get_bluesky_pass(),
#                                  auth = bs_auth(user, pass), clean = TRUE) {
#   req <- httr2::request('https://bsky.social/xrpc/com.atproto.feed.getFeedSkeleton') |>
#     httr2::req_url_query(feed = feed) |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt)
#   resp <- req |>
#     httr2::req_perform() |>
#     httr2::resp_body_json()
#   if (!clean) return(resp)
#
#   resp
# }
