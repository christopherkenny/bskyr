#' Get specific information about one feed generator
#'
#' @param feed `r template_var_feed()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#' @seealso [bs_get_feed_generators()] for less detailed information about multiple feed generators.
#'
#' @return a [tibble::tibble] of feeds
#' @export
#'
#' @section Lexicon references:
#' [feed/getFeedGenerator.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getFeedGenerator.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_feed_generator('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team')
bs_get_feed_generator <- function(feed,
                                  user = get_bluesky_user(), pass = get_bluesky_pass(),
                                  auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(feed)) {
    cli::cli_abort('{.arg feed} must list at least one user.')
  }
  if (!is.character(feed)) {
    cli::cli_abort('{.arg feed} must be a character vector.')
  }


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getFeedGenerator') |>
    httr2::req_url_query(feed = feed) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  dplyr::bind_cols(
    resp |> purrr::pluck('view') |> unlist() |> tibble::as_tibble_row(),
    tibble::tibble(
      isOnline = resp |> purrr::pluck('isOnline'),
      isValid = resp |> purrr::pluck('isValid')
    )
  ) |>
    clean_names()
}
