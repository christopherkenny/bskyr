# Find posts matching search criteria

Find posts matching search criteria

## Usage

``` r
bs_search_posts(
  query,
  sort = NULL,
  since = NULL,
  until = NULL,
  mentions = NULL,
  author = NULL,
  lang = NULL,
  domain = NULL,
  url = NULL,
  tag = NULL,
  cursor = NULL,
  limit = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- query:

  Character vector, length 1. character. Search query, Lucene query
  syntax is recommended.

- sort:

  character. Order or results. Either `'top'` or `'latest'`

- since:

  character. Filter results for posts on or after the indicated datetime
  or ISO date (YYYY-MM-DD).

- until:

  character. Filter results for posts before the indicated datetime or
  ISO date (YYYY-MM-DD).

- mentions:

  character. Filter to posts which mention the given account.

- author:

  character. Filter to posts by the given account.

- lang:

  character. Filter to posts in the given language.

- domain:

  character. Filter to posts with URLs (facet links or embeds) linking
  to the given domain (hostname). Server may apply hostname
  normalization.

- url:

  character. Filter to posts with links (facet links or embeds) pointing
  to this URL. Server may apply URL normalization or fuzzy matching.

- tag:

  character. Filter to posts with the given tag (hashtag), based on
  rich-text facet or tag field. Do not include the hash (#) prefix.
  Multiple tags can be specified, with 'AND' matching.

- cursor:

  Character, length 1. A cursor property from a prior response. Default:
  `NULL`.

- limit:

  Integer. Number of records to request. If over `100`, multiple
  requests are made.

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

- clean:

  Logical. Should output be cleaned into a `tibble`? Default: `TRUE`.

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
of suggested accounts to follow

## Lexicon references

[feed/searchPosts.json
(2024-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/searchPosts.json)

## Function introduced

`v0.1.1` (2023-12-13)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_search_posts('redistricting')
bs_search_posts('ggplot2', tag = 'rstats', sort = 'latest')
}
```
