# Create a list

Create a list

## Usage

``` r
bs_new_list(
  name,
  purpose,
  description,
  avatar,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- name:

  Character. Display name for list.

- purpose:

  Purpose of the list. One of `'modlist'`, `'curatelist'`, or
  `'referencelist'`

- description:

  Optional character. Description of the list.

- avatar:

  Optional character. Path to image to use as avatar. PNG or JPEG
  recommended.

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

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
of list information

## Lexicon references

[graph/list.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
[graph/defs.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/defs.json)
[repo/createRecord.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.2.0` (2024-12-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
bs_new_list(
  name = 'test list bskyr w avatar',
  description = 'to be deleted, just for testing bskyr',
  avatar = fs::path_package('bskyr', 'man/figures/logo.png'),
  purpose = 'curatelist'
)
}
```
