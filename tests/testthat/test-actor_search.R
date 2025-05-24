test_that('`bs_search_actors()` works', {
  vcr::local_cassette('a_search')
  x <- bs_search_actors('political science', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
