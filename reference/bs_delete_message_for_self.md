# Remove a message from your view of a conversation (does not delete it for others)

Remove a message from your view of a conversation (does not delete it
for others)

## Usage

``` r
bs_delete_message_for_self(
  convo_id,
  message_id,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- convo_id:

  Character, length 1. ID of the conversation to get.

- message_id:

  Character, length 1. Message ID.

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

[chat.bsky.convo.deleteMessageForSelf.json
(2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/deleteMessageForSelf.json)

## Function introduced

`v0.4.0` (2025-05-16)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_delete_message_for_self(convo_id = '3ku7w6h4vog2d', message_id = '3lpi4fcbnxv2l')
}
```
