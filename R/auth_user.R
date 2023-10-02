#' Check or Get Bluesky User
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
  user <- Sys.getenv('BLUESKY_APP_USER')

  # if (user == '') {
  #   cli::cli_abort('Must set a user as {.val BLUESKY_APP_USER}.')
  # }
  user
}

#' Add Entry to Renviron
#'
#' Adds Bluesky User to .Renviron.
#'
#' @param user Character. User to add to add.
#' @param overwrite Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_USER` in Renviron be overwritten?
#' @param install Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?
#'
#' @return user, invisibly
#' @export
#'
#' @examples
#' \dontrun{
#' set_bluesky_user('1234')
#' }
#'
set_bluesky_user <- function(user, overwrite = FALSE, install = FALSE) {
  if (missing(user)) {
    cli::cli_abort('Input {.arg user} cannot be missing.')
  }
  name <- 'BLUESKY_APP_USER'

  user <- list(user)
  names(user) <- name

  if (install) {
    r_env <- file.path(Sys.getenv('HOME'), '.Renviron')

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
