#' Get a list of actors suggested for following
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_user()`
#'
#' @concept actor
#'
#' @return a tibble of suggested accounts to follow
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_get_suggestions
bs_get_suggestions <- function(user = get_bluesky_user(), pass = get_bluesky_pass()) {
  auth <- bs_auth(user, pass)
  req <- httr2::request('https://bsky.social/xrpc/app.bsky.actor.getSuggestions') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    purrr::pluck('actors') |>
    proc() |>
    clean_names()
}
