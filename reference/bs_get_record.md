# Get an arbitrary record from a repo

Get an arbitrary record from a repo

## Usage

``` r
bs_get_record(
  repo = NULL,
  collection = NULL,
  rkey = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- repo:

  Character, length 1. The handle or DID of the repo.

- collection:

  Character, length 1. The NSID of the record collection.

- rkey:

  Character, length 1. The CID of the version of the record. If not
  specified, then return the most recent version.

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
of upload blob information

## Lexicon references

[repo/getRecord.json
(2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/getRecord.json)

## Function introduced

`v0.1.0` (2023-11-24)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_get_record('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
}
```
