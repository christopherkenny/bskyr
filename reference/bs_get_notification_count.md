# Get the user's (self) number of unread notifications

Get the user's (self) number of unread notifications

## Usage

``` r
bs_get_notification_count(
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

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

a tibble with a single column and row for the count

## Lexicon references

[notification/getUnreadCount.json
(2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/notification/getUnreadCount.json)

## Function introduced

`v0.0.1` (2023-10-02)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_get_notification_count()
}
```
