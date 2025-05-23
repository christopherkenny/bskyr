template_var_user <- function() { # nocov start
  'Character. User name to log in with. Defaults to `get_bluesky_user()`.'
} # nocov end

template_var_pass <- function() { # nocov start
  'Character. App password to log in with. Defaults to `get_bluesky_pass()`.'
} # nocov end

template_var_auth <- function() { # nocov start
  'Authentication information. Defaults to `bs_auth(user, pass)`.'
} # nocov end

template_var_cursor <- function() { # nocov start
  'Character, length 1. A cursor property from a prior response. Default: `NULL`.'
} # nocov end

template_var_actor <- function() { # nocov start
  "Character, length 1. name of 1 actor, such as `'chriskenny.bsky.social'`"
} # nocov end

template_var_handle <- function() { # nocov start
  "Character, length 1. Handle, such as `'chriskenny.bsky.social'`"
} # nocov end

template_var_actors <- function() { # nocov start
  "Character. Vector of names of actor(s), such as `'chriskenny.bsky.social'`"
} # nocov end

template_var_feed <- function() { # nocov start
  'Character, length 1. Feed to get.'
} # nocov end

template_var_feeds <- function() { # nocov start
  'Character. Vector of feeds to get.'
} # nocov end

template_var_uri <- function() { # nocov start
  'Character, length 1. URI for post to get.'
} # nocov end

template_var_uris <- function() { # nocov start
  'Character. Vector of URIs for posts to get.'
} # nocov end

template_var_url <- function() { # nocov start
  'Character, length 1. URL for record to get.'
} # nocov end

template_var_clean <- function() { # nocov start
  'Logical. Should output be cleaned into a `tibble`? Default: `TRUE`.'
} # nocov end

template_var_limit <- function(val = NULL) { # nocov start
  if (is.null(val)) {
    'Integer. Maximum number to request.'
  } else {
    paste0('Integer. Number of records to request. If over `', val, '`, multiple requests are made.')
  }
} # nocov end

template_var_depth <- function(val = NULL) { # nocov start
  if (is.null(val)) {
    'Integer. Maximum depth to request.'
  } else {
    paste0('Integer. Maximum depth to request. Maximum: `', val, '`')
  }
} # nocov end

template_var_parent_height <- function(val = NULL) { # nocov start
  if (is.null(val)) {
    'Integer. Maximum parent height to request.'
  } else {
    paste0('Integer. Maximum parent height to request. Maximum: `', val, '`')
  }
} # nocov end

template_var_blob <- function() { # nocov start
  'Character, files to upload to a repo.'
} # nocov end

template_var_video <- function() { # nocov start
  'Character, videos to upload to a repo.'
} # nocov end

template_var_repo <- function() { # nocov start
  'Character, length 1. The handle or DID of the repo.'
} # nocov end

template_var_collection <- function() { # nocov start
  'Character, length 1. The NSID of the record collection.'
} # nocov end

template_var_rkey <- function() { # nocov start
  'Character, length 1. The CID of the version of the record. If not specified, then return the most recent version.'
} # nocov end

template_var_post <- function() { # nocov start
  'Character vector, length 1. Link to a post.'
} # nocov end

template_var_record <- function() { # nocov start
  'List, length 1. Description of a record.'
} # nocov end

template_var_starter_pack <- function() { # nocov start
  'Character vector, length 1. URI of starter pack to get.'
} # nocov end

template_var_starter_packs <- function() { # nocov start
  'Character vector. Vector of URIs of starter packs to get.'
} # nocov end

template_var_list <- function() { # nocov start
  'Character vector, length 1. Reference of the list record to get.'
} # nocov end

template_var_query <- function() { # nocov start
  'Character vector, length 1. character. Search query, Lucene query syntax is recommended.'
} # nocov end

template_var_max_tries <- function() { # nocov start
  'Integer, >= 2. Number of times to retry the request if the first fails.'
} # nocov end

template_var_subject <- function() { # nocov start
  'Character, length 1. Subject to act on, as a handle or did.'
} # nocov end

template_var_created_at <- function() { # nocov start
  'Character, length 1 of the form "%Y-%m-%dT%H:%M:%OS6Z". Time to assign to a record. Default is `bs_created_at()`.'
} # nocov end

template_var_convo_id <- function() { # nocov start
  'Character, length 1. ID of the conversation to get.'
} # nocov end

template_var_status <- function() { # nocov start
  'Character, length 1. Conversation status, one of  `c("accepted", "request")`. Default: `NULL`.'
} # nocov end
