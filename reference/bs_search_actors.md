# Find profiles matching search criteria

Find profiles matching search criteria

## Usage

``` r
bs_search_actors(
  query,
  typeahead = FALSE,
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

  character. search query, Lucene query syntax is recommended when
  `typeahead = FALSE`.

- typeahead:

  logical. Use typeahead for search? Default is `FALSE`.

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

[actor/searchActors.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/searchActors.json)
[actor/searchActorsTypeahead.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/searchActorsTypeahead.json)

## Function introduced

`v0.0.1` (2023-10-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_search_actors('political science')
}
```
