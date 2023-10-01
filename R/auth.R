#' Authenticate a user
#'
#' @param user Character. User name to log in with.
#' @param pass Character. App password to log in with.
#'
#' @concept auth
#'
#' @return a list of authentication information
#' @export
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_auth(user = get_bluesky_user(), pass = get_bluesky_pass())
bs_auth <- function(user, pass) {
  if (missing(user)) {
    cli::cli_abort('{.arg user} must not be missing.')
  }
  if (missing(pass)) {
    cli::cli_abort('{.arg pass} must not be missing.')
  }
  validate_pass(pass)
  req <- httr2::request('https://bsky.social/xrpc/com.atproto.server.createSession') |>
    httr2::req_body_json(
      data = list(
        identifier = user, password = pass
      )
    )

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    invisible()
}
