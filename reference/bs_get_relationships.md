# Get relationships between an account and other users

Get relationships between an account and other users

## Usage

``` r
bs_get_relationships(
  actor,
  others,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- actor:

  Character, length 1. name of 1 actor, such as
  `'chriskenny.bsky.social'`

- others:

  Optional, character vector of other users to look up relationships

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
of relationships

## Lexicon references

[graph/getRelationships.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getRelationships.json)

## Function introduced

`v0.2.0` (2024-12-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_relationships('chriskenny.bsky.social', 'bskyr.bsky.social')
}
```
