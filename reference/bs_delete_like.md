# Delete a like (un-like something)

Delete a like (un-like something)

## Usage

``` r
bs_delete_like(
  rkey,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass)
)

bs_unlike(
  rkey,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass)
)
```

## Arguments

- rkey:

  Character, length 1. The CID of the version of the record. If not
  specified, then return the most recent version.

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

## Value

an `httr2` status code

## Lexicon references

[graph/list.json
(2024-12-03)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
[repo/deleteRecord.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)

## Function introduced

`v0.2.0` (2024-12-03)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
like <- bs_like(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
bs_delete_like(bs_extract_record_key(like$uri))
}
```
