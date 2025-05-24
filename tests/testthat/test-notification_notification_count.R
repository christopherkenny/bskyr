test_that('`bs_get_notification_count()` works', {
  vcr::local_cassette('n_nc')
  x <- bs_get_notification_count(auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_get_notification_count()` works', {
  vcr::local_cassette('n_ncL')
  x <- bs_get_notification_count(auth = auth, clean = FALSE)
  expect_equal(class(x), 'list')
})
