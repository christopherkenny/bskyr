with_mock_dir('t/i/resolveh', {
  test_that('`bs_resolve_handle()` works', {
    x <- bs_resolve_handle('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
