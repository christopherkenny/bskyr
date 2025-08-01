test_that('`bs_like()` works', {
  vcr::local_cassette('r_like', match_requests_on = c('uri', 'method'))
  x <- bs_like(post = rcd, auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_like()` works', {
  vcr::local_cassette('r_likeL', match_requests_on = c('uri', 'method'))
  x <- bs_like(post = rcd, auth = auth, clean = FALSE)
  expect_equal(class(x), 'list')
})
