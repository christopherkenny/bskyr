test_that('`bs_get_muted_lists()` works', {
  vcr::local_cassette('g_mutedlists')
  x <- bs_get_muted_lists(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
