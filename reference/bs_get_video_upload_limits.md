# Get Video Upload Limits

Get Video Upload Limits

## Usage

``` r
bs_get_video_upload_limits(
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
of video upload allowances, or a list if `clean = FALSE`

## Lexicon references

[video/getUploadLimits.json
(2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/getUploadLimits.json)

## Function introduced

`v0.5.0` (2026-06-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_video_upload_limits()
}
```
