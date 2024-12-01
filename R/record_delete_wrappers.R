#' Delete a list
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
#' [repo/deleteRecord.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' lst <- bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
#' bs_delete_list(stringr::str_split_i(lst$uri, pattern = '/', 5))
bs_delete_list <- function(rkey,
                        user = get_bluesky_user(), pass = get_bluesky_pass(),
                        auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.list',
    rkey = rkey,
    auth = auth
  )
}
