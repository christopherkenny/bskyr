bs_xrpc_request <- function(
  endpoint,
  auth,
  host = NULL,
  query = NULL,
  body = NULL,
  headers = NULL
) {
  if (is.null(host)) {
    if (is.null(body)) {
      host <- get_bluesky_appview()
    } else {
      host <- bs_pds(auth)
    }
  }

  req <- httr2::request(paste0(host, '/xrpc/', endpoint)) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_user_agent('bskyr') |>
    httr2::req_retry() |>
    httr2::req_error(is_error = function(resp) FALSE)

  if (!is.null(headers)) {
    req <- rlang::inject(httr2::req_headers(req, !!!headers))
  }

  if (!is.null(query)) {
    req <- rlang::inject(httr2::req_url_query(req, !!!query))
  }

  if (!is.null(body)) {
    req <- httr2::req_body_json(req, body)
  }

  req
}

bs_xrpc_response <- function(resp) {
  body <- resp |>
    httr2::resp_body_json()

  if (httr2::resp_is_error(resp)) {
    cli::cli_abort(c(
      'Bluesky API request failed.',
      x = body$error %||% httr2::resp_status_desc(resp),
      i = body$message %||% paste('HTTP status', httr2::resp_status(resp))
    ))
  }

  body
}
