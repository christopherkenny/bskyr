# Retrieve thread of posts

Retrieve thread of posts

## Usage

``` r
bs_get_post_thread(
  uri,
  depth = NULL,
  parent_height = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- uri:

  Character, length 1. URI for post to get.

- depth:

  Integer. Maximum depth to request. Maximum: `1000`

- parent_height:

  Integer. Maximum parent height to request.

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
of posts

## Lexicon references

[feed/getPostThread.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getPostThread.json)

## Function introduced

`v0.0.1` (2023-10-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_post_thread('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
}
```
