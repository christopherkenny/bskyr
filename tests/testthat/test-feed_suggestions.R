with_mock_dir('t/f/sugg', {
  test_that('`bs_get_feed_suggestions()` works', {
    x <- bs_get_feed_suggestions(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
