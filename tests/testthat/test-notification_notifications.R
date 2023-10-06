with_mock_dir("t/n/notifications", {
  test_that("`bs_get_notifications()` works", {
    x <- bs_get_notifications(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
