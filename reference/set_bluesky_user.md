# Adds Bluesky User to .Renviron.

Adds Bluesky User to .Renviron.

## Usage

``` r
set_bluesky_user(user, overwrite = FALSE, install = FALSE, r_env = NULL)

bs_set_user(user, overwrite = FALSE, install = FALSE, r_env = NULL)
```

## Arguments

- user:

  Character. User to add to add.

- overwrite:

  Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_USER` in
  Renviron be overwritten?

- install:

  Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?

- r_env:

  Path to install to if `install` is `TRUE`.

## Value

user, invisibly

## Examples

``` r
example_env <- tempfile(fileext = '.Renviron')
set_bluesky_user('CRAN_EXAMPLE.bsky.social', r_env = example_env)
#> No username set when invalid test username is provided.
# r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
```
