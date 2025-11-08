# Delete a starter pack

Delete a starter pack

## Usage

``` r
bs_delete_starter_pack(
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

[graph/starterpack.json
(2024-12-04)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/starterpack.json)
[repo/deleteRecord.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)

## Function introduced

`v0.2.0` (2024-12-04)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
starter <- bs_new_starter_pack('bskyr test')
bs_delete_starter_pack(bs_extract_record_key(starter$uri))
}
```
