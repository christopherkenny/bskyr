with_mock_dir('t/n/nc', {
  test_that('`bs_get_notification_count()` works', {
    x <- bs_get_notification_count(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/n/ncL', {
  test_that('`bs_get_notification_count()` works', {
    x <- bs_get_notification_count(auth = auth, clean = FALSE)
    expect_equal(class(x), 'list')
  })
})
