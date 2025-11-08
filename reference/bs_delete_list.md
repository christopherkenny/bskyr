# Delete a list

Delete a list

## Usage

``` r
bs_delete_list(
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
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
[repo/deleteRecord.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)

## Function introduced

`v0.2.0` (2024-12-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
lst <- bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
bs_delete_list(bs_extract_record_key(lst$uri))
}
```
