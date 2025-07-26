test_that('`bs_block()` works', {
  vcr::local_cassette('r_post_block', match_requests_on = c('uri', 'method'))
  x <- bs_block(subject = 'nytimes.com', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
