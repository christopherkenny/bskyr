# Resolve a Handle to Decentralized Identifier (DID)

Resolve a Handle to Decentralized Identifier (DID)

## Usage

``` r
bs_resolve_handle(
  handle,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- handle:

  Character, length 1. Handle, such as `'chriskenny.bsky.social'`

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
of decentralized identifier

## Lexicon references

[identity/resolveHandle.json
(2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/identity/resolveHandle.json)

## Function introduced

`v0.1.0` (2023-11-24)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_resolve_handle('chriskenny.bsky.social')
}
```
