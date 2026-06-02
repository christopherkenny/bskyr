#' Check or Get Bluesky App Password
#'
#' @concept auth
#'
#' @return logical if `has`, pass if `get`
#' @export
#'
#' @name pass
#'
#' @examples
#' has_bluesky_pass()
has_bluesky_pass <- function() {
  Sys.getenv('BLUESKY_APP_PASS') != ''
}

#' @rdname pass
#' @export
get_bluesky_pass <- function() {
  invisible(Sys.getenv('BLUESKY_APP_PASS'))
}

#' Add Entry to Renviron
#'
#' Adds Bluesky App Password to .Renviron.
#'
#' @param pass Character. App Password to add to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_PASS` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#' @param r_env Path to install to if `install` is `TRUE`.
#'
#' @concept auth
#'
#' @return pass, invisibly
#' @export
#'
#' @examples
#' example_env <- tempfile(fileext = '.Renviron')
#' set_bluesky_pass('1234-1234-1234-1234', r_env = example_env)
#' # r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
set_bluesky_pass <- function(pass, overwrite = FALSE, install = FALSE,
                             r_env = NULL) {
  if (missing(pass)) {
    cli::cli_abort('Input {.arg pass} cannot be missing.')
  }
  set_bluesky_env(
    value = pass, name = 'BLUESKY_APP_PASS', arg = 'pass',
    test_val = '1234-1234-1234-1234',
    test_val_msg = 'No password set when invalid test password is provided.',
    overwrite = overwrite, install = install, r_env = r_env
  )
}

#' @rdname pass
#' @export
bs_get_pass <- get_bluesky_pass


#' @rdname set_bluesky_pass
#' @export
bs_set_pass <- set_bluesky_pass

#' @rdname pass
#' @export
bs_has_pass <- has_bluesky_pass
