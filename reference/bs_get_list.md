# Get a view of a list

Get a view of a list

## Usage

``` r
bs_get_list(
  list,
  cursor = NULL,
  limit = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- list:

  Character vector, length 1. Reference of the list record to get.

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
of lists

## Lexicon references

[graph/getList.json
(2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getList.json)

## Function introduced

`v0.2.0` (2024-11-25)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_list('at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g')
bs_get_list('at://did:plc:hgyzg2hn6zxpqokmp5c2xrdo/app.bsky.graph.list/3laygnmmcfc2x')
}
```
