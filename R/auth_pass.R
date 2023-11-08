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
  pass <- Sys.getenv('BLUESKY_APP_PASS')

  # if (pass == '') {
  #   cli::cli_abort('Must set a pass as {.val BLUESKY_APP_PASS}.')
  # }
  pass
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
  name <- 'BLUESKY_APP_PASS'

  pass <- list(pass)
  names(pass) <- name

  if (pass == '1234-1234-1234-1234') {
    cli::cli_inform('No password set when invalid test password is provided.')
    return(invisible(pass))
  }

  if (install) {

    if (is.null(r_env)) {
      r_env <- file.path(Sys.getenv('HOME'), '.Renviron')
      if (interactive()) {
        utils::askYesNo(paste0('Install to',  r_env, '?'))
      } else {
        cli::cli_abort(c('No path set and not run interactively.',
                         i = 'Rerun with {.arg r_env} set, possibly to {.file {r_env}}'))
      }
    }

    if (!file.exists(r_env)) {
      file.create(r_env)
    }

    lines <- readLines(r_env)
    newline <- paste0(name, "='", pass, "'")

    exists <- grepl(x = lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort('Multiple entries in .Renviron found.\nEdit manually with {.fn usethis::edit_r_environ}.')
      }

      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, pass)
      } else {
        cli::cli_inform('{.arg BLUESKY_APP_PASS} already exists in .Renviron. \nEdit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.')
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, pass)
    }
  } else {
    do.call(Sys.setenv, pass)
  }

  invisible(pass)
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
