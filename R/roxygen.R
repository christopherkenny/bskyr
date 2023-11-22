template_var_user <- function() { # nocov start
  'Character. User name to log in with. Defaults to `get_bluesky_user()`.'
} # nocov end

template_var_pass <- function() { # nocov start
  'Character. App password to log in with. Defaults to `get_bluesky_pass()`.'
} # nocov end

template_var_auth <- function() { # nocov start
  'Authentication information. Defaults to `bs_auth(user, pass)`.'
} # nocov end

template_var_actor <- function() { # nocov start
  "Character, length 1. name of 1 actor, such as `'chriskenny.bsky.social'`"
} # nocov end

template_var_actors <- function() { # nocov start
  "Character. Vector of names of actor(s), such as `'chriskenny.bsky.social'`"
} # nocov end

template_var_feed <- function() { # nocov start
  "Character, length 1. Feed to get."
} # nocov end

template_var_feeds <- function() { # nocov start
  "Character. Vector of feeds to get."
} # nocov end

template_var_uri <- function() { # nocov start
  "Character, length 1. URI for post to get."
} # nocov end

template_var_uris <- function() { # nocov start
  "Character. Vector of URIs for posts to get."
} # nocov end

template_var_clean <- function() { # nocov start
  "Logical. Should output be cleaned into a `tibble`? Default: `TRUE`."
} # nocov end
