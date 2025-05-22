library(vcr)

if (has_bluesky_pass() && has_bluesky_user()) {
  auth <- bs_auth(user = get_bluesky_user(), pass = get_bluesky_pass())
} else {
  auth <- list(accessJwt = '')
}

rcd <- list(
  uri = 'at://did:plc:5c2r73erhng4bszmxlfdtscf/app.bsky.feed.post/3kf2577exva2x',
  cid = 'bafyreibf5g5pkajhv4afkronrzyu3ywfk7dkjt5sdjdvkawkhcwv2l5fgu'
)

safe_figures <- function(x) {
  img <- NULL
  try({
    img <- fs::path_package('bskyr', paste0('man/figures/', x))
  })
  if (is.null(img)) {
    try({
      img <- fs::path_package('bskyr', paste0('help/figures/', x))
    })
  }
  if (is.null(img)) {
    testthat::skip(paste0('No file', x, ' found.'))
  }
  img
}
