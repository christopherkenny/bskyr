# Retrieve a list of quotes for a given post

Retrieve a list of quotes for a given post

## Usage

``` r
bs_get_quotes(
  uri,
  cid,
  cursor = NULL,
  limit = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- uri:

  Character, length 1. URI for post to get.

- cid:

  Optional, character. Filters to quotes of specific version (by CID) of
  the post record

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
of quote posts

## Lexicon references

[feed/getQuotes.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getQuotes.json)

## Function introduced

`v0.2.0` (2024-12-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_quotes('at://did:plc:5c2r73erhng4bszmxlfdtscf/app.bsky.feed.post/3lc5c5qv72r2w')
}
```
