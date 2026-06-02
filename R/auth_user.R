#' Check or Get Bluesky User
#'
#' @concept auth
#'
#' @return logical if `has`, user if `get`
#' @export
#'
#' @name user
#'
#' @examples
#' has_bluesky_user()
has_bluesky_user <- function() {
  Sys.getenv('BLUESKY_APP_USER') != ''
}

#' @rdname user
#' @export
get_bluesky_user <- function() {
  Sys.getenv('BLUESKY_APP_USER')
}


#' Adds Bluesky User to .Renviron.
#'
#' @concept auth
#'
#' @param user Character. User to add to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_USER` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#' @param r_env Path to install to if `install` is `TRUE`.
#'
#' @return user, invisibly
#' @export
#'
#' @examples
#' example_env <- tempfile(fileext = '.Renviron')
#' set_bluesky_user('CRAN_EXAMPLE.bsky.social', r_env = example_env)
#' # r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
set_bluesky_user <- function(user, overwrite = FALSE, install = FALSE,
                             r_env = NULL) {
  if (missing(user)) {
    cli::cli_abort('Input {.arg user} cannot be missing.')
  }
  set_bluesky_env(
    value = user, name = 'BLUESKY_APP_USER', arg = 'user',
    test_val = 'CRAN_EXAMPLE.bsky.social',
    test_val_msg = 'No username set when invalid test username is provided.',
    overwrite = overwrite, install = install, r_env = r_env
  )
}

#' @rdname user
#' @export
bs_get_user <- get_bluesky_user


#' @rdname set_bluesky_user
#' @export
bs_set_user <- set_bluesky_user

#' @rdname user
#' @export
bs_has_user <- has_bluesky_user
