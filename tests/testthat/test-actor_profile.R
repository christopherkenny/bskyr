with_mock_dir('t/a/profile', {
  test_that('`bs_get_profile()` works', {
    x <- bs_get_profile('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
