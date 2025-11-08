# Add a subject to a list

Add a subject to a list

## Usage

``` r
bs_new_list_item(
  subject,
  uri,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- subject:

  Character, length 1. Subject to act on, as a handle or did.

- uri:

  Character, length 1. URI of the list to add the subject to.

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
of list item information

## Lexicon references

[graph/listitem.json
(2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/listitem.json)
[repo/createRecord.json
(2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.2.0` (2024-12-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() && has_bluesky_user()
lst <- bs_new_list(name = 'test list listitem bskyr', purpose = 'curatelist')
bs_new_list_item(subject = 'chriskenny.bsky.social', uri = lst$uri)
# see the list item
bs_get_list(lst$uri)
}
```
