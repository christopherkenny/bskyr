with_mock_dir("t/n/notification_count", {
  test_that("`bs_get_notification_count()` works", {
    x <- bs_get_notification_count(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
