# Authenticate a user

Authenticate a user

## Usage

``` r
bs_auth(user, pass, save_auth = TRUE)
```

## Arguments

- user:

  Character. User name to log in with.

- pass:

  Character. App password to log in with.

- save_auth:

  Logical. Should the authentication information be saved? If `TRUE`, it
  tries to reload from the cache. If a file is over 10 minutes old, it
  will not be read. Set `save_auth = NULL` to force the token to refresh
  and save the results.

## Value

a list of authentication information

## Lexicon references

[server/createSession.json
(2023-09-30)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/server/createSession.json)

## Function introduced

`v0.0.1` (2023-09-30)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_auth(user = get_bluesky_user(), pass = get_bluesky_pass())
}
```
