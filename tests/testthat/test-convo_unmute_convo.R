test_that('`bs_unmute_convo()` works', {
  vcr::local_cassette('c_unmute', match_requests_on = c('uri', 'method'))
  x <- bs_unmute_convo('3ku7w6h4vog2d', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
