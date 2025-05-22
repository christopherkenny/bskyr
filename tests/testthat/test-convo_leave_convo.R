test_that('`bs_leave_convo()` works', {
  vcr::local_cassette('c_leave')
  x <- bs_leave_convo('3lpidxucy2g27', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
