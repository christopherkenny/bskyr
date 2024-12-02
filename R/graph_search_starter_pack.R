#XRPCNotSupported 2024-12-01

# #' Search for starter packs
# #'
# #' @param query `r template_var_query()`
# #' @param cursor `r template_var_cursor()`
# #' @param limit `r template_var_limit(100)`
# #' @param user `r template_var_user()`
# #' @param pass `r template_var_pass()`
# #' @param auth `r template_var_auth()`
# #' @param clean `r template_var_clean()`
# #'
# #' @concept graph
# #'
# #' @section Lexicon references:
# #' [graph/searchStarterPacks.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/searchStarterPacks.json)
# #'
# #' @section Function introduced:
# #' `v0.2.0` (2024-12-01)
# #'
# #' @return a [tibble::tibble] of starter packs
# #' @export
# #'
# #' @examplesIf has_bluesky_pass() & has_bluesky_user()
# #' bs_search_starter_packs('redistricting')
# #' bs_search_posts('rstats')
# bs_search_starter_packs <- function(query,
#                                     cursor = NULL, limit = NULL,
#                                     user = get_bluesky_user(), pass = get_bluesky_pass(),
#                                     auth = bs_auth(user, pass), clean = TRUE) {
#   if (missing(query)) {
#     cli::cli_abort('{.arg query} must be present.')
#   }
#
#   if (!is.null(limit)) {
#     if (!is.numeric(limit)) {
#       cli::cli_abort('{.arg limit} must be numeric.')
#     }
#     limit <- as.integer(limit)
#     limit <- max(limit, 1L)
#     req_seq <- diff(unique(c(seq(0, limit, 100), limit)))
#   } else {
#     req_seq <- list(NULL)
#   }
#
#   req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.searchStarterPacks') |>
#     httr2::req_url_query(
#       q = query
#     ) |>
#     httr2::req_auth_bearer_token(token = auth$accessJwt) |>
#     httr2::req_url_query(
#       limit = limit
#     )
#
#   resp <- repeat_request(req, req_seq, cursor, txt = 'Searching starter packs')
#
#   if (!clean) {
#     return(resp)
#   }
#
#   resp #|>
#     # lapply(process_search_posts) |>
#     # purrr::list_rbind() |>
#     # add_req_url(req) |>
#     # add_cursor(resp)
#
# }
