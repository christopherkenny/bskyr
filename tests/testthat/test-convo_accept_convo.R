test_that('`bs_accept_convo()` works', {
  vcr::local_cassette('c_accept')
  x <- bs_accept_convo(convo_id = '3ku7w6h4vog2d', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
