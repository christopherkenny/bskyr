template_var_user <- function() {
  'Character. User name to log in with. Defaults to `get_bluesky_user()`.'
}

template_var_pass <- function() {
  'Character. App password to log in with. Defaults to `get_bluesky_pass()`.'
}

template_var_auth <- function() {
  'Authentication information. Defaults to `bs_auth(user, pass)`.'
}

template_var_actor <- function() {
  "Character, length 1. name of 1 actor, such as `'chriskenny.bsky.social'`"
}

template_var_actors <- function() {
  "Character. Vector of names of actor(s), such as `'chriskenny.bsky.social'`"
}

template_var_feed <- function() {
  "Character, length 1. Feed to get."
}

template_var_feeds <- function() {
  "Character, length 1. Vector of feeds to get."
}
