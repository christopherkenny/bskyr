test_that('`bs_get_convo()` works', {
  vcr::local_cassette('c_get_convo')
  x <- bs_get_convo('3ku7w6h4vog2d', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
