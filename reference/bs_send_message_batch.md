# Send multiple messages across different conversations

Send multiple messages across different conversations

## Usage

``` r
bs_send_message_batch(
  convo_id,
  text,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- convo_id:

  Character, length 1. ID of the conversation to get.

- text:

  Character vector of message texts.

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

A [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
or a `list` if `clean = FALSE`.

## Lexicon references

[chat.bsky.convo.sendMessageBatch.json
(2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/sendMessageBatch.json)

## Function introduced

`v0.4.0` (2025-05-16)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_send_message_batch(
  convo_id = c('3ku7w6h4vog2d', '3lpidxucy2g27'),
  text = c('Hello', 'Hi there')
)
}
```
