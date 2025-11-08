# Convert Hypertext Transfer Protocol Secure URLs to Universal Resource Identifiers

Convert Hypertext Transfer Protocol Secure URLs to Universal Resource
Identifiers

## Usage

``` r
bs_url_to_uri(
  url,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass)
)
```

## Arguments

- url:

  Character, length 1. URL for record to get.

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

## Value

character vector of URIs

## Function introduced

`v0.2.0` (2024-11-30)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_url_to_uri('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
}
```
