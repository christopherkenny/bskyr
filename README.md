
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bskyr <img src="man/figures/logo.png" align="right" height="136" alt="" />

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Codecov test
coverage](https://codecov.io/gh/christopherkenny/bskyr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/christopherkenny/bskyr?branch=main)
[![R-CMD-check](https://github.com/christopherkenny/bskyr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/christopherkenny/bskyr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`bskyr` provides an interface to the Bluesky API, allowing you to
interact with Bluesky Social from R. To do this, we provide functions
which match with the [AT Protocol’s
Lexicon](https://atproto.com/guides/lexicon), which is like using
regular HTTP requests. Outputs from `bskyr`’s functions are primarily
`tibble`s, allowing for easy analysis of the outputs from the API calls.

## Installation

You can install the development version of `bskyr` from
[GitHub](https://github.com/) with:

``` r
# install.packages('devtools')
remotes::install_github('christopherkenny/bskyr')
```

## Posting with `bskyr`

Posting capabilities are still under development.

``` r
library(bskyr)
```

Text posts can be made as follows:

``` r
bs_post('text = Your text goes here.')
```

If you have images to include, up to four can be included with the
`images` argument:

``` r
bs_post(
  text = 'Your text goes here.', 
  images = c('path/to/image1.jpg', 'path/to/image2.png')
)
```

Alt text can be added to images with the `images_alt` argument:

``` r
bs_post(
  text = 'Your text goes here.', 
  images = c('path/to/image1.jpg', 'path/to/image2.png'), 
  images_alt = c('Alt text for image 1', 'Alt text for image 2')
)
```

To quote or reply to a post, use the `quote` and/or `reply` argument,
respectively. These can take the link of an existing post. You can quote
and reply to the same post, if you want.

``` r
bs_post(
  text = 'Your text goes here.', 
  quote = 'https://bsky.app/profile/chriskenny.bsky.social/post/3kepscxiljc22',
  reply = 'https://bsky.app/profile/chriskenny.bsky.social/post/3kepscxiljc22'
)
```

See the reference for additional features, including likes with
`bs_like()` and reposts with `bs_repost()`.

## Authentication

To authenticate, you first need to make an App Password. To do this, go
to <https://bsky.app/settings>. Under “Advanced” click App passwords and
then “Add App Password.”

Once you have a password, you need to run:

``` r
set_bluesky_user('YOUR-USERNAME.bsky.social')
set_bluesky_pass('your-apps-pass-word')
```

If you want this to persist across sessions, set `install = TRUE` and
`r_env = file.path(Sys.getenv('HOME'), '.Renviron')`. This will save
your credentials in your R environment file.

Alternatively, you can set them manually using
`usethis::edit_r_environ()` and adding lines like so:

    BLUESKY_APP_USER='YOUR-USERNAME.bsky.social'
    BLUESKY_APP_PASS='your-apps-pass-word'
