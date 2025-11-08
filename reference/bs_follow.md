# Follow an account

Follow an account

## Usage

``` r
bs_follow(
  subject,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- subject:

  Character, length 1. Subject to act on, as a handle or did.

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
of follow information

## Lexicon references

[graph/list.json
(2024-12-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
[repo/createRecord.json
(2024-12-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.2.0` (2024-12-02)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_follow(subject = 'chriskenny.bsky.social')
}
```
