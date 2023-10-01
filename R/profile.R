bs_get_profile <- function(profile, user = get_bluesky_user(), pass = get_bluesky_pass()) {

  if (missing(profile)) {
    cli::cli_abort('{.arg profile} must list at least one user.')
  }

  auth <- bs_auth(user, pass)
  req <- httr2::request('https://bsky.social/xrpc/app.bsky.actor.getProfiles') |>
    httr2::req_url_query(actors = profile) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  resp |>
    proc_profile()
}
