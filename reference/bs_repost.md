# Repost an existing post

Repost an existing post

## Usage

``` r
bs_repost(
  post,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- post:

  Character vector, length 1. Link to a post.

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
of post information

## Lexicon references

[feed/repost.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/repost.json)
[repo/createRecord.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.1.0` (2023-11-25)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_repost('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
}
```
