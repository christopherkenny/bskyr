test_that('`bs_get_followers()` works', {
  vcr::local_cassette('g_followers')
  x <- bs_get_followers('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
