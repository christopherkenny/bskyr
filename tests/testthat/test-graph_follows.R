test_that('`bs_get_follows()` works', {
  vcr::local_cassette('g_follows')
  x <- bs_get_follows('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
