# Upload a blob to a repo

Upload a blob to a repo

## Usage

``` r
bs_upload_blob(
  blob,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- blob:

  Character, files to upload to a repo.

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

[repo/uploadBlob.json
(2023-11-24)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/uploadBlob.json)

## Function introduced

`v0.1.0` (2023-11-24)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
fig <- fs::path_package('bskyr', 'man/figures/logo.png')
bs_upload_blob(fig)
}
```
