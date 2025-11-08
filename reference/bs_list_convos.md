# List the conversations (direct message threads) for the authenticated user

List the conversations (direct message threads) for the authenticated
user

## Usage

``` r
bs_list_convos(
  read_state = NULL,
  status = NULL,
  cursor = NULL,
  limit = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- read_state:

  Character, optional. Filter by read state, one of `c('unread')`.
  Default: `NULL`.

- status:

  Character, optional. Filter by conversation status, one of
  `c('accepted', 'request')`. Default: `NULL`.

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
or a `list` if `clean = FALSE`

## Lexicon references

[chat.bsky.convo.listConvos.json
(2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/listConvos.json)

## Function introduced

`v0.4.0` (2025-05-16)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_list_convos(limit = 5, status = 'accepted')
}
```
