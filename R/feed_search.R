#' Find posts matching search criteria
#'
#' @param query `r template_var_query()`
#' @param sort character. Order or results. Either `'top'` or `'latest'`
#' @param since character. Filter results for posts on or after the indicated datetime or ISO date (YYYY-MM-DD).
#' @param until character. Filter results for posts before the indicated datetime or ISO date (YYYY-MM-DD).
#' @param mentions character. Filter to posts which mention the given account.
#' @param author character. Filter to posts by the given account.
#' @param lang character. Filter to posts in the given language.
#' @param domain character. Filter to posts with URLs (facet links or embeds) linking to the given domain (hostname). Server may apply hostname normalization.
#' @param url character. Filter to posts with links (facet links or embeds) pointing to this URL. Server may apply URL normalization or fuzzy matching.
#' @param tag character. Filter to posts with the given tag (hashtag), based on rich-text facet or tag field. Do not include the hash (#) prefix. Multiple tags can be specified, with 'AND' matching.
#' @param cursor `r template_var_cursor()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @section Lexicon references:
#' [feed/searchPosts.json (2024-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/searchPosts.json)
#'
#' @section Function introduced:
#' `v0.1.1` (2023-12-13)
#'
#' @return a [tibble::tibble] of suggested accounts to follow
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_search_posts('redistricting')
#' bs_search_posts('ggplot2', tag = 'rstats', sort = 'latest')
bs_search_posts <- function(query,
                            sort = NULL, since = NULL, until = NULL, mentions = NULL,
                            author = NULL, lang = NULL, domain = NULL, url = NULL,
                            tag = NULL,
                            cursor = NULL, limit = NULL,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass), clean = TRUE) {
  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    req_seq <- diff(unique(c(seq(0, limit, 100), limit)))
  } else {
    req_seq <- list(NULL)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.searchPosts') |>
    httr2::req_url_query(
      q = query,
      sort = sort,
      since = since,
      until = until,
      mentions = mentions,
      author = author,
      lang = lang,
      domain = domain,
      url = url,
      tag = tag
    ) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )

  resp <- repeat_request(req, req_seq, cursor, txt = 'Searching posts')

  if (!clean) {
    return(resp)
  }

  resp |>
    lapply(process_search_posts) |>
    purrr::list_rbind() |>
    add_req_url(req) |>
    add_cursor(resp)
}

process_search_posts <- function(resp) {
  resp |>
    purrr::pluck('posts') |>
    lapply(function(x) {
      lapply(x, function(y) {
        if (length(y) != 1) {
          list(y)
        } else {
          y
        }
      }) |>
        tibble::as_tibble_row()
    }) |>
    dplyr::bind_rows() |>
    add_singletons(resp) |>
    clean_names()
}
