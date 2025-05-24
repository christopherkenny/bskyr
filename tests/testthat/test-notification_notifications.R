test_that('`bs_get_notifications()` works', {
  vcr::local_cassette('n_notifications')
  x <- bs_get_notifications(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
