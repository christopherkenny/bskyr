#' Convert Universal Resource Identifiers to Hypertext Transfer Protocol Secure URLs
#'
#' @param uri `r template_var_uri()`
#'
#' @return character vector of HTTPS URLs
#' @export
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-24)
#'
#' @examples
#' bs_uri_to_url('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
bs_uri_to_url <- function(uri) {
  pieces <- stringr::str_split(uri, pattern = '/+')[[1]]
  paste0(
    'https://bsky.app/profile/', pieces[2], '/', 'post',
    '/', pieces[4]
  )
}

#' Convert Hypertext Transfer Protocol Secure URLs to Universal Resource Identifiers
#'
#' @param url `r template_var_url()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @return character vector of URIs
#' @export
#'
#' @section Function introduced:
#' `v0.2.0` (2024-11-30)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_url_to_uri('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
bs_url_to_uri <- function(url,
                          user = get_bluesky_user(), pass = get_bluesky_pass(),
                          auth = bs_auth(user, pass)) {

  if (stringr::str_starts(url, 'at://')) {
    return(url)
  }
  pieces <- httr2::url_parse(url)
  handle <- stringr::word(pieces$path, start = 3, sep = stringr::fixed('/'))
  handle_as_id <- bs_resolve_handle(handle, auth = auth)
  if (stringr::str_detect(pieces$path, 'starter-pack')) {
    type <- 'graph.starterpack'
    rid <- stringr::word(pieces$path, start = 4, sep = stringr::fixed('/'))
  } else {
    type <- paste0('feed.', stringr::word(pieces$path, start = 4, sep = stringr::fixed('/')))
    rid <- stringr::word(pieces$path, start = 5, sep = stringr::fixed('/'))
  }

  paste0(
    'at://', handle_as_id$did, '/', 'app.bsky.', type, '/', rid
  )
}



#' Extract Record Key from a link
#'
#' @param url `r template_var_url()`
#'
#' @return character vector of record keys
#' @export
#'
#' @examples
#' bs_extract_record_key('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
bs_extract_record_key <- function(url) {
  dplyr::last(stringr::str_split(url, pattern = '/')[[1]])
}
