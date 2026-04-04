# Adds Bluesky AppView to .Renviron.

Adds Bluesky AppView to .Renviron.

## Usage

``` r
set_bluesky_appview(appview, overwrite = FALSE, install = FALSE, r_env = NULL)

bs_set_appview(appview, overwrite = FALSE, install = FALSE, r_env = NULL)
```

## Arguments

- appview:

  Character. Base URL of the AppView server to add.

- overwrite:

  Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_APPVIEW` in
  Renviron be overwritten?

- install:

  Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?

- r_env:

  Path to install to if `install` is `TRUE`.

## Value

appview, invisibly

## Examples

``` r
example_env <- tempfile(fileext = '.Renviron')
set_bluesky_appview('https://bsky.social', r_env = example_env)
# r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
```
