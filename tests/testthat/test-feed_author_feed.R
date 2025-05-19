test_that('`bs_get_author_feed()` works', {
  vcr::local_cassette('f_autfeed')
  x <- bs_get_author_feed('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
