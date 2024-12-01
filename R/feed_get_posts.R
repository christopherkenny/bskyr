#' Retrieve thread of posts
#'
#' @param uris `r template_var_uris()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of posts
#' @export
#'
#' @section Lexicon references:
#' [feed/getPostThread.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getPostThread.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_posts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
#' bs_get_posts('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
bs_get_posts <- function(uris,
                         user = get_bluesky_user(), pass = get_bluesky_pass(),
                         auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(uris)) {
    cli::cli_abort('{.arg uris} must list at least one uri.')
  }
  if (!is.character(uris)) {
    cli::cli_abort('{.arg uris} must be a character vector.')
  }

  uris <- purrr::map_chr(uris, function(x) {
    if (stringr::str_detect(x, '^http')) {
      bs_url_to_uri(x, auth = auth)
    } else{
      x
    }
  })

  uris <- uris |>
    as.list() |>
    purrr::set_names('uris')

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getPosts')
  req <- rlang::inject(httr2::req_url_query(req, !!!uris))
  req <- req |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  out <- resp |>
    purrr::pluck('posts') |>
    proc_posts()

  out |>
    add_req_url(req) |>
    clean_names()
}
