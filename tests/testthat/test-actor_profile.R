test_that('`bs_get_profile()` works', {
  vcr::local_cassette('a_profile')
  x <- bs_get_profile('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
