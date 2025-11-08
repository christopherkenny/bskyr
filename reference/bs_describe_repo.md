# Describe a repo

Describe a repo

## Usage

``` r
bs_describe_repo(
  repo,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- repo:

  Character, length 1. The handle or DID of the repo.

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
of record information

## Lexicon references

[repo/describeRepo.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/describeRepo.json)

## Function introduced

`v0.1.0` (2023-11-25)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_describe_repo('chriskenny.bsky.social')
}
```
