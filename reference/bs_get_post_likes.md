# Retrieve likes on a post

Retrieve likes on a post

## Usage

``` r
bs_get_post_likes(
  uri,
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
of likes

## Lexicon references

[feed/getLikes.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getLikes.json)

## Function introduced

`v0.0.1` (2023-10-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_post_likes('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
}
```
