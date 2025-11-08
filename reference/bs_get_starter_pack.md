# Get information on one starter pack

Get information on one starter pack

## Usage

``` r
bs_get_starter_pack(
  starter_pack,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- starter_pack:

  Character vector, length 1. URI of starter pack to get.

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
of starter packs

## Lexicon references

[graph/getStarterPack.json
(2024-11-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getStarterPack.json)

## Function introduced

`v0.2.0` (2024-11-20)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_starter_pack(
  'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r'
)
}
```
