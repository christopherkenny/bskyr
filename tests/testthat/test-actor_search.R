with_mock_dir('t/a/search', {
  test_that('`bs_search_actors()` works', {
    x <- bs_search_actors('political science', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
