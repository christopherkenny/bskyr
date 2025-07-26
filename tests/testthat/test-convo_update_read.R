test_that('`bs_update_read()` works', {
  vcr::local_cassette('c_read', match_requests_on = c('uri', 'method'))
  x <- bs_update_read('3ku7w6h4vog2d', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
