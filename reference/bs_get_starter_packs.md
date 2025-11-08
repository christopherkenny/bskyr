# Get information about a list of starter packs

Get information about a list of starter packs

## Usage

``` r
bs_get_starter_packs(
  starter_packs,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- starter_packs:

  Character vector. Vector of URIs of starter packs to get.

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

[graph/getStarterPacks.json
(2024-11-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getStarterPacks.json)

## Function introduced

`v0.2.0` (2024-11-20)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_starter_packs(
  'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r'
)
bs_get_starter_packs(
  c(
    'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r',
    'at://did:plc:bmc56x6ksb7o7sdkq2fgm7se/app.bsky.graph.starterpack/3laywns2q2v27'
  )
)
}
```
