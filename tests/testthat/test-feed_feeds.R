test_that('`bs_get_feeds()` works', {
  vcr::local_cassette('f_feedfeeds')
  x <- bs_get_feeds('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
