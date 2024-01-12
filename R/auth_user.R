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
  !Sys.getenv('BLUESKY_APP_USER') %in% ''
}

#' @rdname user
#' @export
get_bluesky_user <- function() {
  user <- Sys.getenv('BLUESKY_APP_USER')

  # if (user == '') {
  #   cli::cli_abort('Must set a user as {.val BLUESKY_APP_USER}.')
  # }
  user
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
  name <- 'BLUESKY_APP_USER'

  user <- list(user)
  names(user) <- name

  if (user == 'CRAN_EXAMPLE.bsky.social') {
    cli::cli_inform('No username set when invalid test username is provided.')
    return(invisible(user))
  }

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
    newline <- paste0(name, "='", user, "'")

    exists <- grepl(x = lines, paste0(name, '='))

    if (any(exists)) {
      if (sum(exists) > 1) {
        cli::cli_abort('Multiple entries in .Renviron found.\nEdit manually with {.fn usethis::edit_r_environ}.')
      }

      if (overwrite) {
        lines[exists] <- newline
        writeLines(lines, r_env)
        do.call(Sys.setenv, user)
      } else {
        cli::cli_inform('{.arg BLUESKY_APP_USER} already exists in .Renviron. \nEdit manually with {.fn usethis::edit_r_environ} or set {.code overwrite = TRUE}.')
      }
    } else {
      lines[length(lines) + 1] <- newline
      writeLines(lines, r_env)
      do.call(Sys.setenv, user)
    }
  } else {
    do.call(Sys.setenv, user)
  }

  invisible(user)
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
