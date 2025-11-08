# List records in a repo

List records in a repo

## Usage

``` r
bs_list_records(
  repo,
  collection,
  cursor = NULL,
  limit = NULL,
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
of record information

## Lexicon references

[repo/createRecord.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.1.0` (2023-11-25)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_list_records(repo = 'chriskenny.bsky.social', collection = 'app.bsky.feed.post')
}
```
