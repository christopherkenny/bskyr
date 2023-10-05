with_mock_dir("t/f/timeline", {
  test_that("`bs_get_timeline()` works", {
    x <- bs_get_timeline(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
