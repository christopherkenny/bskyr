bs_auth <- function(user, pass) {
  req <- httr2::request('https://bsky.social/xrpc/com.atproto.server.createSession') |>
    httr2::req_body_json(
      data = list(
        identifier = user, password = pass
      )
    )

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
