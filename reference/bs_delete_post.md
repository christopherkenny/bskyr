# Delete a post

Delete a post

## Usage

``` r
bs_delete_post(
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

[feed/post.json
(2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
[repo/deleteRecord.json
(2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)

## Function introduced

`v0.3.0` (2025-03-20)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
pst <- bs_post('a test post to be deleted')
bs_delete_post(bs_extract_record_key(pst$uri))
}
```
