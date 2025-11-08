# Convert Universal Resource Identifiers to Hypertext Transfer Protocol Secure URLs

Convert Universal Resource Identifiers to Hypertext Transfer Protocol
Secure URLs

## Usage

``` r
bs_uri_to_url(uri)
```

## Arguments

- uri:

  Character, length 1. URI for post to get.

## Value

character vector of HTTPS URLs

## Function introduced

`v0.1.0` (2023-11-24)

## Examples

``` r
bs_uri_to_url('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
#> [1] "https://bsky.app/profile/did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/post/3k7qmjev5lr2s"
```
