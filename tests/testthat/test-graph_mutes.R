test_that('`bs_get_mutes()` works', {
  vcr::local_cassette('g_mutes')
  x <- bs_get_mutes(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
