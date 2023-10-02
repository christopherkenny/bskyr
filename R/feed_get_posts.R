#' Retrieve thread of posts
#'
#' @param uris `r template_var_uris()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept feed
#'
#' @return a tibble of posts
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
bs_get_posts <- function(uris,
                         user = get_bluesky_user(), pass = get_bluesky_pass(),
                         auth = bs_auth(user, pass)) {
  if (missing(uris)) {
    cli::cli_abort('{.arg uris} must list at least one uri.')
  }
  if (!is.character(uris)) {
    cli::cli_abort('{.arg uris} must be a character vector.')
  }

  uris <- uris |> as.list() |> purrr::set_names('uris')

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getPosts')
  req <- rlang::inject(httr2::req_url_query(req, !!!uris))
  req <- req |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp <- resp |>
    purrr::pluck('posts')

  out <- lapply(resp, function(x) {
    y <- unlist(x, recursive = FALSE)
    y <- lapply(y, function(z) {
      if (length(z) != 1) {
        list(z)
      } else {
        z
      }
    })
    tibble::as_tibble_row(y)
  }) |>
    dplyr::bind_rows() |>
    clean_names()

  out
}
