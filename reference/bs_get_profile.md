# Get Profile for a Bluesky Social User

Get Profile for a Bluesky Social User

## Usage

``` r
bs_get_profile(
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

a tibble with a row for each actor

## Lexicon references

[actor/getProfiles.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfiles.json)
[actor/getProfile.json
(2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfile.json)

## Function introduced

`v0.0.1` (2023-10-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_get_profile('chriskenny.bsky.social')
bs_get_profile(actors = c('chriskenny.bsky.social', 'simko.bsky.social'))
}
```
