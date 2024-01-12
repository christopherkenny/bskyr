with_mock_dir('t/f/feedfeeds', {
  test_that('`bs_get_feeds()` works', {
    x <- bs_get_feeds('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
