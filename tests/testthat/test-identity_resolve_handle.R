test_that('`bs_resolve_handle()` works', {
  vcr::local_cassette('i_resolveh')
  x <- bs_resolve_handle('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
