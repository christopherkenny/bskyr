# Check conversation availability with specified members

Check conversation availability with specified members

## Usage

``` r
bs_get_convo_availability(
  actors,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- actors:

  character vector of actor(s), such as `'chriskenny.bsky.social'`

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

[chat.bsky.convo.getConvoAvailability.json
(2025-05-16)](https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getConvoAvailability.json)

## Function introduced

`v0.4.0` (2025-05-16)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_convo_availability(actors = 'chriskenny.bsky.social')
}
```
