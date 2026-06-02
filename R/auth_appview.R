#' Check or Get Bluesky AppView
#'
#' @concept auth
#'
#' @return logical if `has`, AppView URL if `get`
#' @export
#'
#' @name appview
#'
#' @examples
#' has_bluesky_appview()
has_bluesky_appview <- function() {
  Sys.getenv('BLUESKY_APP_APPVIEW') != ''
}

#' @rdname appview
#' @export
get_bluesky_appview <- function() {
  appview <- Sys.getenv('BLUESKY_APP_APPVIEW')
  if (appview == '') 'https://bsky.social' else appview
}

#' Adds Bluesky AppView to .Renviron.
#'
#' @concept auth
#'
#' @param appview Character. Base URL of the AppView server to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_APPVIEW` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#' @param r_env Path to install to if `install` is `TRUE`.
#'
#' @return appview, invisibly
#' @export
#'
#' @examples
#' example_env <- tempfile(fileext = '.Renviron')
#' set_bluesky_appview('https://bsky.social', r_env = example_env)
#' # r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
set_bluesky_appview <- function(appview, overwrite = FALSE, install = FALSE,
                                r_env = NULL) {
  if (missing(appview)) {
    cli::cli_abort('Input {.arg appview} cannot be missing.')
  }
  set_bluesky_env(
    value = appview, name = 'BLUESKY_APP_APPVIEW', arg = 'appview',
    overwrite = overwrite, install = install, r_env = r_env
  )
}

#' @rdname appview
#' @export
bs_get_appview <- get_bluesky_appview

#' @rdname set_bluesky_appview
#' @export
bs_set_appview <- set_bluesky_appview

#' @rdname appview
#' @export
bs_has_appview <- has_bluesky_appview
