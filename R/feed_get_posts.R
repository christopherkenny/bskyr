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
bs_get_posts <- function(uris,
                         user = get_bluesky_user(), pass = get_bluesky_pass(),
                         auth = bs_auth(user, pass), clean = TRUE) {
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

  if (!clean) return(resp)

  resp <- resp |>
    purrr::pluck('posts')

  out <- lapply(resp, function(x) {
    x |>
      unlist(recursive = FALSE) |>
      lapply(function(z) {
        if (length(z) != 1) {
          list(z)
        } else {
          z
        }
      }) |>
      tibble::as_tibble_row()
  }) |>
    dplyr::bind_rows() |>
    clean_names()

  out <- out |>
    dplyr::mutate(
      dplyr::across(where(is.list) & where(~purrr::pluck_depth(.x) > 2),
                    function(x) lapply(x, function(x) clean_names(proc(x))))
    )

  # out$record_embed <- lapply(out$record_embed, proc)
  # out$embed_images <- lapply(out$embed_images, proc)

  out |>
    add_req_url(req)
}
