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
  name <- 'BLUESKY_APP_PDS'

  pds <- list(pds)
  names(pds) <- name

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
    newline <- paste0(name, "='", pds, "'")

    exists <- grepl(x = lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort('Multiple entries in .Renviron found.\nEdit manually with {.fn usethis::edit_r_environ}.')
      }

      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, pds)
      } else {
        cli::cli_inform('{.arg BLUESKY_APP_PDS} already exists in .Renviron. \nEdit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.')
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, pds)
    }
  } else {
    do.call(Sys.setenv, pds)
  }

  invisible(pds)
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
