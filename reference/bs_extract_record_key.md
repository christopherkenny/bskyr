# Extract Record Key from a link

Extract Record Key from a link

## Usage

``` r
bs_extract_record_key(url)
```

## Arguments

- url:

  Character, length 1. URL for record to get.

## Value

character vector of record keys

## Examples

``` r
bs_extract_record_key('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
#> [1] "3lc5d6zspys2c"
```
