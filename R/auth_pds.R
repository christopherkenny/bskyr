#' Check or Get Bluesky PDS
#'
#' @concept auth
#'
#' @return logical if `has`, PDS URL if `get`
#' @export
#'
#' @name pds
#'
#' @examples
#' has_bluesky_pds()
has_bluesky_pds <- function() {
  Sys.getenv('BLUESKY_APP_PDS') != ''
}

#' @rdname pds
#' @export
get_bluesky_pds <- function() {
  pds <- Sys.getenv('BLUESKY_APP_PDS')
  if (pds == '') 'https://bsky.social' else pds
}

#' Adds Bluesky PDS to .Renviron.
#'
#' @concept auth
#'
#' @param pds Character. Base URL of the Personal Data Server to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_PDS` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#' @param r_env Path to install to if `install` is `TRUE`.
#'
#' @return pds, invisibly
#' @export
#'
#' @examples
#' example_env <- tempfile(fileext = '.Renviron')
#' set_bluesky_pds('https://bsky.social', r_env = example_env)
#' # r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
set_bluesky_pds <- function(pds, overwrite = FALSE, install = FALSE,
                            r_env = NULL) {
  if (missing(pds)) {
    cli::cli_abort('Input {.arg pds} cannot be missing.')
  }
  set_bluesky_env(
    value = pds, name = 'BLUESKY_APP_PDS', arg = 'pds',
    overwrite = overwrite, install = install, r_env = r_env
  )
}

#' @rdname pds
#' @export
bs_get_pds <- get_bluesky_pds

#' @rdname set_bluesky_pds
#' @export
bs_set_pds <- set_bluesky_pds

#' @rdname pds
#' @export
bs_has_pds <- has_bluesky_pds
