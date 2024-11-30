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
  pieces <- httr2::url_parse(uri)
  type <- stringr::word(pieces$path, start = 2, sep = stringr::fixed('/'))
  paste0(
    'https://bsky.app/profile/', pieces$hostname, ':', pieces$port, '/', 'post',
    '/', stringr::word(pieces$path, start = 3, sep = stringr::fixed('/'))
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
#' @examples
#' bs_url_to_uri('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
bs_url_to_uri <- function(url,
                          user = get_bluesky_user(), pass = get_bluesky_pass(),
                          auth = bs_auth(user, pass)) {
  pieces <- httr2::url_parse(url)
  type <- stringr::word(pieces$path, start = 4, sep = stringr::fixed('/'))
  handle <- stringr::word(pieces$path, start = 3, sep = stringr::fixed('/'))
  handle_as_id <- bs_resolve_handle(handle, auth = auth)
  rid <- stringr::word(pieces$path, start = 5, sep = stringr::fixed('/'))

  paste0(
    'at://', handle_as_id$did, '/', 'app.bsky.feed.', type, '/', rid
  )
}
