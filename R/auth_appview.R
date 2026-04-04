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
  name <- 'BLUESKY_APP_APPVIEW'

  appview <- list(appview)
  names(appview) <- name

  if (install) {
    if (is.null(r_env)) {
      r_env <- file.path(Sys.getenv('HOME'), '.Renviron')
      if (interactive()) {
        utils::askYesNo(paste0('Install to', r_env, '?'))
      } else {
        cli::cli_abort(c('No path set and not run interactively.',
          i = 'Rerun with {.arg r_env} set, possibly to {.file {r_env}}'
        ))
      }
    }

    if (!file.exists(r_env)) {
      file.create(r_env)
    }

    lines <- readLines(r_env)
    newline <- paste0(name, "='", appview, "'")

    exists <- grepl(x = lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort('Multiple entries in .Renviron found.\nEdit manually with {.fn usethis::edit_r_environ}.')
      }

      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, appview)
      } else {
        cli::cli_inform('{.arg BLUESKY_APP_APPVIEW} already exists in .Renviron. \nEdit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.')
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, appview)
    }
  } else {
    do.call(Sys.setenv, appview)
  }

  invisible(appview)
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
