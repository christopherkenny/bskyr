test_that('`bs_get_convo_for_members()` works', {
  vcr::local_cassette('c_for_members')
  x <- bs_get_convo_for_members(c('bskyr.bsky.social', 'chriskenny.bsky.social'), auth = auth)
  expect_s3_class(x, 'tbl_df')
})
