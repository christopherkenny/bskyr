# Retrieve a user's (self) muted lists

Retrieve a user's (self) muted lists

## Usage

``` r
bs_get_muted_lists(
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

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
of actors

## Lexicon references

[graph/getListMutes.json
(2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getListMutes.json)

## Function introduced

`v0.0.1` (2023-10-02)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_muted_lists()
}
```
