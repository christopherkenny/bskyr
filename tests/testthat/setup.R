library(httptest2)
if (has_bluesky_pass() && has_bluesky_user()) {
  auth <- bs_auth(user = get_bluesky_user(), pass = get_bluesky_pass())
} else {
  auth <- list(accessJwt = '')
}

