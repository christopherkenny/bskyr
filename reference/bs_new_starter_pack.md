# Create a new starter pack

Create a new starter pack

## Usage

``` r
bs_new_starter_pack(
  name,
  list,
  description,
  feeds,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- name:

  Character. Display name for starter pack

- list:

  Character. List to base the starter pack on. If not provided, a new
  list will be created.

- description:

  Optional character. Description of the list.

- feeds:

  Optional character. List of feed items to include in starter pack.

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
of post information

## Lexicon references

[graph/starterpack.json
(2024-12-04)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/starterpack.json)
[repo/createRecord.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.2.0` (2024-12-04)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_new_starter_pack('bskyr test')
}
```
