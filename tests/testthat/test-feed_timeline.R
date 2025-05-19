test_that('`bs_get_timeline()` works', {
  vcr::local_cassette('f_timeline')
  x <- bs_get_timeline(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
