test_that('`bs_get_blocks()` works', {
  vcr::local_cassette('g_blocks')
  x <- bs_get_blocks(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
