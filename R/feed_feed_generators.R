#' Get information about a list of feed generators
#'
#' @param feeds `r template_var_feeds()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#' @seealso [bs_get_feed_generators()] for more detailed information about one feed generator.
#'
#' @return a [tibble::tibble] of feeds
#' @export
#'
#' @section Lexicon references:
#' [feed/getFeedGenerators.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getFeedGenerators.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_feed_generators('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team')
#' bs_get_feed_generators(c(
#'   'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team',
#'   'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot'
#'   ))
bs_get_feed_generators <- function(feeds,
                                   user = get_bluesky_user(), pass = get_bluesky_pass(),
                                   auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(feeds)) {
    cli::cli_abort('{.arg feeds} must list at least one user.')
  }
  if (!is.character(feeds)) {
    cli::cli_abort('{.arg feeds} must be a character vector.')
  }


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getFeedGenerators')

  feeds <- feeds |> as.list() |> purrr::set_names('feeds')
  req <- rlang::inject(httr2::req_url_query(req, !!!feeds))

  req <- req |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('feeds') |>
    proc() |>
    clean_names()
}
