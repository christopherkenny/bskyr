# Embed external media in a post

Embeds are not designed as standalone records, but rather as part of a
post. This will create a list representation of an external embed.

## Usage

``` r
bs_new_embed_external(
  uri,
  title,
  description,
  thumb,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass)
)
```

## Arguments

- uri:

  a link to embed

- title:

  the title for the link

- description:

  a description of the link

- thumb:

  Optional. A thumbnail for the link

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

## Value

a list representation of an external embed

## Lexicon references

[embed/external.json
(2024-12-05)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/embed/external.json)

## Function introduced

`v0.2.0` (2024-12-05)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_new_embed_external(
  uri = 'https://christophertkenny.com/bskyr/',
  title = 'Interact with Bluesky Social',
  description = 'An R package for using Bluesky Social'
)

bs_new_embed_external(
  uri = 'https://christophertkenny.com/bskyr/'
)
}
```
