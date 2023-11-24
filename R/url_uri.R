#' Convert Universal Resource Identifiers to Hypertext Transfer Protocol Secure URLs
#'
#' @param uri `r template_var_uri()`
#'
#' @return character vector of HTTPS URLs
#' @export
#'
#' @examples
#' bs_uri_to_url('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
bs_uri_to_url <- function(uri) {
  pieces <- httr2::url_parse(uri)
  paste0('https://bsky.app/profile/', pieces$hostname, ':', pieces$port, '/post/', stringr::word(pieces$path, start = 3, sep = stringr::fixed('/')))
}
