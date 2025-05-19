test_that('`bs_get_feed_suggestions()` works', {
  vcr::local_cassette('f_sugg')
  x <- bs_get_feed_suggestions(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
