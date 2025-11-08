# Add Entry to Renviron

Adds Bluesky App Password to .Renviron.

## Usage

``` r
set_bluesky_pass(pass, overwrite = FALSE, install = FALSE, r_env = NULL)

bs_set_pass(pass, overwrite = FALSE, install = FALSE, r_env = NULL)
```

## Arguments

- pass:

  Character. App Password to add to add.

- overwrite:

  Defaults to FALSE. Boolean. Should existing `BLUESKY_APP_PASS` in
  Renviron be overwritten?

- install:

  Defaults to FALSE. Boolean. Should this be added '~/.Renviron' file?

- r_env:

  Path to install to if `install` is `TRUE`.

## Value

pass, invisibly

## Examples

``` r
example_env <- tempfile(fileext = '.Renviron')
set_bluesky_pass('1234-1234-1234-1234', r_env = example_env)
#> No password set when invalid test password is provided.
# r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
```
