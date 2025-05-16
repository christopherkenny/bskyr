#' Authenticate a user
#'
#' @param user Character. User name to log in with.
#' @param pass Character. App password to log in with.
#' @param save_auth Logical. Should the authentication information be saved? If
#' `TRUE`, it tries to reload from the cache. If a file is over 10 minutes old,
#' it will not be read. Set `save_auth = NULL` to force the token to refresh and
#' save the results.
#'
#' @concept auth
#'
#' @return a list of authentication information
#' @export
#'
#' @section Lexicon references:
#' [server/createSession.json (2023-09-30)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/server/createSession.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-09-30)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_auth(user = get_bluesky_user(), pass = get_bluesky_pass())
bs_auth <- function(user, pass, save_auth = TRUE) {
  if (missing(user)) {
    cli::cli_abort('{.arg user} must not be missing.')
  }
  if (missing(pass)) {
    cli::cli_abort('{.arg pass} must not be missing.')
  }

  if (is.null(save_auth)) {
    if (fs::file_exists(bs_auth_file())) {
      fs::file_delete(bs_auth_file())
    }
    save_auth <- TRUE
  }
  if (!is.logical(save_auth)) {
    cli::cli_abort('{.arg save_auth} must be a logical.')
  }

  validate_user(user)
  validate_pass(pass)

  if (save_auth) {
    auth <- bs_cache_auth(user, pass)
  } else {
    auth <- bs_create_auth(user, pass)
  }

  invisible(auth)
}

bs_create_auth <- function(user, pass) {
  req <- httr2::request('https://bsky.social/xrpc/com.atproto.server.createSession') |>
    httr2::req_body_json(
      data = list(
        identifier = user, password = pass
      )
    )

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    invisible()

  out$bskyr_created_time <- lubridate::now()

  out
}

# read from existing auth or create if too old
bs_cache_auth <- function(user, pass) {
  fs::dir_create(fs::path_dir(bs_auth_file()))
  if (fs::file_exists(bs_auth_file())) {
    # if (bs_has_user()) {
    #   auth <- httr2::secret_read_rds(bs_auth_file(), key = 'BLUESKY_APP_USER')
    # } else {
    auth <- readRDS(bs_auth_file())
    # }
    if (bs_auth_is_valid(auth)) {
      return(auth)
    }
  }

  auth <- bs_create_auth(user, pass)
  # if (bs_has_user()) {
  #   httr2::secret_write_rds(auth, path = bs_auth_file(), key = 'BLUESKY_APP_USER')
  # } else {
  saveRDS(auth, bs_auth_file())
  # }
  auth
}

bs_auth_file <- function() {
  tools::R_user_dir('bskyr', 'config') |>
    fs::path('bs_auth.rds')
}

bs_auth_is_valid <- function(auth) {
  now <- lubridate::now()
  created <- auth$bskyr_created_time
  if (is.null(created)) {
    return(FALSE)
  }
  diff <- now - created
  diff < lubridate::dminutes(10)
}
