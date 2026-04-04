# Adds Bluesky PDS to .Renviron.

Adds Bluesky PDS to .Renviron.

## Usage

``` r
set_bluesky_pds(pds, overwrite = FALSE, install = FALSE, r_env = NULL)

bs_set_pds(pds, overwrite = FALSE, install = FALSE, r_env = NULL)
```

## Arguments

- pds:

  Character. Base URL of the Personal Data Server to add.

- overwrite:

  Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_PDS` in
  Renviron be overwritten?

- install:

  Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?

- r_env:

  Path to install to if `install` is `TRUE`.

## Value

pds, invisibly

## Examples

``` r
example_env <- tempfile(fileext = '.Renviron')
set_bluesky_pds('https://bsky.social', r_env = example_env)
# r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
```
