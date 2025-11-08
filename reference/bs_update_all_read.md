# Mark all conversations as read for the authenticated user

Mark all conversations as read for the authenticated user

## Usage

``` r
bs_update_all_read(
  status = c("accepted", "request"),
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- status:

  Character, length 1. Conversation status, one of
  `c("accepted", "request")`. Default: `NULL`.

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
or a `list` if `clean = FALSE`

## Lexicon references

[chat.bsky.convo.updateAllRead.json
(2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/updateAllRead.json)

## Function introduced

`v0.4.0` (2025-05-16)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_update_all_read()
}
```
